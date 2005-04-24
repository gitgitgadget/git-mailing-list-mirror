From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Git for redundant mail servers
Date: Sun, 24 Apr 2005 15:54:30 +1000
Message-ID: <1114322071.3419.68.camel@localhost.localdomain>
References: <1114238562.3419.29.camel@localhost.localdomain>
	 <2cfc403205042301243841fe0c@mail.gmail.com>
	 <Pine.LNX.4.62.0504232159030.32287@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: jon@zeta.org.au, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 07:51:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPa1G-0002Wq-Hw
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVDXFzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVDXFzf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:55:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45292 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262267AbVDXFz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 01:55:28 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DPa5Q-0002Gp-7U; Sun, 24 Apr 2005 06:55:23 +0100
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504232159030.32287@qynat.qvtvafvgr.pbz>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 22:12 -0700, David Lang wrote:
> 1. when a new message arrives it gets given a numeric messageid, this 
> message id is not supposed to change without fairly drastic things 
> happening (the server telling all clients to forget everything they know 
> about the status of the mailbox). this requires syncronization between 
> servers if both are receiving messages.

Yeah, that's the most interesting part. One option would be to require
quorum before a server is allowed to add to a mailbox -- but that would
render the thing unsuitable for _intentional_ offline use, where you
want to be able to move mails from one folder to another on your laptop
while it's disconnected.

Since it should be relatively rare for 'competing' commits to occur
during periods of disconnection, I suspect that the solution doesn't
have to be particularly efficient. I'm not sure I'd really want to
change UIDVALIDITY if it happened, but perhaps we could simply remove
_all_ the affected UIDs, and assign new UIDs to the same mails.

In practice, it's far more important that for us to ensure that an
existing UID _never_ refers to a different mail, than it is to make sure
that a given mail always keeps the same UID.

> 2. git effectivly stores snapshots of things and you deduce the changes by 
> comparing the snapshots. for things like flags changing this is a 
> relativly inefficiant way to replicate changes (although if one server is 
> offline for a while it could be a firly efficiant way to do the merge)

We don't have to stick _precisely_ to Maildir -- but flag changes are
just a rename in Maildir, leaving the mail object entirely intact while
changing only the tree. That isn't _so_ bad; but yes, it could probably
be done a little better than just "Maildir in git".

-- 
dwmw2

