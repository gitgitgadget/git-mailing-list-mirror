Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F8C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhLQBjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLQBje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC29C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:33 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so1158038wrg.7
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/BXGjKZy5ZjLY8AM79G8q1uwvjx5Tb58jnYtQtJnzc=;
        b=a1eh6GlO5UVmg3A+b5pkwaSrqpTbc0Lqc6LJnf59GOXY7nEY7larhOfj2rK5l7C/y/
         OGboJawnzipGumAc9msqUDX9sW0mhWQXloj6TGL33BTUTlIXJh3HX0mgJf2Tpa7EZkSy
         OnLBC7VpDwxpDCxRKL9qAYwEX5NElcF5rp3ckK763+bnM/EZyYGmceEcUGjOglc51Xtk
         3Pcfsq6QTbBw7IrDPrKDgnv+I9w6e28sBl1J0HzvmI44WurFFciKPCngx2Gmyy/9EO1f
         pdxFKia1nQJ0ZpZyw9Ji17F9Bh6eHTs7NiYKoVDpVRM3CVAkn2NQasTRmu7D+Wat4JjT
         cX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/BXGjKZy5ZjLY8AM79G8q1uwvjx5Tb58jnYtQtJnzc=;
        b=wRi4r7txi58V6JKBKG4q8h0IQ5HkilmoEBVPO2gaUsf8E5o2AB+XyzQEfBI5Y/bUPk
         Fzz571UvB35io3cKn0EbIjc76cbM2SMtFm1cKU9fwixJoJQWnouhMNl/lyv+SE41egiO
         QiJR6K95vThi78bXh3yf1gkDn61NXFuI4aZnC6llTMo/0vSOChtOqfxlBmpaHEOL8Nwh
         JUhVy/XswzQ/53c/cJbJZraEeeS4bvn0FLYjh5vpMAdMS/cIk4yCWO9cbulCCw277xZU
         pVrPFCZ8gMOi9+Y8s+TEj0Z27krOnTwFaUzbuWqYApVxTcsnbeHN39lBbBvlv0w6eJF8
         kYNQ==
X-Gm-Message-State: AOAM530SmB2hRQHF3g3CNEZ+E5eZSOqcb84eqWaadXXZl02jgVouKoMj
        YbzWBR8Sp7wm0/jWK32Q7Q0MuafFPrxqUw==
X-Google-Smtp-Source: ABdhPJwhkXU5ec9JXM8ByDx9+3cxrFVN3bTa/qP0GyUH6Tc4wQWRkvG/fRxNgBgX4kZ6Jw/e4kYgrw==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr518927wrw.517.1639705172053;
        Thu, 16 Dec 2021 17:39:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:30 -0800 (PST)
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
Subject: [PATCH 1/8] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Fri, 17 Dec 2021 02:39:19 +0100
Message-Id: <patch-1.8-f74b47662b7-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
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
index 9c00a793e47..9842a234790 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # The default target of this Makefile is...
 all::
 
@@ -2168,16 +2171,6 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
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
index 882d26eee30..795b94b50ce 100644
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
2.34.1.1119.g7a3fc8778ee

