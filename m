From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Thu, 5 Jun 2008 15:04:15 +0200
Message-ID: <20080605130415.GB28995@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211334.32531.74258.stgit@localhost.localdomain> <20080605070126.GC23209@diana.vm.bytemark.co.uk> <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4F9Z-0003PM-Nc
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbYFENEY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbYFENEY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:04:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2872 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYFENEY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:04:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4F8Z-0007dj-00; Thu, 05 Jun 2008 14:04:15 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83923>

On 2008-06-05 13:03:55 +0100, Catalin Marinas wrote:

> 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-04 22:13:35 +0100, Catalin Marinas wrote:
> >
> > > +    def __init__(self, repository, name):
> > > +        self._repository =3D repository
> > > +        self._name =3D name
> >
> > Using double leading underscores will give you a class-local name.
> > Why just one?
>
> Just a convention: double underscore - private, simple underscore -
> protected (using C++ or Java naming). The _repository or _name are
> meant to be made available to a derived class (stack.Stack in our
> case), though we have the corresponding public properties already.

OK. Then I'd argue that these two should be private since there's no
particular reason for them to be just protected, but I think I've done
enough nitpicking for one day already!

> >> +    @classmethod
> >> +    def create(cls, repository, name, create_at =3D None):
> >
> > Minor nit: in case of things that are clearly "owned" by other
> > things (git objects are owned by a git repository, for example),
> > I've tried to put the creation function in the owner, not the
> > owned. I'm not insisting, though.
>
> As I see these things, the git.Repository and the derived
> stack.Repository are indeed object factories but they are mainly
> responsible for creating/returning a new Python object and passing
> some arguments to the class' __init__. The Repository object doesn't
> need to know more than the name as the rest is handled by __init__.

Yes. This is exactly how it works e.g. when a Repository creates Blob,
Tree, or Commit objects.

> The same goes for the "create" function, the repository shouldn't
> need to know the directory or files structure that a Stack or Branch
> are using. I think we get a clearer separation this way.

Yes, you're right. Knowledge of internals belong in the class itself.

We'll have to be watchful against attempts to create objects other
than via the officially designated factories, though. Python doesn't
really have any mechanisms that help us here.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
