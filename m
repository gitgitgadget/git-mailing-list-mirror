From: John Keeping <john@keeping.me.uk>
Subject: Re: Re: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Wed, 5 Jun 2013 09:19:02 +0100
Message-ID: <20130605081901.GQ1072@serenity.lan>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
 <51A7A73C.6070103@web.de>
 <20130531194051.GC1072@serenity.lan>
 <51AD0EEB.4020106@web.de>
 <20130603222341.GL1072@serenity.lan>
 <20130604052950.GA2943@book.hvoigt.net>
 <20130604081045.GM1072@serenity.lan>
 <20130604111717.GA306@book.hvoigt.net>
 <20130604124826.GN1072@serenity.lan>
 <CABURp0qPt8S4WWhjb22qEJwnUOoT7SFr9=cZBv3Syp-uEX-ycg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 10:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk8wI-0004E2-8F
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 10:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3FEITV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jun 2013 04:19:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47876 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab3FEITS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 04:19:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D01B1CDA620;
	Wed,  5 Jun 2013 09:19:17 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hrhllnoPWwQn; Wed,  5 Jun 2013 09:19:12 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 61104866011;
	Wed,  5 Jun 2013 09:19:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CABURp0qPt8S4WWhjb22qEJwnUOoT7SFr9=cZBv3Syp-uEX-ycg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226443>

On Tue, Jun 04, 2013 at 06:57:34PM -0400, Phil Hord wrote:
> On Tue, Jun 4, 2013 at 8:48 AM, John Keeping <john@keeping.me.uk> wro=
te:
> > The problem is that sometimes you do want to adjust the path and
> > sometimes you don't.  Reading git-submodule(1), it says:
> >
> >      This may be either an absolute URL, or (if it begins with ./ o=
r
> >      ../), the location relative to the superproject=E2=80=99s orig=
in
> >      repository.
> >      [snip]
> >      If the superproject doesn=E2=80=99t have an origin configured =
the
> >      superproject is its own authoritative upstream and the current
> >      working directory is used instead.
> >
> > So I think it's quite reasonable to have a server layout that looks=
 like
> > this:
> >
> >     project
> >     |- libs
> >     |  |- libA
> >     |  `- libB
> >     |- core.git
> >
> > and with only core.git on your local system do:
> >
> >     cd core/libs
> >     git submodule add ../libs/libB
> >
> > expecting that to point to libB.  But if we adjust the path then th=
e
> > user has to do:
> >
> >     git submodule add ../../libs/libB
> >
> > However, it is also perfectly reasonable to have no remote configur=
ed
> > and the library next to the repository itself.  In which case we do=
 want
> > to specify the additional "../" so that shell completion works in t=
he
> > natural way.
>=20
> In submodule add, the leading '../' prefix on the repository url has
> always meant that the url is relative to the url of the current repo.
> The given repo-url is precisely what ends up in .gitmodules'
> submodule.$name.url.  It works this way whether there is a remote
> configured or not.
>=20
> It does seem like we need to be cautious around this change.
>=20
> > The only way I can see to resolve the ambiguity is to die when we h=
it
> > this particular case.  This should be acceptable because people
> > shouldn't be adding new submodules anywhere near as often as they
> > perform other submodule operations and it doesn't affect absolute U=
RLs.
>=20
> I don't think I like that.  But I don't know if I like anything I
> dreamed up, either.

I've decided that I will make it die (unless anyone comes up with an
obviously correct solution before I get around to sending the reroll)
because it's a lot easier to loosen that in the future than to change i=
t
if we get the behaviour wrong now.  I don't want to hold every other
subcommand hostage to this one case.
