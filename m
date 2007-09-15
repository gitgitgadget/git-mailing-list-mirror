From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 02:32:57 -0400
Message-ID: <20070915063257.GZ3099@spearce.org>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com> <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com> <7vk5qtd3le.fsf@gitster.siamese.dyndns.org> <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com> <20070915025129.GY3099@spearce.org> <2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Scott Dobrovodsky <brian@pontech.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 08:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWRHc-0004C4-8G
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 08:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbXIOGdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbXIOGdE
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 02:33:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34863 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXIOGdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 02:33:03 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRD8-0005Y9-Ua; Sat, 15 Sep 2007 02:32:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 342F620FBAE; Sat, 15 Sep 2007 02:32:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58220>

Brian Scott Dobrovodsky <brian@pontech.com> wrote:
> > It isn't unreasonable to want Git to save uncommitted work for the
> > current branch and then you switch to another, ending up with a
> > clean working directory when you finally get there.  Today we have
> > git-stash to help you with this, but I'm thinking maybe we want to
> > connect git-checkout with it?
> 
> That would be great as a default action when using checkout!

Well, a lot of "Git old timers" like the current action of keeping
the tree dirty during a switch.  But maybe we could also teach `git
checkout` that a user specified configuration option can cause it
to automatically stash/unstash unless -m is supplied.  Or something.

Patches are always welcome.  ;-)

> +Switching branches without having to commit improves work flow.
> +Fewer commits = cleaner logs.

Well, I'm not sure that matters here.  Typically Git users will make
heavy use of commit rewriting features (e.g. `git commit --amend`
or `git rebase -i`) to cleanup changes on a side branch before they
submit them to the mainline.  This makes it easy to commit all of
the time and not worry about how the resulting logs will look.
Plus they can have look like they have some serious code-fu and
always write things perfectly the first time. :)

Indeed, before git-stash came about I parked changes on a branch
using the following technique:

	$ git commit -a -m PARK       ; # stash on "demo"
	$ git checkout master         ; # tree is now clean
	$ git checkout demo           ; # back on demo
	$ git reset --soft HEAD^      ; # undo the stash

No messy history, nice neat per-branch stash.  Oh, you can do that
in Git 1.3.  And even earlier probably.  I actually still use this
trick from time to time as I find it flowing out of my fingers far
easier than git-stash.

-- 
Shawn.
