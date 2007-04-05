From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Thu, 5 Apr 2007 09:49:54 -0400
Message-ID: <20070405134954.GA18402@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZSLg-0001Zs-Vn
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766982AbXDENt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766983AbXDENt6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 09:49:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2584 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1766982AbXDENt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 09:49:57 -0400
Received: (qmail 13187 invoked from network); 5 Apr 2007 13:50:31 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Apr 2007 13:50:31 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2007 09:49:54 -0400
Content-Disposition: inline
In-Reply-To: <17940.59514.150325.738141@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43827>

On Thu, Apr 05, 2007 at 07:15:54AM -0500, Bill Lear wrote:

> I'm trying to explain this behavior to a co-worker, and how to solve
> it:
> 
> % git pull
> Already up-to-date.
> 
> % git push
> error: remote 'refs/remotes/origin/flexify' is not a strict subset of
> localref 'refs/remotes/origin/flexify'. maybe you are not up-to-date
> and need to pull first?

That ref name is a bit suspect...why are you pushing your your remote
tracking branches? If you are simply pushing to a repository that is a
pure mirror, maybe your 'push' line in the config file should have a '+'
at the front?

At any rate, the reason why the pull doesn't fix it is that it is not
pulling onto flexify, but onto master, which it looks like you guessed:

> So, I'm confused: I would have thought the way you solve the problem
> in step 2 is by executing step 1.  Would he need to do this:
> 
> % git checkout flexify
> % git pull flexify:flexify
> % git checkout master
> % git push

It would need to be:
  git pull $remote flexify:flexify

I don't think that works, though, because it's _not_ the flexify branch
that's the problem. It's the refs/remotes/origin/flexify, which
generally shouldn't be getting pushed at all. Can you show us the
.git/config?

-Peff
