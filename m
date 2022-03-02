Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ED2C43217
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 12:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiCBMu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiCBMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 07:50:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC78E19D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 04:49:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso1051644wms.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43UPeUeU8fhT43706E6TJjAqvHY/3OmDctJtnQPnxZY=;
        b=BR26RbRgvjYPULNmNm/sqjGlfB1AYvHP+jk1jJMdXq1uc6JY+O+ubQ0Jekh/vtAFJC
         P1Fy0skt63Td6T7VupwRlHVgDMDn5pweeEI6JauBcDOc5SidTsxLLIcQFXttGsM154gG
         Fwh5CfaOpZeBo/jBza33LUy4w7Lq75gX5QXux4wWt0vyPCN6DkrjP9e0JeXFo9rmcygh
         1ZGgw2gcrcM/nsRNOdOyOOkQfagEomaT88LMV6RUhgGlq+wztFsw8ThiLMmqi9ubk3oe
         MexfaYqj5Zt5NdsSMKZwZGS54t0tTjBQGV1jyhh+SQH0Nwh/+b0xlhFDpn1mjt1sYE1p
         Syaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43UPeUeU8fhT43706E6TJjAqvHY/3OmDctJtnQPnxZY=;
        b=BiD3uQk6Ow/0aHYOdMO7VJNoLyZLic7OjDZtQQCPB/wRb5gv1dcgT5BBSJWvKlXvVc
         kN5zHn6BDLdilFPtNZa1DQlIuKOmt0bj6vHQhKF1vAu8BwRj4IUYGxMoeM46HMENJbz3
         SRZhC7/ck6t4Zg0W7LqZUqJVAZaYKC80aFw5cDGbjP84JJnmMi/84vSC/7u4bXFlv9ie
         eO5hm4LHHPsTjaoVYoFELyzs8sHL3Ihb/GpbTh1KmPXxtTfqGNpfLcS4wVroUGh2PT2B
         4sO5+fhpJeuJBvs5zrSqkwXBcy6Y9X4v9W92qK8S0Y3kvud5Y8qJfo85PiPK84+hC8Xa
         xFRw==
X-Gm-Message-State: AOAM5305ay/yred93A2My/vRYLBwuDrKeptDfZJUuhcaiQTuXy0Z08Bs
        D1pqf8aHke2ks9TMXz2USd/sqDJtNxGGwA==
X-Google-Smtp-Source: ABdhPJzmiiIYMWCEMzlWOy3AL8/dOMQtXLqJ6yj0JONzqfKH4JnSM3ZUvC7Qn7HM58BTfq2/ohd1Qg==
X-Received: by 2002:a05:600c:2c49:b0:384:7202:358e with SMTP id r9-20020a05600c2c4900b003847202358emr1909723wmg.108.1646225380071;
        Wed, 02 Mar 2022 04:49:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003811f9102c0sm8210107wmi.32.2022.03.02.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:49:39 -0800 (PST)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/9] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Wed,  2 Mar 2022 13:49:10 +0100
Message-Id: <patch-v4-2.9-74692458b70-20220302T124320Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have various behavior that's shared across our Makefiles, or that
really should be (e.g. via defined templates). Let's create a
top-level "shared.mak" to house those sorts of things, and start by
adding the ".DELETE_ON_ERROR" flag to it.

