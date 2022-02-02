Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD65C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 03:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244090AbiBBDmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 22:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiBBDmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 22:42:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8771C06173B
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:42:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e2so35828825wra.2
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 19:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ASn63U8F+OkDGGw5wemyJAhE/Gh5KOJXeDjOG5jAW0s=;
        b=lISPrXYP8wJVh+nxKznnrD97s0yvRv8ivyuleywqYW0IhBnTbgpCTIZMF5+iRCa4yA
         UrdG9VuSwHgqVb3aI3l10skS9h4jX2L6/eI6rLDob9ScFOJ1wK7OUXe2V6ZYUq++B80M
         FElccwex9BHga3KNMoftQygk4gmOKyI54ZeGDeQjOZF/XvdhXFQsdYBx6G1CcQedHG5U
         fYojyPZmJEgT0ANdHTWzV9T2faf0iRuiAnk3jAYB2nhzdZd3QPGP+/wz890xop2Cyzy7
         bjDL1m3s+wOWXnSz0l3i3bqVsioEPJoK3/ZQEP2wUAQSXegysMEHxqNcLwuJRTazYvnG
         aD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ASn63U8F+OkDGGw5wemyJAhE/Gh5KOJXeDjOG5jAW0s=;
        b=2uqIMOztRL2aVKjbXaKSWGiHMvfWUqeKua65NqZA6dcJBkYd3U2cGs7FZD9M37FT0i
         Q762j6n820tFukhdIE4eOG8jzrp/J9KNCjpfmxCb/cnsHDo8b885tgnLS3Se1nzQBDe7
         anhz9Tm3qXSOoc15kGh9h+h+RzaYrpr4QcO0EIPjWbifHEbGbkO5qf8+DjEXq0GKCCDz
         iqXoJN7zHNMfKSxEfZiRF8uH4l5SRr3DpUi8L8setQSWddoq1d2kz0EIG3w2A3Jxrabk
         lDvIrwfQCTDS/ygdyS1OZFj20VgnaTrAow88B39JNaKOKSXGywHuysD6yY9gdfdi79cY
         8wng==
X-Gm-Message-State: AOAM533vje/I70664+Eq6Ba/QVBraRSDX7JqcAOfPz1aqvi8nzrwOWeL
        7GIDqC+sdenLexWqSl5qlJn1pDAAZwY=
X-Google-Smtp-Source: ABdhPJybPKSJc7IDmpESpES8nJpwZhralEnQOO9hN0XC66dveso7P3XIxAEZqTPEN8H9Yp+ilSn7aA==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr14852661wrq.685.1643773364218;
        Tue, 01 Feb 2022 19:42:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p190sm3498856wmp.16.2022.02.01.19.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 19:42:43 -0800 (PST)
Message-Id: <23f692b81be26072f44609df8c78d1b8d81f01d3.1643773361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
References: <pull.1131.v3.git.1643734828.gitgitgadget@gmail.com>
        <pull.1131.v4.git.1643773361.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 03:42:39 +0000
Subject: [PATCH v4 2/3] repo-settings: fix error handling for unknown values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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

