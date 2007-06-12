From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 23:33:13 +0200
Message-ID: <200706122333.14167.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <466E7A17.CEB0F196@eudaptics.com> <7vfy4xhu6p.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>, skimo@liacs.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 23:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyE06-000318-Uo
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 23:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbXFLVdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbXFLVdt
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 17:33:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:48589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752940AbXFLVds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 17:33:48 -0400
Received: (qmail invoked by alias); 12 Jun 2007 21:33:46 -0000
Received: from p54970FCD.dip0.t-ipconnect.de (EHLO [192.168.1.14]) [84.151.15.205]
  by mail.gmx.net (mp024) with SMTP; 12 Jun 2007 23:33:46 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX1+D7WkW4e2DbVIeqxewiJlR/kug9mncl2MkC3jqub
	S3WTKeWTKnELaN
User-Agent: KMail/1.9.7
In-Reply-To: <7vfy4xhu6p.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50001>

On Tuesday 12 June 2007, Junio C Hamano wrote:
> Johannes Sixt <J.Sixt@eudaptics.com> writes:

> > KDE (superproject)
> >  +- kdelibs (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir1
> >  |   +- ...
> >  +- kdebase (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir2
> >  |   +- ...
> >  +- kdenetwork (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir3
> >  |   +- ...
> >  ...
> 
> If these three instances of 'admin' are truly the same project
> created in multiple places in the directory hierarchy, what is
> the reason that it is not arranged like this instead?
> 
>     KDE
>      +- admin
>      +- kdelibs
>      |   +- subdir1
>      |   +- ...
>      +- kdebase
>      |   +- subdir2
>      |   +- ...
>      +- kdenetwork
>      |   +- subdir3
>      |   +- ...
>      ...

Actually, on the SVN server you have this structure.

KDE applications are put together in groups with
other applications of same kind, e.g. kdenetwork contains
applications for net access.

Now if you want to work on one KDE application e.g. in
kdenetwork, you usually checkout _only_ the kdenetwork
directory. There is no need to have other parts; e.g.
you usually should be able to use the KDE libs from
your distribution - no need to checkout kdelibs.

However, the "admin" directory above contains the build
environment, which has to be checked out so that kdenetwork
is able to build. The applications expect the build tools
to reside in the admin subdirectory.

To checkout admin inside KDE modules such as kdenetwork,
SVN externals are used, which is a primitive form of git
submodules, to automatically checkout the admin directory
on checkout of the KDE module.

So the same admin directory only will be duplicated
multiple times only on the developers side where multiple
KDE modules are checked out.

> When kdelibs/subdir1 needs to access stuff in admin, instead of
> going to ../admin, it could very well go to ../../admin couldn't
> it?

Usually, ../../admin will not exist as explicit checkout on
a developers machine. It would be possible to require this, but
it is much nicer to have each checkout of a KDE module
self-contained, including a copy of admin.

> It makes me wonder if the KDE's layout you quoted is a good
> practice we would want to recommend for other people to follow.
> If not, I doubt it is a good idea to model our important concept
> after that layout to begin with.

In the case of KDE, as far as I remember there is no need to
put _everything_ inside of a the mega supermodule. Every KDE
module (like kdelibs, kdebase, kdenetwork) has its own configure
run and checks dependencies.

What IMHO is an important use case for submodules is to have the
same submodule in multiple different superprojects, as the admin
example shows.

Josef

PS: Above admin example is from KDE3. KDE4 uses an
installed build environment (not really sure).
