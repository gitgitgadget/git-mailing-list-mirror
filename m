From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t5539 broken under Mac OS X
Date: Wed, 14 Jan 2015 20:50:47 +0100
Message-ID: <54B6C897.5030405@web.de>
References: <54B68D99.2040906@web.de> <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 20:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBTy2-0001ia-HX
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 20:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbbANTu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2015 14:50:57 -0500
Received: from mout.web.de ([212.227.17.12]:53198 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbbANTu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 14:50:56 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M2MYq-1Xsa6K2Wkm-00s2h0; Wed, 14 Jan 2015 20:50:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ngtf/Egr18WG/3XVzPkffGJUX0mkQOFP4iybPPPfN1LGDhCALG3
 Glr8slo/d/NClxa/xxSDpTmmwCSfRNoTuiC44J9ZFCrEfaJZjBs0Rqpwz+JlcAl4aUJTVmf
 aOrTUbCRgtumIjQDgliwhkDsvfKLJPIeeEBqqRj9JQaQK1Xbcbybpg2k1tsOz/t6PFsyekN
 OvMWvFMU1EOjd+OHkKPbw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262417>

On 2015-01-14 19.37, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> t5539 doesn't seem to work as expected under Mac OX X 10.6
>> (10.9 is OK)
>>
>> I am not root.
>> Are there any ideas how we can improve the situation, or how to debu=
g ?
>=20
> As to "how to debug", the first step is to grep for that message and
> notice that it comes from here:
>=20
> t/lib-httpd.sh:
>=20
>     if ! test_have_prereq SANITY; then
>             test_skip_or_die $GIT_TEST_HTTPD \
>                     "Cannot run httpd tests as root"
>     fi
>=20
> and then grep for SANITY to find:
>=20
> t/test-lib.sh:
>=20
>     # When the tests are run as root, permission tests will report th=
at
>     # things are writable when they shouldn't be.
>     test -w / || test_set_prereq SANITY
>=20
> It appears that the check in lib-httpd.sh thinks you lack SANITY; is
> the root directory of your system somehow writable by you?
>=20
Yes, that was a good hint, thanks.
The "problem" is that I am Admin on one machine, but not on the other,
and / was writable for the admin group for some reasons, and only on th=
is machine.



But, why does e.g. t0004 behave more gracefully (and skips) and t5539 j=
ust dies ?

=2E/t0004-unwritable.sh=20
ok 1 - setup
ok 2 # skip write-tree should notice unwritable repository (missing SAN=
ITY of POSIXPERM,SANITY)


(And after changing the group of / t5539 passes, and so does t0004)
