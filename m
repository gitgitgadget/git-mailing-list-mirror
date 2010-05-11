From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Tue, 11 May 2010 15:51:15 +0200
Message-ID: <201005111551.21316.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005111258.53388.jnareb@gmail.com> <20100511120924.GC5220@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Tue May 11 15:51:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBpsE-0004FU-38
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 15:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757533Ab0EKNvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 09:51:43 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:22514 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab0EKNvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 09:51:41 -0400
Received: by ey-out-2122.google.com with SMTP id d26so332209eyd.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SOsRcr2Hm+HPoPIIKxA/ZkfyJTrIgnbA2rSxzMVg8G4=;
        b=uaaw/X0avm5tkpzsh5aN4qj0Z36lCQRhAvpnAK0jAdKzU45PDi79dnLRhXH3GIl59c
         U2VB8aQwvUZX0+qLEIYfNRMGmBNkQouAlJ/RBn5b75tNOnS9GZxeZu4zo9vrXTJmiiSw
         28n1I3Lka2oaoH9bVwsZFkhZI4SgMqO5e5az4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ax5ESIcis4xFbPffYwFkELICyBZtrxfKgTT6ThIBvx5qQRHTnD2U7yHr78SBX16m7F
         u+ccMoLBGMQ5ez9aynjfQmu+mrAa+Sr0KGi1hQ7cdZF7Mgahb7Nekzgs3Vy00y7XtYhJ
         z6JiuZJIRxQ6IQzN7vOXInl7qRDhasQcJsav8=
Received: by 10.102.17.22 with SMTP id 22mr3374822muq.37.1273585899724;
        Tue, 11 May 2010 06:51:39 -0700 (PDT)
Received: from [192.168.1.13] (abwc23.neoplus.adsl.tpnet.pl [83.8.226.23])
        by mx.google.com with ESMTPS id e9sm24947681muf.10.2010.05.11.06.51.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 06:51:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100511120924.GC5220@screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146894>

On Tue, 11 May 2010, Peter Vereshagin wrote:
> 2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

> > > > I have changed this 'exit' to non-local goto to toplevel.  It could be
> > > > done instead by redefining 'exit' subroutine, like shown below, but I
> > > > feel that would be hacky if you can change gitweb code (it is not
> > > > black box you should not touch).
> > > 
> > > Right, one shouldn't ever redefine perl built-in functions. I did only because
> > > of no other way to 'get things working'
> > 
> > Why not?  For example CGI::Carp redefines 'die' to log errors.
> 
> Ouch, sorry, I meant 'last' or something like that.

"last" / "last LABEL" is a command, not a function, therefore you cannot
redefine it.

Well, perhaps you can with heavy hackery involving opcodes and the like,
or something debugger-like, or/and something like B::* modules, taking
over Perl parser.  See e.g. Devel::Declare or Template::Declare Perl
modules on CPAN. :-)

> I just believe any non-system application development for end-user being a
> non-developer doesn't need to redefine perl built-in functions. Just a sane
> bone tone for common functioning in a sandbox.
>
> For example, I remember the Linux kernel  ( or Glibc? ) was criticised much of
> being possible to override the str*cmp() inside. Because most of the existing
> commerceware were protected from copying by password, e. g. serial number, etc.
> sometimes by authors. So criticants supposed it's impossible to 'protect' their
> software this way. And thus Linux was 'bad'. ;-)

What about libsafe (?) and similar security solutions, which replace
str* functions from (g)libc with safer but slower counterparts?  What
about Dmalloc, Electric Fence and the like which replace malloc etc.?

> So one who use CORE:: namespace in their sources should always know it can be
> grepped and considered as dangerous, especially if those are 3rd+ party
> sources, not approved by any reasonable authority, and there are lots of such a
> software off the shelves to choose. And most of them doesn't use to override
> perl built-in functions. ;-)

It is true that messing with / overriding things from CORE:: (or
UNIVERSAL:: for OOP) namespace is dangerous, and should be avoided if
possible... but well, sometimes it is a best solution.
 
> > I know this from painful experience of trying to find bug in a
> > test... when the error was in parsing file in 'do $file;'.
> 
> I handle them just fine like in any other CGI program using
> CGI::Carp:fatalsToBrowser. Are you about to 'make test' via the http? ;-)

I don't think you understand what I wanted to say there.

If you don't check if there were parse errors from 'do $file;', you can
get later some error message which is totally unrelated to the parsing
error.  If you don't know or forget that you should check $@ after 
'do $file;', and are unlucky, you can chase elusive error from there
to kingdom come...

For example when debugging gitweb output caching code using automated
tests, I got the following error:

  'Undefined subroutine &GitwebCache::SimpleFileCache::compute called'

The subroutine was defined, but there was a bug in parsing included
file, so Perl didn't make it to definition of said compute() subroutine.

> [...]
> 
> >   builder {
> >         $app;
> >   }
> 
> that's the wow to try. I will after some of my whiles.

Check out http://plackperl.org, especially presentations and Perl Advent
Calendar which describes PSGI/Plack step by step (links at the bottom of
the page).
 
> > or even without it ($app should be the last expression).
> > Or did you mean here something like mod_rewrite, or
> > Plack::Middleware::Rewrite?
> 
> No, nginx rewrites just fine, it's a matter of another application level I
> believe.
>
> The scoop is meat and potatoes: here is the CGI app, just do it over FastCGI.
> There are no such a thing as a mandatory mounts and paths tweaks in PHP's
> FastCGI. Hope PSGI has no them either.

PSGI is interface, Plack is reference implementation.  You can run PSGI
app on any supported web server; this includes running PSGI apps on
FastCGI.

> > > > Gitweb doesn't use no POST requests: it is read-only web repository
> > > > browser... well, except for the 'show_ctags' action.
> > >
> > > Tag cloud? Is there an example of usable tag cloud on any public gitweb out
> > > there?
> > 
> > Tag cloud are optional feature in stock gitweb, named 'ctag' in %feature
> > hash.  It is disabled by default.  If I understand correctly POST is
> > used here to populate which tags one wants to use... but perhaps GET
> > request would be enough here (at the cost of less readable URL).
> > 
> > See http://repo.or.cz for example usage of this feature.
> 
> Ouch, it was the first for me to look for them. It's just not named like that
> there ( and looked like linkspam ;-. Anyway. user registration .cgi is a part
> of gitweb distribution? It contains POST form and it's not  preferable stuff to
> omit for too many cases to consider such a gitweb-based web site to be 'mostly
> read-only' for a user.
>
> Or those .cgi's are nothing in common with gitweb?

The repository management part of http://repo.or.cz is not part of
gitweb.  It is a separate tool, named Girocco.

-- 
Jakub Narebski
Poland
