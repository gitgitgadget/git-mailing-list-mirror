Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47BC6377A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDBD61241
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGUX2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGUX23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:29 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052CC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e11so4765331oii.9
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSwU/7B8rq6qxQau9vq9At+n53HDCsSLl1qPRU6p7WY=;
        b=BHHqwhsqzoXFNCHMfuVtilOyLBGbCj1+kpeJZTdx1eg7XoGsuyuE5K6h7YCJsd8k6A
         75JR+yWXEbywuP4elrREjhZtztSWdeHLmd6wgW7CBNwQ7KlBd9D0JSXYXfZKjWNGNt2T
         wCIMvTnMrLJ70I66pwjPyssFzIOoyPTYmMqkbLNDWdW+iDJwwibpN+5CnCrAdQxlotHe
         lamfojkeLvHJtQlTqU/xDWglZj0I0tvLsUaSABPKJCKV1KjC/W+oJNdMymFN+Ye6JdpK
         dYuP/H7usxO8rYx99ob4KkQAs/VqEvRs8d4TzCeF69sW0Ny+kSmNQZmNw3c0adZmH7rs
         pSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSwU/7B8rq6qxQau9vq9At+n53HDCsSLl1qPRU6p7WY=;
        b=pcPFVVd3J046dUjKolV3qs5id9slonom34MFMAF8Aavm3RDzITpIzswSK3kzFdGj99
         99+S3LmfB+iJcYJt1nTc7kKNXW6D0Vk8onw+tuA3mGUM/wpj79l476kO+FV30f5d+H9x
         TD1Pkkb0AQbeOha3Zllxc96VzvZPyCldbcuD2p5HkUTPtJ4Z2AT4uJvL7BLpk0sEkBEh
         AUXuWPIn01lgFjVOO9ncDAxmJfQFwVL+Bhhb080GdVTtU3vlAoOhj1bbYQvWiD33GMqI
         NUbAJHNP+Qk47EcWSnLcmZO4IF4ZwGirwO2drUctqEyXVkzNMyosvW2IUw8Kavve6qjK
         enjQ==
X-Gm-Message-State: AOAM533MtLKil2aksucWNrtl/PjwGmqgtCgFTDdf3pfKohHzSCsxIlLc
        D2+4GSOR3bNv+N9I1tMG62OXNaEILV9BWg==
X-Google-Smtp-Source: ABdhPJzsUk6arTcG8QqH95OIkD40miKyVBt74MAII0awtJc1VnMCNykZmiAYyqd4nji1jd2O3GJgfg==
X-Received: by 2002:aca:3286:: with SMTP id y128mr4272763oiy.115.1626912543637;
        Wed, 21 Jul 2021 17:09:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o26sm4991177otk.77.2021.07.21.17.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/7] merge: make the diverging advise configurable
Date:   Wed, 21 Jul 2021 19:08:50 -0500
Message-Id: <20210722000854.1899129-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With advice.diverging.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/advice.txt | 2 ++
 advice.c                        | 4 +++-
 advice.h                        | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 8b2849ff7b..dae85310dc 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -123,4 +123,6 @@ advice.*::
 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
+	diverging::
+		Advice shown when a fast-forward is not possible.
 --
diff --git a/advice.c b/advice.c
index 8f068c8be9..60de7fbc4e 100644
--- a/advice.c
+++ b/advice.c
@@ -110,6 +110,7 @@ static struct {
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
+	[ADVICE_DIVERGING]				= { "diverging", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
@@ -329,7 +330,8 @@ void detach_advice(const char *new_name)
 
 void diverging_advice(void)
 {
-	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
+	advise_if_enabled(ADVICE_DIVERGING,
+		_("Diverging branches can't be fast-forwarded, you need to either:\n"
 		"\n"
 		"\tgit merge\n"
 		"\n"
diff --git a/advice.h b/advice.h
index 6ce967c962..695f5a62bb 100644
--- a/advice.h
+++ b/advice.h
@@ -49,6 +49,7 @@ extern int advice_add_empty_pathspec;
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
+	ADVICE_DIVERGING,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
-- 
2.32.0.40.gb9b36f9b52

