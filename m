Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581A3C433E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309B223AAA
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbhANXgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:08 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98927C0613CF
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q18so7518671wrn.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeWxTXBVSg3U8YK5gv2URbzW5x3EI6oGreNp5GPxAQk=;
        b=tjNegOT7F3+bLmqnrygLu8kARCeqiDq51uFgGhxovp0kV68+4UW8Ztu4rTDHVgqLZb
         op9dp7KwreWZuFYTVpgwhG0NIUFAa/XZNMRabiJcfBw/D0XVEGY8TyetkWyz4fvRETPj
         UBcQPGP8BPh5S7BJ0Iygk1pEXh+MvPJpteKpxPK9t9bgxvsEqi0XHZB2jo4CIuNFp6XE
         JhcXyjS2CrkX2HG/ff5mbEkboKAVHHgZzreZEpAA6BJH+o6EBT2ZPzgVsR8epKk70bVN
         ATOiBWqI4I60WjAihoQbCoJnUw6jY14iRdZCHFz9Ruk10HEdvXt1KnBVBXrgo90gR2J3
         5Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeWxTXBVSg3U8YK5gv2URbzW5x3EI6oGreNp5GPxAQk=;
        b=aol8rMTBTQjc3FnequH2HYR3DU4itbS5q6rr8vJSlsz+MYIiMmUKieZN9oJCaklWaP
         NvI+gIACKDBWMfCQEzcCCbQf1HlTaaZGbPziZ/0xDkAZFgGiQTxwNc/4H0DpzCA2J3Tf
         BCxLT1ACQSWqNsCjcnFTYol3EDSkmUcaQsA5iPx8CS71Pdi8QcHsN7mOkvK2NUWH99OT
         ZWy++NuFqFN1kY81Bkm3VNnMaI4gKXxEALu18/TclS+/kWYpFLi4A+fP3QRgPqZXgvHg
         wdH2n77MY05SLZ+5qoHW5Dj1HT0Dtg0HOpt6gosu5l3fn8vv0BxtCAgXIFRaUkrJ+R0W
         oVAw==
X-Gm-Message-State: AOAM530AbUauCqZsWyX1IuCCwoy5Pm8+OdrY+2P8gvov4AXZGFKsqTqE
        c1B5hNzcCivjAx1c/VRJs46nhr1kkNUPKQ==
X-Google-Smtp-Source: ABdhPJwldE97JPiHKyD07TJ84VGGdA6Es1Yf+wWWfRNmPiTnprUj1wFvNtovOHdheM+9WEfeKZ2dqg==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr10220326wru.213.1610667325693;
        Thu, 14 Jan 2021 15:35:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] test_lib: allow test_{must,might}_fail to accept non-git on "sigpipe"
Date:   Fri, 15 Jan 2021 00:35:12 +0100
Message-Id: <20210114233515.31298-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the documentation here notes you usually do not want to do:

    test_might_fail grep ...

But instead:

    ! grep ...

However, as a future commit will show it's handy to be able to do:

    some | test_might_fail ok=sigpipe grep | commands | here

To allow "grep" to fail in the middle of a pipe, if we're in a mode
such as a "set -o pipefail" that knows how to accept check intra-pipe
failures.

To test this in t0000-basic.sh we don't actually need to have
test_{might,must}_fail in the middle of a pipe, it'll just that it
accepts e.g. "grep" when we provide ok=sigpipe.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh        | 13 +++++++++++++
 t/test-lib-functions.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index fd6cb8d5d3..930cf9d1b7 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1337,4 +1337,17 @@ test_expect_success 'test_might_fail supports an ok=* option like test_must_fail
 	test_might_fail ok=success git version
 '
 
+test_expect_success 'test_{must,might}_fail accept non-git on "sigpipe"' '
+	! test_must_fail grep blob <badobjects 2>err &&
+	grep "only.*git.*is allowed" err &&
+	! test_might_fail grep blob <badobjects &&
+	grep "only.*git.*is allowed" err &&
+
+	! test_must_fail ok=sigpipe grep . badobjects 2>err &&
+	test_must_be_empty err &&
+	test_might_fail ok=sigpipe grep . badobjects >out 2>err &&
+	test_must_be_empty err &&
+	test_cmp badobjects out
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e01761f7ba..f10bd6170a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -828,6 +828,7 @@ test_must_fail_acceptable () {
 		return 0
 		;;
 	*)
+		list_contains "$_test_ok" sigpipe && return 0
 		return 1
 		;;
 	esac
@@ -863,6 +864,17 @@ test_must_fail_acceptable () {
 # Instead use '!':
 #
 #    ! grep pattern output
+#
+# An exception to this is if ok=* contains "sigpipe". Then you might
+# want to use this in a test to ignore e.g. "grep" failing due to not
+# finding anything in a multi-pipe command:
+#
+#    test_must_fail ok=success,sigpipe grep [...] | [...]
+#
+# Or, more succinctly with the test_might_fail wrapper function:
+#
+#    test_might_fail ok=sigpipe grep [...] | [...]
+#
 
 test_must_fail () {
 	case "$1" in
-- 
2.29.2.222.g5d2a92d10f8

