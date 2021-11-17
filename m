Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C82C4332F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2F061BFA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhKQKYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbhKQKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4510CC06121D
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y196so1676575wmc.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIMnDR8U8vhdWM6hlpK4KCai6LoGDFCGRmov9GEwmjs=;
        b=IDC3JgHpzhMyIsffGAhGsYqsj3Wi6sR9m3h89MaAhnO3j71zxIjaC32HhpfSNyrJCw
         ZoFF4IvDdYFiMH5veVMf1pMYk89mEBqFKX/+Bj/jrxGju8zs5L+DaKjolRTBG/w/ZD3Y
         nDizNGBloJorCUhgEKwKWHngPx4Gg/Wndhb90k9gNiXywCUQr03Miy25AGsLXY4mcstC
         gFpOB48lhpZHdYL5Z0+aD/T6w0LKosJ7bJ3ftYuPqaEadPNTzMXkY/rPl6b/xKD+IUMR
         TqMqHHBMApjY+DZ80d76qvm85KAdSvD9EIq8+pcc1e7TB3V2AZO+7VY3ULj9mBEZPsdo
         VcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIMnDR8U8vhdWM6hlpK4KCai6LoGDFCGRmov9GEwmjs=;
        b=F8Z/fnmyiE484gnQp3cWFuFi5PsrDSAgssMYla1Qh1Scgcff/zekmzrw01SpAHLzAj
         cbTetrYpBKQAHmc6+Y9QNp3K3QZzN/7IKzjdpFBz2OuoA1GDdyYt7CZqZ03epXDh7KLI
         Pli1+ZxBo75q0HRTTCHxJfJ7ZgTrk1GKtk6XAdcimPZU1QihPjJ2S2R8QY120yod/ctH
         MsG0W3VXM2gslc9BK6Gk1Qf7NQsheS7pP/bUEN86MUf4hpG+odhfdWLKPRqn1EsZ7zC+
         SVGDyAEfXD8gITK9rItsvkqKG8qWk88QT9CY7e0P8n4gB+VIteu5mxxRGDN+VPCbS4BE
         WMvQ==
X-Gm-Message-State: AOAM533ZhE/Cx8iYvPzpst4y/7rXUQ5lgV3p+HhMGdADdxJrvkyaA3IC
        /L1+hhle/jEAaXApxtlUdjMZzlBA5Z3fuQ==
X-Google-Smtp-Source: ABdhPJyUjSDeiRe88yp/v/nnZBAcdEeJCwtjst+GUoBEp4OY5wHzNdRAtqB0YiNdGhh+wCuv/rDFCg==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr16169938wmj.13.1637144435640;
        Wed, 17 Nov 2021 02:20:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:35 -0800 (PST)
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
Subject: [PATCH v4 12/23] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Wed, 17 Nov 2021 11:20:11 +0100
Message-Id: <patch-v4-12.23-30ddf7da2c8-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
index 8205614c6ec..5ae7d012cfb 100644
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
2.34.0.796.g2c87ed6146a

