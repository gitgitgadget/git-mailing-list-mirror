Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5592BC43217
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4024961BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhKQKYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhKQKXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B0C061746
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso3474749wmh.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTuGh0OsKlUWxcaeeKNzPegVUrAJ5g41+M7bgxrbGKA=;
        b=n6fvs+Qlt3ByTRTVlgKl0U5tGCsbKmGJ37bTqncjSzQJMuOnrX3tvFmlwo4YT0tt9T
         FqMuLfnTZNWC307c3ea6nNIiT97xwu7YL4SLxd2LOgArBWJ2U/xyqRcKG1cVNsczPXg+
         +xVZtVwVTT+ZEleQEVxpqOK32YeKbnJ1YL/40FWNKhgg5/ykWpfwwjHBrNyD8RMfZhpA
         kPVYIZClSsvKR2PIpGBifg8O6m6E2wpS9mRvg5G8bg87fJEAIViJJ2PQk18OXbO/zmXH
         EiBRvhxB8qwJtH4de8EOMCGOjUuyww+jbEWazrTxUyPvxoWhItMa72B3kQcudulSGmng
         uA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTuGh0OsKlUWxcaeeKNzPegVUrAJ5g41+M7bgxrbGKA=;
        b=rTjOi5gZFRIddiXNm1UWAeLgn4zeUGewBcUwZO+oplCTZkR14mab22E8Rqfa4yITYy
         W5oFbL7d96Sqkkb0JJgDptnCBT7Go2f26mO6OrOtGG08ptzSfsyYoEB5mgF3sDi0IYLI
         zrQ4wmWbjNl8brbEAKs8mvIvnUkpzjJ2VgNgHCLS0CkARyAJ3lgyhH9yA4TDyAGCT41+
         XnXDGXKlPn2cyq2FJgTjoRor8oeESmJH3IA4A6snKUt4n6WQU29kajNDnHtOm4zVefQO
         b+Q7ZG9u5lFjvXA3/IgUxAs0LV4ofcDsCZbFkKcnux3tuatexHjKhDmyCgdFpalIRrut
         uczQ==
X-Gm-Message-State: AOAM53062ckjLQlHsxFNvT15fGJ+PJV+b3BQubT6v7uny/KNjdf0IVLF
        taJT1FYvXXsMdSgD2kPYv1jSIDJoljTLnw==
X-Google-Smtp-Source: ABdhPJzAOswjxCEM7OiL/SiiLjaaAlI/4t1dy8ziouAURYD9mCu/pbfQ0uBlUOSwkkmAUxEwIH3NbQ==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr16281666wmq.24.1637144440029;
        Wed, 17 Nov 2021 02:20:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/23] Makefile: use $(wspfx) for $(QUIET...) in shared.mak
Date:   Wed, 17 Nov 2021 11:20:16 +0100
Message-Id: <patch-v4-17.23-3c4d0589667-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
index 1b666a1bc69..36f00e88bb8 100644
--- a/shared.mak
+++ b/shared.mak
@@ -50,39 +50,39 @@ ifneq ($(findstring s,$(MAKEFLAGS)),s)
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
2.34.0.796.g2c87ed6146a

