Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F21ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 15:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiITPuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiITPuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 11:50:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D588474EB
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so2814968plo.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dMFWD51ubvbkQajL1AB0Wv6IsyzloFRQT1dqmJXelOY=;
        b=KjCDzb3+zWBptYTG4mi+XwzoC/JHYggT4CJZW+w2Q68sBVxAAwOC/UpwIrisEm/LzD
         CfNic2Nz2PLOmqXX0fxNDpg69SJY+4/SYL1mlhgsksLUVy/0ry7cUnj0vlva4nfuaxDc
         p+G9LSxJBMHfYpqwA29PwvO8Cu61vDCVDREDSVlA9WvuGHdmyTO7vo58TowWEE50JCGr
         gfn9PZk0hu4kpQgFvMZprkyxuWDSpQGHKy1hhkmeenpBTqgtM9R/HDYltq8Pypxw9Y2e
         NuCS3LiFq97NuQUHqlUnyhfMrFK+IzHb0GhVRUD0CeCBuR2yQtAHSbJ5MsYhvt1MTWlI
         qY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dMFWD51ubvbkQajL1AB0Wv6IsyzloFRQT1dqmJXelOY=;
        b=itTZhPH5EXjdkFIaHoWvCEHcM52LveTzPud2GBma/AluZjETCoVBWBLSR5DAUbKKKS
         sXnx1ZR9VM0u4Larsd0eadexVnQflbjDYQ9uYEpVlN6H9CxZuR/WeUpW9P5V/NvpwFoQ
         V7y17hPg5IL8i5wkb/dOAtbZrLKP36xmdFekHJ8T/70h535taUMG2B/wuqjQN2k3r1AN
         27Qyr/urIeQq6/YTME9BFSDIwmRl2kohxZtJkYzUxZXko5rVUJxAnSciqQnn/ezR9KIN
         ZRxx8SrBh2ieaBnGeY5ccnhJ6ksUQ0Bwz9WRmhkxI7b3ZKVeZ0eqedKEC1Go1NWkIAeH
         aN6g==
X-Gm-Message-State: ACrzQf3Q2BhCQa3FW4Kq800iI3oKUD3rnSKGX6eO8ykft4r4evZMJ173
        USwjdtw8JsqvlkWceB+U5N1mX4Z0NGQ=
X-Google-Smtp-Source: AMsMyM4dy1iDViycSYxRRakBUV24D1Nct0g/Ly+gY2nt3eeV3hAbpzK5ChCtgIitCwIuqQOR5+DrnA==
X-Received: by 2002:a17:902:ec8a:b0:178:488b:cbc2 with SMTP id x10-20020a170902ec8a00b00178488bcbc2mr344883plg.114.1663689003611;
        Tue, 20 Sep 2022 08:50:03 -0700 (PDT)
Received: from localhost.localdomain ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b005379c1368e4sm26013pfz.179.2022.09.20.08.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:50:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 3/4] t: convert egrep usage to "grep -E"
Date:   Tue, 20 Sep 2022 22:49:15 +0700
Message-Id: <3217fcd8547746ee3c00648fa8eeab8c4b88478c.1663688697.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.0.rc0
In-Reply-To: <cover.1663688697.git.congdanhqx@gmail.com>
References: <cover.1663688697.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite POSIX states that:

> The old egrep and fgrep commands are likely to be supported for many
> years to come as implementation extensions, allowing historical
> applications to operate unmodified.

GNU grep 3.8 started to warn[1]:

> The egrep and fgrep commands, which have been deprecated since
> release 2.5.3 (2007), now warn that they are obsolescent and should
> be replaced by grep -E and grep -F.

Prepare for their removal in the future.

[1]: https://lists.gnu.org/archive/html/info-gnu/2022-09/msg00001.html

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/perf/run                           |  4 ++--
 t/t1304-default-acl.sh               |  4 ++--
 t/t3702-add-edit.sh                  |  2 +-
 t/t4014-format-patch.sh              |  8 ++++----
 t/t5320-delta-islands.sh             |  2 +-
 t/t7527-builtin-fsmonitor.sh         | 18 +++++++++---------
 t/t7701-repack-unpack-unreachable.sh |  4 ++--
 t/t9001-send-email.sh                |  8 ++++----
 t/t9814-git-p4-rename.sh             |  2 +-
 t/t9815-git-p4-submit-fail.sh        |  4 ++--
 t/test-lib-functions.sh              |  2 +-
 11 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 33da4d2aba..34115edec3 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -232,10 +232,10 @@ then
 	)
 elif test -n "$GIT_PERF_SUBSECTION"
 then
-	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names >/dev/null ||
+	grep -E "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names >/dev/null ||
 		die "subsection '$GIT_PERF_SUBSECTION' not found in '$GIT_PERF_CONFIG_FILE'"
 
