From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH v2 1/2] perl: redirect stderr to /dev/null instead of
 closing
Date: Fri, 5 Apr 2013 16:48:28 +0200
Message-ID: <20130405144828.GX6137@machine.or.cz>
References: <20130404011653.GA28492@dcvr.yhbt.net>
 <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Marcin Owsiany <marcin@owsiany.pl>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWJ3-0002u6-4l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161859Ab3DEOse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 10:48:34 -0400
Received: from pasky.or.cz ([84.242.80.195]:60785 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161785Ab3DEOse (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 10:48:34 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6B74B1700058; Fri,  5 Apr 2013 16:48:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <801ebb2a75d7cddfeee70eb86e8854c78d22eb3e.1365107899.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220202>

  Hi!

On Thu, Apr 04, 2013 at 10:41:41PM +0200, Thomas Rast wrote:
> As pointed out by Eric Wong (thanks), the initial close needs to go:
> die() would again write nowhere if we close STDERR beforehand.
> 
> > Perhaps we should also do the following:
> >
> > --- a/perl/Git.pm
> > +++ b/perl/Git.pm
> > @@ -1489,9 +1489,6 @@ sub _command_common_pipe {
> >  		if (not defined $pid) {
> >  			throw Error::Simple("open failed: $!");
> >  		} elsif ($pid == 0) {
> > -			if (defined $opts{STDERR}) {
> > -				close STDERR;
> > -			}
> >  			if ($opts{STDERR}) {
> >  				open (STDERR, '>&', $opts{STDERR})
> >					or die "dup failed: $!";
> 
> Indeed.  Thanks for pointing that out.

  I'm sorry, I don't follow. Doesn't this just break the STDERR option
altogether as we will try to dup2() over an already open file
descriptor? We do need to close STDERR if we are going to reopen it,
I think.

  Kind regards,

				Petr "Pasky" Baudis
