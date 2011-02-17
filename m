From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Thu, 17 Feb 2011 16:32:16 -0600
Message-ID: <20110217223216.GB10007@elie>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
 <7vipwibfc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 23:32:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqCOy-0007G2-3z
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 23:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab1BQWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 17:32:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57264 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1BQWc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 17:32:26 -0500
Received: by wyb28 with SMTP id 28so3055148wyb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sXqjLpYQe1WmLkJH1HCQaYJrjYCgEJi4uBYQQwLgcT4=;
        b=Oz5660HKg8v5W4eLk1JdMDLdGAVF5/BsF9E61OFdzZNXgDrCI/jCixxULF+Zp5cMmX
         S3hdMxrDBc74odPTW7JSSgvGGYySiG4jR13YHwrwGHjkQdG1jBy5Qv3n9mY8UsGRVWsg
         T7QrTKMQ/0Q6F28ieKtmPAD5OKS9ESC/4IrhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AObJib03w5KPHh4xzRpVqDjgDVJK0yhjf2pfZQcV9BYTv9JoC3sz6QfP5/11szl3JK
         FfofqJ8rCYOBX7eBjd4qHu3YM/G+kM7cAfZ7Uc7mvc0nOSd1uQ3WejSwnktlxsLqWGS0
         iOjs9wpeO2M1stNF9lsoPKpaZTaoLwM5Ry2KM=
Received: by 10.216.72.201 with SMTP id t51mr903441wed.6.1297981945273;
        Thu, 17 Feb 2011 14:32:25 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id t5sm605192wes.33.2011.02.17.14.32.23
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 14:32:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipwibfc5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167130>

Junio C Hamano wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:

