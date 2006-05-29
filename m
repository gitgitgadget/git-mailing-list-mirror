From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 16:41:58 -0400
Message-ID: <20060529204158.GC28538@spearce.org>
References: <20060529202851.GE14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 22:42:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkoZ7-0005kY-8k
	for gcvg-git@gmane.org; Mon, 29 May 2006 22:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWE2UmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 16:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWE2UmD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 16:42:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45534 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751282AbWE2UmC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 16:42:02 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FkoYi-0005jA-ID; Mon, 29 May 2006 16:41:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 474FD20E445; Mon, 29 May 2006 16:41:59 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20060529202851.GE14325@admingilde.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20969>

Martin Waitz <tali@admingilde.org> wrote:
> Allow to commit to another branch and creating a merge in the current branch.

Interesting.  I have been kicking around doing the very same
thing myself but just have not gotten around to it.  Its complex,
especially if the current HEAD isn't strictly the merge commit
between the topic branch and the previous value of HEAD; in that
case you may want to replay the commits which are on HEAD but are
post the merge commit using a form of git-rebase.  Except you would
want to preserve any merges which happened by remerging them rather
than simply exporting a massive patch and reapplying it.
 
> +		test $(git merge-base "$onto_branch" HEAD^) != $onto_branch_commit &&
> +		test $(git merge-base "$onto_branch"^ HEAD^) = $(git rev-parse --verify "$onto_branch"^) ||
> +			die "commits on $onto_branch and HEAD differ, cannot amend."
> +		onto_branch_commit=$(git rev-parse --verify "$onto_branch"^)

Shouldn't these be 'git-merge-base' and 'git-rev-parse' ?

> +		git update-ref "$onto_branch" $commit2 &&

If this is going into next perhaps you would like to considering adding
the -m flag to your git-update-ref calls and include a log message
in the reflog (if the user has it enabled for the current branch and
the topic branch)?

Also shouldn't this be 'git-update-ref'?

-- 
Shawn.
