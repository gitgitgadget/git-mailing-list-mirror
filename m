From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Sun, 27 Oct 2013 09:13:19 +0000
Message-ID: <20131027091318.GA13149@leaf>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <CACsJy8CKUygqbMKK_mkOY2C5whqHN=d+6ME_jkXpPebxeSd3Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 10:13:58 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaMQ1-0005NB-Kk
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 10:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab3J0JN1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 05:13:27 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51851 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3J0JNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 05:13:25 -0400
Received: from mfilter27-d.gandi.net (mfilter27-d.gandi.net [217.70.178.155])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 48FD4172080;
	Sun, 27 Oct 2013 10:13:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter27-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter27-d.gandi.net (mfilter27-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id SWK5og5RVh28; Sun, 27 Oct 2013 10:13:20 +0100 (CET)
X-Originating-IP: 77.221.165.98
Received: from leaf (ip-77-221-165-98.dsl.twang.net [77.221.165.98])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A5BFD172055;
	Sun, 27 Oct 2013 10:13:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8CKUygqbMKK_mkOY2C5whqHN=d+6ME_jkXpPebxeSd3Tw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236794>

On Sun, Oct 27, 2013 at 03:33:19PM +0700, Duy Nguyen wrote:
> On Sun, Oct 27, 2013 at 8:34 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> > Add a command line option for git commit to automatically construct the
> > "Fixes:" line for a commit.  This avoids the need to manually construct
> > that line by copy-pasting the commit hash and subject.
> 
> But you still have to copy/paste the hash in command line. I wonder if
> we should approach it differently: the user writes "Fixes: <hash>" in
> the commit message, then git detects these lines and expands them

Then you have to copy/paste the hash into the commit message; either way
you're not getting around that.  However, note that you can pass a ref
instead of a commit hash, if you happen to have saved a tag pointing to
the broken ref.  (Or, for instance, if you have it from a bisection.)

I could imagine supporting that approach in addition (via a commit-msg
hook, for instance), but I'd still like to have the command-line option
to git commit.

> using a user-configured format. For the kernel circle, the format
> would be "%h ('%s')" (I'll need to think how to let the user say
> "minimum 12 chars").

I considered making the format configurable, and that's easy enough to
do, but I wanted to start out with the simplest patch that achieved the
goal, on the theory that it's easy to add configurability later if
anyone actually needs it.

> Other projects need to refer to old commits sometimes in commit
> messages too and this could be extended further to expand inline
> abbrev sha-1s, but to not break the text alignment badly, maybe
> footnotes will be created to store subjects and stuff, rather than do
> inline expansion. For example,
> 
>   commit 1232343 breaks something.....
> 
> becomes
> 
>   comit 1232343 [1] breaks something....
> 
>   [1] 123234332131 (do something wrong - at this date)

Easily done via a commit-msg hook, if you want that.

- Josh Triplett
