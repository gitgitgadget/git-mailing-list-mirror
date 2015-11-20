From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 4/2] test: use test_must_contain
Date: Fri, 20 Nov 2015 21:50:19 +0100
Message-ID: <564F878B.3090508@web.de>
References: <564DF6BE.6020609@web.de>
 <CAPig+cSXiGVLvq59sUFAzTRoQFf-QswAoMSk20LvJqntzaf65A@mail.gmail.com>
 <564E371E.50606@web.de> <20151120111454.GB11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzsdq-0001cd-1T
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 21:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760997AbbKTUul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 15:50:41 -0500
Received: from mout.web.de ([212.227.17.11]:56156 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760573AbbKTUuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 15:50:40 -0500
Received: from [192.168.178.36] ([79.253.144.111]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MXHXF-1ZuDkw0aG5-00WGhY; Fri, 20 Nov 2015 21:50:31
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120111454.GB11198@sigill.intra.peff.net>
X-Provags-ID: V03:K0:3017q7UMe7FzKFo51AHDZV9+vI1+BkIHePD/2nzZto4VPVpOrE2
 c0haHNb0O7Acc6RdCNiPJRDr0/x5h591DzLtkFHapjFce5TwU0hHIu19DChfIgFdV9OPOq/
 nRTJglqAkSQbKNgl79+bwP1JfLZH1+45xxOpGcNl5zb0QwmtmT2oJJFCWT/MkNqdYQPGw/O
 QtF5x9VK5DO63PUSwD4Mg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9d/FJ0UJjqk=:qJiJCDXgQ4CgtJOFOc6B09
 rigOc01nPw86KsgstHOHbfseOosftoupSp1ufhCL6ipNLbYStYuuZV6+F3nwIV/gtRJE3n6fv
 s8hZE9c0snB66MxCOWn4X/iyoi411Dh1BUPNDqom+WOgXcyNOhbfa5KoexiCkPb2TJETDZCTo
 u2neZ/asDK57sCyVcSqaPLK2yKamjLkLND6DoaECpjimKeBzSbw8FindpWlFNdkmKHSIfmjFK
 0Z/8oaQB7xHoMF0juN1E4qbyMJ5NwF2u5O9aWqMhIdgShKDGYR/8p1V/5Dd4hLxaSKVJyJqov
 LwKfc/x8JeFKxB/MmnvBZqh4hmjwVKbC3va0/SBXrlpfEWNY2j2ag3bz1lV9N1cxJcbc6uh4c
 7e6hfRzuWoW08P0OmwyY8Wh4pDMg1BDUxVgrvkwRIGYvddTTL4SlJtLhiRpSvnxIEv7jxyFje
 3asATsEVCBXccKxMwUMrQUTBpnpfqDZ+lpCURsajJJL7EEFmJQO3uEGi95EoEqVz1jD+HeyOe
 HNdArTheotU1oxF9ZboBUAzOgKZF0lYRgst36qGcFM1UG76SePWvahA03grZhxD3dbXKFiyu7
 z4v/yKwnoqOUaurESJnJKQxsJsYg+DjDz1K6xyjZmmDJ2G/6Ix5y8kpB15OobuRU8rEb/cdov
 V2GMWHNwYdAT95N5XNd5N1CE0AtmAlvPufFrXLbaicfmeA5JBydtJK6+2S1cWi+RztoRUQ3vM
 1xUhDFD8tV4sDMorFi1gkcJE9bE6Biev2dEJ/C0VKQ9wjUac5/3gR1A6iQNRcn4LTWcYWEEw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281534>

Some tests print a file using cat and then grep it for some pattern.
This is done to aid debugging in case the pattern is unexpectedly not
found; the file contents can easily inspected by running the test with
the option --verbose.

Replace these combinations by calls of test_must_contain.  It only
shows the whole file if the pattern is not found, saving a cat call
(and thus a fork(2)) in the normal case.  It also just needs a single
line and makes the intent clearer.

The flag -q in t5801 is dropped as there's no pressing reason for
hiding the matching line in this test.  Consistency is more important,
and none of the remaining grep calls in that file use that flag or
redirect the results to /dev/null.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t1450-fsck.sh           | 52 ++++++++++++++++-------------------------------
 t/t5510-fetch.sh          |  3 +--
 t/t5801-remote-helpers.sh |  3 +--
 t/t9810-git-p4-rcs.sh     |  3 +--
 4 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index e66b7cb..190c97f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -70,16 +70,14 @@ test_expect_success 'object with bad sha1' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "$sha.*corrupt" out
+	test_must_contain "$sha.*corrupt" out
 '
 
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "not a commit" out
+	test_must_contain "not a commit" out
 '
 
 test_expect_success 'HEAD link pointing at a funny object' '
@@ -88,8 +86,7 @@ test_expect_success 'HEAD link pointing at a funny object' '
 	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
-	cat out &&
-	grep "detached HEAD points" out
+	test_must_contain "detached HEAD points" out
 '
 
 test_expect_success 'HEAD link pointing at a funny place' '
@@ -98,8 +95,7 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	echo "ref: refs/funny/place" >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=.git git fsck 2>out &&
-	cat out &&
-	grep "HEAD points to something strange" out
+	test_must_contain "HEAD points to something strange" out
 '
 
 test_expect_success 'email without @ is okay' '
@@ -122,8 +118,7 @@ test_expect_success 'email with embedded > is not okay' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new" out
+	test_must_contain "error in commit $new" out
 '
 
 test_expect_success 'missing < email delimiter is reported nicely' '
@@ -134,8 +129,7 @@ test_expect_success 'missing < email delimiter is reported nicely' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new.* - bad name" out
+	test_must_contain "error in commit $new.* - bad name" out
 '
 
 test_expect_success 'missing email is reported nicely' '
@@ -146,8 +140,7 @@ test_expect_success 'missing email is reported nicely' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new.* - missing email" out
+	test_must_contain "error in commit $new.* - missing email" out
 '
 
 test_expect_success '> in name is reported' '
@@ -158,8 +151,7 @@ test_expect_success '> in name is reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new" out
+	test_must_contain "error in commit $new" out
 '
 
 # date is 2^64 + 1
@@ -172,8 +164,7 @@ test_expect_success 'integer overflow in timestamps is reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new.*integer overflow" out
+	test_must_contain "error in commit $new.*integer overflow" out
 '
 
 test_expect_success 'commit with NUL in header' '
@@ -184,8 +175,7 @@ test_expect_success 'commit with NUL in header' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
-	grep "error in commit $new.*unterminated header: NUL at offset" out
+	test_must_contain "error in commit $new.*unterminated header: NUL at offset" out
 '
 
 test_expect_success 'malformatted tree object' '
@@ -205,7 +195,7 @@ test_expect_success 'malformatted tree object' '
 		git hash-object -w -t tree --stdin
 	) &&
 	test_must_fail git fsck 2>out &&
-	grep "error in tree .*contains duplicate file entries" out
+	test_must_contain "error in tree .*contains duplicate file entries" out
 '
 
 test_expect_success 'tag pointing to nonexistent' '
@@ -223,8 +213,7 @@ test_expect_success 'tag pointing to nonexistent' '
 	echo $tag >.git/refs/tags/invalid &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
-	cat out &&
-	grep "broken link" out
+	test_must_contain "broken link" out
 '
 
 test_expect_success 'tag pointing to something else than its type' '
@@ -285,7 +274,7 @@ test_expect_success 'tag with bad tagger' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	grep "error in tag .*: invalid author/committer" out
+	test_must_contain "error in tag .*: invalid author/committer" out
 '
 
 test_expect_success 'tag with NUL in header' '
@@ -304,8 +293,7 @@ test_expect_success 'tag with NUL in header' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	cat out &&
-	grep "error in tag $tag.*unterminated header: NUL at offset" out
+	test_must_contain "error in tag $tag.*unterminated header: NUL at offset" out
 '
 
 test_expect_success 'cleaned up' '
@@ -335,8 +323,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
-	cat out &&
-	grep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+	test_must_contain "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
 test_expect_success 'force fsck to ignore double author' '
@@ -360,8 +347,7 @@ test_expect_success 'fsck notices blob entry pointing to null sha1' '
 	 sha=$(printf "100644 file$_bz$_bz20" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  cat out &&
-	  grep "warning.*null sha1" out
+	  test_must_contain "warning.*null sha1" out
 	)
 '
 
@@ -371,8 +357,7 @@ test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	 sha=$(printf "160000 submodule$_bz$_bz20" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  cat out &&
-	  grep "warning.*null sha1" out
+	  test_must_contain "warning.*null sha1" out
 	)
 '
 
@@ -392,8 +377,7 @@ while read name path pretty; do
 			printf "$mode $type %s\t%s" "$value" "$path" >bad &&
 			bad_tree=$(git mktree <bad) &&
 			git fsck 2>out &&
-			cat out &&
-			grep "warning.*tree $bad_tree" out
+			test_must_contain "warning.*tree $bad_tree" out
 		)'
 	done <<-\EOF
 	100644 blob
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0ba9db0..f5023b0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -393,8 +393,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # the strange name is: a\!'b
 test_expect_success 'quoting of a strangely named repo' '
 	test_must_fail git fetch "a\\!'\''b" > result 2>&1 &&
-	cat result &&
-	grep "fatal: '\''a\\\\!'\''b'\''" result
+	test_must_contain "fatal: '\''a\\\\!'\''b'\''" result
 '
 
 test_expect_success 'bundle should record HEAD correctly' '
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b158..57ec852 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -245,8 +245,7 @@ clean_mark () {
 test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
-	cat error &&
-	grep -q "Error while running fast-import" error
+	test_must_contain "Error while running fast-import" error
 	)
 '
 
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 8134ab4..e02b490 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -294,8 +294,7 @@ test_expect_success 'cope with rcs keyword file deletion' '
 		echo "\$Revision\$" >kwdelfile.c &&
 		p4 add -t ktext kwdelfile.c &&
 		p4 submit -d "Add file to be deleted" &&
-		cat kwdelfile.c &&
-		grep 1 kwdelfile.c
+		test_must_constain 1 kwdelfile.c
 	) &&
 	git p4 clone --dest="$git" //depot &&
 	(
-- 
2.6.3
