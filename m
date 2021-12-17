Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504CC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLQA0w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhLQA0k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320ABC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:40 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t18so911985wrg.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkYabZUO08gmVllEEG8bS/4Tznfr1f0AQB2TY5mwQxc=;
        b=KDOCZwipxP3xYOet0SPq1pBrNEVgqequcixXsIwkWcbJndad49hX3wKB0pVjmLoDwl
         Waj0Z3j4ABnouU9+AHv+jaeVXB8hZFrNuAqVcaiyGoYAgjuJdh86V/qwU5hC2Hv+8+gp
         b81zZNnduOEgOD3uv06FT/YXxHRFRvHP9Ih6B7UllSXONmf/uRT+gYJFwwxfTVk7gdga
         5Gt+B2gzOIZKKSFtikW9EhtUbGn5Z4t61I/t8cp/fz3yhPRfVymJmRkcKChzlFnqgPE0
         GYuaVJWqlMbvHjjauINQspXDkGTK+hOF5rALoiNM55UhDawNesywNmpljF5EJBck4Vsh
         Jpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkYabZUO08gmVllEEG8bS/4Tznfr1f0AQB2TY5mwQxc=;
        b=My2Zwy9rLZpquncShjIxgVVf8liVTbbDVlZtR5rp6ZztVyPk709wT1RPlpomJFir9i
         hlQtzWGFxywN9n5AwUTViLnTYwlPWt0dQyckaAT+OHT6k+DG+IeICd3tIc1/kZUM6DP+
         YQHkza6WgPQ+gLycVNfq6y6sQ8Bgcp2p+kToK83aJqPStaiQR1X7MYDhtD+uCwh7n9J8
         udRvRdK1D80OsoFK8AnzcjlAjZNVRwC8Lb5GjBZCPC54WOSQS1k08TxB0S25hUuayBep
         gp46Y/LiDAITdpDF1HtNXrG/LW0Xl/qngiEYb1O27zp0MEZRDrj6E96Rz7xI2yGKDOnG
         b4lw==
X-Gm-Message-State: AOAM531hQZkMa/XX/kFMzLLUpi3yaE8JAza4+yYlReywhNziAO4ZMVhG
        BUraJ5Wu2O/bEJUUlT8hwTn9hYIr9/+l7g==
X-Google-Smtp-Source: ABdhPJw5usOn3iFOXpGn6tEoWqLKfyuSGDICo30gC2qH+SMRxUSPwkGBPs3ruxl4aOUg8U5ViZx2oA==
X-Received: by 2002:a05:6000:2ac:: with SMTP id l12mr324316wry.441.1639700798523;
        Thu, 16 Dec 2021 16:26:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/11] Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
Date:   Fri, 17 Dec 2021 01:26:24 +0100
Message-Id: <patch-08.11-8aa35537b08-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
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
index d488a723b79..356c98dff45 100644
--- a/Makefile
+++ b/Makefile
@@ -2298,10 +2298,14 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
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
@@ -2310,22 +2314,26 @@ $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
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
@@ -2347,14 +2355,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
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
@@ -2380,6 +2381,13 @@ git-instaweb: git-instaweb.sh GIT-SCRIPT-DEFINES
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
2.34.1.1119.g7a3fc8778ee

