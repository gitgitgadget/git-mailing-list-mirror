From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v7 4/9] gitweb: Prepare for splitting gitweb
Date: Sun, 26 Dec 2010 23:54:16 +0100
Message-ID: <201012262354.16955.jnareb@gmail.com>
References: <20101222234843.7998.87068.stgit@localhost.localdomain> <20101222235618.7998.17447.stgit@localhost.localdomain> <20101224092932.GA31537@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 23:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWzUE-0005Dd-Cy
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 23:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab0LZWy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 17:54:28 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39197 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0LZWy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 17:54:27 -0500
Received: by fxm20 with SMTP id 20so8813778fxm.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 14:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=u0lMap2YflRrjVIWmh8uX85649QqXtWIYFS+C580z8M=;
        b=wQL0HhLPsKI3F/vvWE5GT71n/k3I57f2ni8LZ+sRO68drQg9nyRQ/hFgg885yfMfIh
         X1qQM/Z8ZtCcWbvHlq113fYfOuYUAebX84fK+mYTV+zX8Wjr6OFlbX49hXGyCsSiyhcY
         gKHI6VWWXVZklahoKztRbMhf5rk1pJ/gjIRc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kfwV8GGyDvtNuJCa1OOh4tRt2dqA22Z3VKXi+xyaxd7MhpU6YfxLr0SIsNMcutCkMs
         wptVDpRSiO5OcRxnKJUHR0+cxtspq7n+paTAT65vNUK49R9amm0brRRpq2OVIsNy+P3+
         bWZ45xQf61Utkti4G3dXVR26a3TUClKc5cyI8=
Received: by 10.223.87.7 with SMTP id u7mr2615976fal.24.1293404065755;
        Sun, 26 Dec 2010 14:54:25 -0800 (PST)
Received: from [192.168.1.13] (abwr69.neoplus.adsl.tpnet.pl [83.8.241.69])
        by mx.google.com with ESMTPS id e6sm2849262fav.8.2010.12.26.14.54.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 14:54:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101224092932.GA31537@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164203>

On Fri, 24 Dec 2010 10:29, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > Prepare gitweb for having been split into modules that are to be
> > installed alongside gitweb in 'lib/' subdirectory, by adding
> > 
> >   use lib __DIR__.'/lib';
> > 
> > to gitweb.perl (to main gitweb script), and preparing for putting
> > modules (relative path) in $(GITWEB_MODULES) in gitweb/Makefile.
> 
> Spelled out, this means modules would typically go in
> 
> 	/usr/share/gitweb/lib

Yes, it's true.  It is mainly to support situation where one can install
files in (subdirectory of) cgi-bin, but nowehere else.  That is why the
default is to install modules alongside with gitweb.

The additional advantage is that t/gitweb-lib.sh used by gitweb tests
can very simply test source version of gitweb, with gitweb finding
source version of modules.  But it is not a very large obstacle to
change this.
 
> Is that the right place?  I suspect something like
> 
> 	/usr/lib/gitweb/
> 
> could make sense in some installations for two reasons:
> 
>  - even braindamaged webserver configurations would not serve lib/
>    as static files in that case;

Actually it doesn't matter what web server does with those files when
accessed directly, except for the client (user) confusion if he/she
goes where not invited.  Modules are used by Perl (by gitweb), not by
web server.

> 
>  - if some modules are implemented in C for speed, they would need
>    to go in /usr/lib anyway to follow usual filesystem conventions.

Ugh, XS!  I sincerely hope that when there would be decision to implement
some features in C for speed, we would be able to use Perl version of
ctypes for C-to-Perl interface, not XS.

Anyway most probable to be implemented in C would be Git.pm, or rather
Perl interface to libgit2.  It is probable that at some point gitweb
would be converted to use Git.pm or its successor.  But I guess that
Git Perl module would be installed somewhere in PERL5LIB, so it would
be found even without  "use lib __DIR__ . '/lib';"  or its replacement.

> Does the Makefile let us override the directory with such a setting?
> 

I have thought that I did provide 'gitweblibdir' as configurable knob,
but I see that in the version I have send I don't do this:

  # Shell quote;
  bindir_SQ = $(subst ','\'',$(bindir))#'
  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
  gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
  gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'

But if we are to allow custom gitweblibdir, we would have to change the
way gitweb is to find its modules.  One solution would be inetad of
current

  # __DIR__ is taken from Dir::Self __DIR__ fragment
  sub __DIR__ () {
  	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
  }
  use lib __DIR__ . '/lib';

use simply

  use lib $ENV{GITWEBLIBDIR} || "++GITWEBLIBDIR++";

Of course both gitweb/Makefile and t/gitweb-lib.sh would have to be 
updated: gitweb/Makefile to include replacement rule for '++GITWEBLIBDIR++'
in GITWEB_REPLACE, and t/gitweb-lib.sh to declare and export GITWEBLIBDIR
environmental variable so that gitweb/gitweb.perl would be able to find
its modules when used for gitweb tests (see comment earlier).

> > While at it pass GITWEBLIBDIR in addition to GITWEB_TEST_INSTALLED to
> > allow testing installed version of gitweb and installed version of
> > modules (for future tests which would check individual (sub)modules).
> > 
> > Using __DIR__ from Dir::Self module (not in core, that's why currently
> > gitweb includes excerpt of code from Dir::Self defining __DIR__) was
> > chosen over using FindBin-based solution (in core since perl 5.00307,
> > while gitweb itself requires at least perl 5.8.0) because FindBin uses
> > BEGIN block
> 
> This explanation and the code below leave me nervous that the answer
> might be "no". ;-)

No it doesn't, but yes it could (see above).

> [...]
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -10,6 +10,14 @@
> >  use 5.008;
> >  use strict;
> >  use warnings;
> > +
> > +use File::Spec;
> > +# __DIR__ is taken from Dir::Self __DIR__ fragment
> > +sub __DIR__ () {
> > +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
> > +}
> > +use lib __DIR__ . '/lib';
> > +
> >  use CGI qw(:standard :escapeHTML -nosticky);
> >  use CGI::Util qw(unescape);
> >  use CGI::Carp qw(fatalsToBrowser);


-- 
Jakub Narebski
Poland
