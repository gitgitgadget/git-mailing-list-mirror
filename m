Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653FB1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 09:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbeHWMnZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 08:43:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54588 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeHWMnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so4481186wmb.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMgrvgqjGluxxzp9UKIwWkbywrLDxMECMEonoa1/kPM=;
        b=nXgF7flWxbsN//zF+3SzCBLuPxhBucNU0kyyvtMs+uTFcuYU3qbN7e+2JXI8cnxc6O
         hvbdNnqnWnIJZhOWhfAJVHyALslaVCmJ0918CuxNDEqnUEFO4MhUN5WJ+a+p6u2e94Rw
         8Xa3AunaHni/i8hL3hPCMuuqaM1ZWVDJCTz1Cv/Hvm2o47/rSamo1p6NluDTNDLZZUJY
         bWhmECV856QAWwGtEFeYVkmUL1qvAE8ZGHC93cfKHTdR1nNQxRrMYUdP1bSLhKubT3Jt
         mKcU0MtrENa/84ASZzw2tEZ1KHlOobwjsTaGzwQ40uvQ1AKpRwDe5d6r+Sy2x618na/p
         U6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMgrvgqjGluxxzp9UKIwWkbywrLDxMECMEonoa1/kPM=;
        b=RilluE7tLbB2IzE5PDresmZ2Z1bSvCGmV3S9F9QMVSdoMUeJ0V/pz3kQwIrX8zTTY/
         4QRripYNGcxaqFONBPbpS83YpUpzXLgqvDga4zEwrRmazAv4t17srdajIi86Hb0SkASw
         Jiai5uYL3I8a4Nmy8FwSbenLX9IwMaCPfELRiO7ZopVT4meHh8LJcelHQQKH34MHmIM1
         RvaCsGI4QuiwUkLiHwHvuxMW/a+SUnIUIN9CEPw4w5zmKtpVHAnkTu68MBJxEoxy95Fb
         gNFv+PhaXAQ0XntY2Ip7TWy2Wd3RwEiXzHrSghz+x4OvGh6P5Nw66vLcbcHSI8TPjBLs
         m5Aw==
X-Gm-Message-State: APzg51Cb0YfCdzgjLBcOPZthJQ+/fhW/Sr1B2bXaCC97o6SUCaxgFUaR
        EopPIPHgjSpzqNFHrimHHsdNnH5W
X-Google-Smtp-Source: ANB0VdZ8DduoXIqJMExikQpr5sEid7/64+mMUok0yNVq/EwnqHqJ2Wj3MLgVI7jrxObgRMia6bLqWg==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr4733465wmc.90.1535015677341;
        Thu, 23 Aug 2018 02:14:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v133-v6sm6567830wma.36.2018.08.23.02.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 02:14:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: fix and add lint for non-portable head -c N
Date:   Thu, 23 Aug 2018 09:14:27 +0000
Message-Id: <20180823091427.1756-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "head -c BYTES" option is non-portable (not in POSIX[1]). Change
such invocations to use the test_copy_bytes wrapper added in
48860819e8 ("t9300: factor out portable "head -c" replacement",
2016-06-30).

This fixes a test added in 9d2e330b17 ("ewah_read_mmap: bounds-check
mmap reads", 2018-06-14), which has been breaking
t5310-pack-bitmaps.sh on OpenBSD since 2.18.0. The OpenBSD ports
already have a similar workaround after their upgrade to 2.18.0[2].

I have not tested this on IRIX, but according to 4de0bbd898 ("t9300:
use perl "head -c" clone in place of "dd bs=1 count=16000" kluge",
2010-12-13) this invocation would have broken things there too.

Also, change a valgrind-specific codepath in test-lib.sh to use this
wrapper. Given where valgrind runs I don't think this would ever
become a portability issue in practice, but it's easier to just use
the wrapper than introduce some exception for the "make test-lint"
check being added here.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/head.html
2. https://github.com/openbsd/ports/commit/08d5d82eaefe5cf2f125ecc0c6a57df9cf91350c#diff-f7d3c4fabeed1691620d608f1534f5e5

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: Even though this isn't a 2.19.0-rc0 regression I think it makes
sense for 2.19.0. The fix is trivial, and it'll unbreak (at least some
of) the tests on stock git on OpenBSD.

OpenBSD guys: If you CC the git mailing list when you find you need to
apply patches like these, we're happy to fix this more pro-actively. I
just happened to be testing the upcoming 2.19.0 on OpenBSD and spotted
this.

 t/check-non-portable-shell.pl | 1 +
 t/t5310-pack-bitmaps.sh       | 2 +-
 t/test-lib.sh                 | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index d5823f71d8..94a7e6165e 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,6 +35,7 @@ sub err {
 		chomp;
 	}
 
+	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/\bsed\s+-i/ and err 'sed -i is not portable';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 557bd0d0c0..7bff7923f2 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -335,7 +335,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	head -c 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8bb0f4348e..44288cbb59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -867,7 +867,7 @@ then
 		# handle only executables, unless they are shell libraries that
 		# need to be in the exec-path.
 		test -x "$1" ||
-		test "# " = "$(head -c 2 <"$1")" ||
+		test "# " = "$(test_copy_bytes 2 <"$1")" ||
 		return;
 
 		base=$(basename "$1")
@@ -882,7 +882,7 @@ then
 		# do not override scripts
 		if test -x "$symlink_target" &&
 		    test ! -d "$symlink_target" &&
-		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		    test "#!" != "$(test_copy_bytes 2 <"$symlink_target")"
 		then
 			symlink_target=../valgrind.sh
 		fi
-- 
2.18.0.865.gffc8e1a3cd6

