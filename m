From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [PATCH] RFC: proxy-command support for git://
Date: Thu, 3 Nov 2005 13:41:37 -0700
Organization: Hewlett Packard
Message-ID: <20051103204137.GA1343@hpsvcnb.fc.hp.com>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org> <7v8xw5h898.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511031117290.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Paul Collins <paul@briny.ondioline.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 21:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXluM-00014x-9Q
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 21:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVKCUlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVKCUlu
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 15:41:50 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:4526 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1030468AbVKCUlt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 15:41:49 -0500
Received: from smtp2.fc.hp.com (smtp2b.fc.hp.com [15.15.136.253])
	by atlrel8.hp.com (Postfix) with ESMTP id 81BAD4759;
	Thu,  3 Nov 2005 15:41:48 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id CA3B041E5C5; Thu,  3 Nov 2005 20:41:37 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id A408C431F1; Thu,  3 Nov 2005 13:41:37 -0700 (MST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Paul Collins <paul@briny.ondioline.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511031117290.27915@g5.osdl.org>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11094>

Another way to do this would be using the ~/.ssh/config file.  It would
look something like this:

Host host
  ProxyCommand ...

Or, more generically...

Host *.*
  ProxyCommand ...

Host *.* assumes that if the machine name has a '.' in it then you are
trying to get outside the firewall.  This might not be a good assumption
but it works well where I am.

Then use host:pathname or ssh://host/pathname or whatever.

The advantage of using this is that it works for anything that uses ssh
to get outside the firewall.  Not just git.  So, setup is minimal.

Carl

On Thu, Nov 03, 2005 at 11:22:35AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 3 Nov 2005, Junio C Hamano wrote:
> 
> > Paul Collins <paul@briny.ondioline.org> writes:
> > 
> > > I spend some of my time using a network that only allows outgoing TCP
> > > connections to certain ports, and the git-daemon port is not one of them.
> > > This patch below implements an analogue to ssh's ProxyCommand feature
> > > for git, as a less messy alternative to ssh port forwarding.
> > 
> > Wonderful.
> > 
> > > Questions:
> > >
> > > * Can git already do this and I just failed to notice?
> > 
> > Maybe I just failed to notice this too, but I do not think so.
> 
> Actually, you could. TWO ways, in fact, afaik.
> 
> Just use the "ssh://host/pathname" format (or just "host:pathname") and 
> the GIT_SSH environment variable.
> 
> You could also override the local command-name with
> 
> 	git-send-pack --exec=my-local-send-program /machine/repo/path
> 
> where the "my-local-send-program" will parse /machine/repo/path thing. At 
> least that works with git-send-pack, but it's possible it doesn't work 
> with some other logic (ie "git push" might decide that it's unhappy that 
> /machine/repo/path doesn't exist locally because it thinks it's a local 
> path).
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
