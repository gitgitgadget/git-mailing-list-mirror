From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] Check for help invocation before setup
Date: Wed, 19 Nov 2008 19:39:02 +0100
Message-ID: <20081119183902.GX10491@machine.or.cz>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org> <20081119182436.GB10544@machine.or.cz> <20081119183234.GA19781@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:40:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2ryh-0005Rd-FC
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 19:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbYKSSjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 13:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbYKSSjI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:39:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47095 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbYKSSjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 13:39:07 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 73E92393984E; Wed, 19 Nov 2008 19:39:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119183234.GA19781@piper.oerlikon.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101368>

On Wed, Nov 19, 2008 at 07:32:34PM +0100, martin f krafft wrote:
> also sprach Petr Baudis <pasky@suse.cz> [2008.11.19.1924 +0100]:
> > > +args_saved="$@"
> > > +while [ -n "$1" ]; do
> > > +	case "$1" in
> > > +	help|--help|-h)
> > > +		shift
> > > +		do_help "$1"
> > > +		exit 1;;
> > > +	esac
> > > +	shift
> > > +done
> > > +set -- $args_saved
> > > +unset args_saved
> > >  
> > >  ## Initial setup
> > 
> > Huh, why do you actually need $args_saved at all? :-) This is bound to
> > do horrible things with space-containing arguments etc., I think. You
> > don't need to do the outer shift and then drop $args_saved altogether,
> > no?
> 
> I figured I need to restore $@ for others to consume, e.g. when you
> check for -r later.
> 
> The challenge is to identify help|--help|-h anywhere on the command
> line. Thus, you need to iterate, or do some weird matching against
> $*.
> 
> When you iterate in a for loop, it's not easy to get at the next
> argument, except if you use a state machine. I wanted to avoid that.

Oh, oops - I missed the loop, I should get some lunch. ;-)
Thus, something like this?

	check_help() { while [ -n "$1" ]; do ...; shift; done }
	check_help "$@"

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
