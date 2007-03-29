From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 11:44:24 +0400
Message-ID: <20070329074424.GD59098@codelabs.ru>
References: <7vmz20xuxq.fsf@assigned-by-dhcp.cox.net> <20070326100344.GV14837@codelabs.ru> <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net> <20070327065940.GC51155@codelabs.ru> <20070327102437.GM14837@codelabs.ru> <7vtzw7nej6.fsf@assigned-by-dhcp.cox.net> <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpJJ-00014R-Ub
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 09:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965971AbXC2Hoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 03:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965974AbXC2Hoj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 03:44:39 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:63896 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965971AbXC2Hoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 03:44:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=hv0oRsl5XtTk9GnpooH9ytGJE/FzyEmeLjlHQ/x6zFQXl2IEc5OFIZ8dRanL+K9vNM/NLqD8eqT0R+FpXeKaVXd3noLU42DVcFZG+0quZgBxmxLPl6bMTEQCc8A9E+Sfx1g9WIb/g+MTQer91KRjBKyk+UxFBUW3/j+j/8QtDg4=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWpJ7-000Dl6-Hf; Thu, 29 Mar 2007 11:44:30 +0400
Content-Disposition: inline
In-Reply-To: <7vps6tf8te.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-3.2 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43407>

Junio, good day.

Wed, Mar 28, 2007 at 12:48:45PM -0700, Junio C Hamano wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> 
> > --with-tcltk enables the search of the Tcl/Tk interpreter. If no
> > interpreter is found then Tcl/Tk dependend parts are disabled.
> >
> > --without-tcltk unconditionally disables Tcl/Tk dependent parts.
> >
> > The original behaviour is not changed: bare './configure' just
> > installs the Tcl/Tk part doing no checks for the interpreter.
> >
> > Makefile knob named NO_TCLTK was introduced. It prevents the build
> > and installation of the Tcl/Tk dependent parts.
> >
> > Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
> > ---
> 
> Thanks.
> 
> Is this supposed to be the first in the series?  I thought you
> said you were going to do NO_TCLTK without anything else at all
> first, and then TCLTK_PATH patch.  I am a bit lost here.
>
> > +# Define NO_TCLTK if you do not want Tcl/Tk GUI.
> > +#
> > +# The TCLTK_PATH variable governs the location of the Tck/Tk interpreter.
> > +# If not set it defaults to the bare 'wish'. If it is set to the empty
> > +# string then NO_TCLTK will be forced (this is used by configure script).
> > +#
> 
> Grumble.  If you are doing this, then there is not much point to
> have two separate patches, is it?

I cheated, sorry: first patch prepared the configure's infrastructure
for the --with-tcltk/--without-tcltk including --with-tcltk=PATH.

And the second one introduced the TCLTK_PATH usage for substituting
the 'wish' in the Tcl/Tk tools.

Sorry for the confusion.

> 
> > @@ -684,7 +696,9 @@ ifneq (,$X)
> >  endif
> >  
> >  all::
> > +ifndef NO_TCLTK
> >  	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
> > +endif
> >  	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
> >  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
> 
> Although you were not supposed to be talking about paths, since
> you've already introduced TCLTK_PATH, it should be passed down
> to git-gui here, I think.

Yes, you're perfectly right.

> 
> > @@ -955,11 +974,17 @@ dist: git.spec git-archive
> >  	@mkdir -p $(GIT_TARNAME)
> >  	@cp git.spec $(GIT_TARNAME)
> >  	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
> > +ifndef NO_TCLTK
> >  	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
> >  	$(TAR) rf $(GIT_TARNAME).tar \
> >  		$(GIT_TARNAME)/git.spec \
> >  		$(GIT_TARNAME)/version \
> >  		$(GIT_TARNAME)/git-gui/version
> > +else
> > +	$(TAR) rf $(GIT_TARNAME).tar \
> > +		$(GIT_TARNAME)/git.spec \
> > +		$(GIT_TARNAME)/version
> > +endif
> >  	@rm -rf $(GIT_TARNAME)
> >  	gzip -f -9 $(GIT_TARNAME).tar
> >  
> 
> Why should a source distribution exclude git-gui/ directory?  I
> think it is sensible to ship a source that contains all.  You
> are shipping gitk even without NO_TCLTK anyway, too.

Oops: didn't noticed that it is the tarball construction.

> And from the part 2:
> 
> > @@ -705,6 +709,12 @@ endif
> >  strip: $(PROGRAMS) git$X
> >  	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
> >  
> > +gitk-wish: gitk GIT-GUI-VARS
> > +	$(QUIET_GEN)rm -f $@ $@+ && \
> > +	sed -e'1,3s|^exec .* "$$0"|exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' < gitk > $@+ && \
> > +	chmod +x $@+ && \
> > +	mv -f $@+ $@
> > +
> 
> This subst() is a nice attention to the detail.  I like it,
> although in practice I do not think anybody is insane enough to
> have a pipe character in the directory name that leads to wish.

Thanks! And for the sanity: I do not think that the single quote
in the path it sane too. But as I was teached, "if we should
quote something, we must quote it". ;))

> 
> I separated your two patches into three with minor modifications
> and parked them in 'pu'.  We need to arrange with Shawn when to
> apply the git-gui/ parts of the patch to his tree, but we are
> not in a rush.

Thank you. Examined the 'origin/pu' and saw that you're already
incorporated the git.spec.in patch. I've found a glitch in it:
the right PYTHON_PATH should be passed. The patch follows.

By the way, when I was creating the git.spec from the git.spec.in,
I had the 'Version' field equal to the '1.5.1-rc1.GIT' and RPM
does not like the '-' characters inside the versions. Did
'tr - _' for specfile version and tarball name. The patch
follows.
-- 
Eygene
