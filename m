Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0E1C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 10:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiB0K0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiB0K00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 05:26:26 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0481E3C3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so11012181wrg.10
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 02:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Thlu0H4HdomAZZN6upLfmTYQ/TimhZaDbN6mZP8lRs=;
        b=O1m0Q1SR28Sr1br+7HJr+vASleqP6xvLcmlDvrnAuNPvIrJFCk8kkQv1Mr18VmhB54
         bY3kb+DIpcKHExNyBIhh6qvStGZYcjq2asRT6I7b+PiMEGWylpbg4d4Ed8zN5U61OZeE
         OMM1GykH9hF8iLY9uePSnbF84Q0lQJBqPob9kLgUhSeibKeml0z21r14M0LJ922T0NTM
         jDQKJB5mm2g/B5+Nq6NP0nknRs2O9eYpLKLm10R9mn2bCQD6WovOkZODMJgDxtSekKho
         wTMDNpvAmEDBWnZPyFhaOL77gjhNu8cXlLz7Fkttz7EpTOZkm9UKree2YDyq5k6Ms8FZ
         0+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Thlu0H4HdomAZZN6upLfmTYQ/TimhZaDbN6mZP8lRs=;
        b=ubUR8xQ+Ve8tei1b/UJXSlVAXHkaKLbrfDE6M2L6i9SuUfg4cUxo22D5V9LM3+RtuE
         ava3ylwk3V3E89n3LyyYUB5T/qmzIAc31DcmDQfTANtNIzIIhS8KeeVz/MJ6UZ8U7TiM
         HpxcYCcMZ1+W8jexYIA1Pt9gVoG0HJ5u3uGy01Vhqhnzilk3gu7HSblP/mwFlAOUrDYM
         ziEEFVS2KY2u5cOgJLmXk+dD4OPrs5f4MStykdzyRZIBYXF+bxTyJiEykFmch84ey3OH
         ko2rrIgLqhNEEZ+m7e8qlhhU2sMFaoAETCmc1Euip2acqFPpNFWsDtLm84sB+Jb6h8W/
         Nxlg==
X-Gm-Message-State: AOAM530Obg/SW9NArefTaLv926X79o9PX+4LENykKtpnC/p2Ks7oeXyI
        /zmx6kYUfYmdHDBOgiyxibybrPNKRoTB0g==
X-Google-Smtp-Source: ABdhPJzMadFcqKn+RN4SZg/HvikxBgoe1JGBsCx66W/2kM7UyblyiYXGnFqIdM9RQbWtq6fSduUKww==
X-Received: by 2002:a5d:5042:0:b0:1ef:88d0:f631 with SMTP id h2-20020a5d5042000000b001ef88d0f631mr4518530wrt.232.1645957548758;
        Sun, 27 Feb 2022 02:25:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a3-20020a7bc1c3000000b00380e493660esm11031685wmj.42.2022.02.27.02.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 02:25:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] test-lib: correct and assert TEST_DIRECTORY overriding
Date:   Sun, 27 Feb 2022 11:25:11 +0100
Message-Id: <patch-v4-2.4-97586ad4541-20220227T102256Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1188.g137d9ee5e75
In-Reply-To: <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20220227T102256Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a misleading comment added by me in 62f539043c7 (test-lib:
Allow overriding of TEST_DIRECTORY, 2010-08-19), and add an assertion
that TEST_DIRECTORY cannot point to any directory except the "t"
directory in the top-level of git.git.

This assertion is in effect not new, since we'd already die if that
wasn't the case[1], but it and the updated commentary help to make
that clearer.

The existing comments were also on the wrong arms of the
"if". I.e. the "allow tests to override this" was on the "test -z"
arm. That came about due to a combination of 62f539043c7 and
85176d72513 (test-lib.sh: convert $TEST_DIRECTORY to an absolute path,
2013-11-17).

Those earlier comments could be read as allowing the "$TEST_DIRECTORY"
to be some path outside of t/. As explained in the updated comment
that's impossible, rather it was meant for *tests* that ran outside of
t/, i.e. the "t0000-basic.sh" tests that use "lib-subtest.sh".

Those tests have a different working directory, but they set the
"TEST_DIRECTORY" to the same path for bootstrapping. The comments now
reflect that, and further comment on why we have a hard dependency on
this.

1. https://lore.kernel.org/git/220222.86o82z8als.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55f263a02d3..48ee3b16ecd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -19,13 +19,20 @@
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
 then
-	# We allow tests to override this, in case they want to run tests
-	# outside of t/, e.g. for running tests on the test library
-	# itself.
-	TEST_DIRECTORY=$(pwd)
-else
 	# ensure that TEST_DIRECTORY is an absolute path so that it
 	# is valid even if the current working directory is changed
+	TEST_DIRECTORY=$(pwd)
+else
+	# The TEST_DIRECTORY will always be the path to the "t"
+	# directory in the git.git checkout. This is overridden by
+	# e.g. t/lib-subtest.sh, but only because its $(pwd) is
+	# different. Those tests still set "$TEST_DIRECTORY" to the
+	# same path.
+	#
+	# See use of "$GIT_BUILD_DIR" and "$TEST_DIRECTORY" below for
+	# hard assumptions about "$GIT_BUILD_DIR/t" existing and being
+	# the "$TEST_DIRECTORY", and e.g. "$TEST_DIRECTORY/helper"
+	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
@@ -35,6 +42,11 @@ then
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+if test "$TEST_DIRECTORY" = "${TEST_DIRECTORY%/t}"
+then
+	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
+	exit 1
+fi
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
-- 
2.35.1.1188.g137d9ee5e75

