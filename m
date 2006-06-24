From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 15:02:34 +0200
Message-ID: <20060624130234.GT21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net> <7vu06bymtr.fsf@assigned-by-dhcp.cox.net> <20060624111657.GR21864@pasky.or.cz> <7vac82wytw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 15:02:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7mb-0006gR-EB
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 15:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFXNCg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 09:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFXNCg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 09:02:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2191 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750760AbWFXNCg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 09:02:36 -0400
Received: (qmail 32184 invoked by uid 2001); 24 Jun 2006 15:02:34 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac82wytw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22515>

Dear diary, on Sat, Jun 24, 2006 at 01:57:31PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > (This is also why I was a bit confused by your make test patch - it does
> > not "fix" anything per se since no tests directly use Git.pm.)
> 
> You are right.
> 
> You do not want to be testing installed version, but the one
> freshly built, so the patch does not have any effect, except for
> one case: testing before installing Git.pm for the first time
> anywhere yet.  -I prepends the directory to the search path, so
> we are not testing the freshly built copy at all.
> 
> Is there a way from the environment to override this behaviour,
> so that we can run the tests properly?  I think PERL5LIB and
> PERLLIB are defeated by having -I there (that's why I said I
> liked what Fredrik did with his Python script, which appends the
> final installed location to the search path).  I think unshift
> into @INC by hand (i.e. without even using use lib "$path")
> would do what we want, but I feel that is a bit too ugly just 
> for the testing X-<.

PERL5LIB and use lib at the same time works for me. Anyway, with the
second patch I've sent things should work well even if you don't have
Git.pm installed anywhere yet.

> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index 54e8b20..92c140d 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -3,7 +3,7 @@ use ExtUtils::MakeMaker;
>  sub MY::postamble {
>  	return <<'MAKE_FRAG';
>  instlibdir:
> -	@echo $(INSTALLSITELIB)
> +	@echo $(INSTALLSITEARCH)
>  
>  MAKE_FRAG
>  }

Oh, yes; that line came from the time when we had no .xs yet. It is not
visible here since both arch-specific and non-arch-specific libraries
get installed to ~/lib.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
