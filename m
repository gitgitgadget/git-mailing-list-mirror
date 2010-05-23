From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via 'plackup'
Date: Sun, 23 May 2010 13:17:07 +0200
Message-ID: <201005231317.08599.jnareb@gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com> <201005222330.43532.jnareb@gmail.com> <20100523091812.GA3426@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 23 13:17:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG9Bf-0007pJ-3U
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 13:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0EWLRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 07:17:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58580 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0EWLRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 07:17:17 -0400
Received: by bwz7 with SMTP id 7so551612bwz.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bwQG+anFEXyXHG4P3818DMSIF4DwKDk14RAhPb1zv3w=;
        b=TmFzczCXM9tLfpkU9LEiSAZXGEd0uTm8FGOi0/p2xL93ezokpkW6kx2eXWfkPwhTUB
         9+f+6TY8r62aGND77R9H4mRPmLA0sZMCSdMXuZtfEYU9nRowk6p9Rj4eXMwyLe13NpGB
         p8ifBxKtnQNcvHGLzWdRkg/YCWQyCJgF5H898=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VFCxa25c8cpDX1QgFlhHWBlA55jhvJ+k49GPWPoEH/HgG0zGS2DHM/xiAE7fMzrong
         sQRtRu/IcVLqCixdy2IIx2pEMKf+wT1rhgLKaqR98jNQAZtLOC8GUDIzf2U1fyJUm1td
         LS5CmoP8iOnaWiZzA5UEDYMDQkgdqV25Ebbjs=
Received: by 10.204.141.78 with SMTP id l14mr1353332bku.85.1274613435733;
        Sun, 23 May 2010 04:17:15 -0700 (PDT)
Received: from [192.168.1.15] (abwr31.neoplus.adsl.tpnet.pl [83.8.241.31])
        by mx.google.com with ESMTPS id 24sm13831225bkr.6.2010.05.23.04.17.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 04:17:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100523091812.GA3426@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147573>

On Sun, 23 May 2010, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > On Thu, 20 May 2010, Jakub Narebski wrote:
> > 
> > > The configuration for 'plackup' is currently embedded in generated
> > > gitweb.psgi wrapper, instead of using httpd.conf ($conf).
> > 
> > A question: is this solution acceptable?  Or should the configuration
> > (port, address if git-instaweb was run with '--local', root) be in
> > a separate file.
> 
> Hi Jakub,
> 
> Yes, the psgi wrapper is acceptable and probably ideal.
> 
> My understanding is that the .psgi file is analogous to a .ru file in
> the (Ruby) Rack world[1], and having only a .ru file is probably how I
> would add Rack support to git-instaweb if WEBrick weren't in Ruby
> core[2].

Yes, .psgi file in the (Perl) PSGI/Plack world is, as I understand it,
analogous to .ru file in the (Ruby) Rack world.  PSGI/Plack was inspired
by WSGI from Python world and Rack from Ruby world.

There is no web server in Perl core, although probably HTTP::Server::Simple
and HTTP::Engine comes close.  Well, there is HTTP::Server::Brick inspired
by WEBrick...

Using PSGI/Plack (via wrapper around CGI) allows easily to serve
gitweb's static files (stylesheet, images, etc.), gives persistent
environment (although this probably doesn't matter much for
git-instaweb), and allows for easy switching between different
PSGI-capable (e.g. via PSGI handlers) web servers, including the default
standalone HTTP::Server::PSGI (aka Standalone), HTTP::Server::Simple,
preforking Starlet or Starman, currently via PLACK_SERVER environment
variable.

> > Webrick, which is in similar situation, uses httpd.conf config file in 
> > YAML.  Unfortunately there is no config / serialization reader in Perl
> > core, so if we have to go this route either the config file would have
> > to be in Perl, or gitweb.psgi wrapper would have to include some simple
> > config file parsing.
> 
> I don't think we need parsing in the gitweb.psgi wrapper, we'll just
> consider gitweb.psgi the config file.  

Well, if it is all right, I would keep it as it is now (rebased on top
of Pavan's work related to GSoC 2010).  If we would want to keep config
separate from wrapper (e.g. by installing wrappers in $(gitwebdir)
together with gitweb.cgi, but keeping config files in ~/.gitweb or
.git/gitweb), we can split it later.

> This is also the case for Rack .ru files, which can be made executable
> and have a shebang pointing to "rackup".

Well, generated gitweb.psgi wrapper could have e.g.

  #!/usr/bin/env plackup

or

  #!$PLACKUP

(after putting full path to 'plackup' in $PLACKUP) as a she-bang line
('plackup' is PSGI/Plack equivalent inspired by 'rackup')... if not for
the fact that (as I wrote earlier) different web servers supported by
'plackup' utility have different ways of configuring them.  The common
API is 'plackup' command line options.

However in most operating systems everything after the interpreter in
the she-bang line is passed as *single* option, so for example
generating first line of gitweb.psgi wrapper as

  #!/usr/bin/evn plackup --port=1234 --host=127.0.0.1

wouldn't work.  That is why I used Plack::Runner instead, the module
behind 'plackup'.

As a nice side effect now you don't need to have 'plackup' in $PATH; you
only need to have Plack::Runner in $PERL5LIB (or equivalent), but you
need to have other required modules there anyway.

> [1] - I'm not familiar with Plack/PSGI at all, but I've been dabbling
>       quite a bit in Rack over the past year or two.
> 
> [2] - of course since WEBrick is in Ruby core and WEBrick supports CGI
>       scripts out-of-the-box (unlike Rack), adding Rack support to
>       instaweb would be a waste of time.

-- 
Jakub Narebski
Poland
