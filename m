From: Jeff King <peff@peff.net>
Subject: Re: Git rebase dies with fatal: Unable to create
 '.../.git/index.lock': File exists.
Date: Mon, 16 Sep 2013 17:15:01 -0400
Message-ID: <20130916211501.GA5477@sigill.intra.peff.net>
References: <20130916182852.GA14513@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
X-From: git-owner@vger.kernel.org Mon Sep 16 23:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLg8Y-0005S6-6g
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 23:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab3IPVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 17:15:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:38596 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab3IPVPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 17:15:07 -0400
Received: (qmail 20768 invoked by uid 102); 16 Sep 2013 21:15:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Sep 2013 16:15:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Sep 2013 17:15:01 -0400
Content-Disposition: inline
In-Reply-To: <20130916182852.GA14513@obsidianresearch.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234842>

On Mon, Sep 16, 2013 at 12:28:52PM -0600, Jason Gunthorpe wrote:

> I have emacs windows open that have files within the git tree open in
> them. My emacs has vc-git mode loaded and global-auto-revert-mode set.
> 
> During the rebase the files open in emacs are changed by git, when
> emacs notices this (which is random with respect to the ongoing
> rebase) it auto reverts and runs git commands (due to vc-git), which
> causes the rebase to randomly fail.
> 
> Worse, I've noticed that this also randomly seems to cause the rebase
> to loose a commit if you --continue from that point.
> 
> Can git have some retry in the locking so this doesn't happen?

I'm not clear on which git commands are being run. If they are actually
mutating the index, then isn't this more than a lock contention issue?
In other words, "git rebase" is assuming nobody is mucking with the
index while it runs; if emacs is doing so, then the results could be
quite confusing, even if we retried the lock acquisition.

-Peff
