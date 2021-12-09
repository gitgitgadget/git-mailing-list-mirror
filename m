Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ECC433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhLIFP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhLIFPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:51 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55728C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:18 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d14so1896464ila.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJSSHX2Bp9pqGpH5pKvVGewrihppmHnV+07KSeB7K8c=;
        b=PIkI1T2dYQsCRDQSa1wWyrguVsQsPz4El143/GU/wSpBFE4yQOOCsqKE83I5NlqYyI
         dtmGvlVYgronJzko1cHIV8K7zZzMR8ak4iAD261QDbD3JXW0KvxcKHSFucKV1Nu8noi8
         zs5KzonCFW2txWsfNlHocYlQrYJkrcxucl5i34ka/xxfAssFgXY4qQ2/lyX633Bz8XEv
         x+ZppqqjNbcXwcrxi70EiINfW7w0ysZ7GkuQ9GkkFkWXeSLdPOq71HAeenj8oJvwCyQU
         jm1cQyr7CbchcRdNqAb4a88f90YSxLtlz7Yb8FIFGLDj+jBjxD4xeAQIKZ+norHIl2cj
         q5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yJSSHX2Bp9pqGpH5pKvVGewrihppmHnV+07KSeB7K8c=;
        b=gqxX+5kRTqmLtsOabNT0M3vRmeMDJQzjdgKMVxK24d6IcgHkON84x69nDmBAs3Uqvu
         FaIy6Qnh26a/pv4HW1lZRbLp6gxoepZqq6mXLkVVfp3xA8oNtsK+BUZ991C+N0+jtbOp
         SoFxDnbgoibj9V0i9Kio7BvRVY3uoo1G0ghS+eYuW+bUvZvfwdPdLAk1ju1bXCKwdQY2
         jdN3HwbdtMGems4UxinC4u/kb6f3FsFV1rFWTaqK5BfbLls2nQeZBCCEc9fOcMvAcb2Q
         fx2BhDp52odSQh2quewwCMNaksL0NnR2io/4MiYJGQS8AD/WNSW+EHclhSUdycLEdIZj
         PKfQ==
X-Gm-Message-State: AOAM530kNCB2F7LWSPAL2tAIWiRVPbRGBBLIZDuTLzb9RTpqYvoe/SR9
        m8SXYu4T9B5IgbODnn2PVpp4KxitquHTUA==
X-Google-Smtp-Source: ABdhPJwJNUidUUgWtVq32zSopfCHcuQH/HwYck32bIegRBroV0iySw8UQrqVqw3GrDHyGl6u9k+3xw==
X-Received: by 2002:a05:6e02:106c:: with SMTP id q12mr10433479ilj.125.1639026737207;
        Wed, 08 Dec 2021 21:12:17 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:16 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 12/19] tests: fix broken &&-chains in `{...}` groups
Date:   Thu,  9 Dec 2021 00:11:08 -0500
Message-Id: <20211209051115.52629-13-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The top-level &&-chain checker built into t/test-lib.sh causes tests to
magically exit with code 117 if the &&-chain is broken. However, it has
the shortcoming that the magic does not work within `{...}` groups,
`(...)` subshells, `$(...)` substitutions, or within bodies of compound
statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
partly fills in the gap by catching broken &&-chains in `(...)`
subshells, but bugs can still lurk behind broken &&-chains in the other
cases.

Fix broken &&-chains in `{...}` groups in order to reduce the number of
possible lurking bugs.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t0021-conversion.sh                  |  8 ++++----
 t/t0069-oidtree.sh                     | 12 ++++++------
 t/t1006-cat-file.sh                    |  2 +-
 t/t1300-config.sh                      |  2 +-
 t/t1403-show-ref.sh                    |  8 ++++----
 t/t2200-add-update.sh                  | 12 ++++++------
 t/t2201-add-update-typechange.sh       | 10 +++++-----
 t/t4023-diff-rename-typechange.sh      |  6 +++---
 t/t4124-apply-ws-rule.sh               |  2 +-
 t/t4150-am.sh                          |  2 +-
 t/t4212-log-corrupt.sh                 |  8 ++++----
 t/t5316-pack-delta-depth.sh            |  7 +++++--
 t/t5510-fetch.sh                       |  2 +-
 t/t5515-fetch-merge-logic.sh           | 12 ++++++------
 t/t5562-http-backend-content-length.sh |  2 +-
 t/t5570-git-daemon.sh                  |  2 +-
 t/t5571-pre-push-hook.sh               |  2 +-
 t/t7513-interpret-trailers.sh          |  2 +-
 t/t8002-blame.sh                       |  2 +-
 19 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 1a1a69ad92..bb3de2701a 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -76,13 +76,13 @@ test_expect_success setup '
 	git config filter.rot13.clean ./rot13.sh &&
 
 	{
-	    echo "*.t filter=rot13"
+	    echo "*.t filter=rot13" &&
 	    echo "*.i ident"
 	} >.gitattributes &&
 
 	{
-	    echo a b c d e f g h i j k l m
-	    echo n o p q r s t u v w x y z
+	    echo a b c d e f g h i j k l m &&
+	    echo n o p q r s t u v w x y z &&
 	    echo '\''$Id$'\''
 	} >test &&
 	cat test >test.t &&
