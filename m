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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD0C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9066020936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqRXPLHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766901AbgJYDOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766890AbgJYDO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:27 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7DCC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:27 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n15so5085826otl.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrkicLVmMPDV7C0agD08QEXLiVvggzyoG//El5+14bw=;
        b=XqRXPLHRg9D0ZsS8/TsB9Ocn9DrgvTa4sMc2sw2ryX0jP2fFbn48mvMoXgqPtheIBN
         u0T8At6IEIke+M9xSK5K9tyqfNzmVnU3Rr+bwvOQG4sBVmIQIX1xCi1d6VyaWusV1Keq
         s5tOW/7WeJX25TXOZ87X+nP4dzNCT2M9SlHZNroRqp3PyoxNnriV8Z18ZpH9gPDRld36
         H3u9UB0r8s5k0cxjhudF93Rp7rsQ4dzCrBy44K7Vs7xZi2XbL1wi/DCD3ZEBfAzrJcDq
         UHUX86QwCZ0SO3ISEYiW+phxpuX+VH6wk9wsCFeotSS/dvgWpk29L7mImsTHnu5yPhEJ
         b61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrkicLVmMPDV7C0agD08QEXLiVvggzyoG//El5+14bw=;
        b=LFwZcVUDtu1S1wqK+mQMhXoBe8A3VlxqDo2E9j/PNX97Eakvel1QFF4bflakk6OXO9
         XoxpW9qk3IE52YOPpgdj908nyHJTs4H5+SxoX1ltV3k874/J1eGIaCg93iwP2ggScLSq
         RyIw8rlX4069OlS9JtiONyJM/8rEmSXLOCfC6M4z5nd6/tqbWQRUJGSRKgNY5vJeqBqz
         QmgrOymX9KH689u8VEgG9K7crMFjKXQcxAsbBdi42l7FaL5ukMfgz9o1QURqllIuIwmF
         260ESur4qR2XwtxYD96Prvy/t0V4+mqdTu7XHMRhnI8Ng5Rni3bRvUI04ZD6iDtu1Rrd
         fC9Q==
X-Gm-Message-State: AOAM531wqVV3kxb1enj0UQvIvdu91IySjStESJn8EBdHfxvnH0QS6fAv
        bLfP21t1caqbieNog/WWLg6+Lq51JbwQow==
X-Google-Smtp-Source: ABdhPJyzKNKHPi8N1rHQivAO7sALcOp3oBOGR18mNROeHzHUrItB/I/NoAkMecastd9BPaKhXk7AsA==
X-Received: by 2002:a9d:6b09:: with SMTP id g9mr6890217otp.202.1603595666417;
        Sat, 24 Oct 2020 20:14:26 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w16sm1679086oth.8.2020.10.24.20.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 27/29] completion: bash: cleanup cygwin check
Date:   Sat, 24 Oct 2020 22:13:41 -0500
Message-Id: <20201025031343.346913-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid Yoda conditions, and use $OSTYPE.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 68e0acb232..ac1835cb30 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3500,6 +3500,6 @@ __git_complete gitk __gitk_main
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
-if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe __git_main
+if [ "$OSTYPE" = cygwin ]; then
+	__git_complete git.exe __git_main
 fi
-- 
2.29.0

