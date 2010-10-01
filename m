From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Fri, 1 Oct 2010 05:23:15 -0500
Message-ID: <20101001102315.GA6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-3-git-send-email-newren@gmail.com>
 <7vd3rwo22t.fsf@alter.siamese.dyndns.org>
 <AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 12:26:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1cpG-0001O2-Da
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 12:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab0JAK00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 06:26:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47655 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0JAK0Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 06:26:24 -0400
Received: by iwn5 with SMTP id 5so3650135iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FlRrsrrE6+W3su19gAmavU9qDDWjwrBh0aLI3pgPkMM=;
        b=fOCgNMMXRtfAqLUulrz04it9OEcD4PmIEoIog2wDLcLoTheF+DS6XVhV8mCKSqHYSN
         5dbMamC4WsC5HzIJXcT5jeI6z2lsxCjvPiZZz+UcST4uMqoEHtztgIG8xun2W+24+Gqn
         Bq7LA2EWIu470EA59LRdsmD6ezjDxRAmrb9z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hBay5Bzb4+amD28D+ckKBFZ4N7vk/+bE4kuHUETuTNxPr+DrCUSiBD6Go+dkkapcXi
         rAvqjfMvSEHM+lxn6E4Ek6sM75NcDR/lQUJO6wE9Wx25Wv0Zc1UGad1/yjmMAAwSslZn
         +HsAEawqTXdpFVGUoIaski9vZ5Cvu4rim2keA=
Received: by 10.231.171.7 with SMTP id f7mr5425019ibz.72.1285928784297;
        Fri, 01 Oct 2010 03:26:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r3sm1060119ibk.1.2010.10.01.03.26.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 03:26:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157738>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Sep 29, 2010 at 18:07, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Elijah Newren <newren@gmail.com> writes:

>>> -test_expect_success 'git diff-tree HEAD^ HEAD' '
>>> +test_expect_code 1 'git diff-tree HEAD^ HEAD' '
>>> =C2=A0 =C2=A0 =C2=A0 git diff-tree --exit-code HEAD^ HEAD
>>> - =C2=A0 =C2=A0 test $? =3D 1
>>> =C2=A0'
>
> It also looks like this will pass for for all exit codes that *aren't=
*
> 1, because if $? !=3D 1 +test_expect_code will get the exit code of
> 1.

You probably missed the - indicating that the "test $? =3D 1" was being
removed.

But using test_expect_code indeed has a similar problem to the one
you point out: it does not nicely discern between outcomes in a test
with multiple commands.  This shows up in some of the later tests in
this script (which is presumably why the original patch did not
touch them).

Maybe something like this would improve things?

-- 8< --
Subject: t4017 (diff-retval): factor out check_exit_status helper

When reporting a difference with --exit-code, diff is not only
supposed to fail but to fail with status 1.  Unfortunately, the shell
code to check for that has to amount to

	git diff --exit-code this that
	test $? =3D 1

which breaks &&-chaining if the script author is not cautious.

This test script already avoids trouble by putting such code in { }
blocks, but that is a bit clunky; better to notice the pattern and
give it its own function.

While at it, improve the output on failure when debugging with -v
by printing the expected and actual exit code (by using test_cmp).
The temporary files expect.status and actual.status used to
bring this about do not adversely affect the test because those
filenames are not tracked, hence not candidates for diffing.

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4017-diff-retval.sh |   93 ++++++++++++++++------------------------=
-------
 1 files changed, 32 insertions(+), 61 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6158985..51a009b 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -4,6 +4,14 @@ test_description=3D'Return value of diffs'
=20
 . ./test-lib.sh
=20
+check_exit_status () {
+	echo "$1" >expect.status
+	shift
+	"$@"
+	echo "$?" >actual.status
+	test_cmp expect.status actual.status
+}
+
 test_expect_success 'setup' '
 	echo "1 " >a &&
 	git add . &&
@@ -21,110 +29,81 @@ test_expect_success 'git diff --quiet -w  HEAD^^ H=
EAD^' '
 '
=20
 test_expect_success 'git diff --quiet HEAD^^ HEAD^' '
-	test_must_fail git diff --quiet HEAD^^ HEAD^
+	check_exit_status 1 git diff --quiet HEAD^^ HEAD^
 '
=20
 test_expect_success 'git diff --quiet -w  HEAD^ HEAD' '
-	test_must_fail git diff --quiet -w HEAD^ HEAD
+	check_exit_status 1 git diff --quiet -w HEAD^ HEAD
 '
=20
 test_expect_success 'git diff-tree HEAD^ HEAD' '
-	git diff-tree --exit-code HEAD^ HEAD
-	test $? =3D 1
+	check_exit_status 1 git diff-tree --exit-code HEAD^ HEAD
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --exit-code HEAD^ HEAD -- a
-	test $? =3D 0
 '
 test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
