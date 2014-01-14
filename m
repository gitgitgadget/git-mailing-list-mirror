From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 23:42:46 +0100
Message-ID: <20140114224246.GA13271@book.hvoigt.net>
References: <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com> <52CE5E51.4060507@web.de> <20140109173218.GA8042@odin.tremily.us> <52CEF71B.5010201@web.de> <20140109195522.GT29954@odin.tremily.us> <52CF1764.40604@web.de> <20140109221840.GW29954@odin.tremily.us> <20140114102445.GA27915@sandbox-ub> <20140114214608.GB838@sandbox-ub> <20140114222231.GA2647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 14 23:43:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ChM-0002I5-Bv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 23:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbaANWnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 17:43:00 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:49938 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbaANWm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 17:42:58 -0500
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W3ChA-0003mn-1H; Tue, 14 Jan 2014 23:42:52 +0100
Content-Disposition: inline
In-Reply-To: <20140114222231.GA2647@odin.tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240420>

On Tue, Jan 14, 2014 at 02:22:31PM -0800, W. Trevor King wrote:
> On Tue, Jan 14, 2014 at 10:46:08PM +0100, Heiko Voigt wrote:
> > I would like to step back a bit and get back to the original proble=
m
> > at hand: Francescos original use case of an attached head for direc=
t
> > commits on a stable branch in a submodule. How about we finish
> > discussing the exact solution of that first. AFAIK that is already
> > solved with the following:
> >=20
> >  * Trevor's first patch[2] to create a branch on initial clone of a=
 submodule
>=20
> v1 broke a bunch of tests.  Are you ok with v2 [1]?  v2 still needs a
> clearer commit message, a test, and a possible transition to
> triggering on non-checkout submodule.<name>.update instead of
> non-empty submodule.<name>.branch [2].

Will have a look.

> > That should be all (and IIRC Francesco agreed) needed for that use-=
case.
>=20
> That was my understanding [3] ;).

Thanks for the pointer.

> > Lets not implement more than currently is needed. We can revisit th=
e
> > ideas once some other real use-case manifests.
>=20
> I have most of a real use case already.  I have a repository with
> submodules in one branch (master) and a subtree version in another
> (assembled) [4].  The *tree* is the same in each case, so I have to
> 'git rm -rf .'  to clear the submodules out of master before I can
> checkout assembled.
>=20
>   $ git checkout assembled
>   error: The following untracked working tree files would be overwrit=
ten by checkout:
>           modular/README.md
>           modular/shell/README.md
>           =E2=80=A6
>   $ git rm -rf .
>   $ git checkout assembled
>=20
> That leaves some extra stuff removed:
>=20
>   $ git status
>   On branch assembled
>   Changes to be committed:
>     (use "git reset HEAD <file>..." to unstage)
>=20
>           deleted:    .gitignore
>           deleted:    .mailmap
>           deleted:    CONTRIBUTING.md
>           deleted:    LICENSE.md
>           deleted:    instructor.md
>=20
> so I need to check that out by hand:
>=20
>   $ git reset --hard HEAD
>=20
> Now I can work in the assembled branch.  Going back to master is a bi=
t
> less tedious:
>=20
>   $ git checkout master
>   $ git submodule update --recursive
>=20
> Luckily for me, I don't have a third superproject branch where the
> submodules are on a different, so the submodule's HEADs are preserved=
=2E
> As I understand it, the new recursive checkout functionality [5] woul=
d
> checkout my submodules with detached HEADs.  The fact that they are
> only accidentally preserved now is not comforting ;).

As it will be opt-in first (you will have to enable it with config
options) you can keep your current workflow. Once done with the initial
implementation we can discuss and iron out use-cases like yours.

> > Also we (Jens and I) would first like to proceed with the recursive
> > checkout / fetch (for which the plan is clear) as the next
> > complicated step.
> >=20
> > Once that is done and people gain some experience with it we can
> > still extend further.
>=20
> This is quite reasonable.  Given the need for backwards compatibility=
,
> I just wanted to make sure my ideal UI was clear before we went
> forward.  There's no need to break fingers twice ;), but if tight
> binding with localBranch is too big a chunk to bite off now, I'm happ=
y
> to kick that can down the road.

Yes, that would be good to clearly understand and find out what we
actually want.

Cheers Heiko

> [1]: http://article.gmane.org/gmane.comp.version-control.git/239967
> [2]: http://article.gmane.org/gmane.comp.version-control.git/239973
> [3]: http://article.gmane.org/gmane.comp.version-control.git/240139
> [4]: (gitweb) http://git.tremily.us/?p=3Dswc-boot-camp.git
> [5]: http://article.gmane.org/gmane.comp.version-control.git/239695
