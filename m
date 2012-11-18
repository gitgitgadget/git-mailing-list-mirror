From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sun, 18 Nov 2012 06:50:16 +0100
Message-ID: <50A87718.4030806@web.de>
References: <509E5B27.5080808@web.de> <CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com> <509EA8EE.1030908@web.de> <CAMP44s2yenQKSgdUXfZP+yDJJ+bdveyms=SQ+3ptPvpT6D0hsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 06:50:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZxm5-0002Uw-Cg
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 06:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab2KRFuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 00:50:19 -0500
Received: from mout.web.de ([212.227.15.3]:63600 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2KRFuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 00:50:18 -0500
Received: from birne.local ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MHYHE-1TYrq91V2S-003yzo; Sun, 18 Nov 2012 06:50:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAMP44s2yenQKSgdUXfZP+yDJJ+bdveyms=SQ+3ptPvpT6D0hsg@mail.gmail.com>
X-Provags-ID: V02:K0:3eALgHAWWN9p6E+NSxMi8aHo9JRXVBZHvGru4Ru/tjq
 gaJPTSHtfSlXcyCSHeQheS0Nfs38aNQ2BreKY4u/D60RegJdeP
 4ayX5DL/CbJ4zJcTLNHK6XNs6bP3MUsOqMfT6S1AHsi+6WAi5a
 Smde6EDQak7n+lCzSFTI3EMNPSza3D6zUq9e1DkoDA8IAIqosm
 0GEHPfnXO9kErdY2pVUAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209990>

On 10.11.12 23:05, Felipe Contreras wrote:
> On Sat, Nov 10, 2012 at 8:20 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 11/10/2012 08:15 PM, Felipe Contreras wrote:
>>>
>>> Hi,
>>>
>>> On Sat, Nov 10, 2012 at 2:48 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de>
>>> wrote:
>>>
>>>> on peff/pu t5801 fails, the error is in git-remote-testgit, please=
 see
>>>> below.
>>>>
>>>> That's on my Mac OS X box.
>>>>
>>>> I haven't digged further into the test case, but it looks as if
>>>> "[-+]A  make NAMEs associative arrays"
>>>> is not supported on this version of bash.
>>>> /Torsten
>>>>
>>>>
>>>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 64: decla=
re: -A:
>>>> invalid option
>>>> declare: usage: declare [-afFirtx] [-p] [name[=3Dvalue] ...]
>>>> /Users/tb/projects/git/git.peff/git-remote-testgit: line 66:
>>>> refs/heads/master: division by 0 (error token is "/master")
>>>> error: fast-export died of signal 13
>>>> fatal: Error while running fast-export
>>>
>>>
>>> What is your bash --version?
>>>
>>  bash --version
>> GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin10.0)
>> Copyright (C) 2007 Free Software Foundation, Inc.
>=20
> I see, that version indeed doesn't have associative arrays.
>=20
>> On the other hand, Documentation/CodingGuidelines says:
>>   - No shell arrays.
>=20
> Yeah, for shell code I guess, but this is bash code.
>=20
>> Could we use perl to have arrays?
>=20
> I think the code in perl would be harder to follow, and this is meant
> not only as a test, but also as a reference.
>=20
> I'm not exactly sure what we should do here:
>=20
> a) remove the code (would not be so good as a reference)
> b) enable the code conditionally based on the version of bash (harder=
 to read)
> c) replace the code without associative arrays (will be much more
> complicated and ugly)
> d) add a check for the bash version to the top of the test in t/
>=20
> I'm leaning towards d), followed by b).
>=20
> If only there was a clean way to do this, so c) would not be so ugly.
>=20
> After investigating different optins this seems to be the best:
>=20
> 	join -e empty -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after")
> | while read e a b; do
> 		test "$a" =3D=3D "$b" && continue
> 		echo "changed $e"
> 	done
>=20
> But to me seems a bit harder to grasp. Not sure.
>=20
> Cheers.
>=20

Hi again,
I managed to have a working solution for
"d) add a check for the bash version to the top of the test in t/"
Please see diff below.

This unbreaks the test suite here.
Is this a good way forward?

=46ilipe, does the code line you mention above work for you?

If yes: I can test it here, if you send it as a patch.

/Torsten



diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
old mode 100644
new mode 100755
index 6e4e078..ea3d0f3
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -13,6 +13,15 @@ compare_refs() {
        test_cmp expect actual
 }
=20
+cat >"testbashArray" <<-EOF
+  declare -A assa
+EOF
+
+/bin/bash testbashArray || {
+       skip_all=3D't5801. /bin/bash does not handle associative arrays=
'
+       test_done
+}
+
 test_expect_success 'setup repository' '
        git init server &&
        (cd server &&
