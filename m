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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35F3C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F2520936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAGv9BbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766863AbgJYDOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766850AbgJYDOM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:12 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBFC0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:12 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u127so6939386oib.6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2SZImvX+yzbkeHz8OzQRaJp2Im0l1+jrbI5zlIzL4Y=;
        b=TAGv9BbBW//JFq2UroZp7aemK3qw1VOx6ldvMwQJQ42ANCllwgg3rhtWUJPicfdUVh
         gloa/9fgtSgxj30Vl7k5+3L+l5c6se6zDGF2cOIgAQAxj60waakeWs5d0FMrlMBFy2UO
         IvPDZHLXMfXP8gXr5onZIvp2s1Vgdri9xZUYsgaRDvawqa72UIE1CNmh5gMrVPqsQxKY
         IovM1UZYzPA99eO4vugDIBj0K6nk4MHgD6kF5FA+8s/3i5UnYTAZ0dH9xVFIgOWasS58
         0jDr8eTAXUPQBgCf0TFV0jheQVmsi1BeBJHifhEkjQXNUZT7R8Tgd+VbuRf+Fh4Ze1ZI
         ex3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2SZImvX+yzbkeHz8OzQRaJp2Im0l1+jrbI5zlIzL4Y=;
        b=HY5njbGWvyUijjXAS8zaHtcJ07CBIc5esns68QWsWTPORy5QH62oNiE+dj9lhylFIm
         nWwDwVgNeKrMNgt1+Wu7VWdS9wB61W4j0UTYA2lo/IB/SfIgPMONzeMsYoFmnds3ik3X
         MS29hN1t8gqXwG1fuAPSJrpBbDKP9jD2jwXOhyfyLIut8p23fbpzSr6pDhxFF0mwB9qD
         jOLElpQwx1qUef0w+itF5dLIpKIxifyq7UPHH9NWfeetsiKIlJ1xU3B6KHuhlH7TapbY
         ByfkSCAiQGCmXeCgZ5xQHtlFj0vMSY30FhxI5TR/aTZ2tiMw/kYX/xaNitU4pVRiVk95
         2AHA==
X-Gm-Message-State: AOAM531gXc0sei6pW6lkGAmRtFIWAu4xXqDZEq6DOQJPLNsgOzt23v1+
        QFD56I0tB7zFb4qnY7Wk91OEBUkcoCCXzw==
X-Google-Smtp-Source: ABdhPJzaFznoXwsX3SLgv0lPMrFzG9fDO+T1aXSpUJJrCSRZCqQomUb514YD11KWZNjK5RmMj/kdJg==
X-Received: by 2002:aca:b588:: with SMTP id e130mr8378005oif.56.1603595651320;
        Sat, 24 Oct 2020 20:14:11 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q10sm1864082oih.56.2020.10.24.20.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/29] completion: zsh: trivial cleanup
Date:   Sat, 24 Oct 2020 22:13:31 -0500
Message-Id: <20201025031343.346913-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b955404fdd..f0babc784a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -129,7 +129,7 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compadd -p "${2-}" -f -- ${(f)1} && _ret=0
+	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.29.0

