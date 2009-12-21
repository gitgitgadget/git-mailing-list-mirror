From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 10:08:49 +0100
Message-ID: <40aa078e0912210108y4ea67dbfs2025bae20bdfb381@mail.gmail.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
	 <4B2F214D.2020905@viscovery.net>
	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>
	 <4B2F2727.4060405@viscovery.net>
	 <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
	 <4B2F320A.6010908@viscovery.net>
	 <40aa078e0912210041g1fd94c77g6cf9f1b236b6ecd7@mail.gmail.com>
	 <4B2F3732.6030903@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 10:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMeGB-00077t-SV
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 10:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbZLUJIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2009 04:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbZLUJIw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 04:08:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:9214 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbZLUJIu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2009 04:08:50 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1268196eyd.19
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 01:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CbLeEAJ1kZSRswTFr9lt+qOGnlwcituofG2/WYqtgYQ=;
        b=BPC8rAdzG3j6leQj2Kj6ee7jTBS7L+CMx+CgguVwZeMW3dHq0qwCgQwW2aaUaOnp6Z
         vUPssh+fPzXlEj+XLHPbtPiVAeaAEP9AEClk691VffxDjwIRNzRQeZF2teY14XBOFQIq
         h/If/5ubqGnD/3w2qwxkd+/mXQxd2aq5gLudY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=LOR3RDKxnERwRbpQy2jZ1wV/hpdQxAh2eQpOHH39xELLs+eExFc/q0BqU0EG20EoI9
         pOJiPJiVIuapabPs6mcnA/sOD+8b6+AZe4GDmui7LW9YP/NOfvwfUxXXe4u6bzkFyL03
         tJHHQQf4dAu1LG4/2ggU5B6VvPon2eezTmJwQ=
Received: by 10.216.90.21 with SMTP id d21mr2344479wef.85.1261386529359; Mon, 
	21 Dec 2009 01:08:49 -0800 (PST)
In-Reply-To: <4B2F3732.6030903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135551>

On Mon, Dec 21, 2009 at 9:52 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Erik Faye-Lund schrieb:
>> On Mon, Dec 21, 2009 at 9:30 AM, Johannes Sixt <j.sixt@viscovery.net=
> wrote:
>>> Frank Li schrieb:
>>>> Maybe some excute path miss initialized it. Otherwise compiler wil=
l
>>>> not report warning.
>>> LOOK AT THE CODE. There is no such code path.
>>>
>>
>> That's odd.
>
> Only if Frank did the homework and removed the initialization from
>
> =A0 =A0 =A0 =A0int failed_errno =3D failed_errno;
>
>> I agree, there isn't such a code path. But this is the
>> first time I've ever seen this MSVC-feature turn up false positives,
>> which puzzles me.
>
> This line will trigger the check. It initializes failed_errno with it=
self,
> which is still uninitialized at this time.
>
> Note that we have more definitions of this kind:
>
> $ git grep -E ' ([a-zA-Z_][a-zA-Z_0-9]*) =3D \1[;,]' *.c
> builtin-rev-list.c: =A0 =A0 =A0 =A0 =A0 =A0 int reaches =3D reaches, =
all =3D all;
> match-trees.c: =A0 =A0 =A0 =A0 =A0unsigned mode1 =3D mode1;
> match-trees.c: =A0 =A0 =A0 =A0 =A0unsigned mode2 =3D mode2;
> run-command.c: =A0int failed_errno =3D failed_errno;
> transport.c: =A0 =A0 =A0 =A0 =A0 =A0int cmp =3D cmp, len;
> wt-status.c: =A0 =A0int status =3D status;
>
> -- Hannes
>
>

Right, I didn't think of that. Since that is the case, I'd say
disabling run-time checks is perfectly sane.

That being said, it might make sense for MSVC people to be able to
have this feature turned on so they can easier find REAL
programmer-errors. But I guess removing the self-assignments makes
trouble for non-MSVC people.

Perhaps some of these warnings could be avoided in a "safer" way? IMO,
assigning variables to themselves like this is a bit fishy, as it
effectively hides uninitialized-use warnings for the entire lifetime
of that variable. Sure, the programmer who did that probably knows
what he or she does -- but they can't possibly know what people will
do in the future. If we could somehow turn these (really few)
occasions into something that produces reliable warnings on
uninitialized variables, I think we might be able to catch some bugs
earlier.

--=20
Erik "kusma" Faye-Lund
