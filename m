Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F4CC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BCB222C3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clsrljqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766871AbgJYDOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766860AbgJYDON (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:13 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283AC0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b2so4539373ots.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TByR5ou9H4c0OYKGXvNNbjYTl32Va4BokotCm+HNExI=;
        b=clsrljqL5AxXE7ENzt0gBPpuNtAO5ML9Ve2kvBy4rccNM2Ikkh5OLtk94aLP5bNc9J
         8Wa/c5aGq1d48YEyACqLFqX2hP5ew8++xO1NTR0+CIWmjRvwBxPs5AZyfDlPDpzhBenb
         Ri6OwJpYjwnRO5ZCqJIsW4jQ/rN9rOcRH1glOf+eb75i15r52kHt1ayyOLairfoyfASZ
         4oxCxmOjsnyvZtyzSRh7fzjRD2Cs9B8fcFNcX4+lohUTO1V0UhJfgN97YFGJtGTvVOfr
         dqqfXqvd8d5ThVbXPGigK6y1J8Snj6ApIuj9p+mOfmP9+G+GBkBz8vTAPr2VI9L2BgV+
         IqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TByR5ou9H4c0OYKGXvNNbjYTl32Va4BokotCm+HNExI=;
        b=BygH7bmYLtBvnJ57eyeCf9hfap7vMFXs3IAdmetmtie7ev/JivJTwlu5q3YE7bGkYX
         ZDPLVbjoGMOsH7aOGig/a4sMNLPBYZKNvi/d1IirG3bf0Ax2Zv/WyAduhFqKV0WS/oBi
         Wm3O4DRoIL1rgqk6Gg4Bd5d1BKZ+sCMP9lX+dWXMKlrOCkB0Vo+QEjLkBJqkBYxuwjsV
         siG4Y40QTyKsXUxVoYfbvOo7iYmUIHmTf7MAUHSK7HNPPFqwm4pSNyJZ8wMU0OaIoLxS
         bhYJInMvYe/5Fas7n04WVgu/n581RCEKXF0pmGGu5z4nCnctq4eT+UmoMCBQk2yw941B
         i6mw==
X-Gm-Message-State: AOAM530kRXYmXkLb6qlHrrzsSq5VaaEZ1AX3mfKwQvpdgio6wvOaPtC6
        UE4WyHLdZn6J85bLxOcIsnxRjPEre1M3RQ==
X-Google-Smtp-Source: ABdhPJy862mRYOIQeyDpLrahUqyKmhDegCagR7pYVWBXjVKwECSnMzyhIwKgILMAgmGwcQdirfde7g==
X-Received: by 2002:a9d:781:: with SMTP id 1mr8005188oto.350.1603595652775;
        Sat, 24 Oct 2020 20:14:12 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y10sm1659665oot.46.2020.10.24.20.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 18/29] completion: zsh: simplify nl_append
Date:   Sat, 24 Oct 2020 22:13:32 -0500
Message-Id: <20201025031343.346913-19-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's exactly the same as __gitcomp_nl(), no need to duplicate code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index f0babc784a..85365bd2f7 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -112,10 +112,7 @@ __gitcomp_nl ()
 
 __gitcomp_nl_append ()
 {
-	emulate -L zsh
-
-	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
+	__gitcomp_nl "$@"
 }
 
 __gitcomp_file_direct ()
-- 
2.29.0