@@ -159,7 +159,7 @@ test_expect_success expanded_in_repo '
 		printf "\$Id: NoTerminatingSymbolAtEOF"
 	} >expected-output-crlf &&
 	{
-		echo "expanded-keywords ident"
+		echo "expanded-keywords ident" &&
 		echo "expanded-keywords-crlf ident text eol=crlf"
 	} >>.gitattributes &&
 
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index 74cc59bf8a..889db50818 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -28,7 +28,7 @@ test_expect_success 'oidtree insert and contains' '
 	EOF
 	{
 		echoid insert 444 1 2 3 4 5 a b c d e &&
-		echoid contains 44 441 440 444 4440 4444
+		echoid contains 44 441 440 444 4440 4444 &&
 		echo clear
 	} | test-tool oidtree >actual &&
 	test_cmp expect actual
@@ -37,11 +37,11 @@ test_expect_success 'oidtree insert and contains' '
 test_expect_success 'oidtree each' '
 	echoid "" 123 321 321 >expect &&
 	{
-		echoid insert f 9 8 123 321 a b c d e
-		echo each 12300
-		echo each 3211
-		echo each 3210
-		echo each 32100
+		echoid insert f 9 8 123 321 a b c d e &&
+		echo each 12300 &&
+		echo each 3211 &&
+		echo each 3210 &&
+		echo each 32100 &&
 		echo clear
 	} | test-tool oidtree >actual &&
 	test_cmp expect actual
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 67a3f64c2d..f6f00c7039 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -283,7 +283,7 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
 
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
-	{ cat foo; echo plus; } >foo-plus &&
+	{ cat foo && echo plus; } >foo-plus &&
 	git add foo foo-plus &&
 	git commit -m foo &&
 	cat >blobs <<-\EOF
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9571649c42..516dd8bfa8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -901,7 +901,7 @@ test_expect_success 'get --expiry-date' '
 	EOF
 	: "work around heredoc parsing bug fixed in dash 0.5.7 (in ec2c84d)" &&
 	{
-		echo "$rel_out $(git config --expiry-date date.valid1)"
+		echo "$rel_out $(git config --expiry-date date.valid1)" &&
 		git config --expiry-date date.valid2 &&
 		git config --expiry-date date.valid3 &&
 		git config --expiry-date date.valid4 &&
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 17d3cc1405..bbc01aae34 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -78,7 +78,7 @@ test_expect_success 'show-ref --verify -q' '
 test_expect_success 'show-ref -d' '
 	{
 		echo $(git rev-parse refs/tags/A) refs/tags/A &&
-		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}"
+		echo $(git rev-parse refs/tags/A^0) "refs/tags/A^{}" &&
 		echo $(git rev-parse refs/tags/C) refs/tags/C
 	} >expect &&
 	git show-ref -d A C >actual &&
@@ -148,7 +148,7 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
 
 	{
 		echo $(git rev-parse HEAD) HEAD &&
-		echo $(git rev-parse refs/heads/B) refs/heads/B
+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
 		echo $(git rev-parse refs/tags/B) refs/tags/B
 	} >expect &&
 	git show-ref --head B >actual &&
@@ -156,8 +156,8 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
 
 	{
 		echo $(git rev-parse HEAD) HEAD &&
-		echo $(git rev-parse refs/heads/B) refs/heads/B
-		echo $(git rev-parse refs/tags/B) refs/tags/B
+		echo $(git rev-parse refs/heads/B) refs/heads/B &&
+		echo $(git rev-parse refs/tags/B) refs/tags/B &&
 		echo $(git rev-parse refs/tags/B^0) "refs/tags/B^{}"
 	} >expect &&
 	git show-ref --head -d B >actual &&
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 67b9cc752f..d2ef0041f9 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -153,10 +153,10 @@ test_expect_success 'add -u resolves unmerged paths' '
 			echo "100644 $one 1	$path" &&
 			echo "100644 $two 2	$path" &&
 			echo "100644 $three 3	$path"
