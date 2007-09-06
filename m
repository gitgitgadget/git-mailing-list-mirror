From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Invoke "git gc --auto" from commit, merge, am and rebase.
Date: Wed, 5 Sep 2007 22:39:34 -0400
Message-ID: <20070906023934.GI18160@spearce.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0709051634190.21186@xanadu.home> <7vwsv4hjfi.fsf@gitster.siamese.dyndns.org> <7vmyw0hixs.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:39:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7Hg-0001NE-KB
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbXIFCjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757438AbXIFCjw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:39:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36081 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbXIFCjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:39:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7HB-0006Pa-6I; Wed, 05 Sep 2007 22:39:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4CAAF20FBAE; Wed,  5 Sep 2007 22:39:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vmyw0hixs.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57804>

Junio C Hamano <gitster@pobox.com> wrote:
> The point of auto gc is to pack new objects created in loose
> format, so a good rule of thumb is where we do update-ref after
> creating a new commit.
...
>  git-am.sh                  |    2 ++
>  git-commit.sh              |    1 +
>  git-merge.sh               |    1 +
>  git-rebase--interactive.sh |    2 ++
>  4 files changed, 6 insertions(+), 0 deletions(-)
...
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index abc2b1c..8258b7a 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -307,6 +307,8 @@ do_next () {
>  	rm -rf "$DOTEST" &&
>  	warn "Successfully rebased and updated $HEADNAME."
>  
> +	git gc --auto
> +
>  	exit
>  }

Why bother with git-rebase--interactive.sh?  It calls two tools,
git-cherry-pick (which calls git-commit) and git-commit to do its
per-commit dirty work.  So on every step of `git rebase -i` we are
now running `git gc --auto`.  No need to also run it at the end.

Note this is also true of `git rebase -m` as that uses the wonderful
feature of `git commit -C $oldid` per commit to make the new commit.
 
-- 
Shawn.
