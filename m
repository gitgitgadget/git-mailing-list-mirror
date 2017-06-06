Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDF7209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbdFFPMz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 11:12:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34833 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFPMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 11:12:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so35342237wmc.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUkiRoZXBoahIO3lWpEw54elbv7j44k+5ySwnQuM/0k=;
        b=gHcNaZtbjEZqRwgGbqs2QKqZwZUPtIVs1HvIBI0td37+ncAkH5PFWbYIssqRE39LpZ
         ZZavJbdJX7bZb2bpr7SVWWytmbPTcMLzN68MRRowJc5rxtgNYqALktcmCQTvFVLWrbOa
         g7cRfxO/CtePCtk3pxDzMFCWJSyDqnHc/PKi+uIjZR5FZ4ao3wJLg8REgn2O2WeId80i
         br+B9LELOnkSPpbxU6MEvCXoDJovIGey/xu9jF9M8qhNWVzbQthPUNWcq5cDRk72hpoJ
         d+W68Z/tx4vi9z6itnXP03Jmta3Zvw+4fWxjrlOQ0Cr45g3P3LbQq6mvXa9wyEloQdtA
         31+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUkiRoZXBoahIO3lWpEw54elbv7j44k+5ySwnQuM/0k=;
        b=CQKdkMrGGhHkGjke+fFoc+neetmizGNUswXKOZT0gh+KEVghNk1Tiqy7CALTibSr4u
         nH+puZKcCkOgNB5G8NAWdNf5H4/1//4IQ1FHKdTYeMe7HF1N8r08iqT8vZEguD/L0Yts
         +D2Cub89sPPU1BILSOYUPTWd0X9neSdyE90v5t7QxqJh4EaKbKRcGx8D0j93OszuA8Ba
         yqnKteuUTJs/fg3tqMpRwj/7cg1aU3tfx5pK1uvCG5c7KJpNsKiREZ0HMs1qCDRB+RGa
         hL+XzyxMMR7RdLV/3X4XxNdRoRwp+l/GI5C7bvwe5A8I3dX2KacTl2/3xe+qpAJR/VUL
         OITQ==
X-Gm-Message-State: AODbwcCOhguOxo/MQ6ZcInOqEms5FMKqofth7UoeF4Ku4dVARx90okJG
        d3wFdPLquJSg/vzgFso=
X-Received: by 10.80.188.1 with SMTP id j1mr21910152edh.100.1496761972026;
        Tue, 06 Jun 2017 08:12:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d37sm2250632edb.54.2017.06.06.08.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 08:12:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
Date:   Tue,  6 Jun 2017 15:12:30 +0000
Message-Id: <20170606151231.25172-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170606151231.25172-1-avarab@gmail.com>
References: <20170606124323.GD25777@dinwoodie.org>
 <20170606151231.25172-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to use the sha1collisiondetection library from the
submodule in sha1collisiondetection/ instead of in the copy in the
sha1dc/ directory.

This allows us to try out the submodule in sha1collisiondetection
without breaking the build for anyone who's not expecting them as we
work out any kinks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitmodules            |  4 ++++
 Makefile               | 12 ++++++++++++
 hash.h                 |  4 ++++
 sha1collisiondetection |  1 +
 4 files changed, 21 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..cbeebdab7a
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "sha1collisiondetection"]
+	path = sha1collisiondetection
+	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
+	branch = master
diff --git a/Makefile b/Makefile
index 7c621f7f76..adeff26d57 100644
--- a/Makefile
+++ b/Makefile
@@ -146,6 +146,12 @@ all::
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
+# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# sha1collisiondetection shipped as a submodule instead of the
+# non-submodule copy in sha1dc/. This is an experimental option used
+# by the git project to migrate to using sha1collisiondetection as a
+# submodule.
+#
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
 #
@@ -1416,8 +1422,14 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
+ifdef DC_SHA1_SUBMODULE
+	LIB_OBJS += sha1collisiondetection/lib/sha1.o
+	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
+	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
+else
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
+endif
 	BASIC_CFLAGS += \
 		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/hash.h b/hash.h
index a11fc9233f..bef3e630a0 100644
--- a/hash.h
+++ b/hash.h
@@ -8,7 +8,11 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
+#ifdef DC_SHA1_SUBMODULE
+#include "sha1collisiondetection/lib/sha1.h"
+#else
 #include "sha1dc/sha1.h"
+#endif
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1collisiondetection b/sha1collisiondetection
new file mode 160000
index 0000000000..e1399840b5
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit e1399840b501a68ac6c8d7ed9a5cb1455480200e
-- 
2.13.0.506.g27d5fe0cd

