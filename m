From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/7] t/t5503-tagfollow: change from skip_all=* to prereq skip
Date: Wed, 11 Aug 2010 19:04:07 +0000
Message-ID: <1281553450-26467-5-git-send-email-avarab@gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:05:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGc3-0003WL-M6
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486Ab0HKTEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:04:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47186 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab0HKTEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:04:30 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so462345wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OJM6CIUvQMAlTkyHEPFFaml2XjWNR82jLsrJ2SNKX7Q=;
        b=m1Zsw7dTJHK3ifhAmgwWjKotN5RMnskxWO8+vTCLjzdD5em6/evvZCu++OBWjq8pS2
         xNrVq2JO9nmlxNJszv+DOvgG0442536aXmRCBH7y8PXONkBB3SEec4PqvcQbtE7vU1sY
         Kk9FzePrObdO9U9HJNiXsVqOtbBKvz7vBKuEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K7bLnHKdHuNOqF21AP84M/4sD4KEVLU4vZa9iJFTVKdPTqkCLfuvaREobR7+mYel2O
         SwApn+0sMiTeGC1okPLHn1+GMwTfIaNq/SbiG+0ZIkA+MBxfJDqQr3ST+mtXuNtwRC73
         jySuO3pgxCxa0CxFN2SnLglVzINANAGigALBo=
Received: by 10.227.37.164 with SMTP id x36mr16744814wbd.138.1281553470007;
        Wed, 11 Aug 2010 12:04:30 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b18sm369379wbb.19.2010.08.11.12.04.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:04:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153288>

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
1.7.2.1.295.gdf931
