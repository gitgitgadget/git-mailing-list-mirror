Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58CC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8809611C3
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhKPMF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhKPMEh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B207C06122B
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az33-20020a05600c602100b00333472fef04so1719081wmb.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9c+Tnx5WN/x457Qc4NaLx0dTbaRDrTVc+KBx9HiTNnw=;
        b=iXx34yRK7LcwROyJkc4EfsQtOpPjCtPG4Sy4lJ+HZqr5zNuO4zOHf265FuR/g9jZJm
         s3klj5tv75iEXZ0vmCUy1msQ3jf4+F8fDne1eXTkvS8hc08l/hB0E/xKaNUE+8mLbPsy
         5NbADOQbVlrtJCHUfjLoqAw9LRWoqtCwwuGIttqt+TCGHWRuAlCIRb15TrJG97bI0HaO
         0oXCQ23M7WlsfxsXFIfmYSnitTtC8UpYd5iWVB/N1TF54AmgOdXc1z8LCYkiGeGD7HIn
         J5WitxAqpdXL0gs/zCE9BE1iYrh63vrCqUXcVaWWzHyYJiF324Qbh42QdDfBc6EixVdA
         kfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9c+Tnx5WN/x457Qc4NaLx0dTbaRDrTVc+KBx9HiTNnw=;
        b=Fhs5pk5+CsISpFFAqAr+/op58QdXhDTi1Bl2NzqAgW4sMPBTnP2RR7cFahzP+euJ4h
         YOoC7MGIQaj01jnRf5M2I9+Ouqni6mDoIwtI5V69NV0jracshun4YDAWiKzyJ2u+DXDf
         glCtYjDIKhN14N2hrMybrV1Z4j3C3dSHiNRR3VJV1hK/lFwi89Ej8nG66EixV4BJuI6Q
         p7w9Gha2E5EhLL/53sNSB7DU+R2P7DtXPXT/V8ZmGGWOtoj5yyEGp6Uv8OyUPVsyrti3
         u4zIx/Kj9RcPUPVYyc5JkUH3jVgabgsG9EzAj1fv00KAMDZif1W2apN3e9tp2y0nHlzz
         ypoQ==
X-Gm-Message-State: AOAM530IBNqJonJpna42uunVlmJk0RzoHfKoh3qMQ0PFUjMk32CYbVLD
        1GiM9LFUHMQwUd+dM0d3kHzpSBhSrvbXDQ==
X-Google-Smtp-Source: ABdhPJw2ZJfwxFG82FJZ+Ii2J69Xf/JdWpGUef1Z+Yfy7nldw9OQgmJYzVx5NIV+8J43kK5HcY7WGA==
X-Received: by 2002:a05:600c:19d0:: with SMTP id u16mr7002164wmq.111.1637064044472;
        Tue, 16 Nov 2021 04:00:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:43 -0800 (PST)
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
Subject: [PATCH v3 12/23] Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
Date:   Tue, 16 Nov 2021 13:00:12 +0100
Message-Id: <patch-v3-12.23-19539ce7d2d-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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
2.34.0.795.g1e9501ab396

