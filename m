Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF0C77B61
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjC1Rjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjC1Rjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:40 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FAAF09
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:38 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l39-20020a9d1b2a000000b006a121324abdso5203529otl.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIPYckbJ1PMG0Y5FdCo4De/KmihcIXIszuI8XbFEBzE=;
        b=gOSvwlOtU5iiouWEMDAvrAWcJqcXLeSLggTQCHuFRr4iXRfy2FMPj5hdELqIczGSmO
         ADMnsbgQDSPGY3VGaQN3+Jtkz10HWJzGjWwK2yBeGH7i6cw2QHinvzcbCzjgYJvQsevi
         2oEt5e6tjN/ZyxA/CAjN39gvfsx7B46oXKhOnbegpSe1CBb3xPQGipd9TBChV9QKHQ1X
         MoDhdn+qjGLI6sxcXBLM2G7lRf/nwDX2hYn2yBnV1nCabp3B0bpFt1jlniEkgDXSEM+3
         sb2dYLBqhfpO50PvLU0PB3AI7k+bbnHgVmloH2EP6+TxXvBhkVEFCV+tJrqkLSupPt6D
         cqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIPYckbJ1PMG0Y5FdCo4De/KmihcIXIszuI8XbFEBzE=;
        b=lnTmVBd5f7egO6i5ga6GkgF2dBqmw8ghiXdfNBqU8C77XO0TKGkzHPN1Xx5oVK7MyS
         z9wseH2RdEElirjEknQEJziRLKUbHK0ntQVg5FiAN7zoTp+BN+38kkS7Lk1Z1MrW7GWI
         ueroSVDkrq8ORN4Lg+m/9lTAHCPVLE6EGWD0V0kXEPP9BOlX953hSFvOc4L1/juE18n1
         jHrfJTs6tsuwzmoxvuxaohGRgUJMzsZLAima2+Ga8h4FdYFv8ONgsJKRRVRDPqAZlYPK
         0FbmqcfpTYnVE6eBE8K63eFvRQmMpoZ4DpSl9GzpZawCV5tg8GsMSyuYKvcfLNEmq2gC
         ztCw==
X-Gm-Message-State: AAQBX9ePyIgTB0Ugw3Uz0MM/t+HLj5WWFysxhOgMB40727ioG2EJozy9
        aLpGAQqidDGxv9j5deTLlJlR92oFgVY=
X-Google-Smtp-Source: AKy350ZMXT6cWHeBg/12U9JGSssAoeDuanaZC07LUEZ/w5w0WSmXLNqeDlNTy3Jpt2v6J3DwcGyn8g==
X-Received: by 2002:a9d:6857:0:b0:6a1:380a:eb0a with SMTP id c23-20020a9d6857000000b006a1380aeb0amr4595651oto.9.1680025177942;
        Tue, 28 Mar 2023 10:39:37 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o9-20020a9d7649000000b00697be532609sm13075716otl.73.2023.03.28.10.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] test: avoid `stat` variable
Date:   Tue, 28 Mar 2023 11:39:28 -0600
Message-Id: <20230328173932.3614601-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has special meaning in zsh.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0001-init.sh                | 4 ++--
 t/t3432-rebase-fast-forward.sh | 4 ++--
 t/t4013-diff-various.sh        | 6 +++---
 t/t5512-ls-remote.sh           | 4 ++--
 t/t5516-fetch-push.sh          | 8 ++++----
 t/test-lib.sh                  | 4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 30a6edca1d..88c9de8f53 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -362,12 +362,12 @@ test_lazy_prereq GETCWD_IGNORES_PERMS '
 		cd $base/dir &&
 		test-tool getcwd
 	)
-	status=$?
+	stat=$?
 
 	chmod 700 $base &&
 	rm -rf $base ||
 	BUG "cannot clean $base"
-	return $status
+	return $stat
 '
 
 check_long_base_path () {
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 7f1a5dd3de..49ecf8f18b 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -41,7 +41,7 @@ test_rebase_same_head () {
 }
 
 test_rebase_same_head_ () {
-	status="$1" &&
+	stat="$1" &&
 	shift &&
 	what="$1" &&
 	shift &&
@@ -57,7 +57,7 @@ test_rebase_same_head_ () {
 	else
 		msg="git rebase$flag $* with $changes is $what with $cmp HEAD"
 	fi &&
-	test_expect_$status "$msg" "
+	test_expect_$stat "$msg" "
 		if test $abbreviate -eq 1
 		then
 			test_config rebase.abbreviateCommands true
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d19075..8f82946c2f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -178,7 +178,7 @@ process_diffs () {
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
-	status=success
+	stat=success
 	case "$magic" in
 	'' | '#'*)
 		continue ;;
@@ -188,7 +188,7 @@ do
 		case "$magic" in
 		noellipses) ;;
 		failure)
-			status=failure
+			stat=failure
 			magic=
 			label="$cmd" ;;
 		*)
@@ -203,7 +203,7 @@ do
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
 
-	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
+	test_expect_$stat "git $cmd # magic is ${magic:-(not used)}" '
 		{
 			echo "$ git $cmd"
 			case "$magic" in
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 20d063fb9a..88f0f81baf 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -167,9 +167,9 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
 	{
 		git ls-remote --exit-code ./no-such-repository
-		status=$?
+		stat=$?
 	} &&
-	test $status != 2 && test $status != 0
+	test $stat != 2 && test $stat != 0
 '
 
 test_expect_success 'Report success even when nothing matches' '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 19ebefa5ac..ed8b676156 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1732,9 +1732,9 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 
 	git update-index -q --refresh &&
 	git read-tree -u -m HEAD "$1" || {
-		status=$?
+		stat=$?
 		echo >&2 read-tree failed
-		exit $status
+		exit $stat
 	}
 	EOF
 
@@ -1800,9 +1800,9 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	no)
 		git read-tree -u -m "$1" ;;
 	esac || {
-		status=$?
+		stat=$?
 		echo >&2 read-tree failed
-		exit $status
+		exit $stat
 	}
 	EOF
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index cc705df981..621a10941d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1866,12 +1866,12 @@ test_lazy_prereq SANITY '
 
 	! test -r SANETESTD.1/x &&
 	! rm SANETESTD.1/x && ! test -f SANETESTD.2/x
-	status=$?
+	stat=$?
 
 	chmod +rwx SANETESTD.1 SANETESTD.2 &&
 	rm -rf SANETESTD.1 SANETESTD.2 ||
 	BUG "cannot clean SANETESTD"
-	return $status
+	return $stat
 '
 
 test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}
-- 
2.39.2.13.g1fb56cf030

