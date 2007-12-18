From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Tue, 18 Dec 2007 13:37:19 -0800
Message-ID: <7vmys7y99s.fsf@gitster.siamese.dyndns.org>
References: <87wsrhex4c.fsf@cpan.org>
	<7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	<7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
	<46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
	<46a038f90712181238p7529a02bmde21c89956a3f641@mail.gmail.com>
	<51dd1af80712181310q38255593t989be64799be2e0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	=?utf-8?Q?=C3=86var_Ar?= =?utf-8?Q?nfj=C3=B6r=C3=B0_Bjarmason?= 
	<avar@cpan.org>, git@vger.kernel.org
To: =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4k8V-0001BJ-Cz
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbXLRVhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 16:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbXLRVhg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:37:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbXLRVhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 16:37:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDD06C8A;
	Tue, 18 Dec 2007 16:37:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 305296C87;
	Tue, 18 Dec 2007 16:37:23 -0500 (EST)
In-Reply-To: <51dd1af80712181310q38255593t989be64799be2e0e@mail.gmail.com>
	(=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason's message of "Tue, 18 Dec
 2007 21:10:28
	+0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68821>

"=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason"  <avarab@gmail.com> writes:

>> On this aspect, I see no reason why we wouldn't have the passwords
>> crypt()ed or SHA1'd. Perl includes crypt() in the default
>> distribution, so it wouldn't add any dependency.
>
> It also includes Digest::SHA in the default distribution as of today:=
)
>
> I could add another option for allowing users to choose their passwor=
d
> storage, e.g.:
>
> [gitcvs]
>     password_storage =3D plaintext # or sha1, crypt, ...

I personally feel that selectable password storage format is going
overboard.  Pick a reasonable one and use it everywhere.

Using some form of crypt is a good idea but then we would need a
separate mode of operation to gitcvs to generate user password.

	$ gitcvs adduser junio
        Password: ******
        Retype password: ******
	Added user 'junio' to .git/config
	$ exit

I personally do not care about deluser or change-password subcommands,
as you can always go directly to .git/config to remove the user and
recreate anew, but adding them might be nice finishing touches.

	$ gitcvs password junio
        New password: ******
        Retype password: ******
	Changed password for user 'junio' in .git/config       =20
	$ gitcvs deluser junio
        Are you sure you want to remove user 'junio' [y/N]? Y
	Removed user 'junio' from .git/config
	$ exit