-		done
-		echo "100644 $one 1	path3"
-		echo "100644 $one 1	path4"
-		echo "100644 $one 3	path5"
+		done &&
+		echo "100644 $one 1	path3" &&
+		echo "100644 $one 1	path4" &&
+		echo "100644 $one 3	path5" &&
 		echo "100644 $one 3	path6"
 	} |
 	git update-index --index-info &&
@@ -173,8 +173,8 @@ test_expect_success 'add -u resolves unmerged paths' '
 	git add -u &&
 	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
 	{
-		echo "100644 $three 0	path1"
-		echo "100644 $two 0	path3"
+		echo "100644 $three 0	path1" &&
+		echo "100644 $two 0	path3" &&
 		echo "100644 $two 0	path5"
 	} >expect &&
 	test_cmp expect actual
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index a4eec0a346..687be974d4 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -97,17 +97,17 @@ test_expect_success modify '
 		"
 	} >expect &&
 	{
-		cat expect
-		echo ":100644 160000 $_empty $ZERO_OID T	yonk"
+		cat expect &&
+		echo ":100644 160000 $_empty $ZERO_OID T	yonk" &&
 		echo ":100644 000000 $_empty $ZERO_OID D	zifmia"
 	} >expect-files &&
 	{
-		cat expect
+		cat expect &&
 		echo ":000000 160000 $ZERO_OID $ZERO_OID A	yonk"
 	} >expect-index &&
 	{
-		echo "100644 $_empty 0	nitfol"
-		echo "160000 $yomin 0	yomin"
+		echo "100644 $_empty 0	nitfol" &&
+		echo "160000 $yomin 0	yomin" &&
 		echo "160000 $yonk 0	yonk"
 	} >expect-final
 '
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 47d6f35dcc..7cb9909293 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -55,7 +55,7 @@ test_expect_success 'cross renames to be detected for regular files' '
 
 	git diff-tree five six -r --name-status -B -M | sort >actual &&
 	{
-		echo "R100	foo	bar"
+		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
 	} | sort >expect &&
 	test_cmp expect actual
@@ -66,7 +66,7 @@ test_expect_success 'cross renames to be detected for typechange' '
 
 	git diff-tree one two -r --name-status -B -M | sort >actual &&
 	{
-		echo "R100	foo	bar"
+		echo "R100	foo	bar" &&
 		echo "R100	bar	foo"
 	} | sort >expect &&
 	test_cmp expect actual
@@ -78,7 +78,7 @@ test_expect_success 'moves and renames' '
 	git diff-tree three four -r --name-status -B -M | sort >actual &&
 	{
 		# see -B -M (#6) in t4008
-		echo "C100	foo	bar"
+		echo "C100	foo	bar" &&
 		echo "T100	foo"
 	} | sort >expect &&
 	test_cmp expect actual
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ebff6c6883..ec5c10d2a0 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -233,7 +233,7 @@ test_expect_success 'blank at EOF with --whitespace=fix (1)' '
 	test_write_lines a b c >one &&
 	git add one &&
 	test_write_lines a b c >expect &&
