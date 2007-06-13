From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:54:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131648070.4059@racer.site>
References: <18031.64456.948230.375333@lisa.zopyra.com>
 <Pine.LNX.4.64.0706131559210.4059@racer.site> <200706131640.22588.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVEC-0004Jy-E0
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199AbXFMP5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757016AbXFMP5m
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:57:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:51628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758042AbXFMP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:57:41 -0400
Received: (qmail invoked by alias); 13 Jun 2007 15:57:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 13 Jun 2007 17:57:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PaOZLrraPANHUua5E9nHJrLW06b8kD6HoPkDQHJ
	FzZE5GvBI2X34+
X-X-Sender: gene099@racer.site
In-Reply-To: <200706131640.22588.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50083>

Hi,

On Wed, 13 Jun 2007, Andy Parkins wrote:

> On Wednesday 2007 June 13, Johannes Schindelin wrote:
> 
> > The other thing, if you have to, is to put all dirty changes into the
> > index before pull. Something like "git add $(git ls-files --modified)".
> 
> Or the shiny new
> 
>  git add -u
> 
> which works a treat :-)

Yeah, completely forgot about that.

Another idea just hit me: you could add this to your "[alias]" section:

	stash = !git add -u && \
		tree=$(git-write-tree) && \
		commit=$(echo stash $(date) | \
			git-commit-tree $tree -p HEAD) && \
		git-update-ref refs/heads/stash $commit && \
		git-reset --hard

	up = !git stash && git pull && git cherry-pick -n stash

Or something like that (untested!). Then, your users could use "git up" to 
pull from origin, and reapply their changes on top, without committing.

This assumes that your users only have the remote "origin", but given 
their obvious "objections" to Git concepts, I think they do.

Ciao,
Dscho
