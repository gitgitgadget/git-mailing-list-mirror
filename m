Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A92FC4332B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422EF6527D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 16:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhCIQCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhCIQCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 11:02:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66116C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 08:02:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id 7so16699735wrz.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 08:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAU/PGDShvkB0mElY/95HRS0r/8YqJwb3HLfBRmGq64=;
        b=nP4FxZ7nNGyHUaUsnmpHL9GcuPlQREwtsCqeAHno90VMS7auCeqUdYud2vwgJbVzvk
         K/yJ9EXVJLJr5Z4L/m4v2Qy0JuQgc93i4ITWQp4MmQidc+2MyOYMIyrum9bDIPBBHpiM
         AKGMmGsrUowexvwRw2kUFRqs2p1GngKAAtBH7aHlGGXAYfeMna7/kDvAe6xbiyp88zij
         feEGbeVVCGrI7tYu/o0cOZMzo2V9Df9Mw8Z+YOFHWeGZNY5V1EhUKaBYJTsqukwvBsoo
         xmdH7zTnOWuI4yoEfQe2zDghAvdyzIDZyXo7M3AmHV5qfsZBXtiN6yscOSV3pKf84CTw
         l2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAU/PGDShvkB0mElY/95HRS0r/8YqJwb3HLfBRmGq64=;
        b=OeMYiBX0D8bDqEw+TThUEV7aswlIpnb9Z1A+GOCdtWj95phiZKIBQ8pd3CtI+qYiBV
         fV1cqFsol1LxytmEiNqHWrj/csX+Cm6DSsAXt2cJjlGDYAl/ZeiHDdFgDz/8w7bletiE
         loWU2TdxgnPxx08w+NwTlHgj1IUOxf8TOWOuv301KqcETdRMacJdlJiKlS96aZKTWJAJ
         23YclQghBEaeKIVtRxM527m81qtbKD8Vi6Hx6hQrNEpHwEonWmAfpdQH8Dxm6n4c6epa
         /W9Ufmgf5zU9UBdWOalaay6taPLIi8fCkRjW5k8TCUlGKQV637gl9OhU1qqiyNxrT7HS
         sSxg==
X-Gm-Message-State: AOAM531V+T+xa/a3zXYr81IYI9yOSPHDB+ho7pbTVD6e5ijrSm9/IxJp
        cAaa3mkAcLAsoSqNPsCRI6EgsXoTwSZbCA==
X-Google-Smtp-Source: ABdhPJz7aDDKx5enWz6izgWgGLj3Yx+x6SFFXIC2R97+VeHWOK6rnZATiLksRCSJCc8cCGzfgDh1QQ==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr28200846wrc.276.1615305753052;
        Tue, 09 Mar 2021 08:02:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n6sm5089223wmd.27.2021.03.09.08.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 08:02:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] test-lib: add say_color_tap helper to emit TAP format
Date:   Tue,  9 Mar 2021 17:02:14 +0100
Message-Id: <20210309160219.13779-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.210.g0f8085a843c
In-Reply-To: <87r1kzj7xi.fsf@evledraar.gmail.com>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 5099b99d25 (test-lib: Adjust output to be valid TAP format,
2010-06-24) and make it easy to distinguishing when we're emitting TAP
directives (with the new "say_color_tap"), and when we just want to
say something with colored text "say_color".

This also makes it easier to do any follow-up changes where we'd like
to do something special with the TAP directives, as they're what
drives the test when we run under the prove(1) utility.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b0a8bc42510..9a3a3d8d16d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -562,6 +562,13 @@ else
 	}
 fi
 
+say_color_tap() {
+	test "$#" = 2 ||
+	BUG "not 2 parameters to say_color_tap"
+
+	say_color "$1" "$2"
+}
+
 TERM=dumb
 export TERM
 
@@ -666,7 +673,7 @@ test_ok_ () {
 		write_junit_xml_testcase "$*"
 	fi
 	test_success=$(($test_success + 1))
-	say_color "" "ok $test_count - $@"
+	say_color_tap "" "ok $test_count - $@"
 }
 
 test_failure_ () {
@@ -691,7 +698,7 @@ test_failure_ () {
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok $test_count - $1"
+	say_color_tap error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
@@ -712,7 +719,7 @@ test_known_broken_failure_ () {
 		write_junit_xml_testcase "$* (known breakage)"
 	fi
 	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	say_color_tap warn "not ok $test_count - $@ # TODO known breakage"
 }
 
 test_debug () {
@@ -1027,7 +1034,7 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
+		say_color_tap skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
 	*)
@@ -1153,12 +1160,12 @@ test_done () {
 		test -z "$skip_all" || skip_all="# SKIP $skip_all"
 		case "$test_count" in
 		0)
-			say "1..$test_count${skip_all:+ $skip_all}"
+			say_color_tap "" "1..$test_count${skip_all:+ $skip_all}"
 			;;
 		*)
 			test -z "$skip_all" ||
 			say_color warn "$skip_all"
-			say "1..$test_count"
+			say_color_tap "" "1..$test_count"
 			;;
 		esac
 
@@ -1181,7 +1188,7 @@ test_done () {
 
 	*)
 		say_color error "# failed $test_failure among $msg"
-		say "1..$test_count"
+		say_color_tap "" "1..$test_count"
 
 		exit 1 ;;
 
-- 
2.31.0.rc1.210.g0f8085a843c

