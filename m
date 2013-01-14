From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t0050: mark TC merge (case change) as success
Date: Mon, 14 Jan 2013 18:53:34 +0100
Message-ID: <50F4461E.3060408@web.de>
References: <201301132138.37154.tboegi@web.de> <7v7gnghdj2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, prohaska@zib.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 18:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoEY-0001jb-Py
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 18:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001Ab3ANRxp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 12:53:45 -0500
Received: from mout.web.de ([212.227.17.12]:60167 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757974Ab3ANRxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 12:53:43 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M5fhI-1T1uLf0ifw-00y8p3; Mon, 14 Jan 2013 18:53:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v7gnghdj2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:ZTBFFCBe+esw+YpHdZH280qLxG3G+RfqprEK0ocEa2s
 L94+UMyJHU4fTnFvP7aGsi0n7tsBqXmB8pFpoe3ZURpQZRSZMZ
 9wvcgW3+7TVvNeKDF/+aPIJBpTALlGMENczLI4ttHKXRWYULhn
 Zr0Sd0yvyKExRZrjYp0+GUOgkV9msdfIRxsFvtdijZITWYl6i2
 AbvEivCqVhz0eQDiFvz8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213508>

On 14.01.13 00:24, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> The test "merge (case change)" passes on a case ignoring file system
>>
>> Use test_expect_success to remove the "known breakage vanished"
>>
>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>> ---
>=20
> Interesting.  When did this change?  Do you happen to have a
> bisection? =20
This seems to be the commit:

commit 6aad47dec7a72bb36c64afb6c43f4dbcaa49e7f9
Merge: e13067a 0047dd2
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri May 23 16:05:52 2008 -0700

    Merge branch 'sp/ignorecase'
   =20
    * sp/ignorecase:
      t0050: Fix merge test on case sensitive file systems
      t0050: Add test for case insensitive add
      t0050: Set core.ignorecase case to activate case insensitivity
      t0050: Test autodetect core.ignorecase
      git-init: autodetect core.ignorecase

Which comes from here:

commit 0047dd2fd1fc1980913901c5fa098357482c2842
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Thu May 15 07:19:54 2008 +0200

    t0050: Fix merge test on case sensitive file systems
   =20
    On a case sensitive filesystem, "git reset --hard" might refuse to
    overwrite a file whose name differs only by case, even if
    core.ignorecase is set.  It is not clear which circumstances cause =
this
    behavior.  This commit simply works around the problem by removing
    the case changing file before running "git reset --hard".
   =20
    Signed-off-by: Steffen Prohaska <prohaska@zib.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>Or did the test pass from the very beginning?
Hm, reading the commit, it seems as if the "root problem" still exist:
git reset --hard does not change the case of an existing file

What is the exist behvior?



My feeling is that the test as such deserves some more improvements,
the result of the merge is not checked, files are empty so that
the content is not checked.

Another improvement:
Running under Linux gives:
not ok 6 - add (with different case) # TODO known breakage
(and running under mingw failes)
=20
Please stay tuned for more updates, thanks for reviewing.
/Torsten
