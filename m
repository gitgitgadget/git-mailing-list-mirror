Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E392FC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 21:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiBRVCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiBRVCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 16:02:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83D28B610
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so16503026wrc.6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXtKWzVM2q6gQrra7ZEYYGVvbxpGkINVOIEMI8AnLa4=;
        b=FLd/8Y9T+Yyx3celiYxl/YM9KCLhp4CCekctSQUh4zURLFTPD/jYz0J0EQ+BGRfWoM
         cXjtQa2WFNZc5fHNiuD4fkyWRu3Oh6simIRtngiag8z91Feg+HrJ+uk09IpiuttvX/Qx
         /Ix/EhWGOd0q8nOSy30x8GZ7/YLz+GICr76kVFW9+ef3Iagy/3yizEn/qYINgvWgxGdT
         5vBJQCNKpbc0pDczCtHd8We71dFYzJoNvQdt6VVa+a1r9jqWNHEY6HbxCFo6ufXn6Cri
         /GdCQWISebD7N4TS8qmvzxuiRA5QBwClYhfD6JPucjOc2hmgW8cqys/64hLKIpdWvMrI
         omBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXtKWzVM2q6gQrra7ZEYYGVvbxpGkINVOIEMI8AnLa4=;
        b=BqXxG/XCMXJoDReeBi54X8YiY3DroAKuut2KegycSaBNXNS3KGyfr4S0/hO+TuHzIS
         mrjVeWsJTojqNZuPPSFIV7wthuAfbDfwt8uEz6pUEvEshyRxDLveYV8XHYbUBGddsxP6
         sRkND1BSVfG4ckL7TzQpDnO8IOspGTALLk09IxzOiyAI+A/DUGGK86iJgcAjPF+Vv4fd
         Hj95hBIQ+Yr6Z9H2PGOBtCyKiVWgtatOlp0nJKweZGSUKAFgiM1NXxm2aCAEy85Wy3ex
         5qwj3dp+OIQjA1/ZaPghcpvH4gxo6c+aB9Bis6tnJg1ah3ZZL0NOXZGJGUhl9XNDypO7
         E9CA==
X-Gm-Message-State: AOAM533TiUQYMuGgy/U3RXsM1janhDzVkm+y6fmM55QmKKshhNQCYGvd
        tecSbYBBg1Z0TXwk489PiIFoQynzelvyDg==
X-Google-Smtp-Source: ABdhPJxSF+3INQeLb7awQlPbtaevaRTi5LPtFK+tyJF5TMH/VgBpGDlj9Et9hWW0iKBQuUGz+7qDvA==
X-Received: by 2002:a05:6000:2c6:b0:1e4:a103:3986 with SMTP id o6-20020a05600002c600b001e4a1033986mr7640287wry.58.1645218113761;
        Fri, 18 Feb 2022 13:01:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm14238018wri.33.2022.02.18.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:01:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Fri, 18 Feb 2022 22:01:42 +0100
Message-Id: <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
variables, rather than punting out entirely if we already have them in
the environment.

We do want to take any user-provided settings over our own, but we can
do do that by prepending our defaults to the variable. The
libsanitizer options parsing has "last option wins" semantics.

It's now possible to do e.g.:

    LSAN_OPTIONS=report_objects=1 ./t0006-date.sh

And not have the "report_objects=1" setting overwrite our sensible
default of "abort_on_error=1", but by prepending to the list we ensure
that:

    LSAN_OPTIONS=report_objects=1:abort_on_error=0 ./t0006-date.sh

Will take the desired "abort_on_error=0" over our default.

See b0f4c9087e1 (t: support clang/gcc AddressSanitizer, 2014-12-08)
for the original pattern being altered here, and
85b81b35ff9 (test-lib: set LSAN_OPTIONS to abort by default,
2017-09-05) for when LSAN_OPTIONS was added in addition to the
then-existing ASAN_OPTIONS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b867..3212966a82f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,17 +36,31 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+# Prepend a string to a VAR using an arbitrary ":" delimiter, not
+# adding the delimiter if VAR is empty. I.e. a generalized:
+#
+#	VAR=$1${VAR:+$VAR}
+#
+# Usage (using ":" as a delimiter):
+#
+#	prepend_var VAR : $1
+prepend_var () {
+	eval "$1=$3\${$1:+$2\$$1}"
+}
+
+# If [AL]SAN is in effect we want to abort so that we notice problems.
+prepend_var XSAN_OPTIONS : abort_on_error=1
+
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
 # the noise level. This needs to happen at the start of the script,
 # before we even do our "did we build git yet" check (since we don't
 # want that one to complain to stderr).
-: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
+prepend_var ASAN_OPTIONS : $XSAN_OPTIONS
+prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
-# If LSAN is in effect we _do_ want leak checking, but we still
-# want to abort so that we notice the problems.
-: ${LSAN_OPTIONS=abort_on_error=1}
+prepend_var LSAN_OPTIONS : $XSAN_OPTIONS
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1031.g277d4562d2e

