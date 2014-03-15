From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Sat, 15 Mar 2014 22:00:20 +0100
Message-ID: <5324BF64.7020900@web.de>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>	<1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>	<xmqqk3c0o3cj.fsf@gitster.dls.corp.google.com>	<53244777.2040302@web.de> <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXI=?= =?UTF-8?B?c2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 15 22:00:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOvhN-0000TD-Iw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219AbaCOVAs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2014 17:00:48 -0400
Received: from mout.web.de ([212.227.15.14]:51821 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbaCOVAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:00:47 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0McFgl-1WgJYL1qQp-00JXQ9; Sat, 15 Mar 2014 22:00:26
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
X-Provags-ID: V03:K0:r6x2tIJHhYco9G0mGQsaS4DlqH18aKkdjGPOfrpH9A+7Wsd4IM2
 JAJaOMkKNRZt5E0o+VypqE6YSoa7bLNnPPtCnTQ04vxGbmtr7sKoRSm7UqQsadCu0fiVaIe
 s+TIlSTj7ckPHie3QJ0IdsITukjyDUvF9tzhzRVr2PCWzDncB5wfwiJIh6dvz3+flpRJ24S
 8RGW1tz9i++K4Dcqcxh+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244165>

On 2014-03-15 17.11, Benoit Pierre wrote:
> On Sat, Mar 15, 2014 at 1:28 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 2014-03-11 22.03, Junio C Hamano wrote:
>>> Benoit Pierre <benoit.pierre@gmail.com> writes:
>>>
>>>> Add (failing) test: with commit changing the environment to let ho=
oks
>>>> now that no editor will be used (by setting GIT_EDITOR to ":"), th=
e
>>>> "edit hunk" functionality does not work (no editor is launched and=
 the
>>>> whole hunk is committed).
>>>>
>>>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>>>> ---
>>>>  t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++=
++++++++
>>>>  1 file changed, 34 insertions(+)
>>>>  create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>>>>
>>>> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p=
_-m_hunk_edit.sh
>>>
>>> I'll move this to t/t7514-commit-patch.sh for now while queuing.
>>
>> This line is problematic:
>>         echo e | env GIT_EDITOR=3D"sed s/+line3\$/+line2/ -i" git co=
mmit -p -m commit2 f
>>
>> (sed -i is not portable:
>> http://pubs.opengroup.org/onlinepubs/007908799/xcu/sed.html)
>>
>> The whole test hangs in a forever loop loop under MacOS:
>> debug=3Dt verbose=3Dt ./t7514-commit-patch.sh
>> Stage this hunk [y,n,q,a,d,/,e,?]? @@ -1 +1,2 @@
>>  line1
>> +line3
>>
>> I think perl can be used instead of sed (but I haven't found the exa=
ct syntax yet)
>=20
> Or maybe change the test to just 'touch' a temporary file or change
> its content like Jun Hao did with for its version of the tests:
>=20
> https://github.com/bloomberg/git/compare/commit-patch-allow-hunk-edit=
ing
>=20
> Should I make a third version? I'll simplify and move the tests to
> t/t7514-commit-patch.sh and add a test for the '--dry-run' case. And
> also:
> - 'now' =3D> 'know' in one of the commit message
> - sign off the last patch (which I forgot to do)
> - fix the indentation in one of the patch
>=20
The following works for me, (diff against pu)
(and if you want to send a 3rd version, please do so :-)

diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 1f05d32..da92669 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -25,10 +25,20 @@ test_expect_success 'setup (initial)' '
 	EOF
 '
=20
+write_script .git/FAKE_EDITOR <<\EOF
+	sed -e "s/+line3\$/+line2/" <"$1" >tmp &&
+	mv -f tmp "$1"
+	exit 0
+EOF
+
 test_expect_success 'edit hunk "commit -p -m message"' '
-	echo e | env GIT_EDITOR=3D"sed s/+line3\$/+line2/ -i" git commit -p -=
m commit2 file &&
-	git diff HEAD^ HEAD >actual &&
-	test_cmp expect actual
+	(
+		GIT_EDITOR=3D"\"$(pwd)/.git/FAKE_EDITOR\"" &&
+		export GIT_EDITOR &&
+		echo e | git commit -p -m commit2 file &&
+		git diff HEAD^ HEAD >actual &&
+		test_cmp expect actual
+	)
 '
=20
 test_done
