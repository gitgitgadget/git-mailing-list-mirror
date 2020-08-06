Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63364C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D092173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBzAAwA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHFBF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHFBFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:05:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321EC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 18:05:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 9so7343486wmj.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4UuM5/ldThGYvw7XCsyyhq8treS7zYTiB/PDxgaYZOI=;
        b=ZBzAAwA+yry85/CTaVNZRpOaNpJ1lcpllUehK0/vBQJt9bdWo1v97XG4PCqK6acHc9
         nZIf8XQFmV7l6uVn5Hxpkj+uwW2yPiDnNQmftlWsmvwWih0BBW+AiHu9WJal6mInLCot
         +9xWdtEF97OgzYNzpvAiW9l/8ES4PYfYsV0hYy7JLpyZ1AWhbc0dtDlzMr0BF8CpZvz8
         KuNWfrupmO8XJvCN7UYCghMSIyP25Zees4E7+F17w6vZbiJoycKqWRIaWILsBHusFVQ+
         gbFA+DYO7Zp0qwSCC1xrZIS0gdbk1CvwfTNw3zRskt8znG4Y/YpnHEK9mrQ4bS95w6Kd
         JNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4UuM5/ldThGYvw7XCsyyhq8treS7zYTiB/PDxgaYZOI=;
        b=jdL5ahcYF4sye1DZbwl+K/OJ4YIMkehDEqkMJ9+QL2t53Q3ynNb8cn9yUcgsxUL49i
         RoBedXFU6N9HfFvUNsOibuzoShkmScyn9A6bF0xx5p5POhxQE0L66k4ehhquV8HvbrgC
         PoPUBFqizJ4zyKwWGwMT2akz2Rbag3KHZcEr3bDAjX0BtRbBz/P5LGNz0A6x52TPgmBj
         6TqWKP4ngmWQwQpSu6vMoZBcD+WACyikEvAWqdXmEnk/mWpCqzljI5t1CPbirTKC4XXS
         LRurN7pdN8jUO7KJ5UM/6lSa7BwItzvcPbFfemtXQM5psc3zSMn+4LsN5GH/czuGd4Xs
         7hew==
X-Gm-Message-State: AOAM530wS8ecCkKir+ABRBMWW3Ye60A9SEnVRZEuPr9+8N2hvGb7xq4s
        T+A0YYhkhBj2yqdIZCnCJZv9PrjN
X-Google-Smtp-Source: ABdhPJzuSm2N++PCbwCNZSQajjTkF7r50j7LDDzy3JzT5M7YWH1hXMMGLopFSwK2a5elWkVRoJsTJg==
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr5310135wmt.44.1596675907805;
        Wed, 05 Aug 2020 18:05:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s205sm4861107wme.7.2020.08.05.18.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 18:05:07 -0700 (PDT)
Message-Id: <22f8f3e37a18263d890307701903dc18c98aa54b.1596675905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.git.1596675905.gitgitgadget@gmail.com>
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 01:05:02 +0000
Subject: [PATCH 2/4] Define TAR_CF and TAR_XF variables in Makefile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "KADOTA, Kyohei" <lufia@lufia.org>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Plan 9's tar(1) don't support o option.
So I changed Makefiles to replace tar commands if needed.

Signed-off-by: lufia <lufia@lufia.org>
---
 Makefile           | 14 ++++++++------
 templates/Makefile |  6 ++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 372139f1f2..e222241509 100644
--- a/Makefile
+++ b/Makefile
@@ -547,6 +547,8 @@ AR = ar
 RM = rm -f
 DIFF = diff
 TAR = tar
+TAR_CF = $(TAR) cf
+TAR_XF = $(TAR) xof
 FIND = find
 INSTALL = install
 TCL_PATH = tclsh
@@ -2926,13 +2928,13 @@ endif
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
-	(cd po/build/locale && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd po/build/locale && $(TAR_CF) - .) | \
+	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR_XF) -)
 endif
 ifndef NO_PERL
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
-	(cd perl/build/lib && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd perl/build/lib && $(TAR_CF) - .) | \
+	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR_XF) -)
 	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK
@@ -2999,8 +3001,8 @@ install-man: install-man-perl
 
 install-man-perl: man-perl
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
-	(cd perl/build/man/man3 && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
+	(cd perl/build/man/man3 && $(TAR_CF) - .) | \
+	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR_XF) -)
 
 install-html:
 	$(MAKE) -C Documentation install-html
diff --git a/templates/Makefile b/templates/Makefile
index d22a71a399..eddc07effb 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -6,6 +6,8 @@ endif
 
 INSTALL ?= install
 TAR ?= tar
+TAR_CF ?= tar cf
+TAR_XF ?= tar xof
 RM ?= rm -f
 prefix ?= $(HOME)
 template_instdir ?= $(prefix)/share/git-core/templates
@@ -62,5 +64,5 @@ clean:
 
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
-	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd blt && $(TAR_CF) - .) | \
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR_XF) -)
-- 
gitgitgadget

