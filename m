From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 18:27:38 -0400
Message-ID: <20050419222738.GA14566@nevyn.them.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com> <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO18A-0005Vu-G8
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDSW1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDSW1s
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:27:48 -0400
Received: from nevyn.them.org ([66.93.172.17]:26509 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261701AbVDSW1l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:27:41 -0400
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DO1By-0003sL-Me; Tue, 19 Apr 2005 18:27:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 03:00:04PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 19 Apr 2005, Greg KH wrote:
> > 
> > It looks like your domain name isn't set up properly for your box (which
> > is why it worked for you, but not me before, causing that patch).
> 
> No, I think it's a bug in your domainname changes. I don't think you
> should do the domainname at all if the hostname has a dot in it.
> 
> Most machines I have access to (and that includes machines that are
> professionally maintained, not just my own cruddy setup) says "(none)" to
> domainname and have the full hostname in hostname.
> 
> And even the ones that use domainname tend to not have a fully qualified 
> DNS domain there. You need to use dnsdomainname to get that, and I don't 
> even know how to do it with standard libc.
> 
> So how about something like this?
> 
> (Somebody who actually knows how these things should be done - please feel 
> free to pipe up).

The glibc documentation blows for this, but what getdomainname comes
from uname(2), not from any DNS-related configuration.  Debian only
ever sets this if you're using NIS.

There's no real great way to get the current hostname; a lot of
applications do a reverse DNS lookup on the primary network interface,
with appropriate handwaving to define primary.

Easiest might be to punt to hostname --fqdn, or an equivalent to its
algorithm - which appears to be fetch the hostname from uname, do a DNS
lookup on that, and a reverse DNS lookup on the result.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
