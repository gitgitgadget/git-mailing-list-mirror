From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess,iffy] Re: "Integrated Web Client for git" GSoC
 proposal
Date: Sat, 17 Apr 2010 15:09:52 +1200
Message-ID: <1271473792.3506.30.camel@denix>
References: <201004130403.42179.chriscool@tuxfamily.org>
	 <201004150204.42813.jnareb@gmail.com> <1271293123.6248.147.camel@denix>
	 <201004161118.32163.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog9@eaglescrag.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 05:10:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2yQ6-00064B-Jm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 05:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712Ab0DQDKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 23:10:02 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47369 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758615Ab0DQDKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 23:10:01 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 7B71713E52A; Sat, 17 Apr 2010 15:09:59 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 7ADFD21C381;
	Sat, 17 Apr 2010 15:09:53 +1200 (NZST)
In-Reply-To: <201004161118.32163.jnareb@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145111>

On Fri, 2010-04-16 at 11:18 +0200, Jakub Narebski wrote: 
> > > gitweb was and is meant to be simple, easy to install git web interface
> > > (single script + some static files), with minimal dependencies outside
> > > Perl core, and running with as old Perl as feasible (good Unicode support
> > > is requirement that forces minimal Perl version).
> 
> By the way, is the above statement correct?  What should be the *goal*
> for gitweb?  Is it running on oldest Perl possible (which IIRC is Perl
> 5.8.6, because gitweb needs good Unicode support)?  Is it minimal 
> required non-core dependencies (core as of Perl 5.8.6)?  Is it being
> easy to install (single monolithic script + some minimal number of static
> files like CSS, JavaScript, images + perhaps extra files with optional
> features like output caching) by hand?  Is it being easy to configure
> by hand?
> 
> With local::lib it is easy to install Perl modules from CPAN locally
> (in home directory), so perhaps we could ease on minimal dependencies
> rule.  On the other hand gitweb is web app, and one would have to be
> able to configure web server to use locally installed Perl modules,
> which might be not possible; this swicthes the problem from "not being
> able to install Perl modules as non-root" to "not being able to install
> Perl modules that web server can use without help from sysadmin".

This is correct for XS modules, using DynaLoader to link in
arbitrary .so's may be restricted in a web server :).  But for pure Perl
modules it should be no problem.  Many modules have both XS and
Pure-Perl versions, for instance Template Toolkit has both and so is
suitable for this style of bundling.

> There exists very many web frameworks in Perl[1][2][3][4]: Catalyst
> (one of more popular, used by Gitalist), Jifty, CGI::Application (and
> its offshot Titanium), Mojolicus, Dancer, Squatting, Web::Simple,...
> 
> Nowadays many (all mentioned) of those web frameworks are either built
> on top of PSGI / Plack (Perl Superglue for Web Frameworks and Web Servers),
> or have PSGI / Plack adapter (see http://plackperl.org).  So another
> solution would be to use bare-bones Plack instead of CGI with help
> of CGI.pm, perhaps also using one of URI dispatchers[5][6].  Plack/PSGI
> looks like the future of Perl web scripting... but is currently quite new,
> at version 0.9930.

Ok so PSGI is the port of Python's WSGI to Perl.  Plack is the reference
implementation, and also quite heavy at 2.5MB tarball.

Titanium is an extension to CGI::Application and requires DBI for
instance.  That's probably not right.

Jifty, Mojolicious, will also have prohibitively difficult dependencies
for the run-anywhere case.

Squatting has a few XS dependencies, but perhaps they could be excised if
required.  Dancer however seems to stand out at only 94kB tarball, minimal
non-core dependencies and support for PSGI.  The HTTP::Server::Simple::PSGI
dependency should let it support the 'instaweb' case with pure perl.

> The trouble with splitting is installing split web script.  I have no
> idea how to do this in cross-webserver way, cross-distribution and
> cross-system way (the filesystem hierarchy used by web server may
> differ from distribution to distribution, and from operating system
> to operating system).

It should be possible for the script to figure out what filesystem path it
is being run from, perhaps find a local lib/ dir and then add that to @INC.
In shell scripts you just use FindBin, I don't know whether that is still
expected to work from eg mod_perl but there's bound to be a solution for
that.  So yeah I'd say just aim to ship lots of .pm files in a nearby dir
alongside the script...

Sam
