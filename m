Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49855C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 09:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiBYJFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiBYJFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 04:05:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534A7DABE
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d28so3414397wra.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/A5BDSTeWDgE3L7qPcmzrNYFUOd9i98pikcExrxp5U=;
        b=bFavLA3y80rBcYoVoFc3CbU23LwNamI+sr7yjRM21eAaVsEO0sD0WBWEB9HCDtUOG9
         CfcIglCvzABPFSBh/vi2gBCAUC4JdWBJ+5OPJl/WAWBNaCadYZqovHLd2wo+Yu3l5HtK
         FKc/7oEoqNm2EfGPQVvnE3mJtNvz7yrd5rm5GMKqAwd0/FyDcXFkpxtQSzS6GCaEE9F/
         Dto8WqQa/EiqT0LIMQcwhPOfg7EjNzxwfghoAfNkk6MDiTY3vO34wQUzGfHIaT+lG6Q+
         7bzFHwYmpwqMgxzEHCMKSUB8uhg21xB7weYM0Rwasf+XSBDvHJ5PP97QFmw7E+DUody2
         aofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/A5BDSTeWDgE3L7qPcmzrNYFUOd9i98pikcExrxp5U=;
        b=p/6p1eEzID/lNCem8ffQr7f7n8zLwEQww+A4VVevhae8noexQcpcyIyvUs3b+KxjHc
         Co0c6btILibZUWpm6PTQSmG7jQZI2hzQsdALY7ytaONJ547HCqhcql3nqM2PsWNxmeB7
         Ke0wjl7P50g7MeyAd3h8YLXyzD0VrrJ6tkB2iOTB7pPBUmV0u4XO36rwmklYGSeDztDZ
         4fDpS8/1mDLbSlSBPHDi3QlrwiFBcSmVcyaTGL1vI9Je0+XKiOzhICV8VIDr2zH3fydy
         DOk6N32F31SP/TlAhPwYgDoOjtZafA5KvbN5sXAZ/7n3qhKCvyL/+35eW8BWWwEBPl3M
         nFVA==
X-Gm-Message-State: AOAM531mJjrEf31ntoVAi7G33EFQn4//7CE7kriBk5ETqftKMmQ1MZFU
        TmXoBehJoiFJp0XkShDceaeTojukwFu/fg==
X-Google-Smtp-Source: ABdhPJwnQ9NpZiqgF3+fw4djOuKEL/e3kb29G/deMlLDn2Bx9GlwHBp3aqLXbHrUdb0hacwV7GIg1w==
X-Received: by 2002:a5d:6da8:0:b0:1e3:3e4c:24a7 with SMTP id u8-20020a5d6da8000000b001e33e4c24a7mr5215883wrs.673.1645779881098;
        Fri, 25 Feb 2022 01:04:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l38-20020a05600c1d2600b0037e9090fb1esm5636657wms.24.2022.02.25.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 01:04:40 -0800 (PST)
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
Subject: [PATCH v3 2/9] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Fri, 25 Feb 2022 10:04:28 +0100
Message-Id: <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1175.gf9e1b23ea35
In-Reply-To: <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
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

This does have the potential downside that if e.g. templates/Makefile
would like to include this "shared.mak" in the future the semantics of
such a Makefile will change, but as noted in the above commits (and
GNU make's own documentation) any such change would be for the better,
so it's safe to do this.

This also doesn't introduce a bug by e.g. having this
".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
have no such scoping semantics.

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
index 6f0b4b775fe..d378ec22545 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # The default target of this Makefile is...
 all::
 
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
index 5b12a437426..6fb5cc8b701 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include ../../shared.mak
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
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
2.35.1.1175.gf9e1b23ea35

