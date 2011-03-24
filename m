From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Thu, 24 Mar 2011 14:11:34 -0400
Message-ID: <AANLkTikjN_90UApfD2rRksDk8qXyE6pJHhd00Aw-Qe7Y@mail.gmail.com>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org> <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2p13-0005aQ-Pe
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 19:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab1CXSMI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 14:12:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45444 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab1CXSME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 14:12:04 -0400
Received: by iyb26 with SMTP id 26so213167iyb.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=mz+EZZSkx2/6ZtcugwyGgOkauSuhya6Fp4YhXCVC4/g=;
        b=ZF6TFlHZIMwQ0kWdmakgmpg5TJkv6GoWmYiAM7yy6DgMCO2DUFUH5Se0/kKciuasC1
         DVk+AYRa0C1wIegrWVQKKBIGtKm7EMERWKvtkxnYkakvy4/6iHoopSfeL9bxfoU5KUqB
         /ShoIWZQ9j3Q6Dq5Dusb7bJiPKLU2SZALJfJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A+yR0xCbVQofhABMigndTYPpSRQ1iV8omOdwBrSW0aWpweL2QZZBZVvz3H6gATjTo3
         DDQis0e+yDojXJlWpktzdMruP8vmeBVOV8de8lmudtGS3vbyImvVPDEfy1uP5RL6/1vn
         VIeBXKjCz/qM2CEgzpc1PDN1JV7dzzx11AE2I=
Received: by 10.42.131.137 with SMTP id z9mr14014633ics.60.1300990324210; Thu,
 24 Mar 2011 11:12:04 -0700 (PDT)
Received: by 10.231.181.91 with HTTP; Thu, 24 Mar 2011 11:11:34 -0700 (PDT)
In-Reply-To: <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169934>

On Wed, Mar 23, 2011 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> New people can be trained not to say "git diff A..B" when they mean t=
o
> compare two endpoints with "git diff A B", and that would reduce the
> confusion greatly.

I think this is ill-advised because...

> Warn the use of "git diff A..B" syntax when "git diff A B" equally wo=
rks
> well, is shorter, and is much more clear what the command is comparin=
g
> (i.e. two endpoints).

=2E.. this is not consistent ...

> The new code does not issue a warning against "git diff ..B" that is =
used
> as a shorthand for "git diff HEAD B", and "git diff A.." that is used=
 as a
> shorthand for "git diff A HEAD", respectively. =C2=A0These are shorte=
r to type
> and are often useful.

=2E..with this.

I don't think telling newbies "Use diff A B instead of diff A..B, but
A.. and ..B are okay" reduces confusion any. i.e., this makes more
sense to me:

(1) One sided '..' implies HEAD on the other side with both git log and=
 git diff
(2) "diff A..B" is the same as "diff A B"

Therefor:

- "diff A.." is the same as "diff A..HEAD" (1) is the same as "diff A H=
EAD" (2).
- "diff ..B" is the same as "diff HEAD..B" (1) is the same as "diff HEA=
D B" (2).

Also, the fact that a one-sided '..' implies HEAD on the other side


> +static void check_useless_use_of_range(struct object_array_entry *en=
t)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!(ent[0].item->flags & UNINTERESTING) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ent[1].item->flags & UNINTERESTI=
NG)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* not a r=
ange made by "A..B" notation */
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((ent[0].name =3D=3D dotdot_default_HEAD) |=
|
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ent[1].name =3D=3D dotdot_defau=
lt_HEAD))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return; /* "A.." o=
r "..B" */
> +
> + =C2=A0 =C2=A0 =C2=A0 warning("Do not write 'git diff A..B' but writ=
e 'git diff A B'");
> + =C2=A0 =C2=A0 =C2=A0 warning("diff is about two endpoints!");
> +}
> +

I use diff A..B all the time, because I've often just used log A..B,
or I'm about to, and it's one less part of the command line to change.
Please make this warning squelch-able at least.

j.
