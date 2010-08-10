From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/7] t/t5503-tagfollow: change from skip_all=* to prereq skip
Date: Tue, 10 Aug 2010 19:52:45 +0000
Message-ID: <1281469968-25670-5-git-send-email-avarab@gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiutC-0008MW-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab0HJTxW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:53:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58890 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab0HJTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:53:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so13310538wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=14JRrqU5KdjoJuDyxY9QUCSDGvHktybmhz3SOjksw0g=;
        b=pq32RTEETWdzDOJCb0sUWlvbH8xgTuvk6RRCk//QtysG5O1KPPpBXGovviTKlfXY9I
         +iGWeNquUPuGX/u6iYMJ6UOnIgJb0eXrkjaZ3GE3EcM9w7PlAK8ZGXdJSdxj5CL16e+Q
         MOadEhnSGuqBDZTq1jgl7241DYMT2ErQY1ZeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xJPUtc/H6JRciZr4MZI0d5vmQ0kdQdBhBsM48QiSSqFy8hbkns1L9haSC4rOulF//X
         y0bVQJzgLPski9yf+SChX6Hf+Tnroa4cf5JGnqMKYG6gj36mWk8U2z7YYDyRV4LZeUW+
         lHCQcQL+nNNUTf4gozTN3Nclncc6lXSs3OzZI=
Received: by 10.216.8.138 with SMTP id 10mr4370440wer.57.1281470001161;
        Tue, 10 Aug 2010 12:53:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.53.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:53:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153147>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5503-tagfollow.sh |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index bab1a53..8a298a6 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -6,8 +6,11 @@ test_description=3D'test automatic tag following'
=20
 case $(uname -s) in
 *MINGW*)
-	skip_all=3D"GIT_DEBUG_SEND_PACK not supported - skipping tests"
-	test_done
+	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
+	;;
+*)
+	test_set_prereq NOT_MINGW
+	;;
 esac
=20
 # End state of the repository:
@@ -19,7 +22,7 @@ esac
 #     \   C - origin/cat    \
 #      origin/master         master
=20
-test_expect_success setup '
+test_expect_success NOT_MINGW setup '
 	test_tick &&
 	echo ichi >file &&
 	git add file &&
@@ -42,12 +45,15 @@ test_expect_success setup '
=20
 U=3DUPLOAD_LOG
=20
+test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
 #S
 want $A
 #E
 EOF
-test_expect_success 'fetch A (new commit : 1 connection)' '
+'
+
+test_expect_success NOT_MINGW 'fetch A (new commit : 1 connection)' '
 	rm -f $U
 	(
 		cd cloned &&
@@ -59,7 +65,7 @@ test_expect_success 'fetch A (new commit : 1 connecti=
on)' '
 	test_cmp expect actual
 '
=20
-test_expect_success "create tag T on A, create C on branch cat" '
+test_expect_success NOT_MINGW "create tag T on A, create C on branch c=
at" '
 	git tag -a -m tag1 tag1 $A &&
 	T=3D$(git rev-parse --verify tag1) &&
=20
@@ -71,13 +77,16 @@ test_expect_success "create tag T on A, create C on=
 branch cat" '
 	git checkout master
 '
=20
+test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
 #S
 want $C
 want $T
 #E
 EOF
-test_expect_success 'fetch C, T (new branch, tag : 1 connection)' '
+'
+
+test_expect_success NOT_MINGW 'fetch C, T (new branch, tag : 1 connect=
ion)' '
 	rm -f $U
 	(
 		cd cloned &&
@@ -91,7 +100,7 @@ test_expect_success 'fetch C, T (new branch, tag : 1=
 connection)' '
 	test_cmp expect actual
 '
=20
-test_expect_success "create commits O, B, tag S on B" '
+test_expect_success NOT_MINGW "create commits O, B, tag S on B" '
 	test_tick &&
 	echo O >file &&
 	git add file &&
@@ -107,13 +116,16 @@ test_expect_success "create commits O, B, tag S o=
n B" '
 	S=3D$(git rev-parse --verify tag2)
 '
=20
+test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
 #S
 want $B
 want $S
 #E
 EOF
-test_expect_success 'fetch B, S (commit and tag : 1 connection)' '
+'
+
+test_expect_success NOT_MINGW 'fetch B, S (commit and tag : 1 connecti=
on)' '
 	rm -f $U
 	(
 		cd cloned &&
@@ -127,13 +139,16 @@ test_expect_success 'fetch B, S (commit and tag :=
 1 connection)' '
 	test_cmp expect actual
 '
=20
+test_expect_success NOT_MINGW 'setup expect' '
 cat - <<EOF >expect
 #S
 want $B
 want $S
 #E
 EOF
-test_expect_success 'new clone fetch master and tags' '
+'
+
+test_expect_success NOT_MINGW 'new clone fetch master and tags' '
 	git branch -D cat
 	rm -f $U
 	(
--=20
1.7.2.1.295.gd03d
