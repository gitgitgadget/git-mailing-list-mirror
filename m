From: Manuel Koller <koller.manuel@gmail.com>
Subject: Re: Re: Git Submodule Problem - Bug?
Date: Wed, 7 Dec 2011 09:21:50 +0100
Message-ID: <CAPUobv1QnuAT76=yGDM-KKjoiXCzMt0jCda0LdYxAjN49qmAgA@mail.gmail.com>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com>
 <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya>
 <201111291125.41943.trast@student.ethz.ch> <20111129104105.GA10839@kolya>
 <4ED5196B.5030200@web.de> <20111129220303.GA2812@sandbox-rc.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:22:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCld-0002kW-Q3
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab1LGIWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:22:12 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39003 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab1LGIWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:22:11 -0500
Received: by qcqz2 with SMTP id z2so145611qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GpDH0ZPVyavyL96UAmWqA3QFDPS4goT22LvrR5WOKRk=;
        b=qM6THohQeJP+wTdUX0bphN9U+6dBzpLZaXaM4tdCHrPOmYzPiICTyH0QG7e97j83MA
         U+4WAgMnEWSIPWCQD9GWYlaqKRDixHoC4LKx8embOxEKms2Q4YFIWRwAggtTRqEA53CW
         Ik1JvY2DqufUKlOrd4/uwOxSRpVqT6sR5VC14=
Received: by 10.229.67.213 with SMTP id s21mr3940106qci.89.1323246131162; Wed,
 07 Dec 2011 00:22:11 -0800 (PST)
Received: by 10.229.59.160 with HTTP; Wed, 7 Dec 2011 00:21:50 -0800 (PST)
In-Reply-To: <20111129220303.GA2812@sandbox-rc.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186444>

> How about this:
>
> The user issues 'git submodule add foo' and we discover that there is
> already a local clone under the name foo. Git then asks something lik=
e
> this
>
> =A0 =A0 =A0 =A0Error when adding: There is already a local submodule =
under the
> =A0 =A0 =A0 =A0name 'foo'.
>
> =A0 =A0 =A0 =A0You can either rename the submodule to be added to a d=
ifferent
> =A0 =A0 =A0 =A0name or manually remove the local clone underneath
> =A0 =A0 =A0 =A0.git/modules/foo. If you want to remove the local clon=
e please
> =A0 =A0 =A0 =A0quit now.
>
> =A0 =A0 =A0 =A0We strongly suggest that you give each submodule a uni=
que name.
> =A0 =A0 =A0 =A0Note: This name is independent from the path it is bou=
nd to.
>
> =A0 =A0 =A0 =A0What do you want me to do ([r]ename it, [Q]uit) ?
>
> When the user chooses 'rename' git will prompt for a new name.
>
> If we are going to support the remove use case with add we additional=
ly
> need some logic to deal with it during update (which is not supported
> yet AFAIK). But we probably need this support anyway since between
> removal and adding a new submodule under the same can be a long time.
> If users switch between such ancient history and the new history we
> would have the same conflict.
>
> We could of course just error out and tell the user that he has to gi=
ve
> the submodule an uniqe name. If the user does not do so leave it to h=
im
> to deal with the situation manually.
>
> What do you think?
>
> Cheers Heiko

Prompt to choose another name would be fine I guess - but it solves
the problem only if the submodule has been initialized already. There
could be a submodule of the same name in another branch, which I
haven't checked out yet, for example. The user would have to be forced
choose a unique name for every submodule.

Anyway, it seems impossible to handle a name clash automatically,
since there are good reasons to have different urls for the same
submodule. Having read the thread linked by Junio, the only way out
seems to be a kind of url rewrite scheme and using the url as name.
Doesn't it solve all the problems?

- the url is more or less unique (there are problems now if we have to
different submodules at the same path, which is much more likely to
happen than a different repository at the same url some time in the
future)
- after a change of the submodule's url, we can still check out old
commits in a comfortable way
- we could have the same submodule at different paths, but downloaded o=
nly once
- the user is not forced to do anything, but the .gitmodule config can
still be overruled if necessary