-	git diff-tree --exit-code HEAD^ HEAD -- b
-	test $? =3D 1
+	check_exit_status 1 git diff-tree --exit-code HEAD^ HEAD -- b
 '
 test_expect_success 'echo HEAD | git diff-tree --stdin' '
-	echo $(git rev-parse HEAD) | git diff-tree --exit-code --stdin
-	test $? =3D 1
+	git rev-parse HEAD |
+	check_exit_status 1 git diff-tree --exit-code --stdin
 '
 test_expect_success 'git diff-tree HEAD HEAD' '
 	git diff-tree --exit-code HEAD HEAD
-	test $? =3D 0
 '
 test_expect_success 'git diff-files' '
 	git diff-files --exit-code
-	test $? =3D 0
 '
 test_expect_success 'git diff-index --cached HEAD' '
 	git diff-index --exit-code --cached HEAD
-	test $? =3D 0
 '
 test_expect_success 'git diff-index --cached HEAD^' '
-	git diff-index --exit-code --cached HEAD^
-	test $? =3D 1
+	check_exit_status 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
 	echo 3 >c &&
-	git add . && {
-		git diff-index --exit-code --cached HEAD^
-		test $? =3D 1
-	}
+	git add . &&
+	check_exit_status 1 git diff-index --exit-code --cached HEAD^
 '
 test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
-	git commit -m "text in b" && {
-		git diff-tree -p --exit-code -Stext HEAD^ HEAD -- b
-		test $? =3D 1
-	}
+	git commit -m "text in b" &&
+	check_exit_status 1 git diff-tree -p --exit-code -Stext HEAD^ HEAD --=
 b
 '
 test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree -p --exit-code -Snot-found HEAD^ HEAD -- b
-	test $? =3D 0
 '
 test_expect_success 'git diff-files' '
-	echo 3 >>c && {
-		git diff-files --exit-code
-		test $? =3D 1
-	}
+	echo 3 >>c &&
+	check_exit_status 1 git diff-files --exit-code
 '
 test_expect_success 'git diff-index --cached HEAD' '
-	git update-index c && {
-		git diff-index --exit-code --cached HEAD
-		test $? =3D 1
-	}
+	git update-index c &&
+	check_exit_status 1 git diff-index --exit-code --cached HEAD
 '
=20
 test_expect_success '--check --exit-code returns 0 for no difference' =
'
-
 	git diff --check --exit-code
-
 '
=20
 test_expect_success '--check --exit-code returns 1 for a clean differe=
nce' '
-
-	echo "good" > a &&
-	git diff --check --exit-code
-	test $? =3D 1
-
+	echo "good" >a &&
+	check_exit_status 1 git diff --check --exit-code
 '
=20
 test_expect_success '--check --exit-code returns 3 for a dirty differe=
nce' '
-
 	echo "bad   " >> a &&
-	git diff --check --exit-code
-	test $? =3D 3
-
+	check_exit_status 3 git diff --check --exit-code
 '
=20
 test_expect_success '--check with --no-pager returns 2 for dirty diffe=
rence' '
-
-	git --no-pager diff --check
-	test $? =3D 2
-
+	check_exit_status 2 git --no-pager diff --check
 '
=20
 test_expect_success 'check should test not just the last line' '
 	echo "" >>a &&
-	git --no-pager diff --check
-	test $? =3D 2
-
+	check_exit_status 2 git --no-pager diff --check
 '
=20
 test_expect_success 'check detects leftover conflict markers' '
@@ -133,10 +112,8 @@ test_expect_success 'check detects leftover confli=
ct markers' '
 	echo binary >>b &&
 	git commit -m "side" b &&
 	test_must_fail git merge master &&
-	git add b && (
-		git --no-pager diff --cached --check >test.out
-		test $? =3D 2
-	) &&
+	git add b &&
+	check_exit_status 2 git --no-pager diff --cached --check >test.out &&
 	test 3 =3D $(grep "conflict marker" test.out | wc -l) &&
 	git reset --hard
 '
@@ -146,19 +123,13 @@ test_expect_success 'check honors conflict marker=
 length' '
 	echo ">>>>>>> boo" >>b &&
 	echo "=3D=3D=3D=3D=3D=3D" >>a &&
 	git diff --check a &&
-	(
-		git diff --check b
-		test $? =3D 2
-	) &&
+	check_exit_status 2 git diff --check b &&
 	git reset --hard &&
 	echo ">>>>>>>> boo" >>b &&
 	echo "=3D=3D=3D=3D=3D=3D=3D=3D" >>a &&
 	git diff --check &&
 	echo "b conflict-marker-size=3D8" >.gitattributes &&
-	(
-		git diff --check b
-		test $? =3D 2
-	) &&
+	check_exit_status 2 git diff --check b &&
 	git diff --check a &&
 	git reset --hard
 '
--=20
1.7.2.3
