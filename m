From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Mon, 15 May 2006 02:38:49 -0400
Message-ID: <20060515063849.GA28337@spearce.org>
References: <7vody2v7yr.fsf@assigned-by-dhcp.cox.net> <20060513071753.GA21998@spearce.org> <20060513074328.GB21998@spearce.org> <Pine.LNX.4.64.0605130815550.3866@g5.osdl.org> <7vbqu1vps3.fsf@assigned-by-dhcp.cox.net> <20060513181816.GA12475@spearce.org> <7vk68o19n4.fsf@assigned-by-dhcp.cox.net> <20060515031511.GA27505@spearce.org> <20060515055830.GC28068@spearce.org> <7vac9jx0nq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:39:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfWjK-0001JY-LK
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWEOGiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEOGiz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:38:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48012 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932332AbWEOGiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:38:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfWjD-0003YO-VT; Mon, 15 May 2006 02:38:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14E83212667; Mon, 15 May 2006 02:38:49 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac9jx0nq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20028>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > This is all well and good but its sort of useless without the diffcore
> > being able to lookup what SHA1 was valid on a given branch at a given
> > point in time.  :-)
> >
> > I'm thinking about extending the 'extended SHA1' syntax to accept
> > a date (or date expression) as a suffix:
> >
> > 	HEAD@'2 hours ago'
> > 	HEAD@'2006-04-20'
> > 	HEAD@'2006-04-20 14:12'
> >
> > etc... This would be merged into get_sha1 (sha1_name.c) so its
> > usable pretty much anywhere.  Does this seem reasonable?  If so
> > I'll work up a patch for it.
> 
> HEAD?
> 
> Are you going to hook into symbolic-ref as well to track branch
> switching?

I hadn't planned on it.  I was going to resolve the symref HEAD
down to the real ref (e.g. refs/heads/sp/ref-log) and then do the
date range searching on the real branch.  I didn't think it was
interesting to track what HEAD is.  But I think it would be very
common for the user to use HEAD rather than their actual branch
ref names when forming an expression.
 
[snip]
> The time-warp format would make sense for individual branches,
> like refs/heads/master, though.
> 
> sha1_name.c and sha1_file.c were supposed to be real core, but
> get_sha1() is looking more and more Porcelainish these days, and
> I do not have much problem with being able to say "tip of this
> branch, two hours ago".
> 
> I am not sure about the syntax though.  We would want to be able
> to say "start from the commit that was at the tip of 'master'
> branch two days ago, grab its tree and look at arch/sparc64
> directory", so things like
> 
>             "master@2006-05-14 14:12"
>             "master@2006-05-14 14:12^{tree}"
>             "master@two days ago:arch/sparc64"
> 
> would need to be supported.

Yea, I realize that.  I'm currently looking at get_sha1_1 and how
I can put the date resolution in before the ^, ~ and :.  :-)

-- 
Shawn.
