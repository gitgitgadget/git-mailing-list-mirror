From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sat, 26 Jan 2013 07:57:35 +0100
Message-ID: <51037E5F.8090506@web.de>
References: <201301120650.46479.tboegi@web.de> <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de> <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org> <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 07:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyziS-0006Cn-S1
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 07:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab3AZG5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jan 2013 01:57:55 -0500
Received: from mout.web.de ([212.227.17.11]:49905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab3AZG5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 01:57:53 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M8iaa-1UB2vG1Fzo-00CIrq; Sat, 26 Jan 2013 07:57:39
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:mv0nF67SbRiU32Ryw3mADfRcerzTFOTiNy/ofM0K6/I
 CioWAc83TAYWTa9GclpjGXEGDHBtirVhA3wmaprTEKtVC44itw
 W1uoi/tonPrpOn3J3LWyNuA3Y441iWCl8wyjSrx6BG4xOcDv3W
 Pa0QySYfYzWvcP6Jr5fJB/8N3fFvOx33mQxP+uVnD/rCdl3UoK
 0zkNumUqfXKYXj/fy/qdQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214611>

On 15.01.13 21:38, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> What do we think about something like this for fishing for which:
>>
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -644,6 +644,10 @@ yes () {
>>                 :
>>         done
>>  }
>> +which () {
>> +       echo >&2 "which is not portable (please use type)"
>> +       exit 1
>> +}
>>
>>
>> This will happen in runtime, which might be good enough ?
>=20
> 	if (
> 		which frotz &&
>                 test $(frobonitz --version" -le 2.0
> 	   )
>         then
> 		test_set_prereq FROTZ_FROBONITZ
> 	else
> 		echo >&2 "suitable Frotz/Frobonitz combo not available;"
>                 echo >&2 "some tests may be skipped"
> 	fi
>=20
> I somehow think this is a lost cause.

I found different ways to detect if frotz is installed in the test suit=
e:
a) use "type"    (Should be the fastest ?)
b) call the command directly, check the exit code
c) "! test_have_prereq" (easy to understand, propably most expensive ?)

Do we really need  "which" to detect if frotz is installed?


/Torsten



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
if ! type cvs >/dev/null 2>&1
then
	skip_all=3D'skipping cvsimport tests, cvs not found'
	test_done
fi

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
	# we are in full-on bash mode
	true
elif type bash >/dev/null 2>&1; then
	# execute in full-on bash mode
	unset POSIXLY_CORRECT
	exec bash "$0" "$@"
else
	echo '1..0 #SKIP skipping bash completion tests; bash not available'
	exit 0
fi
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
svn >/dev/null 2>&1
if test $? -ne 1
then
    skip_all=3D'skipping git svn tests, svn not found'
    test_done
fi
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
( p4 -h && p4d -h ) >/dev/null 2>&1 || {
	skip_all=3D'skipping git p4 tests; no p4 or p4d'
	test_done
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
if ! test_have_prereq PERL; then
	skip_all=3D'skipping gitweb tests, perl not available'
	test_done
fi
