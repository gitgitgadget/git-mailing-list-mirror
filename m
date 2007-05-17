From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-gui: Build even if tclsh is not available
Date: Thu, 17 May 2007 04:36:14 +0200
Message-ID: <20070517023614.GL4489@pasky.or.cz>
References: <20070517020616.4722.33946.stgit@rover> <20070517021448.24022.8282.stgit@rover> <20070517021858.GY3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 17 04:36:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVqt-0004j4-P4
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbXEQCgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbXEQCgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:36:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50968 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755219AbXEQCgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:36:16 -0400
Received: (qmail 26430 invoked by uid 2001); 17 May 2007 04:36:14 +0200
Content-Disposition: inline
In-Reply-To: <20070517021858.GY3141@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47489>

On Thu, May 17, 2007 at 04:18:58AM CEST, Shawn O. Pearce wrote:
> I have a couple of problems with the patch as-is.  The first is
> of course that the patch needs to be split into two; one patch for
> the git-gui subdirectory itself and one for git.git.

Hmm, why? It's an atomic change, one part doesn't make sense without the
other.

> My other problem is 
> 
> >  ifeq ($(findstring $(MAKEFLAGS),s),s)
> > @@ -92,7 +92,7 @@ install: all
> >  	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> >  	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
> >  	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
> > -	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
> > +	[ ! -e lib/tclIndex ] || $(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
> >  	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
> 
> git-gui won't work if lib/tclIndex is missing or invalid.  So not
> installing it means we should just disable git-gui entirely.

Aha, ouch - I understood that it is only an optimization. :-(

So AIUI, there are several possibilities:

  (i) Makefile will autodecide on whether git-gui will be
built+installed or not

  (ii) ./configure will, people not using configure and building on
servers will be left to tweak config manually

  (iii) ./configure will, git-gui will default to not to be built and
people not using configure and wanting git-gui will be left to tweak
config manually

I suspect that (ii) will be chosen, and even though I don't like it
*personally* I guess it's the most reasonable approach for the general
public. I didn't know that tclIndex is vital for git-gui when I
submitted the patch, the /Makefile comment suggests otherwise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
