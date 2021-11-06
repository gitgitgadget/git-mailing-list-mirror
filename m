Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1737C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8220610FD
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhKFVGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbhKFVG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01DC061234
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w29so7948269wra.12
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0fNjK2gpfLEAZYG6wfYL7G7MpvKA2h/dPgx8Nresas=;
        b=YIxp22EqnXIvYZTgGjCyB5TxTAhnqt+tnneYRfhmWTIJ4HwRKETMtA9ELGDCNicr3U
         CDVA8/7957Aj5SmtHMMjzHRwCFPl6a7TrCb5W/58n6vmCcwc/2zmyLyNdrv8y/a8zwmU
         L600cVjJFxObCq5KVL5FHqiN5ezvzevSZxMXOtw6QxcaSFaV/zJ8u8fJBGE8S/GoGRNH
         xTEzkFpEo8xE5T+71k/RcG97611Vv8b73vdaW4ixJnK+6vCFe4M32bG9RpI/JynFuVrr
         8d2FrfreKRM84BBWQuA6qyPCMsW51Ef1iBdjpn8tEJ3CGIBe4E8yQeXjqFND6UTe3Qud
         zaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0fNjK2gpfLEAZYG6wfYL7G7MpvKA2h/dPgx8Nresas=;
        b=URY0ScVe8qLPyExq5KBHZbkaUrQ0D7clUE6f3Yk57eu3j/pCuEEI9wY7NFopNZOnVv
         rMW3d6poXorSY3OmL6PQF/0eMdiftTo4pEJYZPsiYT0HylJFnWD2AxmbeDfCi2nNA5c1
         zsUbUg/cCyJs5+DBYjikZnt4KOwbShHB4S113m57hbpfp0aD3ogtG9fTW2W8SBBJ2HQm
         GYh4G1Q9+kcZokeexxWNw0ECaCboaqI/DOOFwmGFpcCI1SRLm5CVZimHH9e8UJCvkdyi
         WBxmd7/VXoqtEBX0FKdDYLzRbGpoZ5qvWSAjjqCnaD+uMukl1Hq5oOgROcXzQNIlOv+D
         TLcQ==
X-Gm-Message-State: AOAM533tDffzxwGAshsdg4xm9WLovoB6J5Tz4R9VzH2rBj2U8PUsSOnQ
        2b22Vlv5izEX5MX2d40vCBDw5nJ706HqZQ==
X-Google-Smtp-Source: ABdhPJxY+3FXv1AjWdfumr62xC8A5m+3340Xyaqt6oscxlh6W7QxAhlKI5pDKFqSGojr/SmqT788Lw==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr52744121wri.438.1636232611474;
        Sat, 06 Nov 2021 14:03:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/16] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Sat,  6 Nov 2021 22:03:15 +0100
Message-Id: <patch-14.16-2966218d6c8-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the mostly move-only change in the preceding commit to use the
$(wspfx) variable for defining the QUIET padding, to guarantee that
it's consistent with the "TRACK_template" template.

    $ make CFLAGS=-I$RANDOM grep.o wspfx='$(space)->'
     -> GIT-CFLAGS PARAMETERS (changed)
     -> CC grep.o

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/shared.mak b/shared.mak
index 850ce1f6a0f..566eb70cf2a 100644
--- a/shared.mak
+++ b/shared.mak
@@ -67,39 +67,39 @@ ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
 ## common
 	QUIET_SUBDIR0  = +@subdir=
-	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo $(wspfx_sq) SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
 
 	QUIET          = @
-	QUIET_GEN      = @echo '   ' GEN $@;
+	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
 
 ## Used in "Makefile"
-	QUIET_CC       = @echo '   ' CC $@;
-	QUIET_AR       = @echo '   ' AR $@;
-	QUIET_LINK     = @echo '   ' LINK $@;
-	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
-	QUIET_LNCP     = @echo '   ' LN/CP $@;
-	QUIET_XGETTEXT = @echo '   ' XGETTEXT $@;
-	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
-	QUIET_GCOV     = @echo '   ' GCOV $@;
-	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
-	QUIET_RC       = @echo '   ' RC $@;
-	QUIET_SPATCH   = @echo '   ' SPATCH $<;
+	QUIET_CC       = @echo $(wspfx_sq) CC $@;
+	QUIET_AR       = @echo $(wspfx_sq) AR $@;
+	QUIET_LINK     = @echo $(wspfx_sq) LINK $@;
+	QUIET_BUILT_IN = @echo $(wspfx_sq) BUILTIN $@;
+	QUIET_LNCP     = @echo $(wspfx_sq) LN/CP $@;
+	QUIET_XGETTEXT = @echo $(wspfx_sq) XGETTEXT $@;
+	QUIET_MSGFMT   = @echo $(wspfx_sq) MSGFMT $@;
+	QUIET_GCOV     = @echo $(wspfx_sq) GCOV $@;
+	QUIET_SP       = @echo $(wspfx_sq) SP $<;
+	QUIET_HDR      = @echo $(wspfx_sq) HDR $(<:hcc=h);
+	QUIET_RC       = @echo $(wspfx_sq) RC $@;
+	QUIET_SPATCH   = @echo $(wspfx_sq) SPATCH $<;
 
 ## Used in "Documentation/Makefile"
-	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
-	QUIET_XMLTO	= @echo '   ' XMLTO $@;
-	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
-	QUIET_MAKEINFO	= @echo '   ' MAKEINFO $@;
-	QUIET_DBLATEX	= @echo '   ' DBLATEX $@;
-	QUIET_XSLTPROC	= @echo '   ' XSLTPROC $@;
-	QUIET_GEN	= @echo '   ' GEN $@;
+	QUIET_ASCIIDOC	= @echo $(wspfx_sq) ASCIIDOC $@;
+	QUIET_XMLTO	= @echo $(wspfx_sq) XMLTO $@;
+	QUIET_DB2TEXI	= @echo $(wspfx_sq) DB2TEXI $@;
+	QUIET_MAKEINFO	= @echo $(wspfx_sq) MAKEINFO $@;
+	QUIET_DBLATEX	= @echo $(wspfx_sq) DBLATEX $@;
+	QUIET_XSLTPROC	= @echo $(wspfx_sq) XSLTPROC $@;
+	QUIET_GEN	= @echo $(wspfx_sq) GEN $@;
 	QUIET_STDERR	= 2> /dev/null
 
-	QUIET_LINT_GITLINK	= @echo '   ' LINT GITLINK $<;
-	QUIET_LINT_MANSEC	= @echo '   ' LINT MAN SEC $<;
-	QUIET_LINT_MANEND	= @echo '   ' LINT MAN END $<;
+	QUIET_LINT_GITLINK	= @echo $(wspfx_sq) LINT GITLINK $<;
+	QUIET_LINT_MANSEC	= @echo $(wspfx_sq) LINT MAN SEC $<;
+	QUIET_LINT_MANEND	= @echo $(wspfx_sq) LINT MAN END $<;
 
 	export V
 endif
-- 
2.34.0.rc1.741.gab7bfd97031

