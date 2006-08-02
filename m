From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: require $ENV{'GITWEB_CONFIG'}
Date: Wed, 2 Aug 2006 16:50:33 -0400
Message-ID: <20060802205033.GB15678@sigio.intra.peff.net>
References: <20060802192333.GA30861@coredump.intra.peff.net> <E1G8NLU-0006TL-J7@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:50:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Nfr-0002G3-Ow
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWHBUuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWHBUuf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:50:35 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:58074 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751326AbWHBUue (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:50:34 -0400
Received: (qmail 32502 invoked from network); 2 Aug 2006 16:49:58 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 2 Aug 2006 16:49:58 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 16:50:33 -0400
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <E1G8NLU-0006TL-J7@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24682>

On Wed, Aug 02, 2006 at 10:29:36PM +0200, Matthias Lederhofer wrote:

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -63,6 +63,10 @@ our $mimetypes_file = undef;
>  our $GITWEB_CONFIG = '@@GITWEB_CONFIG@@';
>  require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
>  
> +if (defined($ENV{'GITWEB_CONFIG'}) && -e $ENV{'GITWEB_CONFIG'}) {
> +	require $ENV{'GITWEB_CONFIG'};
> +}
> +
>  # version of the core git binary
>  our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";

I think this patch is a good idea, but it seems confusing to have two
different config files. Maybe the environment should trump the built-in
default:
  our $GITWEB_CONFIG = $ENV{GITWEB_CONFIG} || '@@GITWEB_CONFIG@@';
Which actually might be a reasonable thing for all of the config
directives (so people can use a config file, apache environment munging,
or the built-in defaults). I would think the sanest order would be
environment, then config file, then built-ins (which is what all the
rest of the git programs do).

-Peff
