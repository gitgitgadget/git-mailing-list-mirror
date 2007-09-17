From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: rename detection limit checking, cherry picking, and git am -3
Date: Sun, 16 Sep 2007 23:47:42 -0400
Message-ID: <20070917034742.GG3099@spearce.org>
References: <46EDF54F.5030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX7aS-0005uf-2N
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbXIQDrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 23:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbXIQDrr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:47:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49727 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbXIQDrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 23:47:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IX7a8-0008V5-Ay; Sun, 16 Sep 2007 23:47:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 433C720FBAE; Sun, 16 Sep 2007 23:47:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46EDF54F.5030503@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58382>

Mark Levedahl <mlevedahl@gmail.com> wrote:
> The curious thing to me is the vast superiority of whatever 
> git-format-patch|git-am -3 does, and I wonder if that isn't a 
> fundementally better design for cherry picking than git-cherry-pick 
> implements (it obviously is for this case).

In this case `git am -3` creates a tree object containing only
the files modified by the patch and then feeds that tree into
git-merge-recursive.  Now if you go study git-revert's code you'll
see it actually just calls git-merge-recursive on three trees,
but these are three complete trees.

So what's probably happening here is there's less candidates on one
side in the `am -3` case, so we spend a lot less time generating
the rename matrix, searching for a match, and we get better changes
of finding a match.

I actually don't see why cherry-pick can't be defined in terms
of `format-patch|am -3`.  It probably would be faster in almost
all cases.

-- 
Shawn.
