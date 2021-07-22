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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B04C6377C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B610561249
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhGUX2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhGUX2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:28:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78365C06179B
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:11 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so3714666otq.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7XPsHr+QYWLtj5cIN4rDERCBDOs9WMoxaobb1pI12og=;
        b=LyKscApPNJkxTfgl0siTJlpcjDnC2zWSGRGVfyepcQqDQj0afGrs5bwWZfgisHNP77
         VpW/XhTVYvgVjThtnwdDbf3QONU/Ng8Em5K9SvBLJTab47ulB1KFzj8lBdl9b2h4gx7l
         FGPp1M60f8spjzmX93G82l9aq10QWXyuVgwCaHaqLCJgHJ+iAQoV8n2DNpuOqVIj5fxL
         GoMdP7pzF+Avz/U139NC7bjlY4wm0xDne5dmgTi3rrsOrK2WB8c06Vvu0xjAS3iseKUR
         FoENILh5K67knMTOzmwUQuWQK1wLKWpN8VkUJ6Qig4Qphs9FvO7V8MxADbk1efLUAkSd
         E7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XPsHr+QYWLtj5cIN4rDERCBDOs9WMoxaobb1pI12og=;
        b=S0LkxSGnZ8fD7ZV7JNmKtvWH2XVl5WW6i5BxCgS7lZQyfX/Rh/7Cx51jEyrnWnr7Zh
         rrqDDyl+YZdAFkMEhOtiPobc4jZKmNuRI38QdsY4C/sQrWZ6Yzn9z16j2h8lYR3KOgCM
         xux3LlMAshQW4/QUkLZbYSeGhx77EmHekWCoRESA6QDf9nlj2elEONq+VA6JGQ3iUXZZ
         Vu+pCf8jrvMirxccUb+5Gw7JA516VUDqOo5FSbizPAKZehSt0kPVs65L3c7g9CamQKSl
         XAoCIEHDX0xOps3tTlBVavSXd24Xk/HZYVK2QsaYbZdcXvkGSCoMrFlwZNjVTkjyXma4
         aY4w==
X-Gm-Message-State: AOAM530ejwCqiX43V74RgSKoyw6ptOiJGiZIeWtm5KdBs8+E8tpBHkaw
        O84dOFlJY4bUY3Uq3C39Ejuql0aZb8cvUA==
X-Google-Smtp-Source: ABdhPJwXwKlfXIcD3AHPW2FF7nRGvQX+mFUTwMhb9/M4DIaj0ZHHwQDWkn/CLjSHxhIl3WI4jqS9WA==
X-Received: by 2002:a9d:1c99:: with SMTP id l25mr28308077ota.26.1626912550667;
        Wed, 21 Jul 2021 17:09:10 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r24sm4953472otg.14.2021.07.21.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 17:09:10 -0700 (PDT)
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
Subject: [PATCH 7/7] fast-forward: add help about merge vs. rebase
Date:   Wed, 21 Jul 2021 19:08:54 -0500
Message-Id: <20210722000854.1899129-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
In-Reply-To: <20210722000854.1899129-1-felipe.contreras@gmail.com>
References: <20210722000854.1899129-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have a locus for merge versus rebase documentation, we can
refer to it on the diverging advice.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-forward.txt | 48 ++++++++++++++++++++++++++++++
 advice.c                           |  4 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
index 38c920964f..1989fdec4a 100644
--- a/Documentation/git-fast-forward.txt
+++ b/Documentation/git-fast-forward.txt
@@ -50,6 +50,54 @@ synchronize the two branches.
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
 
+MERGE OR REBASE
+---------------
+
+The decision to whether merge or rebase depends on the situation and the
+project. Traditionally git has prefered merge over rebase, but that creates a
+new commit, and that's frowned up on some projects, so you can't just simply
+choose to merge blindly.
+
+------------
+    D---C---B---A origin/master
+	 \
+	  X---Y master
+------------
+
+The nature of distributed version control systems make this divergence
+unavoidable; you must decide how to synchronize this divergence.
+
+Should you choose to merge, the two heads (master and origin/master) will be joined
+together in a new commit:
+
+------------
+	  origin/master
+		|
+		v
+    D---C---B---A---M master
+	 \	   /
+	  X---Y---+
+------------
+
+This new commit is called a "merge commit" and has two parents (A and Y).
+
+Rebasing on the other hand rewrites the history:
+
+------------
+	  origin/master
+		|
+		v
+    D---C---B---A---X'---Y' master
+------------
+
+The commits that diverged (X and Y) are rewritten as if they were created on top
+of the new base (A). This creates a linear history, which is cleaner, but some
+people prefer to preserve the original hsitory.
+
+In both cases it's likely you would have to resolve conflicts, the difference is
+that in a merge you would have to do it all at once in one commit, while with a
+rebase you would have to do it on every rewritten commit.
+
 SEE ALSO
 --------
 linkgit:git-merge[1], linkgit:git-rebase[1]
diff --git a/advice.c b/advice.c
index 60de7fbc4e..7f422b05d3 100644
--- a/advice.c
+++ b/advice.c
@@ -337,5 +337,7 @@ void diverging_advice(void)
 		"\n"
 		"or:\n"
 		"\n"
-		"\tgit rebase\n"));
+		"\tgit rebase\n"
+		"\n"
+		"For more information check \"git help fast-forward\".\n"));
 }
-- 
2.32.0.40.gb9b36f9b52

