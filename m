From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] Timeouts on HTTP requests
Date: Wed, 19 Oct 2005 13:09:10 +0200
Message-ID: <20051019110909.GO30889@pasky.or.cz>
References: <20051018235104.GO5509@reactrix.com> <7voe5mgi3d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 13:10:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESBot-0002g8-0Z
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 13:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVJSLJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 07:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVJSLJN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 07:09:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4019 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964793AbVJSLJM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 07:09:12 -0400
Received: (qmail 29009 invoked by uid 2001); 19 Oct 2005 13:09:10 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe5mgi3d.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10284>

Dear diary, on Wed, Oct 19, 2005 at 08:02:14AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Nick Hengeveld <nickh@reactrix.com> writes:
> 
> > Our QA department today checked what would happen if the network connection
> > went away completely in the middle of an HTTP transfer.  It looks as though
> > the answer is that git-http-fetch sits there forever waiting for CURL to
> > return something.
> 
> Ouch.
> 
> > I'm thinking of taking advantage of CURL's capability of aborting a request
> > if the transfer rate drops below a threshold for a specified length of time
> > using a new pair of environment variables and/or config file settings:
> >
> > GIT_HTTP_LOW_SPEED_LIMIT/http.lowspeedlimit
> > GIT_HTTP_LOW_SPEED_TIME/http.lowspeedtime
> >
> > Does this make sense, and if so should there be defaults if nothing is
> > specified?
> 
> I suspect these would be quite different between DSL and
> localnet, so I doubt if there is a reasonable default value to
> quick give-up.
> 
> On the other hand, having _no_ activity for say 30 seconds would
> indicate a dead link on either modem or localnet.

I agree that we should definitely use timeout instead of some low speed
limit - can't curl do that?

But 30 seconds is too little (on bad links, I've seen TCP connections
stalled for much longer), I would use at least 120 seconds. Or perhaps
30 seconds, but retry three times or so.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
