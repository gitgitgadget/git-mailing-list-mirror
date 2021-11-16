Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9FDC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A8461B39
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhKPMGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhKPMEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C033C061228
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso1733897wms.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hInNR+nhuE/zSD4l17a7t44fs7UBSgKVKtmZ2RaI0cQ=;
        b=QG9QoO2UbKV6sSung8ImfQvL8JmxFLrFjxKo8Uo7cAmQcCnBzyGb1swJfRte8SzPDT
         489FvIhrSBOlxgM3eokDRx2dtOHYO9v8B0dxg+CivYzA4KzdjX41Dc6U2mrbr1Oyjom2
         FphJyreLp42rr0WAMPnuUkcM6L/YKYFoA3Tw1eYokWCYfhFEBPtDwB7d0qjREFIPsafe
         rpWGpJgzCUmIQGGDg7Ue6PXo1yUv7n+iI0T+aPDF3jG5ilUT6vD6jxb8ddXhJY/GU2a7
         J+qqN/v8ibLZAWOVi7u2eyoNSxDXLpTgyj/9DoIHIHKTLcS5C+d2PdmGD/0hGnWPCd0f
         mAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hInNR+nhuE/zSD4l17a7t44fs7UBSgKVKtmZ2RaI0cQ=;
        b=79cmLfLh4+b4g0jfEh/cfvyF/c7he5v70ciqQ1w3cOH9WQ2qTzZUGCfajcxoL8PFZ0
         eqJDnDU15a8C//658m7oU/oXrUqAp14SGf2Kegtyo2EHI4s07Sg1XLpbtfonQiV0XWq9
         k9y/EY1Gw0ySb4u1tCU5Vu/Nm9i48AaULvz1zmLthLlShSu7dLDg9D9o1LJuIjFRFCiJ
         Q9GAMTaVDHkAVzN5HZUZsZZbPCQ9nFOPwI864tifLIunGRiDiNUdI8s30x/8DVc3csnV
         U+r27HFofluJndrQVMG71QUp2ENefQPHTgop+JT2QVVLXxlRT5rTgTZlRcGdjyhbN/P8
         BwDw==
X-Gm-Message-State: AOAM531EUJmRYrYhDCVUIsg/kKwG2tEvCnCPwiDGdtC8r5v//umuu/lM
        73R580E+G5RfDRw+f9/lwGSQv6LGpXLJUQ==
X-Google-Smtp-Source: ABdhPJwn7fmVssOBCNlQc3l4JyFl//mwEKZ89RpaAPEFap82cc50BJ4Vki4LfqUtgTWSMbgUlsJuTg==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr68958469wml.80.1637064041916;
        Tue, 16 Nov 2021 04:00:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/23] Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
Date:   Tue, 16 Nov 2021 13:00:09 +0100
Message-Id: <patch-v3-09.23-1ece3160915-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

