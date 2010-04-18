From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Sun, 18 Apr 2010 21:56:23 +0200
Message-ID: <20100418195623.GA3563@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004180324.54722.jnareb@gmail.com>
 <20100418021223.GP10939@machine.or.cz>
 <201004181950.19610.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 21:56:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3abe-0008O7-5R
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab0DRT4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 15:56:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36767 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab0DRT41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 15:56:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 69A63125A0EA; Sun, 18 Apr 2010 21:56:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004181950.19610.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145241>

On Sun, Apr 18, 2010 at 07:50:17PM +0200, Jakub Narebski wrote:
> So it is intended, I guess, more like git-instaweb or webmin, not like
> administrative parts of Girocco (or repo.or.cz), GitHub, Gitorious or
> InDefero.  Probably authentication and authorization would not be needed
> then, if it is to be run as web interface but locally...

If the project is a success, I wanted to use it for mob branch editing
on repo.or.cz. It could also be used as open-source Gist alternative.
But it needs to be coded so that it does not require an actual checked
out copy (which shouldn't be too much hassle).

> >> Well, you can always add some of "Web Client" functionality directly
> >> to gitweb (for example dispatch must be, I think, in gitweb).
> > 
> > But I don't think you can reasonably separate a major portion of web
> > client that would not depend on gitweb functions like href(), format*()
> > etc. all over the map.
> 
> Well, there is also copy'n'paste of code as a last resort.  

I would prefer the do. :-)

> >> Or you
> >> can (ab)use "do $gitwebgui_pm;" instead of "require $gitwebgui_pm;",
> >> like in http://repo.or.cz/w/git/jnareb-git.git/commitdiff/261b99e3#patch3
> >> (second chunk).
> > 
> > This already occured to me, yes. It's tempting to have this as the
> > emergency way out, shall other things fail. But .
>                                               ^^^^^^^^^^-- ???
> But what?
> 
> Yes, it is not as elegant as "require", and you have to catch errors
> in "do"-ed file yourself (as described at the end of `perldoc -f do`).

Oops, sorry. I meant that it should be really only last result if we try
to split things and for some reason it keeps not working out.

> Currently to install gitweb you have to copy *one* script, and a few
> static files (2 x image, CSS, JavaScript).  You can configure it using
> "make gitweb" with appropriate options, you can simply edit gitweb script,
> or you can leave this to the gitweb config file.

I don't really think things can get *any* more complicated than "also
copy over this directory recursively", do they?

> Also there is a question _how_ to split gitweb into modules, 
> e.g. whether to follow SVN::Web example on how gitweb (Git::Web?) should
> be split.  But I guess any splitting would suffice; we need to provide
> a way to build and install split gitweb.  
> 
> Split can be as simple as:
> 
>   Makefile, or Makefile.PL, or Build.PL
>   gitweb.perl
>   static/git-logo.png
>   static/git-favicon.png
>   static/gitweb.css
>   static/gitweb.js
>   lib/Gitweb/Utils.pm   (Gitweb::Utils)
>   lib/Gitweb/Editor.pm  (Gitweb::Editor, for GSoC2010, if it gets accepted)

Exactly! I think we can do this reasonably incrementally; if something
is not working out, we can move it again later. Let's not overengineer
stuff. I think it would make sense to just split out something like
Gitweb::Git (for Git invocations), Gitweb::CGI (for CGI parsing and
HTML output toolkit) and perhaps Gitweb::Util for misc. stuff. Then,
if we feel like it, maybe we can start splitting out things more, like
Gitweb::CGI::Blame, but I don't think that's even neccessary for now.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