-	{ cat expect; echo; } >one &&
+	{ cat expect && echo; } >one &&
 	git diff -- one >patch &&
 
 	git checkout one &&
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7de..103cd39148 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -116,7 +116,7 @@ test_expect_success setup '
 		git format-patch --stdout first | sed -e "1d"
 	} | append_cr >patch1-crlf.eml &&
 	{
-		printf "%255s\\n" ""
+		printf "%255s\\n" "" &&
 		echo "X-Fake-Field: Line One" &&
 		echo "X-Fake-Field: Line Two" &&
 		echo "X-Fake-Field: Line Three" &&
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 03b952c90d..0244888a5a 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -20,10 +20,10 @@ test_expect_success 'fsck notices broken commit' '
 
 test_expect_success 'git log with broken author email' '
 	{
-		echo commit $(cat broken_email.hash)
-		echo "Author: A U Thor <author@example.com>"
-		echo "Date:   Thu Apr 7 15:13:13 2005 -0700"
-		echo
+		echo commit $(cat broken_email.hash) &&
+		echo "Author: A U Thor <author@example.com>" &&
+		echo "Date:   Thu Apr 7 15:13:13 2005 -0700" &&
+		echo &&
 		echo "    foo"
 	} >expect.out &&
 
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 759169d074..df524f7b6d 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -57,8 +57,11 @@ test_expect_success 'create series of packs' '
 		git commit -m $i &&
 		cur=$(git rev-parse HEAD^{tree}) &&
 		{
-			test -n "$prev" && echo "-$prev"
-			echo $cur
+			if test -n "$prev"
+			then
+				echo "-$prev"
+			fi &&
+			echo $cur &&
 			echo "$(git rev-parse :file) file"
 		} | git pack-objects --stdout >tmp &&
 		git index-pack --stdin --fix-thin <tmp || return 1
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 1892d6615a..01468ce6d8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -71,7 +71,7 @@ test_expect_success "fetch test for-merge" '
 	main_in_two=$(cd ../two && git rev-parse main) &&
 	one_in_two=$(cd ../two && git rev-parse one) &&
 	{
-		echo "$one_in_two	"
+		echo "$one_in_two	" &&
 		echo "$main_in_two	not-for-merge"
 	} >expected &&
 	cut -f -2 .git/FETCH_HEAD >actual &&
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 9d440e2821..c69cfd5c64 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -191,17 +191,17 @@ do
 		cp "$expect_r" expect_r &&
 		convert_expected expect_r sed_script &&
 		{
-			echo "# $cmd"
-			set x $cmd; shift
-			git symbolic-ref HEAD refs/heads/$1 ; shift
-			rm -f .git/FETCH_HEAD
+			echo "# $cmd" &&
+			set x $cmd && shift &&
+			git symbolic-ref HEAD refs/heads/$1 && shift &&
+			rm -f .git/FETCH_HEAD &&
 			git for-each-ref \
 				refs/heads refs/remotes/rem refs/tags |
 			while read val type refname
 			do
 				git update-ref -d "$refname" "$val"
-			done
-			git fetch "$@" >/dev/null
+			done &&
+			git fetch "$@" >/dev/null &&
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
 		git show-ref >"$actual_r" &&
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 05a58069b0..b68ec22d3f 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -63,7 +63,7 @@ test_expect_success 'setup' '
 	hash_next=$(git commit-tree -p HEAD -m next HEAD^{tree}) &&
 	{
 		printf "%s %s refs/heads/newbranch\\0report-status object-format=%s\\n" \
-			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw
+			"$ZERO_OID" "$hash_next" "$(test_oid algo)" | packetize_raw &&
 		printf 0000 &&
 		echo "$hash_next" | git pack-objects --stdout
 	} >push_body &&
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index b87ca06a58..1131503b76 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -194,7 +194,7 @@ test_expect_success 'hostname cannot break out of directory' '
 
 test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	{
-		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw
+		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize_raw &&
 		printf "0000"
 	} >input &&
 	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index b043a279f1..80e86d8284 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -114,7 +114,7 @@ test_expect_success 'push to URL' '
 
 test_expect_success 'set up many-ref tests' '
 	{
-		nr=1000
+		nr=1000 &&
 		while test $nr -lt 2000
 		do
 			nr=$(( $nr + 1 )) &&
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 04885d0a5e..97f10905d2 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -156,7 +156,7 @@ test_expect_success 'with config option on the command line' '
 		Acked-by: Johan
 		Reviewed-by: Peff
 	EOF
-	{ echo; echo "Acked-by: Johan"; } |
+	{ echo && echo "Acked-by: Johan"; } |
 	git -c "trailer.Acked-by.ifexists=addifdifferent" interpret-trailers \
 		--trailer "Reviewed-by: Peff" --trailer "Acked-by: Johan" >actual &&
 	test_cmp expected actual
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 5bb302b1ba..ee4fdd8f18 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -97,7 +97,7 @@ test_expect_success 'set up abbrev tests' '
 	test_commit abbrev &&
 	sha1=$(git rev-parse --verify HEAD) &&
 	check_abbrev () {
-		expect=$1; shift
+		expect=$1 && shift &&
 		echo $sha1 | cut -c 1-$expect >expect &&
 		git blame "$@" abbrev.t >actual &&
 		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
-- 
2.34.1.307.g9b7440fafd

