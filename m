Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA0C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 05:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCMFBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 01:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCMFBp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 01:01:45 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE72457CF
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:37 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17671fb717cso12545958fac.8
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov841ADxrFVhWLXqGzlma61w4hvDFdv5HEnPz4oAEws=;
        b=O09TsgepoFSHElmu5Pxz3MS5MbwL+AljPQzBUkJ4VP4wGUeIzo4jf/lc0vFhTeg41t
         3TfSBuKktRY3frfvXLLoDsQmGW00Ku/oHw2Rena59CETJJxeCBkCT9mc+lgjeB5LIKaL
         pVP1Sto7+yDFbewtkWjjJBAn6fGSXR9ZgyRMx6dt6C2Ph7Q7QH/uz28iwWPK9McTOS02
         OkbYaYSdbRmKrJn9CV+Fc4tFri0mjhvJdFzn1KWV885o+9fQRtuipgnt/AygfbEeOSOa
         0zc/FfwYwO1494OxzJzMB9TvQ6/puEAMkgVf4If1RP0cILBYjZwOxSwkbRtLFUSBDE7l
         EVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov841ADxrFVhWLXqGzlma61w4hvDFdv5HEnPz4oAEws=;
        b=KTV9uBdKBme/l2c5BLVbpaLRnA0oiIjo8WTB6rtQQu/+ZcmS2XLsBwfCtRL1yXDc0Y
         9JuAyPgEV3Z7E3E7Qx8ujnvp1pxmjCvoRFBA1rwHyYOM2dmiVgLpQB4ZC2kcFL4awd86
         jRIQfBueLjNhDwSf81bm1CSnm1mgSgpalKJgAIdQrjabISOwd/enaT+jEPS4hB5sKk7T
         qFosxjN0WGgMRLtMja+J+wXxaBrARDXMM8SahMlko6CYCm2g8vTuRr30uhbSKUmMk4BW
         8rwaFsfNScmcB2V5utb3WcFIESTRk/ZGrw0IhEwux9IsyJBA8DV8lJGslS/XC2J7+lWC
         +3Xg==
X-Gm-Message-State: AO0yUKUZijLgQgx1qtqI5TzIGdw5X6ZwGkssC0YtpvQ5kodCdv7i9F8m
        8542SEzCDVGxEaUoMd/xdIXNwyqivWk=
X-Google-Smtp-Source: AK7set/Wh+Ovzp7MXPEWIDqcAR9F2LhGGp1zWByDdUnPNs6VgS2qlFIvUCXY/l69RtUtiHMwiem8+g==
X-Received: by 2002:a05:6870:7082:b0:177:b78b:1e39 with SMTP id v2-20020a056870708200b00177b78b1e39mr1217640oae.0.1678683696320;
        Sun, 12 Mar 2023 22:01:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870954e00b00177ba198612sm480144oal.53.2023.03.12.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:01:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 1/2] test: relocate test_expect_{success,failure}
Date:   Sun, 12 Mar 2023 23:01:31 -0600
Message-Id: <20230313050132.3464802-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230313050132.3464802-1-felipe.contreras@gmail.com>
References: <20230313050132.3464802-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Their proper place is in test-lib.sh since they aren't meant to be
called in a subshell, except in t0000-basic.sh of course.

The rationale behind the move (12a29b1a50 (Move the user-facing test
library to test-lib-functions.sh, 2012-02-17)) was that the tests in
t/perf would need test-lib-functions.sh inside the subshells, for
example:

        test_perf 'perf test' 'test_expect_success foo :'

But that doesn't actually happens in any of the perf tests.

So move these functions back where they belong.

Cc: Thomas Rast <tr@thomasrast.ch>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib-functions.sh | 42 -----------------------------------------
 t/test-lib.sh           | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999d46fafe..49a850989a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -801,48 +801,6 @@ test_verify_prereq () {
 	BUG "'$test_prereq' does not look like a prereq"
 }
 
-test_expect_failure () {
-	test_start_ "$@"
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	BUG "not 2 or 3 parameters to test-expect-failure"
-	test_verify_prereq
-	export test_prereq
-	if ! test_skip "$@"
-	then
-		test -n "$test_skip_test_preamble" ||
-		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2" expecting_failure
-		then
-			test_known_broken_ok_ "$1"
-		else
-			test_known_broken_failure_ "$1"
-		fi
-	fi
-	test_finish_
-}
-
-test_expect_success () {
-	test_start_ "$@"
-	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
-	test "$#" = 2 ||
-	BUG "not 2 or 3 parameters to test-expect-success"
-	test_verify_prereq
-	export test_prereq
-	if ! test_skip "$@"
-	then
-		test -n "$test_skip_test_preamble" ||
-		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
-		if test_run_ "$2"
-		then
-			test_ok_ "$1"
-		else
-			test_failure_ "$@"
-		fi
-	fi
-	test_finish_
-}
-
 # debugging-friendly alternatives to "test [-f|-d|-e]"
 # The commands test the existence or non-existence of $1
 test_path_is_file () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62136caee5..388075a6c6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1269,6 +1269,48 @@ check_test_results_san_file_ () {
 	fi
 }
 
+test_expect_failure () {
+	test_start_ "$@"
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
+	test "$#" = 2 ||
+	BUG "not 2 or 3 parameters to test-expect-failure"
+	test_verify_prereq
+	export test_prereq
+	if ! test_skip "$@"
+	then
+		test -n "$test_skip_test_preamble" ||
+		say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
+		if test_run_ "$2" expecting_failure
+		then
+			test_known_broken_ok_ "$1"
+		else
+			test_known_broken_failure_ "$1"
+		fi
+	fi
+	test_finish_
+}
+
+test_expect_success () {
+	test_start_ "$@"
+	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
+	test "$#" = 2 ||
+	BUG "not 2 or 3 parameters to test-expect-success"
+	test_verify_prereq
+	export test_prereq
+	if ! test_skip "$@"
+	then
+		test -n "$test_skip_test_preamble" ||
+		say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
+		if test_run_ "$2"
+		then
+			test_ok_ "$1"
+		else
+			test_failure_ "$@"
+		fi
+	fi
+	test_finish_
+}
+
 test_done () {
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
-- 
2.39.2.13.g1fb56cf030

