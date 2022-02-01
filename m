Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B64C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiBARAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 12:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiBARAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 12:00:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC983C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 09:00:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m13-20020a05600c3b0d00b00353951c3f62so1953498wms.5
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ASn63U8F+OkDGGw5wemyJAhE/Gh5KOJXeDjOG5jAW0s=;
        b=kbuJAB21tROchNUeCO/1TGDs+Q4Bu3D6qq4yBo7tn6Lj64jAUDEIzaNNgxIWMR69Im
         h9MSCirqZqp12e2PCwciiFeKRhrGYY3VrVjX+jUvZwIH3sV4xn+F/VeuiwvcLWbmKN08
         nGClboKICthO96HUIFi35ZGWPv4aVCHtd4lZbFJ+YOyweAVWNqxubiHAbD6NM3x8zCSG
         w7vpVgwjlaqOuMDvwzx6IlQP4fSrW/u9js5YacM1+dj5C+4lAJShoHTKK7KD2ZAU9p7z
         MRYOl7f+dvgh7YiaVQMCzey17rdeszvqhpqQMLh+DSFN6Mhp+yhlHc4cIQCeT5aTBWhw
         5oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ASn63U8F+OkDGGw5wemyJAhE/Gh5KOJXeDjOG5jAW0s=;
        b=Z0o9aZ7tToUVosqYHgDDSAIx9zZORdtipaZrKLsI1+PtlYBjcGzUBnbeD64fJFe69u
         iolBhlJxZEH+gtezmCgYGx+cr5bny8OrNjxSZunUDB0UFwVjnWzmA59vyd8PRoi+vdTS
         WiFHqt9eX2+DBAe/PZY64zfQ3Q+zMYe76uJWVfVktKLm/tfFUOxY6xS3mOJGaSriBGax
         mXIRE8p6zfs33XpNJ8Brf0BnlduqW16M6qFV+UJYIADwDeAg87TvIfg5u5q4X8/zTalL
         hUB+Z1WntxgjeTNoBqIqxi6CgFYwgasKpWOxGcHyYF5xhdkQSSpuXIFRjYygl//YLUBo
         5M4g==
X-Gm-Message-State: AOAM530yxGAt6R1amwP+QvSD01WGM6qpFqhaw2m7pz9+jbrEOT/yjZWh
        svPCAcONDT3sn55jUec0g0RwyqTSJ3c=
X-Google-Smtp-Source: ABdhPJxi4DD5fhwHFvff24IqR+3P9IKRyZX5je6U0i7rGmz1HclpsSZS3NI6r3uMWH0xeadjmn0P2g==
X-Received: by 2002:a05:600c:1988:: with SMTP id t8mr2562759wmq.66.1643734831271;
        Tue, 01 Feb 2022 09:00:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm20619855wri.117.2022.02.01.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:00:30 -0800 (PST)
Message-Id: <23f692b81be26072f44609df8c78d1b8d81f01d3.1643734828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
References: <pull.1131.v2.git.1643478692337.gitgitgadget@gmail.com>
        <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 17:00:27 +0000
Subject: [PATCH v3 2/3] repo-settings: fix error handling for unknown values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit af3a67de01 ("negotiator: unknown fetch.negotiationAlgorithm
should error out", 2018-08-01), error handling for an unknown
fetch.negotiationAlgorithm was added with the code die()ing.  This was
also added to the documentation for the fetch.negotiationAlgorithm
option, to make it explicit that the code would die on unknown values.

This behavior was lost with commit aaf633c2ad ("repo-settings: create
feature.experimental setting", 2019-08-13).  Restore it so that the
behavior again matches the documentation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 repo-settings.c       | 2 ++
 t/t5500-fetch-pack.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/repo-settings.c b/repo-settings.c
index 38c10f9977b..41e1c30845f 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -87,6 +87,8 @@ void prepare_repo_settings(struct repository *r)
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
 		else if (!strcasecmp(strval, "default"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
+		else
+			die("unknown fetch negotiation algorithm '%s'", strval);
 	}
 
 	/*
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 666502ed832..41ea9f25de6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -971,6 +971,13 @@ test_expect_success 'same as last but with config overrides' '
 		-c fetch.negotiationAlgorithm=default
 '
 
+test_expect_success 'ensure bogus fetch.negotiationAlgorithm yields error' '
+	test_when_finished rm -rf clientv0 &&
+	cp -r client clientv0 &&
+	test_must_fail git -C clientv0 --fetch.negotiationAlgorithm=bogus \
+		       fetch origin server_has both_have_2
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
gitgitgadget

