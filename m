From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Thu, 10 Mar 2011 17:05:22 +0700
Message-ID: <AANLkTimsv9bO+Go6Mqrrp_1-AZ=sC3ndyAuskPYLVbkv@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
 <7vmxl37bdp.fsf@alter.siamese.dyndns.org> <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 11:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxckp-0006J0-RT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 11:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab1CJKFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 05:05:54 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55074 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab1CJKFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 05:05:53 -0500
Received: by wya21 with SMTP id 21so1286329wya.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=S7RG9TsnP0/GZ3nNseK4DMvUgB5NF5JRahfpAoyozPY=;
        b=CAWpNRgDZtBmWZpVYuF+UpJ2RkxrVZsIPkaWEcqR3Wpu/6i4OfQXQlha9009RxaI4j
         afqUhQKTsMw34W0Ag6Zpr6hN2rEDlmUQnPVEF/obQUZE6KLNqSrKcz2wu/7j/rSJo7MX
         QbJLW/i9EpQ9ZwAyvelmyFSUt6v0r3io4tYmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lZcNFY+CgS+XxKk9F5FdLh1cEoehU5DvO1lN3K272Hx+Y7kpfxcnYy9oBJF4AsqlC9
         IOqdSLJeGNLRxE3qQct7Jx9oPSnDw8GjqBIvINroG4Oigak1mtEngmZ0TP5qPXhRIyfg
         rfejc3obiHRKKyQ/oLhGE0P7+GFxLG/u/0xPM=
Received: by 10.216.49.15 with SMTP id w15mr5633757web.1.1299751552054; Thu,
 10 Mar 2011 02:05:52 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 10 Mar 2011 02:05:22 -0800 (PST)
In-Reply-To: <7vvczr5pw6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168805>

2011/3/10 Junio C Hamano <gitster@pobox.com>:
> Let's step back a bit.
>
> We chose to use ":/<regexp>" as one new form of extended SHA-1 expres=
sion
> to name an object for two reasons: (1) no normal <ref> can have a col=
on in
> it, because of check-ref-format restriction; (2) ":" is an unlikely l=
etter
> to appear at the beginning of a pathname, and people with such a path=
 can
> work around by saying "./:frotz" or "\:xyzzy".
>
> There is a disambiguation logic to check a list of arguments that lac=
ks an
> explicit "--" separator to make sure that each element early on the l=
ist
> can only be interpreted as an object name but not as a pathname that
> exists on the filesystem, and all the remaining elements are pathname=
s
> that exist on the filesystem.
>
> If we introduce an extended syntax for pathspec and make the prefix m=
agic
> character ":", and if we choose to use ":/" as one kind of magic, I w=
as a
> bit worried that this may affect the disambiguation. =C2=A0The users =
must use
> an explicit "--" when feeding a pathspec with the magic so that the p=
arser
> knows which kind of magic (either object name magic or pathspec magic=
)
> they are talking about.

Or.. we can consider this ':' a special form of wildcard and interpret
the same way:

 - first try exact match. If it matches, the leading ':' is
interpreted literally as part of file name.
 - magic.

> I however realized that it is not an issue at all, because the users
> already need to disambiguate with "--" when using wildcards in their
> pathspecs (e.g. "git log 'Makefil*'" will give you an ambiguity error=
).
> Admittedly, wildcard pathspecs are lessor kind of magic, but they are
> magic nevertheless.

Yes, ':' is on the same side with wildcard pathspecs.

> So my tentative conclusion is that there is no problem using the same=
 ":"
> as the magic introducer for pathspecs, just like we do for object nam=
es.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Side note: please point out flaws in the a=
bove train of thought
> =C2=A0 =C2=A0 =C2=A0 =C2=A0that would make the end result non-workabl=
e.

Huh? I failed.

> I am not very happy with ":!" as negative from syntactical point of v=
iew,
> because traditionally "!" is a tad cumbersome to quote in shells with
> history support (e.g. "csh"), but unfortunately I don't think of any =
good
> alternative that is easy to type. =C2=A0Pathspecs are globs by nature=
, and "!"
> is a good choice of nagation indicator for that reason (think "[!aeio=
u]"
> not "[^aeiou]" the latter of which is a regexp and not glob), though.

We don't need to stick to ':!'. I just needed something to start
coding. Other candidates can be '^' or '-' or '~'. '^' looks best in
my opinion.
--=20
Duy
