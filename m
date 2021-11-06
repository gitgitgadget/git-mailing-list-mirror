Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ADCC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68AF46103B
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhKFVGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbhKFVGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6FC061210
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d24so19540332wra.0
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOAE1meGn/jbaEdTHwCs8QvndZaz95EdwYUZvdj/pEE=;
        b=qGX6sjch27aZXIpkvn5mQxIbKwzFpbpXVlpU9CI6ZBHYA5Lts+J68jKmzd0VijIMjk
         aOehTNQeI03brtaWAclOoZ/sffosOaDnBjMydjX1AwSMz7mgaApFM512srycdSumBLSj
         xflb3dMabDBlFgx+x148jcHx7IUDNzPPhScTtRQ9oS9bsg00/KraqzCUYj0V0zzIvJJr
         SEzpqIwJat04euN3wSgC9IV4knMwIjezew/IeXkJlgvdopKBPv0RlR7H6rhq6dH4He0G
         HjwjPnm3vZAeEVSDSmdv8HVZDJRc/ASuDLylxS52CoMjdT8bbK5UUzvrS+rGRaHe3r0L
         4whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOAE1meGn/jbaEdTHwCs8QvndZaz95EdwYUZvdj/pEE=;
        b=uceEapgSYtlXZlEELxql/5w3KEhNgty393cEMd7rit53KCqqLaogwSLTyjeix1jRB2
         VZXtKNNXEunMQTOcshma6zoh+vjfs37yvKtbHAIgpwEG8FRB4ZcTycfQilpiMGiFDuh9
         H5FrGfdaf6MGa0f7+PPRQrPrOLoCmWtnmWh3n8SLv7UZ8GcsPORLVm0U5RotqzicWdLR
         WIEEdufWT0WaIZfwG07rSHx7yGS8zaA4k6HW5jz9vc+I0aT4VV4a9TKrfdHD1wv44ipD
         0zqUxmil5i9UNpZ7xNSYoMPV+e6F136YjgveLcydsWvZk54x055RBSymSjvnqn6+S6J+
         CamA==
X-Gm-Message-State: AOAM533d6awD3SGArS/mFg/5zUZY5z2x8e4RskRBkYuxyJ9bfpjY4txT
        AAkc7FZU0i2g0VJ9tQoUBiSbm6ExflF/8A==
X-Google-Smtp-Source: ABdhPJxq46hlKu+ocFyx8M+6OP4Q8tbv3vxCstutsvQ92t3GFUf6RORQ9auy0lbkIKoptxOAybbfwg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr55192750wru.384.1636232607532;
        Sat, 06 Nov 2021 14:03:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/16] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Sat,  6 Nov 2021 22:03:10 +0100
Message-Id: <patch-09.16-e23663bfb20-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
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
 3 files changed, 15 insertions(+), 13 deletions(-)
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
index b2970c6ded9..e65d346e7cd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+# Import tree-wide shared Makefile behavior and libraries
+include shared.mak
+
 # The default target of this Makefile is...
 all::
 
@@ -2158,16 +2161,6 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
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
-- 
2.34.0.rc1.741.gab7bfd97031

