From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Mon, 11 Apr 2011 00:55:13 +0200
Message-ID: <4DA23551.4040304@web.de>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org> <BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 00:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q93XX-0000tL-Bx
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 00:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab1DJWzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 18:55:16 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33927 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab1DJWzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 18:55:15 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 38AC419BF8635;
	Mon, 11 Apr 2011 00:55:14 +0200 (CEST)
Received: from [93.240.110.179] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q93XG-00037D-00; Mon, 11 Apr 2011 00:55:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+Ic+8AliwcfPd+oZNC8BeHgL7qeIdtU5kMFQYo
	4vscVRf3Qnp0tLfba/GbhIlQUwyFR46hnUjp0Yf5j1L89DOSGE
	+RELfB7fpTUjEF+pd0tw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171297>

Am 10.04.2011 20:52, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Wed, Apr 6, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wrot=
e:
>=20
>> * jl/submodule-fetch-on-demand (2011-03-06) 7 commits
>>  (merged to 'next' on 2011-03-20 at a5e452d)
>>  + fetch/pull: Describe --recurse-submodule restrictions in the BUGS=
 section
>>  + submodule update: Don't fetch when the submodule commit is alread=
y present
>>  + fetch/pull: Don't recurse into a submodule when commits are alrea=
dy present
>>  + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'=
 option
>>  + config: teach the fetch.recurseSubmodules option the 'on-demand' =
value
>>  + fetch/pull: Add the 'on-demand' value to the --recurse-submodules=
 option
>>  + fetch/pull: recurse into submodules when necessary
>=20
> This series needs to be fixed to not fail tests with GETTEXT_POISON=3D=
YesPlease.

Maybe something like this? Junio, do you want me to squash the changes =
in
the patch series and resend it or should I send a new commit?

-----------------8<-------------
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index af78e21..3279aec 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -230,7 +230,7 @@ test_expect_success "Recursion doesn't happen when =
no new commits are fetched in
 	! test -s actual.err
 '

-test_expect_success "Recursion stops when no new submodule commits are=
 fetched" '
+test_expect_success C_LOCALE_OUTPUT "Recursion stops when no new submo=
dule commits are fetched" '
 	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -247,7 +247,7 @@ test_expect_success "Recursion stops when no new su=
bmodule commits are fetched"
 	test_cmp expect.out.sub actual.out
 '

-test_expect_success "Recursion doesn't happen when new superproject co=
mmits don't change any submodules" '
+test_expect_success C_LOCALE_OUTPUT "Recursion doesn't happen when new=
 superproject commits don't change any submodules" '
 	add_upstream_commit &&
 	head1=3D$(git rev-parse --short HEAD) &&
 	echo a > file &&
@@ -264,7 +264,7 @@ test_expect_success "Recursion doesn't happen when =
new superproject commits don'
 	test_cmp expect.err.file actual.err
 '

-test_expect_success "Recursion picks up config in submodule" '
+test_expect_success C_LOCALE_OUTPUT "Recursion picks up config in subm=
odule" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules &&
@@ -293,7 +293,7 @@ test_expect_success "Recursion picks up config in s=
ubmodule" '
 	test_cmp expect.out actual.out
 '

-test_expect_success "Recursion picks up all submodules when necessary"=
 '
+test_expect_success C_LOCALE_OUTPUT "Recursion picks up all submodules=
 when necessary" '
 	add_upstream_commit &&
 	(
 		cd submodule &&
@@ -351,7 +351,7 @@ test_expect_success "'--recurse-submodules=3Don-dem=
and' doesn't recurse when no ne
 	! test -s actual.err
 '

-test_expect_success "'--recurse-submodules=3Don-demand' recurses as de=
ep as necessary (and ignores config)" '
+test_expect_success C_LOCALE_OUTPUT "'--recurse-submodules=3Don-demand=
' recurses as deep as necessary (and ignores config)" '
 	head1=3D$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -379,7 +379,7 @@ test_expect_success "'--recurse-submodules=3Don-dem=
and' recurses as deep as necess
 	test_cmp expect.err actual.err
 '

-test_expect_success "'--recurse-submodules=3Don-demand' stops when no =
new submodule commits are found in the superproject (and ignores config=
)" '
+test_expect_success C_LOCALE_OUTPUT "'--recurse-submodules=3Don-demand=
' stops when no new submodule commits are found in the superproject (an=
d ignores config)" '
 	add_upstream_commit &&
 	head1=3D$(git rev-parse --short HEAD) &&
 	echo a >> file &&
@@ -396,7 +396,7 @@ test_expect_success "'--recurse-submodules=3Don-dem=
and' stops when no new submodul
 	test_cmp expect.err.file actual.err
 '

-test_expect_success "'fetch.recurseSubmodules=3Don-demand' overrides g=
lobal config" '
+test_expect_success C_LOCALE_OUTPUT "'fetch.recurseSubmodules=3Don-dem=
and' overrides global config" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -424,7 +424,7 @@ test_expect_success "'fetch.recurseSubmodules=3Don-=
demand' overrides global config
 	test_cmp expect.err.2 actual.err
 '

-test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=3Don-dema=
nd' overrides fetch.recurseSubmodules" '
+test_expect_success C_LOCALE_OUTPUT "'submodule.<sub>.fetchRecurseSubm=
odules=3Don-demand' overrides fetch.recurseSubmodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules
@@ -452,7 +452,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseS=
ubmodules=3Don-demand' override
 	test_cmp expect.err.2 actual.err
 '

-test_expect_success "don't fetch submodule when newly recorded commits=
 are already present" '
+test_expect_success C_LOCALE_OUTPUT "don't fetch submodule when newly =
recorded commits are already present" '
 	(
 		cd submodule &&
 		git checkout -q HEAD^^