-	egrep "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names | while read -r subsec
+	grep -E "^$GIT_PERF_SUBSECTION\$" "$TEST_RESULTS_DIR"/run_subsections.names | while read -r subsec
 	do
 		(
 			GIT_PERF_SUBSECTION="$subsec"
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 335d3f3211..c69ae41306 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -18,7 +18,7 @@ test_expect_success 'checking for a working acl setup' '
 	if setfacl -m d:m:rwx -m u:root:rwx . &&
 	   getfacl . | grep user:root:rwx &&
 	   touch should-have-readable-acl &&
-	   getfacl should-have-readable-acl | egrep "mask::?rw-"
+	   getfacl should-have-readable-acl | grep -E "mask::?rw-"
 	then
 		test_set_prereq SETFACL
 	fi
@@ -34,7 +34,7 @@ check_perms_and_acl () {
 	getfacl "$1" > actual &&
 	grep -q "user:root:rwx" actual &&
 	grep -q "user:${LOGNAME}:rwx" actual &&
-	egrep "mask::?r--" actual > /dev/null 2>&1 &&
+	grep -E "mask::?r--" actual > /dev/null 2>&1 &&
 	grep -q "group::---" actual || false
 }
 
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index a1801a8cbd..82bfb2fd2a 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -100,7 +100,7 @@ EOF
 
 echo "#!$SHELL_PATH" >fake-editor.sh
 cat >> fake-editor.sh <<\EOF
-egrep -v '^index' "$1" >orig-patch &&
+grep -E -v '^index' "$1" >orig-patch &&
 mv -f patch "$1"
 EOF
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ad5c029279..de1da4673d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1457,7 +1457,7 @@ append_signoff()
 	C=$(git commit-tree HEAD^^{tree} -p HEAD) &&
 	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
 	sed -n -e "1,/^---$/p" append_signoff.patch |
-		egrep -n "^Subject|Sign|^$"
+		grep -E -n "^Subject|Sign|^$"
 }
 
 test_expect_success 'signoff: commit with no body' '
@@ -2274,10 +2274,10 @@ test_expect_success 'format-patch --base with --attach' '
 test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_when_finished "rm -fr patches" &&
 	git format-patch -o patches --cover-letter --attach=mimemime --base=HEAD~ -1 &&
-	! egrep "^--+mimemime" patches/0000*.patch &&
-	egrep "^--+mimemime$" patches/0001*.patch >output &&
+	! grep -E "^--+mimemime" patches/0000*.patch &&
+	grep -E "^--+mimemime$" patches/0001*.patch >output &&
 	test_line_count = 2 output &&
-	egrep "^--+mimemime--$" patches/0001*.patch >output &&
+	grep -E "^--+mimemime--$" patches/0001*.patch >output &&
 	test_line_count = 1 output
 '
 
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index 124d47603d..406363381f 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -134,7 +134,7 @@ test_expect_success 'island core places core objects first' '
 	    repack -adfi &&
 	git verify-pack -v .git/objects/pack/*.pack |
 	cut -d" " -f1 |
-	egrep "$root|$two" >actual &&
+	grep -E "$root|$two" >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 56c0dfffea..1746d30cf6 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -939,9 +939,9 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	# directories and files that we touched.  We may or may not get a
 	# trailing slash on modified directories.
 	#
-	egrep "^event: abc/?$"       ./insensitive.trace &&
-	egrep "^event: abc/def/?$"   ./insensitive.trace &&
-	egrep "^event: abc/def/xyz$" ./insensitive.trace
+	grep -E "^event: abc/?$"       ./insensitive.trace &&
+	grep -E "^event: abc/def/?$"   ./insensitive.trace &&
+	grep -E "^event: abc/def/xyz$" ./insensitive.trace
 '
 
 # The variable "unicode_debug" is defined in the following library
@@ -983,20 +983,20 @@ test_expect_success !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
 	then
 		# We should have seen NFC event from OS.
 		# We should not have synthesized an NFD event.
-		egrep    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
-		egrep -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
+		grep -E    "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace &&
+		grep -E -v "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace
 	else
 		# We should have seen NFD event from OS.
 		# We should have synthesized an NFC event.
-		egrep "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
-		egrep "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
+		grep -E "^event: nfc/c_${utf8_nfd}/?$" ./unicode.trace &&
+		grep -E "^event: nfc/c_${utf8_nfc}/?$" ./unicode.trace
 	fi &&
 
 	# We assume UNICODE_NFD_PRESERVED.
 	# We should have seen explicit NFD from OS.
 	# We should have synthesized an NFC event.
-	egrep "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
-	egrep "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
+	grep -E "^event: nfd/d_${utf8_nfd}/?$" ./unicode.trace &&
+	grep -E "^event: nfd/d_${utf8_nfc}/?$" ./unicode.trace
 '
 
 test_done
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 937f89ee8c..b7ac4f598a 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -35,7 +35,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are packed in repository
 	test 3 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   egrep "^($fsha1|$csha1|$tsha1) " |
+		   grep -E "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
@@ -49,7 +49,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	git repack -A -d -l &&
 	# verify objects are retained unpacked
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
-		   egrep "^($fsha1|$csha1|$tsha1) " |
+		   grep -E "^($fsha1|$csha1|$tsha1) " |
 		   sort | uniq | wc -l) &&
 	git show $fsha1 &&
 	git show $csha1 &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 01c74b8b07..1130ef21b3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1519,7 +1519,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
 	grep "Which 8bit encoding" stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1530,7 +1530,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1545,7 +1545,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config overrides --g
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
@@ -1557,7 +1557,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
-	egrep "Content|MIME" msgtxt1 >actual &&
+	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 468767cbf4..2a9838f37f 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -216,7 +216,7 @@ test_expect_success 'detect copies' '
 # variable exists, which allows admins to disable the "p4 move" command.
 test_lazy_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW '
 	p4 configure show run.move.allow >out &&
-	egrep ^run.move.allow: out
+	grep -E ^run.move.allow: out
 '
 
 # If move can be disabled, turn it off and test p4 move handling
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 9779dc0d11..0ca9937de6 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -417,8 +417,8 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		! p4 fstat -T action text &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		ls -l text | egrep ^-r-- &&
-		ls -l text+x | egrep ^-r-x
+		ls -l text | grep -E ^-r-- &&
+		ls -l text+x | grep -E ^-r-x
 	)
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c6479f24eb..527a714500 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -897,7 +897,7 @@ test_path_is_symlink () {
 test_dir_is_empty () {
 	test "$#" -ne 1 && BUG "1 param"
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test -n "$(ls -a1 "$1" | grep -E -v '^\.\.?$')"
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.38.0.rc0

