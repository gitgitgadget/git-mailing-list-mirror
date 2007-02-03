From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-clone wrongly setting branch.*.merge ? (Was: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".)
Date: Sat, 3 Feb 2007 01:14:30 +0100
Message-ID: <20070203001430.GH5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth> <20070201234805.3313.20525.stgit@gandelf.nowhere.earth> <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com> <20070202180706.GE5362@nan92-1-81-57-214-146.fbx.proxad.net> <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 01:15:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD8Z5-0004co-S5
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 01:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933396AbXBCAPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 19:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933397AbXBCAPZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 19:15:25 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:45948 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933396AbXBCAPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 19:15:24 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 207C49B72A
	for <git@vger.kernel.org>; Sat,  3 Feb 2007 01:15:23 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8DF581F080; Sat,  3 Feb 2007 01:14:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20070202235655.GG5362@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38543>

On Sat, Feb 03, 2007 at 12:56:55AM +0100, Yann Dirson wrote:
> With current GIT HEAD, plain git-clone creates the following config
> (when cloning a repo with HEAD pointing to branch "downstream":
> 
> 
> [remote "origin"]
>         url = /export/work/yann/git/stgit/tmp/.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "downstream"]
>         remote = origin
>         merge = refs/heads/downstream
>                 ^^^^^^^^^^^^^^^^^^^^^
> 
> I would have expected "merge = remotes/origin/downstream" instead, and
> this setting confuses the rebase-after-pull logic, causing it to
> rebase the stack onto its own base (no-op).

Hm, I see I was confused about the branch.*.merge meaning.  The config
doc does document it to be the remote part of the refspec.

But what does that mean - why using the remote part here ?  I cannot
see that, although I can see arguments why using the local part here:

- When we come to finding the branch to merge, we have already fetched
all remote branches into local ones, so why would we need to find a
local branch matching this remote name ?

- How are we supposed to handle the case where a single remote ref is
mapped to several local ones ?  Although I cannot see a use for this
situation, it would seem to be a valid one, whereas having several
fetch lines for a single local ref in a single remote would clearly
be invalid: using a local ref would avoid a possible ambiguity.

Best regards,
-- 
Yann.
