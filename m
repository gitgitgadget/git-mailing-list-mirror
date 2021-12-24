Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4662C433FE
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353325AbhLXRh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLXRh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:37:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB8C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:56 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso7638871wmd.2
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6soc5elrEap8bp3AVyAsdfDl5iSy5NoYhJNFtJETgjI=;
        b=UYe4gSOPsvXeLaoxRpxL6DfCsQNPA22NzELUzNfG1zyoJlADJGjFdE4C2xxJuNeNlm
         hlmB1t0A21g1wXiUXJw2wpbOjMSALeMa1EX2hwEkUBTuLl6rasDT+gmQ2tSXRShz0nDP
         rJ+N+HEFV/ks1IoUVPUsS4Li6zE5MghLqA+wp2q6lio5qt/xwchckrkqAMwOBAd6MwMz
         n+WzwJ2XZ8lw5nIeYKuZk03bEsoVkCyNEl+SDWk/EwVS+ZJ7qF7wjnJU/a4GqyPVYeo6
         W0ochdjVvrhvkl4i8mipJNx2RXlIrJSiRl8VfoUhOpsmbrptgLdTNYs78jp79dMxlMqz
         QGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6soc5elrEap8bp3AVyAsdfDl5iSy5NoYhJNFtJETgjI=;
        b=tKhAp/DfHkv8UyVw0802QWhiI5ytWwsYcLXKpvYN6HyTZq0zW0btMH5lwThL6sgYLm
         6+E95TdYjpEB63tfQrJl49JynmmIlbfhclk0PJ/8tKapW51cvJQ4M25Dls6zHC70yhoG
         OLQ54Ar1lFBollCE+fcH3b3jl9sRqfiUGD6jfB+y/OxHvDwH4FWP+/CglMdrcVQ6NsHU
         2p/MfOt/54xfNiKnpF0dKiva+hF1s4fW0pTJsHnqTyvRoimX7x3JKJTGzx0eLXICqag5
         yE/V40DBSbpaUK4A8WHyIvu+SV5GZgmIj6WNQfuBS6dsvCpt3gal5OwN20KrXxLOan18
         Sd1Q==
X-Gm-Message-State: AOAM532gXFPJZkE8L5qpmsaeSaUnMNZjxGhU4OkO5KFCqgfC7bcIo9cy
        53xBXh0tnb0uCd4TWNaTe0Zdl0neDn/6Bw==
X-Google-Smtp-Source: ABdhPJys3mLycEgtj8v8jUhsKqBOlwkdtW3djTlX3z9Qq4kxAM4TdLF0gdGYH5OyeFCYZOrztGWZUQ==
X-Received: by 2002:a05:600c:1d1c:: with SMTP id l28mr5241255wms.69.1640367475144;
        Fri, 24 Dec 2021 09:37:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:54 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Fri, 24 Dec 2021 18:37:40 +0100
Message-Id: <patch-v2-1.8-b652fc78fda-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
In-Reply-To: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
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
 Documentation/Makefile |  6 +++---
 Makefile               | 13 +++----------
 shared.mak             |  9 +++++++++
 t/Makefile             |  3 +++
 t/interop/Makefile     |  3 +++
 templates/Makefile     |  3 +++
 6 files changed, 24 insertions(+), 13 deletions(-)
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
index 75ed168adbc..7dddea3caf3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # The default target of this Makefile is...
 all::
 
@@ -2169,16 +2172,6 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
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
2.34.1.1215.g6e154b84c77

