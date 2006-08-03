From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Thu, 3 Aug 2006 12:24:27 -0400
Message-ID: <20060803162427.GA4215@coredump.intra.peff.net>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com> <20060803065852.GH16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 03 18:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fzt-0000hd-E2
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 18:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHCQYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 12:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHCQYa
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 12:24:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:53704 "HELO
	peff.net") by vger.kernel.org with SMTP id S932578AbWHCQYa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 12:24:30 -0400
Received: (qmail 24402 invoked from network); 3 Aug 2006 12:23:53 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Aug 2006 12:23:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  3 Aug 2006 12:24:27 -0400
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20060803065852.GH16364@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24739>

On Thu, Aug 03, 2006 at 08:58:52AM +0200, Martin Waitz wrote:

> we could make the default use %ENV.
> 
> Something like (in Makefile):
> 
> GITWEB_SITENAME = $$ENV{GITWEB_SITENAME}
> GITWEB_PROJECTROOT = $$ENV{GITWEB_SITENAME} || "/pub/git"

An interesting idea, but it means that gitweb.perl no longer parses as
valid perl, since we have things like:

> our $projectroot = @@GITWEB_PROJECTROOT@@;

Do the environment variable names really need to be configurable, or
would something like this work:
  1. accept from config file if it exists and defines $projectroot
  2. otherwise, accept from environment if GITWEB_PROJECTROOT is defined
  3. otherwise, default to compile-time value

Speaking of which, perhaps we should clean up the names of variables
that are used by the config file now, before they get into widespread
use. The names are very inconsistent (e.g., projectroot, git_temp) and
undocumented. We could standardize on something like
$GITWEB_PROJECTROOT, matched to GITWEB_PROJECTROOT in the environment
and GITWEB_PROJECTROOT in the Makefile.

-Peff
