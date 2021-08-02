Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C9FC432BE
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AB7610A2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhHBQyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhHBQxz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:53:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23862C061796
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 09:53:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z4so22272243wrv.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CpONMo1NgsRjmLqGOdzgyXEs+Ovf29aJOIu4Ra261PI=;
        b=Oqy7fbClCErzxO0Ti/aKbq96ncaVt77aypfGVIxyk9BXkMFYVexdJLk1+plePBEp/+
         PRgOTLW5JMFdxt2wp+rmS7SOOloEz+RWtS+faS7o2oWDgu32Q3BYZVkdGerAVbn1W6RH
         pHB9lqgbYg7qMI7OtGZaAOX1e2vRCQiUv4q3C2xWtnEfougkc+PNfYdL4/2hU+8D0S60
         XLtnoAIUMC0rGU2m8e22yeMlBwFAHFBPtW0Om7/037S7a+5ZduKkoURd14joZMnfWtJA
         srjp8g/P+0hGyazpFD4FuXgqPmihMJ1oUh6JJlXorpYwJYgxnT4qRUJ0MAzHHbExcakJ
         E52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CpONMo1NgsRjmLqGOdzgyXEs+Ovf29aJOIu4Ra261PI=;
        b=Zjet+ysa8up5doA5Ikyths0mKKOSqXiNsHPZ3+R084mmChbhdzNDKm3y12bmXsvZgY
         DEwWEd8XrcEc53MgC4HblYZLaT2t6NzehonGWGQTssehH5NeVsSt9BejNaIITLHlk98Q
         uWirDf685tS11OoWitSwxtsQzYgOV+S1ueO9Fq1I5kYDDCc4N6sX7NcUIIta/EGFYZP4
         B6NWuOJdDKHqcgd93xV04HU0d35OFzFtqBi6LL+IebxX124wJsed4S1L/IEkO/CQrS1o
         +o1UP+QOnJ1iJdfl1XzzODVKiyo0iWt/0x1u/qCfuJBFRiqvMN/w3heJUECB7lf+oC52
         PJBw==
X-Gm-Message-State: AOAM533dsK/KGWpzNSGJIgshbP36fBiXLL/e/E5Mf7KozsKV+0gmbdx6
        Tg5qKzmqkAVeBoofGDdLTKzlStiSrU0=
X-Google-Smtp-Source: ABdhPJwBEOzChDFYkSIqOOWtnoS6bjxXVg3pyvBJeuZzkHtSX8CiFkgd2EAj5liTI8OVb3rIk1eiOQ==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr19011718wru.304.1627923224841;
        Mon, 02 Aug 2021 09:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm5031237wrd.97.2021.08.02.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 09:53:44 -0700 (PDT)
Message-Id: <4a3418b795451aabf6b79b7d7f09e09fa9e5bbc5.1627923216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
        <pull.1052.v3.git.git.1627923216.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Aug 2021 16:53:36 +0000
Subject: [PATCH v3 11/11] t6001: avoid direct file system access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6001-rev-list-graft.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 90d93f77fa7..7294147334a 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -23,7 +23,8 @@ test_expect_success setup '
 	git commit -a -m "Third in one history." &&
 	A2=$(git rev-parse --verify HEAD) &&
 
-	rm -f .git/refs/heads/main .git/index &&
+	git update-ref -d refs/heads/main &&
+	rm -f .git/index &&
 
 	echo >fileA fileA again &&
 	echo >subdir/fileB fileB again &&
-- 
gitgitgadget
