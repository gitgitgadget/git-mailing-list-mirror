Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E35C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 15:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379774AbiBUP7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 10:59:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiBUP7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 10:59:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB772980C
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso11491755wmb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObOtvIQLn55nvRiRlYVIDva0R11X8Tr96pfZoGcXu5Q=;
        b=M/dbs/LsfIEYOnJyCWJ8myVsylp2DQ5Qe1gMi9xFZ94qCeTnh0Lc3PWoEi/yNN/Sb9
         ulDEjyAre3oHJXj62o1fd9Y/uTr+efOutWaKnhOfVO3VW39T+2v0zjFOQw4yz+F26MWO
         6S9aW7JEfRGLpERcLUteguELqagWFKXyBWgiDmvaQrQ01H5DHnqFTgu7SpUfs+s1vCSK
         ZuY79RKp5O30FBJDSNItPXKUWfNyEXTPbLgP/Lb/Y3ua3+2wmVs0daFq510BJ0gBD03z
         gdYWQDcZ1ZA3FN2TqC9VzU53NjICxQksCsaC9JveFlT5nrNErezUr4rD1BmXo6Fn6Us3
         wRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObOtvIQLn55nvRiRlYVIDva0R11X8Tr96pfZoGcXu5Q=;
        b=p1VZ9kpmZioop2QtBWYFM1FO92W/oHZUCC1PVmrdA96nN4Eg+dDSL8IrBS1zg2EyLS
         KboThJg330xn8+JKeJIPo/z1F9f9V3zb/l7OEo7hyynz5PHEAnoK0WWvg85ITF12vlt5
         1WywUxqq67Fpq+IqjLucp+1TDTYjAPq7Nk3wNJ//QOkrCaNWz5ImTG7h4BK5GuomWP3g
         8M87EDPtJqRfz7woJCafjWs1DQYmz4IDqFeQaFgf34PYnj9nHZu+8cO+rexlKvtohhVy
         MOBLOll8ozOyblRvsxujhOKBI/QcKQei4mugLy0UQjvut6sHRj+qPVslrEmUEcCppM12
         Y2WA==
X-Gm-Message-State: AOAM530eNByayimS7SXS7dU/nZC/pGdt3DCDQtU1d4/BxdlBRl4uRMGU
        G9M76vwYSsdaE0w0IZaX4k4nPlguRE4okg==
X-Google-Smtp-Source: ABdhPJy3uoYeUxkes3Scv9W/UzQnfP5fG4eRffLLoQps5TngilvECUEwAKnN1qf0k/CAIvJNUgePMA==
X-Received: by 2002:a05:600c:1ca1:b0:37b:a639:96a5 with SMTP id k33-20020a05600c1ca100b0037ba63996a5mr21715492wms.68.1645459136802;
        Mon, 21 Feb 2022 07:58:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x10sm7811170wmj.17.2022.02.21.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 07:58:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/4] test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Mon, 21 Feb 2022 16:58:32 +0100
Message-Id: <patch-v3-1.4-bf31efca464-20220221T155656Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change our ASAN_OPTIONS and LSAN_OPTIONS to set defaults for those
variables, rather than punting out entirely if we already have them in
the environment.

We want to take any user-provided settings over our own, but we can do
that by prepending our defaults to the variable. The libsanitizer
options parsing has "last option wins" semantics.

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
 t/test-lib.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b867..55f263a02d3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,17 +36,33 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+# Prepend a string to a VAR using an arbitrary ":" delimiter, not
+# adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
+#
+#	VAR=$1${VAR:+${1:+$2}$VAR}
+#
+# Usage (using ":" as the $2 delimiter):
+#
+#	prepend_var VAR : VALUE
+prepend_var () {
+	eval "$1=$3\${$1:+${3:+$2}\$$1}"
+}
+
+# If [AL]SAN is in effect we want to abort so that we notice
+# problems. The GIT_SAN_OPTIONS variable can be used to set common
+# defaults shared between [AL]SAN_OPTIONS.
+prepend_var GIT_SAN_OPTIONS : abort_on_error=1
+
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
 # the noise level. This needs to happen at the start of the script,
 # before we even do our "did we build git yet" check (since we don't
 # want that one to complain to stderr).
-: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
+prepend_var ASAN_OPTIONS : $GIT_SAN_OPTIONS
+prepend_var ASAN_OPTIONS : detect_leaks=0
 export ASAN_OPTIONS
 
-# If LSAN is in effect we _do_ want leak checking, but we still
-# want to abort so that we notice the problems.
-: ${LSAN_OPTIONS=abort_on_error=1}
+prepend_var LSAN_OPTIONS : $GIT_SAN_OPTIONS
 export LSAN_OPTIONS
 
 if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
-- 
2.35.1.1132.ga1fe46f8690

