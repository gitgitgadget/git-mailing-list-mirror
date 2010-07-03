From: Sam Vilain <sam@vilain.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Sun, 04 Jul 2010 11:27:29 +1200
Message-ID: <1278199649.9701.6.camel@denix>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
	 <20100701005854.GO2337@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Nick Edelen <sirnot@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 04 01:27:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVC7M-0004rg-IB
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 01:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0GCX1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 19:27:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:43096 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782Ab0GCX1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 19:27:14 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1B13321C3E6; Sun,  4 Jul 2010 11:27:13 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id B433621C35E;
	Sun,  4 Jul 2010 11:27:08 +1200 (NZST)
In-Reply-To: <20100701005854.GO2337@spearce.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150211>

On Wed, 2010-06-30 at 17:58 -0700, Shawn O. Pearce wrote:
> > I can do this using "git tag --contains <commit-id>", but it's quite
> > slow.  It takes something like 8-9 seconds.  (8.5 seconds of user time,
> > 8.6 times of wall clock, to be precise).
> > 
> > I can get the information much faster using "gitk -1 <commit-id>", which
> > [...]
> > using the built-in native git tools?  And if so, why is git tag
> > --contains apparently 4 times slower than gitk at performing this task?
> 
> gitk keeps a cache of this stuff in .git/gitk.cache.  I'll bet its
> pulling from cache here, which is why it snaps so fast.
> 
> Without the cache is expensive, which is what 'git tag --contains'
> is doing.  The code walks back from each tag tracing along the commit
> parent pointers, keeping track of the nearest tag name that can reach
> any given commit.  When it finds your commit, it stops and outputs.
> 
> Since this stuff can't change unless the refs change, yes, it can be
> cached easily.  But nobody has done caching for this in Git itself,
> only in Tcl for gitk.  :-\

I think possibly rev-cache would improve this case.  Maybe it could also
be used for gitk.  Perhaps Nick you might like to say more, and comment
on what the outstanding work is to do?

Sam
