From: John Keeping <john@keeping.me.uk>
Subject: Re: Re: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Tue, 4 Jun 2013 13:48:26 +0100
Message-ID: <20130604124826.GN1072@serenity.lan>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
 <51A7A73C.6070103@web.de>
 <20130531194051.GC1072@serenity.lan>
 <51AD0EEB.4020106@web.de>
 <20130603222341.GL1072@serenity.lan>
 <20130604052950.GA2943@book.hvoigt.net>
 <20130604081045.GM1072@serenity.lan>
 <20130604111717.GA306@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqfJ-0006Zy-6F
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3FDMsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 08:48:37 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:50700 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3FDMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:48:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 75CBC22F12;
	Tue,  4 Jun 2013 13:48:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Wuln8JdMBW5; Tue,  4 Jun 2013 13:48:34 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E93D123123;
	Tue,  4 Jun 2013 13:48:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130604111717.GA306@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226359>

On Tue, Jun 04, 2013 at 09:17:17PM +1000, Heiko Voigt wrote:
> On Tue, Jun 04, 2013 at 09:10:45AM +0100, John Keeping wrote:
> > On Tue, Jun 04, 2013 at 03:29:51PM +1000, Heiko Voigt wrote:
> > > On Mon, Jun 03, 2013 at 11:23:41PM +0100, John Keeping wrote:
> > > > > Sorry, I should have been more specific here. I saw that you =
did some
> > > > > changes to make "submodule add" do the right thing with relat=
ive paths,
> > > > > but the following change to t7406 does not work like I believ=
e it
> > > > > should but instead makes the test fail:
> > > > > -------------------8<---------------------
> > > > > diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-=
update.sh
> > > > > index a4ffea0..9766b9e 100755
> > > > > --- a/t/t7406-submodule-update.sh
> > > > > +++ b/t/t7406-submodule-update.sh
> > > > > @@ -559,7 +559,9 @@ test_expect_success 'add different submod=
ules to the same pa
> > > > >  test_expect_success 'submodule add places git-dir in superpr=
ojects git-dir' '
> > > > >         (cd super &&
> > > > >          mkdir deeper &&
> > > > > -        git submodule add ../submodule deeper/submodule &&
> > > > > +        (cd deeper &&
> > > > > +         git submodule add ../../submodule submodule
> > > > > +        ) &&
> > > > >          (cd deeper/submodule &&
> > > > >           git log > ../../expected
> > > > >          ) &&
> > > > > -------------------8<---------------------
> > > >=20
> > > > Ah, ok.  I think this case is problematic because the repositor=
y
> > > > argument is either relative to "remote.origin.url" or to the to=
p of the
> > > > working tree if there is no "origin" remote.  I wonder if we sh=
ould just
> > > > die when a relative path is given for the repository and we're =
not at
> > > > the top of the working tree.
> > >=20
> > > Why not behave as if we are at the top of the working tree for re=
lative
> > > paths? If there is an origin remote thats fine. If there is no or=
igin
> > > remote you could warn that the path used is taken relative from t=
he root
> > > of the superproject during add. What do you think?
> >=20
> > That's what the patch currently queued on "pu" does, which Jens wan=
ts to
> > change, isn't it?
>=20
> True I did not realize this when reading it the first time. But I thi=
nk
> we should still not die when in a subdirectory. After all this series=
 is
> trying to archive that the submodule command works in subdirectories
> seamlessly right? So you probably want to translate a relative path
> without "origin" remote given from a subdirectory to the superproject
> level and use that. Then you do not have to die.

The problem is that sometimes you do want to adjust the path and
sometimes you don't.  Reading git-submodule(1), it says:

     This may be either an absolute URL, or (if it begins with ./ or
     ../), the location relative to the superproject=E2=80=99s origin
     repository.
     [snip]
     If the superproject doesn=E2=80=99t have an origin configured the
     superproject is its own authoritative upstream and the current
     working directory is used instead.

So I think it's quite reasonable to have a server layout that looks lik=
e
this:

    project
    |- libs
    |  |- libA
    |  `- libB
    |- core.git

and with only core.git on your local system do:

    cd core/libs
    git submodule add ../libs/libB

expecting that to point to libB.  But if we adjust the path then the
user has to do:

    git submodule add ../../libs/libB

However, it is also perfectly reasonable to have no remote configured
and the library next to the repository itself.  In which case we do wan=
t
to specify the additional "../" so that shell completion works in the
natural way.

The only way I can see to resolve the ambiguity is to die when we hit
this particular case.  This should be acceptable because people
shouldn't be adding new submodules anywhere near as often as they
perform other submodule operations and it doesn't affect absolute URLs.
