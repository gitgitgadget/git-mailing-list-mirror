From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 4/4] LsTree: Enable pattern matching in LsTree
Date: Wed, 25 Jun 2008 00:09:31 -0400
Message-ID: <20080625040931.GA11793@spearce.org>
References: <20080622233525.GJ11793@spearce.org> <1214343392-5341-1-git-send-email-robin.rosenberg@dewire.com> <1214343392-5341-2-git-send-email-robin.rosenberg@dewire.com> <1214343392-5341-3-git-send-email-robin.rosenberg@dewire.com> <1214343392-5341-4-git-send-email-robin.rosenberg@dewire.com> <1214343392-5341-5-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Florian Koeberle <florianskarten@web.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMLL-00046P-NV
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbYFYEJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbYFYEJg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:09:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37109 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508AbYFYEJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:09:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBMJs-0004KT-Qn; Wed, 25 Jun 2008 00:09:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 09E7420FBAE; Wed, 25 Jun 2008 00:09:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1214343392-5341-5-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86214>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
> index ce6da5e..8b22e25 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/filter/WildCardTreeFilter.java
> @@ -76,7 +76,7 @@ public class WildCardTreeFilter extends TreeFilter {
>  		if (walker.isRecursive() && walker.isSubtree())
>  			return true;
>  		matcher.reset();
> -		matcher.append(walker.getPathString());
> +		matcher.append(walker.getName());
>  		if (matcher.isMatch())
>  			return true;
>  		return false;

Are we only supporting `jgit ls-tree . '*.c'` ?
Or do we want to allow `jgit ls-tree . 'src/*.c'`?

ls-tree is only a little sample program that is not likely to have
a lot of real-world users calling it; but is a good demonstration
of how to use TreeWalk.  So I really don't care either way.

The WildCardTreeFilter on the other hand could be applied to a
RevWalk, such as to grab history for not just 'foo.c' but anything
that matches 'f*.c'.  But then you have to ask, why is the filter
limited to testing only the last component of the path?  Why can't
it test 'src/f*.c'?

Otherwise everything in your series up until here makes sense and
looks good to me.  Be nice if the tree filter wasn't so abusive in
needing to look at every path in the project, as that would really
hurt if it was applied to a RevWalk.  But its not required to be
fast, if you ask for fnmatch paths, you get what you asked for...

-- 
Shawn.
