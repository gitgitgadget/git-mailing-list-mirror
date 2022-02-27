Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFDC433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiB0K00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiB0K0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:26:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A691E3CA
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b5so11083816wrr.2
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxaTEw263G9wBwb0C+ak7OptsgqPJcwBfiLGsB1MN9M=;
        b=dsMq1jQ95TZf/D2Vd+l0NGuI+WwUCEhsi8Ebo4wFVdBWMlhM8a3Obi+0m3Hi0VD45c
         txyuZbGoU8QP0aQ7DXoLi9vr6G+iSCWufLiV22WP3qM6bRvpxq2qplXRk570ZUxfVwPA
         MtRRfUuft8HFzCb0L2YhBTlCueJSQu5uO6eLRlXa/itvWyanee4wxslv42loXtqvUk2l
         aciloNK321kSmiw42YCZnTeusx4dfwiVVtCaSlM55/dqCQphxb3qfdxjL+xOqpwr0BwD
         2/HglLcjmiLoiVQEh74Bw9Ny+WE52xFqW3r8q29KuzVMUxt9Bia1TspUywH9yreqT+qz
         5htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxaTEw263G9wBwb0C+ak7OptsgqPJcwBfiLGsB1MN9M=;
        b=G9C94yOmafn8OS6Z4ZQC6hiz1XrD8PRcpucaNPRtB0gUT2aql8mn7AfxVyf2Xml8xT
         qNqsxDnIq1GgbNnhvbngxUYscVCTuph8sm8OlasBG1w6Kxh1XO78a2FyyZjMbKJr9qk0
         YcZLz1axgNRpaySYzB/NApAXsDx1wAIcbszb2k5M8lW/EK223NIl4yI6ABX9QJ92xpQJ
         60bX8HNowpKnXaCoHA2oFIgWo8kXNd4Nla6YMnCsVzK/e15vSytItkzmdioRYlZfgd23
         YVb+9/nMguw832qmJ5FzpfNoW3sXCh6Oim0wSE5yXwt0HhRPzQQZja6xXnho7N0QCnv8
         CgGA==
X-Gm-Message-State: AOAM531m2IM11eZfp7Xa0/mMGvKkveI58XOCYTh3vnp2xXCjIIEo/FrB
        uVuMiczdeLz8lkM4w9k/LIj8y6FsPcevwQ==
X-Google-Smtp-Source: ABdhPJwwfxX7q55ba7NqbjtV/9/b9HdpgAJqcL2Y2RfnRV/W48/kN2xdZb6gpCAQEA44ePk2LwJqQg==
X-Received: by 2002:a5d:568d:0:b0:1ed:e3d4:580a with SMTP id f13-20020a5d568d000000b001ede3d4580amr12094120wrv.391.1645957547775;
        Sun, 27 Feb 2022 02:25:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm11031685wmj.42.2022.02.27.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:25:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] test-lib: add GIT_SAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Sun, 27 Feb 2022 11:25:10 +0100
Message-Id: <patch-v4-1.4-d1967ab34a5-20220227T102256Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1188.g137d9ee5e75
In-Reply-To: <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
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
2.35.1.1188.g137d9ee5e75

