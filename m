From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: Re: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Fri, 27 May 2016 14:43:47 +0200
Message-ID: <9975E0C6-7BCC-4D80-BBC6-2C0BAB13D3E6@grenoble-inp.org>
References: <vpqshx5cb51.fsf@anie.imag.fr> <1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 14:44:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6H7a-0000tx-QU
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 14:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbcE0Mny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 08:43:54 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:54563 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbcE0Mnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 08:43:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 245312570;
	Fri, 27 May 2016 14:43:48 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6hqGVG0nWst; Fri, 27 May 2016 14:43:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 13790256E;
	Fri, 27 May 2016 14:43:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0C23C2077;
	Fri, 27 May 2016 14:43:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVBQ7a7QKty7; Fri, 27 May 2016 14:43:47 +0200 (CEST)
Received: from eduroam-032166.grenet.fr (eduroam-032166.grenet.fr [130.190.32.166])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C841A2055;
	Fri, 27 May 2016 14:43:47 +0200 (CEST)
In-Reply-To: <xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295748>

>> +test_expect_success '"add" using shorthand - fails when no previous=
 branch' '
>> +	test_must_fail git worktree add existing -
>> +'
>=20
> Just an observation, but the error message we would see here might
> be interesting.

Of course, that=E2=80=99s useful to be sure of the error, I will do in =
next preroll.

>=20
>> +	branch=3D$(cd short-hand && git rev-parse --symbolic-full-name HEA=
D) &&
>> +	test "$branch" =3D refs/heads/newbranch &&
>> +	cd ..
>=20
> If any of the command between "cd short-hand" and "cd .." failed,
> after correcting the broken &&-chain, the next test will end up
> running in short-hand directory, which it is not expecting.  A
> canonical way to avoid this problem is to replace the above with:
>=20
> 	...
>        git worktree add short-hand - &&
>        (
> 		cd short-hand &&
>                ...
>                test "$branch" =3D refs/heads/newbranch
> 	)
>=20
> In this particular case, alternatively, you could also do something
> like this:
>=20
>        git worktree add short-hand - &&
> 	echo refs/heads/newbranch >expect &&
> 	git -C short-hand rev-parse --symbolic-full-name HEAD >actual &&
> 	test_cmp expect actual
Yes, that=E2=80=99s a good idea. I take these lines.=20
