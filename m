From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Tue, 17 Aug 2010 01:54:59 -0500
Message-ID: <20100817065459.GC22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG6I-00065f-1F
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756333Ab0HQG4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:56:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32852 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287Ab0HQG4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:56:40 -0400
Received: by gyg10 with SMTP id 10so2247037gyg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h2kUzlZjd3oa7IsAlcP3nxonAK/L/0OnxPIWPJGkHMA=;
        b=l7AZDghHHFNbhZyMOUaxVy2Y+EbpORBBNl+lVj7IHGjqptSyRa7g++4f1xRpgwJ/c7
         RpCyaKhnMqHuTzRvuaBasu9/5TTB53uyOwU532eBA3JksZbxyDfFv90LkeMu2KHlGKPv
         k/PpFkrg6OX8Mw0kZPTlaTm4Km1EyE/DFHXWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GAdiVZFxHIQjZqBeGwCXk2YrE3beiSdr6mpRftThMKt04Xpi+ppqgqMKfDssWGT52V
         QnYu1P6AQGZrcmtzgpcKYR47I+Xq1PuN2NVyI1LeRRXQRWk6hTdo5K4Xz+ReA/SOS9us
         fRM8LISnfrZNpOSchptQVrVqwTSybELPiEahQ=
Received: by 10.100.45.17 with SMTP id s17mr7017736ans.202.1282028199525;
        Mon, 16 Aug 2010 23:56:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f22sm11746898anh.24.2010.08.16.23.56.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:56:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153706>

Probably as a development aid, this test script runs gitk --all
to allow the driver to inspect history between tests when run
with --debug.  As a result, running all tests with --debug
requires closing a long series of gitk displays, one at a time.

Use git log --graph --oneline instead.  This way, the history is
available for viewing with "git show" but the test script finishes
without interaction.

Longer term, it would be nice to have an option to run a
user-specified command between tests.  This patch does not do
that.

Cc: Lars Hjemli <hjemli@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7600-merge.sh |   58 +++++++++++++++++++++++++++---------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 48a91ba..64a4265 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -133,7 +133,7 @@ test_expect_success 'setup' '
 	create_merge_msgs
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'test option parsing' '
 	test_must_fail git merge -$ c1 &&
@@ -155,7 +155,7 @@ test_expect_success 'merge c0 with c1' '
 	verify_head "$c1"
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 with --ff-only' '
 	git reset --hard c0 &&
@@ -165,7 +165,7 @@ test_expect_success 'merge c0 with c1 with --ff-only' '
 	verify_head "$c1"
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
@@ -175,7 +175,7 @@ test_expect_success 'merge c1 with c2' '
 	verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
 	git reset --hard c1 &&
@@ -185,7 +185,7 @@ test_expect_success 'merge c1 with c2 and c3' '
 	verify_parents $c1 $c2 $c3
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'failing merges with --ff-only' '
 	git reset --hard c1 &&
@@ -202,7 +202,7 @@ test_expect_success 'merge c0 with c1 (no-commit)' '
 	verify_head $c1
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (no-commit)' '
 	git reset --hard c1 &&
@@ -212,7 +212,7 @@ test_expect_success 'merge c1 with c2 (no-commit)' '
 	verify_mergeheads $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3 (no-commit)' '
 	git reset --hard c1 &&
@@ -222,7 +222,7 @@ test_expect_success 'merge c1 with c2 and c3 (no-commit)' '
 	verify_mergeheads $c2 $c3
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (squash)' '
 	git reset --hard c0 &&
@@ -233,7 +233,7 @@ test_expect_success 'merge c0 with c1 (squash)' '
 	test_cmp squash.1 .git/SQUASH_MSG
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (squash, ff-only)' '
 	git reset --hard c0 &&
@@ -244,7 +244,7 @@ test_expect_success 'merge c0 with c1 (squash, ff-only)' '
 	test_cmp squash.1 .git/SQUASH_MSG
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (squash)' '
 	git reset --hard c1 &&
@@ -255,14 +255,14 @@ test_expect_success 'merge c1 with c2 (squash)' '
 	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'unsuccesful merge of c1 with c2 (squash, ff-only)' '
 	git reset --hard c1 &&
 	test_must_fail git merge --squash --ff-only c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3 (squash)' '
 	git reset --hard c1 &&
@@ -273,7 +273,7 @@ test_expect_success 'merge c1 with c2 and c3 (squash)' '
 	test_cmp squash.1-5-9 .git/SQUASH_MSG
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (no-commit in config)' '
 	git reset --hard c1 &&
@@ -284,7 +284,7 @@ test_expect_success 'merge c1 with c2 (no-commit in config)' '
 	verify_mergeheads $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
@@ -296,7 +296,7 @@ test_expect_success 'merge c1 with c2 (squash in config)' '
 	test_cmp squash.1-5 .git/SQUASH_MSG
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
@@ -326,7 +326,7 @@ test_expect_success 'override config option -n with --stat' '
 	fi
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
@@ -342,7 +342,7 @@ test_expect_success 'override config option --stat' '
 	fi
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
@@ -353,7 +353,7 @@ test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --squash)' '
 	git reset --hard c1 &&
@@ -364,7 +364,7 @@ test_expect_success 'merge c1 with c2 (override --squash)' '
 	verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c0 with c1 (no-ff)' '
 	git reset --hard c0 &&
@@ -375,7 +375,7 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
 	verify_parents $c0 $c1
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --squash --no-ff c1 &&
@@ -412,7 +412,7 @@ test_expect_success 'merge log message' '
 	test_cmp msg.log msg.act
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
@@ -423,7 +423,7 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
@@ -434,7 +434,7 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c1 and c2' '
        git reset --hard c1 &&
@@ -445,7 +445,7 @@ test_expect_success 'merge c1 with c1 and c2' '
        verify_parents $c1 $c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge fast-forward in a dirty tree' '
        git reset --hard c0 &&
@@ -455,7 +455,7 @@ test_expect_success 'merge fast-forward in a dirty tree' '
        git merge c2
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'in-index merge' '
 	git reset --hard c0 &&
@@ -464,7 +464,7 @@ test_expect_success 'in-index merge' '
 	verify_parents $c0 $c1
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'refresh the index before merging' '
 	git reset --hard c1 &&
@@ -504,7 +504,7 @@ test_expect_success 'merge early part of c2' '
 	test_cmp expected.tag actual.tag
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge --no-ff --no-commit && commit' '
 	git reset --hard c0 &&
@@ -513,13 +513,13 @@ test_expect_success 'merge --no-ff --no-commit && commit' '
 	verify_parents $c0 $c1
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'amending no-ff merge commit' '
 	EDITOR=: git commit --amend &&
 	verify_parents $c0 $c1
 '
 
-test_debug 'gitk --all'
+test_debug 'git log --graph --decorate --oneline --all'
 
 test_done
-- 
1.7.2.1.544.ga752d.dirty
