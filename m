From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: Git rebase dies with fatal: Unable to create
 '.../.git/index.lock': File exists.
Date: Mon, 16 Sep 2013 15:21:59 -0600
Message-ID: <20130916212159.GA16437@obsidianresearch.com>
References: <20130916182852.GA14513@obsidianresearch.com>
 <20130916211501.GA5477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 16 23:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLgFB-00079N-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 23:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab3IPVWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 17:22:00 -0400
Received: from quartz.orcorp.ca ([184.70.90.242]:41719 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3IPVWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 17:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=obsidianresearch.com; s=rsa1;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PaX5+l8EIseebstTlyWKXNXrEJeE+vZZ8DUgMiP0RuU=;
	b=cYWPLSXpL7J6Vpcg6rcqOJqvl/vU2qILy+UnfXEgLcOutH75cWOYteiiaujZMTsjlVKsOvYwVfLlbb3fipm4Dahl4HbWdVi8srhMDV2Gbfkn0wIVcy+ywNfrmivZczsPXT5PzmrFKwK0u2UW2hMk8B9s2mMo7/BfMH4LYIt7x58=;
Received: from [10.0.0.161] (helo=jggl.edm.orcorp.ca)
	by quartz.orcorp.ca with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1VLgF5-0002li-Ex; Mon, 16 Sep 2013 15:21:59 -0600
Received: from jgg by jggl.edm.orcorp.ca with local (Exim 4.80)
	(envelope-from <jgunthorpe@obsidianresearch.com>)
	id 1VLgF5-0006cs-46; Mon, 16 Sep 2013 15:21:59 -0600
Content-Disposition: inline
In-Reply-To: <20130916211501.GA5477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Broken-Reverse-DNS: no host name found for IP address 10.0.0.161
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234843>

On Mon, Sep 16, 2013 at 05:15:01PM -0400, Jeff King wrote:
> On Mon, Sep 16, 2013 at 12:28:52PM -0600, Jason Gunthorpe wrote:
> 
> > I have emacs windows open that have files within the git tree open in
> > them. My emacs has vc-git mode loaded and global-auto-revert-mode set.
> > 
> > During the rebase the files open in emacs are changed by git, when
> > emacs notices this (which is random with respect to the ongoing
> > rebase) it auto reverts and runs git commands (due to vc-git), which
> > causes the rebase to randomly fail.
> > 
> > Worse, I've noticed that this also randomly seems to cause the rebase
> > to loose a commit if you --continue from that point.
> > 
> > Can git have some retry in the locking so this doesn't happen?
> 
> I'm not clear on which git commands are being run. If they are actually
> mutating the index, then isn't this more than a lock contention issue?
> In other words, "git rebase" is assuming nobody is mucking with the
> index while it runs; if emacs is doing so, then the results could be
> quite confusing, even if we retried the lock acquisition.

I'm not sure what commands vc-git mode in Emacs is actually running
automatically, but I'd be surprised and alaramed if they were mutating
command..

I agree retry on the lock is hackish, holding the lock continuously
rather than release/reaquire during operation would be much stronger
prevention.

Jason