>> +test_expect_success 'cherry-pick --no-commit sets CHERRY_PICK_HEAD' '
>> +
>> +	git checkout -f initial^0 &&
>> +	git read-tree -u --reset HEAD &&
>> +	git clean -d -f -f -q -x &&
>> +
>> +	git update-index --refresh &&
>> +	git diff-index --exit-code HEAD &&
>
> Getting tired of seeing these five lines repeated over and over.  Perhaps
> it is time to introduce:
> 
> 	pristine_detach () {

The following patch (modulo naming) was sitting in my tree as a separate
patch on top.

> I don't think "diff-index --exit-code HEAD" is necessary as the point of
> this testsuite is not about testing "read-tree --reset", and the index
> refresh is just a prerequisite for diff-index that can go together with
> it.

Yep.  Confusingly, the index refresh was just meant to check for a
clean index.

-- 8< --
Subject: [PATCH] tests: introduce pristine-detach helper

All the tests in t3507 (cherry-pick with conflicts) begin with the
same checkout + read-tree + clean incantation to ensure a predictable
starting point.  Factor out a function for that so the interesting
part of the tests is easier to read.

The "update-index --refresh" and "diff-index --exit-code HEAD" are not
necessary as the point of this testsuite is not about testing
"read-tree --reset".

Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Applies on top of the CHERRY_PICK_HEAD tests.

 t/t3507-cherry-pick-conflict.sh |  142 +++++++--------------------------------
 1 files changed, 24 insertions(+), 118 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index ea52720..2d8437e 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -17,6 +17,12 @@ test_cmp_rev () {
 	test_cmp expect.rev actual.rev
 }
 
+pristine_detach () {
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
 test_expect_success setup '
 
 	echo unrelated >unrelated &&
@@ -29,13 +35,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'failed cherry-pick does not advance HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git cherry-pick picked &&
@@ -45,12 +45,7 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
 '
 
 test_expect_success 'advice from failed cherry-pick' "
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	picked=\$(git rev-parse --short picked) &&
 	cat <<-EOF >expected &&
@@ -65,73 +60,35 @@ test_expect_success 'advice from failed cherry-pick' "
 "
 
 test_expect_success 'failed cherry-pick sets CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
+	pristine_detach initial &&
 	test_must_fail git cherry-pick picked &&
-
 	test_cmp_rev picked CHERRY_PICK_HEAD
 '
 
 test_expect_success 'successful cherry-pick does not set CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
+	pristine_detach initial &&
 	git cherry-pick base &&
-
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
 test_expect_success 'cherry-pick --no-commit sets CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
+	pristine_detach initial &&
 	git cherry-pick --no-commit base &&
-
 	test_cmp_rev base CHERRY_PICK_HEAD
 '
 
 test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
+	pristine_detach initial &&
 	(
 		GIT_CHERRY_PICK_HELP="and then do something else" &&
 		export GIT_CHERRY_PICK_HELP &&
 		test_must_fail git cherry-pick picked
 	) &&
-
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
 test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 	git reset &&
@@ -140,13 +97,7 @@ test_expect_success 'git reset clears CHERRY_PICK_HEAD' '
 '
 
 test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 	test_must_fail git commit &&
@@ -155,13 +106,7 @@ test_expect_success 'failed commit does not clear CHERRY_PICK_HEAD' '
 '
 
 test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 	echo resolved >foo &&
@@ -178,13 +123,7 @@ test_expect_success 'cancelled commit does not clear CHERRY_PICK_HEAD' '
 '
 
 test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 	echo resolved >foo &&
@@ -195,13 +134,7 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 '
 
 test_expect_success 'failed cherry-pick produces dirty index' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	pristine_detach initial &&
 
 	test_must_fail git cherry-pick picked &&
 
@@ -210,9 +143,7 @@ test_expect_success 'failed cherry-pick produces dirty index' '
 '
 
 test_expect_success 'failed cherry-pick registers participants in index' '
-
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	{
 		git checkout base -- foo &&
 		git ls-files --stage foo &&
@@ -226,10 +157,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
 	" < stages > expected &&
-	git checkout -f initial^0 &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	git read-tree -u --reset HEAD &&
 
 	test_must_fail git cherry-pick picked &&
 	git ls-files --stage --unmerged > actual &&
@@ -238,10 +166,7 @@ test_expect_success 'failed cherry-pick registers participants in index' '
 '
 
 test_expect_success 'failed cherry-pick describes conflict in work tree' '
-
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -250,9 +175,6 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 	>>>>>>> objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git cherry-pick picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
@@ -260,11 +182,8 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
 '
 
 test_expect_success 'diff3 -m style' '
-
+	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -275,9 +194,6 @@ test_expect_success 'diff3 -m style' '
 	>>>>>>> objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git cherry-pick picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
@@ -285,10 +201,8 @@ test_expect_success 'diff3 -m style' '
 '
 
 test_expect_success 'revert also handles conflicts sanely' '
-
 	git config --unset merge.conflictstyle &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
+	pristine_detach initial &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -309,10 +223,7 @@ test_expect_success 'revert also handles conflicts sanely' '
 		2 s/ 0	/ 2	/
 		3 s/ 0	/ 3	/
 	" < stages > expected-stages &&
-	git checkout -f initial^0 &&
-
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
+	git read-tree -u --reset HEAD &&
 
 	head=$(git rev-parse HEAD) &&
 	test_must_fail git revert picked &&
@@ -328,10 +239,8 @@ test_expect_success 'revert also handles conflicts sanely' '
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
+	pristine_detach initial &&
 	git config merge.conflictstyle diff3 &&
-	git checkout -f initial^0 &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x &&
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
@@ -342,9 +251,6 @@ test_expect_success 'revert conflict, diff3 -m style' '
 	>>>>>>> parent of objid picked
 	EOF
 
-	git update-index --refresh &&
-	git diff-index --exit-code HEAD &&
-
 	test_must_fail git revert picked &&
 
 	sed "s/[a-f0-9]*\.\.\./objid/" foo > actual &&
-- 
1.7.4.1
