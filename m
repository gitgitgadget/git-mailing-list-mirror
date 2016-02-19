From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Fri, 19 Feb 2016 14:44:22 -0800
Message-ID: <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:44:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWtmx-0002d9-74
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 23:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949719AbcBSWo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 17:44:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1949532AbcBSWoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 17:44:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECC9D4440A;
	Fri, 19 Feb 2016 17:44:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G426sBAaDfeu
	Wpw95uhG+VSvYOE=; b=EPKkW2+5S5+Nb+fBtePFKdH8/8Jrk1dkz6uN0L0aX/qM
	UnxJ3oeGvByPCkPxJ0gEQeC7ELDtLW0icp5N2XCA4HCnj36dgqvdSmjGftPLx5yX
	csjVZHLyh2WAb1oE7UV5pn+4RzHXN9weTFxVUabunp+pXmVHHul158prlexGjQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Di2P7X
	8sNaTZLrivy5zkOizvwYnXRqxhwr8FzEqxNKsdfPwICbJNJdeHiFRCN63m9n3eM2
	6czrLpUiowQJwMdAxdG+9ktPr2f/3MfzF9wSmqPjOGOO/jrY6lD0OmaGf2JV1N8m
	i1CFfoSjSXkhKsBzVtz4ZTZJvbPlWYDqnIAFw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E47BE44408;
	Fri, 19 Feb 2016 17:44:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 696B244407;
	Fri, 19 Feb 2016 17:44:23 -0500 (EST)
In-Reply-To: <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	("Amadeusz =?utf-8?B?xbtvxYJub3dza2kiJ3M=?= message of "Fri, 19 Feb 2016
 21:57:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 526AF1B0-D75A-11E5-B142-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286756>

Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name> writes:

> git-p4 can be successfully used from bare repository (which may act a=
s a
> bridge between Perforce repository and pure Git repositories). After
> submitting changelist to Perforce, git-p4 performs unconditional reba=
se
> which obviously fails.
>
> Perform rebase only on non-bare repositories, so submit command can b=
e
> successful on bare repository.

It is obvious that an attempt to run rebase would fail in a bare
repository, and skipping it would obviously make it not fail.

I think that part is well understood.

What is unclear is what the ramification of _not_ rebasing after
submitting is.

In other words, why do we have to rebase after submitting when we
are in a non-bare repository?  There must be a reason behind it,
i.e. "If we do not rebase, then the repository would be in a state
where future operations like X and Y do not work correctly because
of Z".

And why does that same reason Z not apply when we submit from a bare
repository?

A possible explanation might be that X and Y are operations that
happen only in a non-bare repository that we do not have to worry
about happening in a bare repository after we finish submitting.

But these X, Y and Z are left unexplained--that is what is unclear
in the original proposed log message, and it is still unclear in the
above update.

Thanks.



> Signed-off-by: Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidecoe.name>
> ---
>  git-p4.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c33dece..e00cd02 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
>                  sync.branch =3D self.branch
>              sync.run([])
> =20
> -            rebase =3D P4Rebase()
> -            rebase.rebase()
> +            if not gitConfigBool("core.bare"):
> +                rebase =3D P4Rebase()
> +                rebase.rebase()
> =20
>          else:
>              if len(applied) =3D=3D 0:
