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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22686C6377A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDEB61244
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGUX2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhGUX2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE104C0613D3
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:09 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so3714601otq.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ifr11gmwwjvHbboaF8ARfkoBBFj0sBb88BxkO7vJgSs=;
        b=Ia1G+Dd3/hhbT3gPiHWJe2lqGWLzMIVs14UEHAEqLdYtgiDf5paLKl2/4OlnzhZW01
         9pPUPQIurwyPdF16z9K3sllSDD/Ol+NTSnUp8A78IMnRMUHatlMFTMhtcRNC/pzYV2Wr
         aCE8RkPpijGa74LgIQEj342678qHbuoz4883YIwmO8pmVkXj9Tr6NBzIoESh69pQxEV1
         8+TML5UMZe80fI8iV8G5crNebDIrOEMCf5aSTpDaqN04VxNH2xJyBqaMiTnWeymk59/M
         kfWF8czu9aHIuf4Im5/h8TGNyBOtUIGeySzBEhFtSMWINOSq9wO8NeTrAMx1HPvK0noO
         MyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ifr11gmwwjvHbboaF8ARfkoBBFj0sBb88BxkO7vJgSs=;
        b=SgzJkbBXTr1ILhmynHW2OQZk4Z63usgW3QJRRg2eO/GNXXQpjDZavC5x+zzDZqmwnJ
         umhGzeCR7gnKAHOfRxEr8MsnG5jScC2V/qfXt7fli31xIhaxkL4I51Bf+yQLBP1JYmFc
         IApMv7jafdzGhdo4St/0xNW5463fM7q1herPSq7sx228rCPPNUZCyK1A3vNiBwlwOAkK
         gl4soxLmaPxEruwKpQrjAE0uo9XY4w7mO+9OHbPiy3EjDJX3z3zOHwlIHSIJa3YlGUrH
         Ue5EqhyNOq4s34SswYZ4KphK8KvcQElJ60/FbUDdXZXJAr3q1HrypI1Cx7VpJhQ9ZT3p
         X27w==
X-Gm-Message-State: AOAM530QXYaqdGi/6flLLvQMfLyvC6RhYwY+DVhNVo+p02lD2J/odbL2
        M4v3LwwGfjB9QnTprt/qhitA6GJ9L9BLig==
X-Google-Smtp-Source: ABdhPJzsO/ezJBaiREf4rSuDNTHUMSXN7K6s6JCMe/SgyKhuYfqM9kx6Ogz3izN2/iizO9h1Ayyb7w==
X-Received: by 2002:a05:6830:1f2b:: with SMTP id e11mr27952118oth.336.1626912548914;
        Wed, 21 Jul 2021 17:09:08 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e31sm4575621ote.22.2021.07.21.17.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:08 -0700 (PDT)
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
Subject: [PATCH 6/7] doc: fast-forward: explain what it is
Date:   Wed, 21 Jul 2021 19:08:53 -0500
Message-Id: <20210722000854.1899129-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-forward.txt | 35 +++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
index d457022629..38c920964f 100644
--- a/Documentation/git-fast-forward.txt
+++ b/Documentation/git-fast-forward.txt
@@ -15,11 +15,44 @@ DESCRIPTION
 Incorporates changes into the current branch. By default the upstream branch is
 used, but a different commit can be specified in the arguments.
 
+Assume the following history exists and the current branch is
+`master`:
+
+------------
+    D---C---B---A origin/master
+	^
+	|
+      master
+------------
+
+Then `git fast-forward` will advance the local `master` to `origin/master`:
+
+------------
+    D---C---B---A origin/master
+		^
+		|
+	      master
+------------
+
+This operation is not always possible; if you've made changes and the branches
+diverged:
+
+------------
+    D---C---B---A origin/master
+	 \
+	  X---Y master
+------------
+
+then the fast-forward command will fail.
+
+In those cases you need to either `git merge`, or `git rebase` in order to
+synchronize the two branches.
+
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
 
 SEE ALSO
 --------
-linkgit:git-merge[1]
+linkgit:git-merge[1], linkgit:git-rebase[1]
 
 GIT
 ---
-- 
2.32.0.40.gb9b36f9b52

