From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] wincred: add install target and avoid overwriting
	configured variables
Date: Wed, 30 Apr 2014 13:27:24 +0200
Organization: <)><
Message-ID: <20140430112724.GA22929@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 13:27:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSfi-0006RD-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693AbaD3L11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:27:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37940 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbaD3L10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:27:26 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 567801C00F3;
	Wed, 30 Apr 2014 13:27:25 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UBRPhl023035;
	Wed, 30 Apr 2014 13:27:25 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UBROdb023034;
	Wed, 30 Apr 2014 13:27:24 +0200
Content-Disposition: inline
In-Reply-To: <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247705>

Hello,

> On Wed, Apr 30, 2014 at 8:46 AM, Stepan Kasal <kasal@ucw.cz> wrote:
> > Date: Wed, 24 Oct 2012 00:15:29 +0100
> >
> > Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> > Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> > ---
> > Another one from msysGit project.
> > Original subject by Pat; I would suggest:
> >     wincred: improve Makefile

On Wed, Apr 30, 2014 at 11:21:17AM +0200, Erik Faye-Lund wrote:
> I'm a little bit unsure about this, because the makefile was basically
> just copied from contrib/credential/osxkeychain/Makefile (which was
> the first credential helper) and tweaked slightly.
> 
> So, what makes wincred special compared to gnome-keyring, netrc and
> osxkeychain wrt installation? Shouldn't all helpers get the same
> treatment?

I can only guess that the hardwired CC and CFLAGS values can cause
problems.
It is probably much sane on Windows to use the compiler that the user
set up for the build.

I'm not sure if users of, say, OS X, have the same problems, so I
would hesitate to apply these changes to all helpers.

> > From: Pat Thoyts <patthoyts@users.sourceforge.net>
> >  contrib/credential/wincred/Makefile | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
> > index bad45ca..3ce6aba 100644
> > --- a/contrib/credential/wincred/Makefile
> > +++ b/contrib/credential/wincred/Makefile
> > @@ -1,14 +1,20 @@
> > -all: git-credential-wincred.exe
> > -
> > -CC = gcc
> > -RM = rm -f
> > -CFLAGS = -O2 -Wall
> > -
> >  -include ../../../config.mak.autogen
> >  -include ../../../config.mak
> >
> > -git-credential-wincred.exe : git-credential-wincred.c
> > +prefix ?= /usr/local
> > +libexecdir ?= $(prefix)/libexec/git-core
> > +
> > +INSTALL ?= install
> > +
> > +GIT_CREDENTIAL_WINCRED := git-credential-wincred.exe
> 
> Why this variable? IMO, it's just as "GIT_CREDENTIAL_WINCRED" easy to
> miss-spell as "git-credential-wincred.exe", and it doesn't seem to be
> possible to overload.

If you mis-spell a variable name, nothing is build.  If you misspell
a binary name, that binary may get compiled using a default rule;
that is why I would generally prefer variables.
Moreover, if the cardinality of the set ever increases, the
indirection may get helpful.
No big deal.

> > +
> > +all: $(GIT_CREDENTIAL_WINCRED)
> > +
> 
> Also, why move the all-target down from the top? Is it simply because
> of the definition above?

Again, I agree with Pat that it is nicer this way, but no big
deal.

Stepan Kasal
