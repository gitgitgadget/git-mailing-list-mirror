From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 23:46:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-886112248-1419288393=:21312"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3BkO-0005W9-W4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbaLVWqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:46:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:63764 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaLVWqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:46:36 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Lp7d2-1XQX530FUK-00et63;
 Mon, 22 Dec 2014 23:46:33 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq38878gao.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:AnwVocfon0iSo4H69TbA1aT4BBEB//mIUI5dmXkaZdMiIqsVsuA
 Pc1XYlFyw91l4TMwqIUS6ropy0pkgco5L0yhq+H1oVedFeImr/AT/z7QPkzConpMIQ22PTQ
 mn+RRRI9egXghjM/CXVYqiotaJL107HXU5y8ywSlPHQ5sTVjxaeG8L7k2whgWWr0KBZoCPL
 qca+kAE2EoBDBn3cjVAmw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261690>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-886112248-1419288393=:21312
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > Or do you want the error messages to also use camelCased IDs, i.e.
> >
> > =09warning in tag $tag: missingTaggerEntry: invalid format ...
> >
> > instead of
> >
> > =09warning in tag $tag: missing-tagger-entry: invalid format ...
> >
> > ? It is easy to do, but looks slightly uglier to this developer's eyes.=
=2E.
>=20
> Do you really need to know what I think?

Well, but yes ;-)

> Can I say "The latter is probably slightly better, but both look ugly to
> me"?

Of course you can say that! ;-) The problem these ugly messages try to
solve is to give the user a hint which setting to change if they want to
override the default behavior, though...

> If we want a human readable message
>=20
>     "warning: tag object lacks tagger field '$tag'"
>=20
> would be my preference.
>=20
> But I personally think it may not be necessary to give a pretty
> message that later can go through l10n here.  If we take that
> position, it is just a machine-readble error token, so I'd say
> whichever way you find more readable is OK.

Okay, I will leave it as-is, then.

> >> Should these be tied to receive-pack ones in any way?  E.g. if you
> >> set fsck.missingEmail to ignore, you do not have to do the same for
> >> receive and accept a push with the specific error turned off?
> >>=20
> >> Not a rhetorical question.  I can see it argued both ways.  The
> >> justification to defend the position of not tying these two I would
> >> have is so that I can be more strict to newer breakages (i.e. not
> >> accepting a push that introduce a new breakage by not ignoring with
> >> receive.fsck.*) while allowing breakages that are already present.
> >> The justification for the opposite position is to make it more
> >> convenient to write a consistent policy.  Whichever way is chosen,
> >> we would want to see the reason left in the log message so that
> >> people do not have to wonder what the original motivation was when
> >> they decide if it is a good idea to change this part of the code.
> >
> > Hmm. I really tried very hard to separate the fsck.* from the receive.*
> > settings because the two code paths already behave differently:...
> >
> > If you agree, I would rephrase this line of argument and add it to the
> > commit message. Do you agree?
>=20
> Yeah, that reasoning sounds sensible.

I added this paragraph:

    In the same spirit that `git receive-pack`'s usage of the fsck machiner=
y
    differs from `git fsck`'s =E2=80=93 some of the non-fatal warnings in `=
git fsck`
    are fatal with `git receive-pack` when receive.fsckObjects =3D true, fo=
r
    example =E2=80=93 we strictly separate the fsck.* from the receive.fsck=
=2E*
    settings.

Ciao,
Dscho
--1784107012-886112248-1419288393=:21312--
