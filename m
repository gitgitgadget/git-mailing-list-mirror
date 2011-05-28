From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] Embed an application manifest on MinGW
Date: Sat, 28 May 2011 23:19:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105282311220.11411@bonsai2>
References: <1306612707-29748-1-git-send-email-cesarb@cesarb.net> <alpine.DEB.1.00.1105282241510.11411@bonsai2> <4DE16418.4020002@cesarb.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Sat May 28 23:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQQup-0004HH-2J
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 23:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab1E1VTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 17:19:11 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:39655 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752730Ab1E1VTK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 17:19:10 -0400
Received: (qmail invoked by alias); 28 May 2011 21:19:08 -0000
Received: from pD9EB207C.dip0.t-ipconnect.de (EHLO noname) [217.235.32.124]
  by mail.gmx.net (mp054) with SMTP; 28 May 2011 23:19:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1979DhBG6Z7cIZZsiqxMx+qz5A9vkr7IK9ezOTLKg
	O0J5/+cOIonclF
X-X-Sender: gene099@bonsai2
In-Reply-To: <4DE16418.4020002@cesarb.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174679>

Hi,

On Sat, 28 May 2011, Cesar Eduardo Barros wrote:

> Em 28-05-2011 17:44, Johannes Schindelin escreveu:
> > On Sat, 28 May 2011, Cesar Eduardo Barros wrote:
> > > [...]
> > > @@ -1551,6 +1554,11 @@ ifdef USE_NED_ALLOCATOR
> > >          COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
> > >   endif
> > >
> > > +ifdef APPLICATION_MANIFEST
> > > +	# Cannot be in LIB_OBJS because it must always be linked in
> > > +	RESOURCE_OBJS += compat/win32/resource.o
> > > +endif
> > > +
> > >   ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
> > >   	export GIT_TEST_CMP_USE_COPIED_CONTEXT
> > >   endif
> > > [...]
> > >
> > > -git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
> > > +git$X: git.o $(BUILTIN_OBJS) $(RESOURCE_OBJS) $(GITLIBS)
> > > [...]
> > >
> > > -git-%$X: %.o $(GITLIBS)
> > > +git-%$X: %.o $(RESOURCE_OBJS) $(GITLIBS)
> > > [...]
> >
> > Is it possible that adding the resource object to GITLIBS would reduce 
> > the patch and be "more correct", too?
> 
> I thought about it, but it felt wrong. It is not a library, it is an 
> object.

Well, a library is a collection of objects. A .a file traditionally 
contains also .o files that define both global and local variables.

Even so, let's assume for a moment that you're right and a library is a 
library of functions (which I assume that you assume), and let's ignore 
for a moment that GITLIBS provides non-functions such as inside_git_dir 
and auto_crlf. Then the approach of adding another $(RESOURCE) in exactly 
all the places where we have $(GITLIBS) is so redundant that it asks for 
future inconsistencies (somebody _will_ forget, because things still 
compile). In that case, one patch to rename GITLIBS to, say, 
COMMON_OBJECTS, and another patch to add the manifest to the common 
objects.

But as I said, IMHO GITLIBS is aptly named and should take the resource, 
too.

> Also, while adding it to GITLIBS would add the object to all the right 
> rules (in fact, I did a search for GITLIBS to find all the places to add 
> the new object to), I believe it would get the object linked twice in 
> some of the rules (the ones which do a $(filter %.o,$^) would get it 
> both from GITLIBS via the filter and from GITLIBS via $(LIBS) on the 
> command line).

Does it result in a link error? If not, it's not an issue.

Ciao,
Johannes
