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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2470C43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8511F6105A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhDZQUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhDZQUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA8C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:49 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 35-20020a9d05260000b029029c82502d7bso21188363otw.2
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2fUlfveS0C8CnjRwhf7QKxanU9/P6mi3DIHkBJAnBc=;
        b=ius+6UzW8MHdT1xrlG0qpwwNGSgzg2CHGuopc39ATwELPmjGlC4Ar7u0U0KqNkzzh6
         Plkhb3Qfvc2OTBQ7+radF/BiQxBtoh7Q5PqHkCQhU5fFdsug8sg59swjpjg/gTiFE/2y
         wtQqjkfnljCAZPnCpkL6ddnjZrWVWtb6o0jWPPZSBG8xvRfDAMvaVslOJvjZ9XmfNWow
         Qa7nhls0u5VhqgztG1ZoZfDtZgFiCsMYx+opNvnjVWYhNxp7scLoEtxeOX5d3Fu7+Ptm
         RHTikjr2J0g2ah2I21sC9rPIiET5yEgWDKTuoErzhZAW4B2IdhccEEPSXh3YwavXCqud
         g2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2fUlfveS0C8CnjRwhf7QKxanU9/P6mi3DIHkBJAnBc=;
        b=hxknpdxki7reYR6jDg+NbyMGKsK1bevoj3iIa9lTQgGrOD2437CQRBz6WwUK+zOg7F
         I9rhW74NRTyRrdHUdh/mlgSmOGKb7TJAWbKiT6MfuStY2MjYzq4p20k6yOtHjNANvzpV
         mrZIE9JJP5Dc5i4V0klllACHQX8QmQsT5IwF7SJkVT+z7TUA/X7W3toWfMnoxUqS7tLa
         YpZULMsfBu2OH7BMvW3FiVS1UPLLh+cnpkV4MgUDvzBGp7pkHM3aUVJF84+x+U5CqgGS
         fxCJDHUP0xyOxzM7N3OR5sTyQUskIgdoot5HS2k4FZY5FXocNShB4fom2cCN3CTn1g75
         Qyzw==
X-Gm-Message-State: AOAM530SJCqnJOUG30GA6Oh7d3+/+CgGvgW2iOqpodc4sQfy7zTdShCW
        8KY67LzrYg8K+hJboZ4+NqcLOR45DKAu/w==
X-Google-Smtp-Source: ABdhPJzBmSaoJ19IoMjaCKj79lMk2XUC1ywPRn3WBmWnZNyBofgnMOKlRHOOTnEI7Xf7J0R6Y84Rjg==
X-Received: by 2002:a05:6830:1507:: with SMTP id k7mr3615757otp.106.1619453986965;
        Mon, 26 Apr 2021 09:19:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id l11sm67760ooq.44.2021.04.26.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:19:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 33/43] completion: zsh: shuffle __gitcomp* functions
Date:   Mon, 26 Apr 2021 11:14:48 -0500
Message-Id: <20210426161458.49860-34-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6afcf1810b..3665167b3f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -87,11 +87,6 @@ __gitcomp_opts ()
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
-__gitcomp_direct ()
-{
-	__gitcomp_nl "$1" "" "" ""
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -106,6 +101,11 @@ __gitcomp_file ()
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
+__gitcomp_direct ()
+{
+	__gitcomp_nl "$1" "" "" ""
+}
+
 __gitcomp_file_direct ()
 {
 	__gitcomp_file "$1" ""
-- 
2.31.0

