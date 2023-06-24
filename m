Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F807EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 21:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjFXVXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXVXv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 17:23:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B52171A
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9cf20da51so19213221cf.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687641829; x=1690233829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9VUVtNgRkjG9Z7OOm1MkIXR7FvH2CNgpOWN91TCRXs=;
        b=n1bsTnckhgc7pRTdLw+ZK3VQiVsxD2O+WHU9VlmwOwiSm1BTitscBWsCNOw7wexuvd
         8Zfnf5X6YRU9xqPzKdaVmLLGb7niQb846SKaWcrte3kSmUKjGl/Ypqb2oHrkZIq+4rNr
         CS9Dn3AUrhI4GClpagozWHKHRdQ2yuHoWoUNmisO470kZxjScOHbEr5dW+3RhDefugnI
         3W6kp9fkCcr86t/4WCu58w8W4WF92e/HlJ/R/iCWL5gWLGnEaZd7B7sCBbN4rsGi096d
         84UWASU5ha4i4ihy4m64qKWJ/qmwt8HULp6NyU61iioTr3Z2DTTICj2xluo/tz5pjXh4
         yfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687641829; x=1690233829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9VUVtNgRkjG9Z7OOm1MkIXR7FvH2CNgpOWN91TCRXs=;
        b=axZDQ1Z5A+Etol0cWKT8659HnWBr2gS8wJrfYu35s6UIEUGcfUH1tzOrQInYDkEi/i
         LU/tpKjL1lWKQGngW3qXLpumDBdIHO9p3IDWqreGYYUwwl94dDhqoiYTHP3bsWn/VRik
         mLjfuO9MMofxvygkW0I8yzIQ43llZV8eQ5CtCACKmMafuLCUqP5QCR2XBz/3ibTHNppN
         TQtog9e7kIWLSBIUL0azFE2TjjP3D2IqyhcqM0TGD1ANg8N1nCpZ7UlZxC/YIYm8huQx
         +/pLWXF31rlCtzxwRTmbzZBeJglm/7mhrYNJVPEdMuCkq+pAMDLDBo9DD+QhmdvKx1Ej
         SXTw==
X-Gm-Message-State: AC+VfDyIhqoD5Oa+aI9hux121McohR8ibWOP7uXuhiy/CJNgVBdWGz1i
        axgDQ9N7ggIEFUwwAPhDiDScdXSl8Cl7/g==
X-Google-Smtp-Source: ACHHUZ68854fwvtKRb8UD2i4rtckonjjwfpv7fBSPvlmGaN41dZjkq6HhK2kbK7kcBWywmmWVUJ3/A==
X-Received: by 2002:a05:622a:13c8:b0:3f8:4905:9533 with SMTP id p8-20020a05622a13c800b003f849059533mr31713421qtk.50.1687641829348;
        Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id x15-20020ac87ecf000000b003fdd34c6babsm1118182qtj.76.2023.06.24.14.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 14:23:49 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v0 1/4] git gui Makefile - remove Cygwin modiifications
Date:   Sat, 24 Jun 2023 17:23:44 -0400
Message-ID: <20230624212347.179656-2-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui's Makefile hardcodes the absolute Windows path of git-gui's libraries
into git-gui, destroying the ability to package git-gui on one machine and
distribute to others. The intent is to do this only if a non-Cygwin Tcl/Tk is
installed, but the test for this is wrong with the unix/X11 Tcl/Tk shipped
since 2012. Also, Cygwin does not support a non-Cygwin Tcl/Tk.

The Cygwin git maintainer disables this code, so this code is definitely
not in use in the Cygwin distribution, and targets an untested /
unsupportable configuration.

The simplest approach is to just delete the Cygwin specific code as
stock Cygwin needs no special handling. Do so.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Makefile | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index a0d5a4b..3f80435 100644
--- a/Makefile
+++ b/Makefile
@@ -138,25 +138,10 @@ GITGUI_SCRIPT   := $$0
 GITGUI_RELATIVE :=
 GITGUI_MACOSXAPP :=
 
-ifeq ($(uname_O),Cygwin)
-	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
-
-	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
-	# POSIX path translation just like cygpath does and we must
-	# keep libdir in POSIX format so Cygwin packages of git-gui
-	# work no matter where the user installs them.
-	#
-	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
-		gg_libdir_sed_in := $(gg_libdir)
-	else
-		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
-	endif
-else
-	ifeq ($(exedir),$(gg_libdir))
-		GITGUI_RELATIVE := 1
-	endif
-	gg_libdir_sed_in := $(gg_libdir)
+ifeq ($(exedir),$(gg_libdir))
+	GITGUI_RELATIVE := 1
 endif
+gg_libdir_sed_in := $(gg_libdir)
 ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
 		GITGUI_MACOSXAPP := YesPlease
-- 
2.41.0.99.19

