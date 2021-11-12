Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDFC433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C287D60F0F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhKLVwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbhKLVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CC3C06120E
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so7788919wmz.2
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orF27Es/j/6T8VD4YNyQZPfV+Aj9dudAGaTu6h3c51Q=;
        b=p4Dw7TfcFljTvon4Z6vRhguu4EFPoU4dnATaJeX+zkVGb5r9CsQ8EEcJ8Q5iMNlLyb
         LsFNvM4aO/vCx/MBquK0NqYvj7kkyK9cHB9b8B7AzjXCLSMOQyde0oxZI2jZ7QRanYEb
         qaXcrwxEk4yimjvamVDCfpLuDYn7nnRdUjrThui90Kp/QVLQpb+ENLoFPoXFR3AhqnMv
         zFz0nF15Z3OXbkwN+UuM9wUyg+XuCwrdBcgoRYe5tiiMsu4H+G3F1I1/WghqI4AwW5FM
         JgnuiZC68UZ+7ebD4guDhD7Llma1SYbN4NldkRTfmHL+06Y02ysMKv0Xxa8qWuSx5qJS
         XTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orF27Es/j/6T8VD4YNyQZPfV+Aj9dudAGaTu6h3c51Q=;
        b=6Kh3OOhCAwgsxEqBSRasK5vMePJ3SFKtoqrgiIQr5lZ627EPa1Otkv6xdZ1TdXVr81
         UnPokYjtyexX8PIkcLx+kcLvHgkil3O4WpnvaRlZ5x7nVq1wjvibOYHWnOaWTXgu48nz
         pALF5YFXbwEQ2Fh2IkwV1Xl7lNDW3QrqRTWaovccOczkWx+o+nZyLzRJJMoDaSIbNAVb
         x/Zkn5ZmQrDWoXwE1/FM0sVYWkEjiAvIbAcKomBqX1jqW4PMhI8eEdTgCYyMR+inIk6j
         NJGEJGy8cQLHNc7q5MlQjFQ7EBiAbztR22tbdm8Hmg30MT+RJV29cQxodH8f+JmstSdG
         OrgA==
X-Gm-Message-State: AOAM530e9u0g64+CBCVN1Zy4E3oCOwojJM+t1ALX7nq0n9+iDYXaqebd
        SRIgGvHX0xKRSisyIixkfymis4KaxV5gYg==
X-Google-Smtp-Source: ABdhPJw9ZzMd53kqMGiei+miSmb/PbHVIBgw2FYO5YHX/D4+6VEBuwolBldIcaq2MEDpDai9NsS6ng==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr20769295wmk.27.1636753755072;
        Fri, 12 Nov 2021 13:49:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/18] Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
Date:   Fri, 12 Nov 2021 22:48:53 +0100
Message-Id: <patch-v2-09.18-c1336fc0a56-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix several small issues with the dependency graph of the generated
"GIT-PERL-DEFINES" and "GIT-PERL-HEADER" files:

1. Don't have "GIT-PERL-HEADER" depend on the "Makefile". That was a
   lazy way to over-declare the dependencies added in
   f6a0ad4be71 (Makefile: generate Perl header from template file,
   2018-04-10). Let's correct our dependency graph instead.

2. Don't have $(SCRIPT_PERL_GEN) (such as "git-send-email") depend on
   GIT-BUILD-OPTIONS. Let's instead use GIT-PERL-DEFINES.

   The reason for depending on "GIT-BUILD-OPTIONS" was to trigger a
   re-build if NO_PERL=Y was defined. We can instead add that variable
   to "PERL_DEFINES", and have "GIT-PERL-DEFINES" created and updated
   if "NO_PERL=Y" is defined.

3. Due to #2 we'll need to have GIT-PERL-DEFINES be generated even
   under NO_PERL, since that variable will be used by the
   "unimplemented.sh" script.

4. Don't depend on $(gitexecdir), $(perllibdir) and $(localedir),
   instead depend on the $(*_relative_SQ) versions of those.

   The latter is what we'll actually use, while it's unlikely to
   matter in practice (we'd just skip re-building these under
   RUNTIME_PREFIX if the relative path was the same) it makes the code
   easier to read.

   That's because this brings us to a 1=1 mapping of these variables
   and what's subsequently used in the "GIT-PERL-DEFINES",
   "GIT-PERL-HEADER" and "perl/build/lib/%.pm" rules below.

5. We don't need the substitution of " " for ":" added in
   07d90eadb50 (Makefile: add Perl runtime prefix support,
   2018-04-10), let's drop it. This doesn't matter for the correctness
   of these files, because unlike GIT-BUILD-OPTIONS nothing is
   consuming them except the Makefile itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index ab78f8dd42e..361abff2402 100644
--- a/Makefile
+++ b/Makefile
@@ -2288,10 +2288,14 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 	    $(shell echo $(GIT_VERSION) 0 0 0 0 | tr '.a-zA-Z-' ' '))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
 
-# This makes sure we depend on the NO_PERL setting itself.
-$(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
+# Under NO_PERL=Y we'll still make GIT-PERL-DEFINES. We need to depend
+# on NO_PERL=Y itself for creating "unimplemented.sh" scripts.
+PERL_DEFINES =
+$(SCRIPT_PERL_GEN): GIT-PERL-DEFINES
 
 ifdef NO_PERL
+PERL_DEFINES += $(NO_PERL)
+
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -2300,22 +2304,26 @@ $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PERL
-# Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
-# since the locale directory is injected.
+# The localedir is only used in Perl modules if !NO_GETTEXT
+ifndef NO_GETTEXT
 perl_localedir_SQ = $(localedir_SQ)
+endif
 
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
-PERL_DEFINES =
+
 PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 PERL_DEFINES += $(NO_GETTEXT)
-PERL_DEFINES += $(gitexecdir)
-PERL_DEFINES += $(perllibdir)
-PERL_DEFINES += $(localedir)
-PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
+ifdef RUNTIME_PREFIX
+PERL_DEFINES += $(gitexecdir_relative_SQ)
+PERL_DEFINES += $(perllibdir_relative_SQ)
+PERL_DEFINES += $(localedir_relative_SQ)
+else
+PERL_DEFINES += $(perllocaledir_SQ)
+endif
 
 ifdef RUNTIME_PREFIX
 PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
@@ -2337,14 +2345,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
-GIT-PERL-DEFINES: FORCE
-	@FLAGS='$(PERL_DEFINES)'; \
-	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo >&2 "    * new perl-specific parameters"; \
-		echo "$$FLAGS" >$@; \
-	    fi
-
-GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES
 	$(QUIET_GEN) \
 	INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
@@ -2370,6 +2371,13 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
 	mv $@+ $@
 endif # NO_PERL
 
+GIT-PERL-DEFINES: FORCE
+	@FLAGS='$(PERL_DEFINES)'; \
+	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
+		echo >&2 "    * new perl-specific parameters"; \
+		echo "$$FLAGS" >$@; \
+	    fi
+
 # This makes sure we depend on the NO_PYTHON setting itself.
 $(SCRIPT_PYTHON_GEN): GIT-BUILD-OPTIONS
 
-- 
2.34.0.rc2.795.g926201d1cc8

