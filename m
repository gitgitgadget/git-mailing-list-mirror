From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Fri, 29 Aug 2008 00:01:24 +0200
Message-ID: <20080828220124.GF15520@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com> <20080817195839.GB4542@efreet.light.src> <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com> <20080818180048.GA15520@efreet.light.src> <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com> <20080827201819.GD15520@efreet.light.src> <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com> <20080828153118.GA13169@diana.vm.bytemark.co.uk> <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpZd-0004iX-Qe
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbYH1WBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 18:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbYH1WBc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:01:32 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40210 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbYH1WBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:01:32 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B128C57401;
	Fri, 29 Aug 2008 00:01:30 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id IBJXVAdpV9G6; Fri, 29 Aug 2008 00:01:28 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 77CCC57309;
	Fri, 29 Aug 2008 00:01:27 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KYpYS-0005Bm-OZ; Fri, 29 Aug 2008 00:01:24 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94191>

On Thu, Aug 28, 2008 at 20:54:44 +0200, Marco Costalba wrote:
> On Thu, Aug 28, 2008 at 5:31 PM, Karl Hasselstr=C3=B6m <kha@treskal.c=
om> wrote:
> > StGit has no per-repo data. It's all per-branch. "stg init" operate=
s
> > on the current branch, not the whole repo.
>=20
> Ok. Thanks. In this case the check qgit does is broken, and I think
> not only that because I never had this point clear while developing
> the interface.
>=20
> > Hmm. For me, "stg branch" succeeds even if "stg init" has not yet b=
een
> > run (which is arguably as it should be, since it doesn't require th=
at
> > stg init has been run in the current branch). "stg series" or
> > something is probably better for this purpose.

That would indeed mean, that the check does not do what indented and wo=
uld
show the same symptoms I recalled initially. Seems I can finally reprod=
uce
them.

> But if I run 'stg branch' in a git-only repo this gives an error. Thi=
s
> conditions, at least until now, has always been working for me.
>=20
>=20
> > Though if you're concerned about speed (as the comment indicates), =
you
> > should probably do something cheaper than running stg, such as
> > checking if .git/patches/<branchname> exists.
> >
>=20
> Actually the actual code chunk is:
>=20
>         // check for a StGIT stack
>          QDir d =3D gitDir;
>=20
>          if (d.exists("patches")) { // early skip
>=20
>                  isStGIT =3D run("stg branch", &stgCurBranch); // slo=
w command
>=20
>                  stgCurBranch =3D stgCurBranch.trimmed();
>          } else
>                  isStGIT =3D false;

Ook. Ook.

Now I actually wrote the test cases I am begining to understand why it
behaves the way it does.=20

So, now there is a test infrastructure plus test case to reproduce this
switching between stgit and non-stgit branch in
git://repo.or.cz/qgit4/bulb.git (http://repo.or.cz/r/qgit4/bulb.git) wi=
th
whoping 9 commits. Should I send out a patch series, or do you prefer j=
ust
pulling?

Now in my opinion the code could use some refactoring rather than just =
fixing
the bugs (my long term intent is to add features like topgit support,
push/pull/merge and other things git-gui can do and such). I'd start wi=
th
the Git initialization sequence. I'll write tests for the new code, but=
 as
I expect it to have significantly different interface from the old one,=
 I'll
not try to write tests for the current one.

Best regards,
Jan

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
