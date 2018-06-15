Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA001F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756556AbeFOSaw (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:30:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39153 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756484AbeFOSau (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:30:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so10798842wrn.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=TGAmGl2swrn0rfOwx5nQwm51ftk4UiHTuQ3v72ssvMY=;
        b=T+IpwoXMBO0Dxo/uQ0zBBF5ldb59k7EU+j3ReFKwbYGG89F57WnIJV4eetsug/8EAp
         JhsSA+WzvqQiWLTbHvhZp+IA1JKIuXm/aJqYuEPJsjQHbJr8DcLqW174XohBj2mhvyNS
         hpVCRkY5JQAwic5eoORICu4EHOdSRB03dxaGuWZzCiCj+Syaib+tlqv9SCd+jUy7gTmL
         oELUWOCMorTTz/xFKVxt78Q7TLkkn5v/9rdXNvE+PMFExr2h8o9wCIAXDGNdHezF1hCx
         xD3D8shp0efUaWyhYxwgVWrnUK4lP39nbUfkVBV3bkX2qB3a0qOkH6nG87KaM/cR0JWc
         qcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=TGAmGl2swrn0rfOwx5nQwm51ftk4UiHTuQ3v72ssvMY=;
        b=mTtmRmQupE+DMFu/NlA6xEcJ9yst/wgyIx4xChtjB2eJlH3L++Fzfx5bxIKU1QHEf1
         TuyuO2b0EiIFkhjIJXys02Gv4WL4gtFG/zWNgCtG1jNTvDGQ/asJLXR9J1RdAuoyEkZz
         X9N2JavtN7I2joQNtoQv7oPeH1tYPQjsbP96cwuLTXx1pGAMGMXXZl/srbzFerwwiU3c
         5N6q43vCwxHQnYrDGRC9fv57SbDtWXDKse8Q5/rvL4KRnTGeGLp+kfwGbgycxziltQdz
         EKqoc/VpvN2hMTy9lU2vy9Y0LzsG/O0e5Zi2DQZEbkt7rqdESXqqntN3WFa2JFJoKiy1
         iSZQ==
X-Gm-Message-State: APt69E05tmL+ruN99sqrEqudYy5ftnDpLTr5R8bbcW7I3Fz3djEwjP6Y
        pzfw7YgFZnN5syRL/qgwtKtqBktN
X-Google-Smtp-Source: ADUXVKJkzdIBYd6TPIoFc16/QVlFlUHTXoJv0ee8a2ZRbteryXwSedPanE8s3Dpog9NJXnTsUhSGvQ==
X-Received: by 2002:adf:9924:: with SMTP id x33-v6mr2705575wrb.29.1529087449129;
        Fri, 15 Jun 2018 11:30:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h71-v6sm2632378wme.47.2018.06.15.11.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:30:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] tests: clean after SANITY tests
Date:   Fri, 15 Jun 2018 11:30:48 -0700
Message-ID: <xmqqa7rv297r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of our tests try to make sure Git behaves sensibly in a
read-only directory, by dropping 'w' permission bit before doing a
test and then restoring it after it is done.  The latter is needed
for the test framework to clean after itself without leaving a
leftover directory that cannot be removed.

Ancient parts of tests however arrange the above with

	chmod a-w . &&
	... do the test ...
	status=$?
	chmod 775 .
	(exit $status)

which obviously would not work if the test somehow dies before it
has the chance to do "chmod 775".  Rewrite them by following a more
robust pattern recently written tests use, which is

	test_when_finished "chmod 775 ." &&
	chmod a-w . &&
	... do the test ...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I happened to hit ^C at the right moment and saw "make distclean"
   fail miserably.  I guess you can still kill the process in such a
   way that when-finished hander would not fire, so in that sense
   this is more about consistency and uniformity than the actual
   safety, but anyway...

 t/t0001-init.sh             | 1 +
 t/t0070-fundamental.sh      | 2 +-
 t/t1004-read-tree-m-u-wf.sh | 6 ++----
 t/t5537-fetch-shallow.sh    | 2 +-
 t/t7508-status.sh           | 4 +---
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c413bff9cf..4c865051e7 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -287,6 +287,7 @@ test_expect_success 'init notices EEXIST (2)' '
 '
 
 test_expect_success POSIXPERM,SANITY 'init notices EPERM' '
+	test_when_finished "chmod +w newdir" &&
 	rm -fr newdir &&
 	mkdir newdir &&
 	chmod -w newdir &&
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 991ed2a48d..60e3de7b7b 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -19,8 +19,8 @@ test_expect_success 'mktemp to nonexistent directory prints filename' '
 
 test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints filename' '
 	mkdir cannotwrite &&
-	chmod -w cannotwrite &&
 	test_when_finished "chmod +w cannotwrite" &&
+	chmod -w cannotwrite &&
 	test_must_fail test-mktemp cannotwrite/testXXXXXX 2>err &&
 	grep "cannotwrite/test" err
 '
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index c7ce5d8bb5..826cd32e23 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -179,6 +179,8 @@ test_expect_success 'funny symlink in work tree' '
 
 test_expect_success SANITY 'funny symlink in work tree, un-unlink-able' '
 
+	test_when_finished "chmod a+w a 2>/dev/null; rm -fr a b" &&
+
 	rm -fr a b &&
 	git reset --hard &&
 
@@ -188,10 +190,6 @@ test_expect_success SANITY 'funny symlink in work tree, un-unlink-able' '
 
 '
 
-# clean-up from the above test
-chmod a+w a 2>/dev/null
-rm -fr a b
-
 test_expect_success 'D/F setup' '
 
 	git reset --hard &&
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index df8d2f095a..943231af96 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -175,8 +175,8 @@ EOF
 
 test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	cp -R .git read-only.git &&
-	find read-only.git -print | xargs chmod -w &&
 	test_when_finished "find read-only.git -type d -print | xargs chmod +w" &&
+	find read-only.git -print | xargs chmod -w &&
 	git clone --no-local --depth=2 read-only.git from-read-only &&
 	git --git-dir=from-read-only/.git log --format=%s >actual &&
 	cat >expect <<EOF &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 50052e2872..10b084d890 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1099,6 +1099,7 @@ EOF
 '
 
 test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository' '
+	test_when_finished "chmod 775 .git" &&
 	(
 		chmod a-w .git &&
 		# make dir1/tracked stat-dirty
@@ -1108,9 +1109,6 @@ test_expect_success POSIXPERM,SANITY 'status succeeds in a read-only repository'
 		# make sure "status" succeeded without writing index out
 		git diff-files | grep dir1/tracked
 	)
-	status=$?
-	chmod 775 .git
-	(exit $status)
 '
 
 (cd sm && echo > bar && git add bar && git commit -q -m 'Add bar') && git add sm
-- 
2.18.0-rc2

