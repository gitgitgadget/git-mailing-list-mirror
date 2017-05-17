Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB7C201CF
	for <e@80x24.org>; Wed, 17 May 2017 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbdEQLis (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 07:38:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35109 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdEQLir (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 07:38:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so2886985wmb.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1zCpRtD3iHQr6nGNz4bz1TQJ+FQA4CvvJQwtN3rYsG4=;
        b=Fa62/H6phm8Gt7EfeI7cj3nBRpkE0KOa6aBVNAdBeTgJU3hNa2St68axu/A3APD/pQ
         1DFpzT5SGUP5Wu9ETcjoJ9KIZozaWPFfJE8Z+oIYdSF0zWfBmS+t34x5Z7DVJrTSdJRj
         2hXRzXB7R/00WT5X7CrTybIqFp12gmtHznTNE/rpoEXdH29U2v73gAS7uLvg4qk8kbkH
         RpHUtzLkqvK68XPJlX7888tuyOR4W4T0oVN3N2p7UWG6cmrEoxefVJgOaMe+urbk3E1V
         a1XFvqs9dbyjoYayw5Or2IN5U8Rs2vZRFPh67tyXvKitauS5ErV/x9NQGDfswYlTUODi
         lHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1zCpRtD3iHQr6nGNz4bz1TQJ+FQA4CvvJQwtN3rYsG4=;
        b=jngsfR3FtYpYxq1pvFh9PCQ8q/ss433w344HmacLH2HEeZzQ7zoycfYXK5e6kH6rC3
         9yxA3jcUzgo1vB28KCiT0BMhj6m8jtr9kxGFg6TQgyh1NEZnuNcGo4syCESfERWOryjZ
         fONfWoQ/ao0f5qkkBE0lbPgr2hYiommqJG1zde8xt1pwYwLpHxUYHib3RLuZLX5ko+ch
         j4Unm1ypMIV+a8RhhBfp8HTsWblMzUW+WF4g7qXRVTkxhsY1VnaeooQovjZLEyACqBRY
         l5G3MJ2obPgkSfUlWyNK9MgnRN/AGHOpOJvB8h0UacXl6cMWdtmyYdodnqMX8t0sm1/O
         oQjg==
X-Gm-Message-State: AODbwcBuhGJ+eaBAIZrXJM58UbOTmjI5rTPlxFIRWKDeu0wu2IU9Ss8k
        dv7TZSx34MHTMQ==
X-Received: by 10.28.109.195 with SMTP id b64mr2205756wmi.46.1495021121059;
        Wed, 17 May 2017 04:38:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm12502473wmd.1.2017.05.17.04.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 04:38:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 2/3] sha1dc: use sha1collisiondetection as a submodule
Date:   Wed, 17 May 2017 11:38:23 +0000
Message-Id: <20170517113824.31700-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170517113824.31700-1-avarab@gmail.com>
References: <20170517113824.31700-1-avarab@gmail.com>
In-Reply-To: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we don't need local modifications to the code anymore with my
avar/sha1collisiondetection:easier-inclusion-in-other-programs branch
we can use the upstream code-as is.

If and when this change gets accepted by upstream we should of course
point to the https://github.com/cr-marcstevens/sha1collisiondetection
master branch instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitmodules            | 4 ++++
 Makefile               | 8 ++++----
 hash.h                 | 2 +-
 sha1collisiondetection | 1 +
 4 files changed, 10 insertions(+), 5 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..b60238a087
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "sha1collisiondetection"]
+	path = sha1collisiondetection
+	url = https://github.com/avar/sha1collisiondetection.git
+	branch = easier-inclusion-in-other-programs
diff --git a/Makefile b/Makefile
index 342466d83a..63223fd02f 100644
--- a/Makefile
+++ b/Makefile
@@ -1412,15 +1412,15 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
-	LIB_OBJS += sha1dc/sha1.o
-	LIB_OBJS += sha1dc/ubc_check.o
+	LIB_OBJS += sha1dc/lib/sha1.o
+	LIB_OBJS += sha1dc/lib/ubc_check.o
 	BASIC_CFLAGS += \
 		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
 		-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 \
 		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
-		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C="\"../sha1dc_git.c\"" \
-		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H="\"../sha1dc_git.h\"" \
+		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C="\"../../sha1dc_git.c\"" \
+		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H="\"../../sha1dc_git.h\"" \
 		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
 endif
diff --git a/hash.h b/hash.h
index a11fc9233f..e585237136 100644
--- a/hash.h
+++ b/hash.h
@@ -8,7 +8,7 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
-#include "sha1dc/sha1.h"
+#include "sha1dc/lib/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1collisiondetection b/sha1collisiondetection
new file mode 160000
index 0000000000..5423dd8bcf
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit 5423dd8bcf3cdbd029dfa08d5d5f6dc044f7ac6d
-- 
2.13.0.303.g4ebf302169