See my own 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR"
flag, 2021-06-29) and db10fc6c09f (doc: simplify Makefile using
.DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
".DELETE_ON_ERROR" flag.

I.e. this changes the behavior of existing rules in the altered
Makefiles (except "Makefile" & "Documentation/Makefile"). I'm
confident that this is safe having read the relevant rules in those
Makfiles, and as the GNU make manual notes that it isn't the default
behavior is out of an abundance of backwards compatibility
caution. From edition 0.75 of its manual, covering GNU make 4.3:

    [Enabling '.DELETE_ON_ERROR' is] almost always what you want
    'make' to do, but it is not historical practice; so for
    compatibility, you must explicitly request it.

This doesn't introduce a bug by e.g. having this
".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
have no such scoping semantics.

It does increase the danger that any Makefile without an explicit "The
default target of this Makefile is..." snippet to define the default
target as "all" could have its default rule changed if our new
shared.mak ever defines a "real" rule. In subsequent commits we'll be
careful not to do that, and such breakage would be obvious e.g. in the
case of "make -C t".

We might want to make that less fragile still (e.g. by using
".DEFAULT_GOAL" as noted in the preceding commit), but for now let's
simply include "shared.mak" without adding that boilerplate to all the
Makefiles that don't have it already. Most of those are already
exposed to that potential caveat e.g. due to including "config.mak*".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile    |  6 +++---
 Makefile                  | 13 +++----------
 contrib/scalar/Makefile   |  3 +++
 contrib/scalar/t/Makefile |  3 +++
 shared.mak                |  9 +++++++++
 t/Makefile                |  3 +++
 t/interop/Makefile        |  3 +++
 t/perf/Makefile           |  3 +++
 templates/Makefile        |  3 +++
 9 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 shared.mak

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ed656db2ae9..ba27456c86a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # Guard against environment variables
 MAN1_TXT =
 MAN5_TXT =
@@ -524,7 +527,4 @@ doc-l10n install-l10n::
 	$(MAKE) -C po $@
 endif
 
-# Delete the target file on error
-.DELETE_ON_ERROR:
-
 .PHONY: FORCE
diff --git a/Makefile b/Makefile
index 6f0b4b775fe..aa5ff001b6e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,9 @@
 # The default target of this Makefile is...
 all::
 
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # Define V=1 to have a more verbose compile.
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
@@ -2194,16 +2197,6 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
-### Flags affecting all rules
-
-# A GNU make extension since gmake 3.72 (released in late 1994) to
-# remove the target of rules if commands in those rules fail. The
-# default is to only do that if make itself receives a signal. Affects
-# all targets, see:
-#
-#    info make --index-search=.DELETE_ON_ERROR
-.DELETE_ON_ERROR:
-
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 1e9b969f3df..d585b319edc 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -1,6 +1,9 @@
 # The default target of this Makefile is...
 all::
 
+# Import tree-wide shared Makefile behavior and libraries
+include ../../shared.mak
+
 include ../../config.mak.uname
 -include ../../config.mak.autogen
 -include ../../config.mak
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
index 6170672bb37..01e82e56d15 100644
--- a/contrib/scalar/t/Makefile
+++ b/contrib/scalar/t/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../../../shared.mak
+
 # Run scalar tests
 #
 # Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
diff --git a/shared.mak b/shared.mak
new file mode 100644
index 00000000000..0170bb397ae
--- /dev/null
+++ b/shared.mak
@@ -0,0 +1,9 @@
+### Flags affecting all rules
+
+# A GNU make extension since gmake 3.72 (released in late 1994) to
+# remove the target of rules if commands in those rules fail. The
+# default is to only do that if make itself receives a signal. Affects
+# all targets, see:
+#
+#    info make --index-search=.DELETE_ON_ERROR
+.DELETE_ON_ERROR:
diff --git a/t/Makefile b/t/Makefile
index 46cd5fc5273..056ce55dcc9 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # Run tests
 #
 # Copyright (c) 2005 Junio C Hamano
diff --git a/t/interop/Makefile b/t/interop/Makefile
index 31a4bbc716a..6911c2915a7 100644
--- a/t/interop/Makefile
+++ b/t/interop/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../../shared.mak
+
 -include ../../config.mak
 export GIT_TEST_OPTIONS
 
diff --git a/t/perf/Makefile b/t/perf/Makefile
index 2465770a782..e4808aebed0 100644
--- a/t/perf/Makefile
+++ b/t/perf/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../../shared.mak
+
 -include ../../config.mak
 export GIT_TEST_OPTIONS
 
diff --git a/templates/Makefile b/templates/Makefile
index d22a71a3999..636cee52f51 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../shared.mak
+
 # make and install sample templates
 
 ifndef V
-- 
2.35.1.1228.g56895c6ee86

