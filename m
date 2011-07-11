From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: clearly specify what refs are honored by core.logAllRefUpdates
Date: Mon, 11 Jul 2011 20:23:17 +0200
Message-ID: <CAKPyHN3aef5MQh+rv4O07vrVbzziTj+==2H-hKM1XwUwCOqq6Q@mail.gmail.com>
References: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
	<7v7h7og1zo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 20:23:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgL8d-0000EU-9a
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 20:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899Ab1GKSXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jul 2011 14:23:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34468 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757467Ab1GKSXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2011 14:23:17 -0400
Received: by vws1 with SMTP id 1so2909177vws.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=TQDR+4kqpfe84FGDsxheq+NW8y2wAeh04WtrmUzNkqE=;
        b=cqN3a3/Z3f5LYE3nc4AKid0pivJDDFA3GzmnhZ3Ua79yDjI8e6MFiIwZYyEAf/IMfa
         O5CNGTbmknhOMS7hrgQD51wdpbh2UzAUcUzVteYSNWCepC1LUXc4Ui312Visxcb2tIap
         vorJCcbjE19BFgAkUZutJ/gptB4vk3dvewaFE=
Received: by 10.52.23.69 with SMTP id k5mr2667062vdf.396.1310408597106; Mon,
 11 Jul 2011 11:23:17 -0700 (PDT)
Received: by 10.52.185.105 with HTTP; Mon, 11 Jul 2011 11:23:17 -0700 (PDT)
In-Reply-To: <7v7h7og1zo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176886>

On Mon, Jul 11, 2011 at 19:29, Junio C Hamano <gitster@pobox.com> wrote=
:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>> The documentation for logging updates in git-update-ref, doesn't mak=
e it
>> clear that only a specific subset of refs are honored by this variab=
le.
>
> Thanks.
>
>> The initial justification in 4057deb (Junio C Hamano, 2006-10-08), l=
eaves
>> the impression, that a blacklist would have made more sense,...
>
> I didn't mean it that way, and I still don't think blacklisting is
> feasible nor necessarily desirable. Different porcelains can use
> namespaces under refs/ for their own purposes, and it would be more
> prudent not to create reflog files that can grow long and not useful
> given that we cannot predict/guess what they are used for and how, so
> I would prefer white-listing the ones that are known to be useful.
>
> It might make sense to allow customizing the white-list via the
> configuration mechanism, though. When your favorite third-party git
> "frotz" add-on uses refs/frotz/ hierarchy for its own purpose, and if
> viewing "git log -g frotz/master@{now}" is useful, you may want to be=
 able
> to say "In addition to the standard ones, please log refs/frotz/*
> automatically". Of the top of my head, something like:

This sounds like a good idea, and with the -c option you could use it l=
ike this:

    git -c core.autoLogRef=3Dfrotz update-ref -m foo refs/frotz/master =
<sha1>

without having the trouble to set this config inside git-frotz

Actually, I tried also to add something like --force or --always-log
as an option to update-ref, so that the log file is created
automatically. But that doesn't looked that trivial.

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0autoRefLog =3D=
 refs/heads/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0autoRefLog =3D=
 refs/remotes/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0autoRefLog =3D=
 refs/notes/*
>
> or less expressive but even simpler and probably sufficient:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0autoRefLog =3D=
 heads remotes notes
>
> can be the spelled-out form of traditional "core.logAllRefUpdates", a=
nd
> you may be able to tweak it like:
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0autoRefLog =3D=
 heads remotes notes frotz
>

The question is: should the user be able to disable logging of the
hard-coded values. With your examples that would be possible. But I
think we should not allow that. Thus, this config should only adds to
the list, but never resets.

Bert
