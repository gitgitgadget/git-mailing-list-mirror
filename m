From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 13:57:54 +0200
Message-ID: <515824C2.1020004@physik.tu-berlin.de>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de> <51562E79.7000202@physik.tu-berlin.de> <87obe0x94e.fsf@linux-k42r.v.cablecom.net> <51581617.1030107@physik.tu-berlin.de> <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 13:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMGuK-0000OV-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 13:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab3CaL6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 07:58:16 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:36187 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690Ab3CaL6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 07:58:15 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMGtm-000549-Fm; Sun, 31 Mar 2013 13:58:15 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 36C3E11404;
	Sun, 31 Mar 2013 13:58:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <039abbea-6a8b-4014-a383-ad2189a6969d@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219617>

On 03/31/2013 01:38 PM, Thomas Rast wrote:
> "Sebastian G=C3=B6tte" <jaseg@physik.tu-berlin.de> wrote:
>=20
>> On 03/31/2013 10:32 AM, Thomas Rast wrote:
>>>> +	test_must_fail git merge --ff-only --verify-signatures
>> side-untrusted 2>mergeerror &&
>>>> +	test_i18ngrep "from an untrusted key" mergeerror
>>>> +'
>>>
>>> This test gives me the following:
>>>
>>> =3D=3D26527=3D=3D Conditional jump or move depends on uninitialised=
 value(s)
>>> =3D=3D26527=3D=3D    at 0x4C2D8BC: strchrnul (mc_replace_strmem.c:1=
084)
>>> =3D=3D26527=3D=3D    by 0x4989CC: parse_signature_lines (commit.c:1=
074)
>>> =3D=3D26527=3D=3D    by 0x498B33: check_commit_signature (commit.c:=
1100)
>>> =3D=3D26527=3D=3D    by 0x453719: cmd_merge (merge.c:1246)
>>> =3D=3D26527=3D=3D    by 0x4057B6: run_builtin (git.c:282)
>>> =3D=3D26527=3D=3D    by 0x405949: handle_internal_command (git.c:44=
4)
>>> =3D=3D26527=3D=3D    by 0x405A63: run_argv (git.c:490)
>>> =3D=3D26527=3D=3D    by 0x405BF2: main (git.c:565)
> [...]
>=20
> If you have valgrind installed locally, you can also test yourself ;-=
) just pass --valgrind to the test script.
Ok, I can reproduce this with v6 of the patch:

expecting success:=20
        test_must_fail git merge --ff-only --verify-signatures side-unt=
rusted 2>mergeerror &&
        test_i18ngrep "has a good, untrusted GPG signature" mergeerror

=3D=3D1430=3D=3D Conditional jump or move depends on uninitialised valu=
e(s)
=3D=3D1430=3D=3D    at 0x4C26B5C: strchrnul (mc_replace_strmem.c:711)
=3D=3D1430=3D=3D    by 0x47B90B: check_commit_signature (commit.c:1057)
=3D=3D1430=3D=3D    by 0x444212: cmd_merge (merge.c:1245)
=3D=3D1430=3D=3D    by 0x4050E6: handle_internal_command (git.c:281)
=3D=3D1430=3D=3D    by 0x40530C: main (git.c:489)

Though I also can't see the problem. strchrnul gets passed a char* that=
 is just fine.
