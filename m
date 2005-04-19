From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Change "pull" to _only_ download, and "git update"=pull+merge?
Date: Tue, 19 Apr 2005 14:28:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504191245160.30848-100000@iabervon.org>
References: <20050419105008.GB12757@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	David Greaves <david@dgreaves.com>, dwheeler@dwheeler.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 20:24:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNxO7-0004wq-QX
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 20:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDSS2C (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 14:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDSS2C
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 14:28:02 -0400
Received: from iabervon.org ([66.92.72.58]:1542 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261501AbVDSS1z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 14:27:55 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNxS4-0007Cz-00; Tue, 19 Apr 2005 14:28:00 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419105008.GB12757@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Petr Baudis wrote:

> I disagree. This already forces you to have two branches (one to pull
> from to get the data, mirroring the remote branch, one for your real
> work) uselessly and needlessly.

If you pull in a non-tracked tree, it certainly won't apply the
changes, so you can just have your local tree and pull other people's
trees as desired.

> I think there is just no good name for what pull is doing now, and
> update seems like a great name for what pull-and-merge really is. Pull
> really is pull - it _pulls_ the data, while update also updates the
> given tree. No surprises.

I'm actually getting suspicious that the right thing is to hide "pull" in
the id scheme. That is, instead of saying "linus" to refer to the
"linus" head that you currently have, you say "+linus" to refer to the
head Linus has on his server currently, and this will cause you to
download anything necessary to perform the operation with the resulting
value.

See, I don't think you ever want to just pull. You want to
pull-and-do-something, but the something could be any operation that uses
a commit, not necessarily update. So you could do "git diff -r +linus" to
compare your head against current linus. You'd want "git update" to take a
working directory from "linus" to "+linus" (just because you know Linus's
more recent head doesn't mean you're automatically using it). You could
just "git merge +linus" in your working directory to sync with Linus. Even
"git log +linus" to see his recent changes.

I think the only reason not to just make any reference to a head pull it
is performance on looking up the head; you don't really want to hammer the
server getting these 40-byte files constantly or wait for a connection
every time (not to mention the possibility of not being able to
connect). But there's no reason to want to not have the latest data, since
the older data doesn't go away.

	-Daniel
*This .sig left intentionally blank*

