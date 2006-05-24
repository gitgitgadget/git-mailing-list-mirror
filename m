From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Wed, 24 May 2006 19:25:06 -0400
Message-ID: <20060524232506.GB3554@spearce.org>
References: <20060519091716.GM22257@spearce.org> <7vk68fyarn.fsf@assigned-by-dhcp.cox.net> <20060524035234.GA13329@spearce.org> <7vy7wr3tc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 01:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj2j9-0003fu-Jl
	for gcvg-git@gmane.org; Thu, 25 May 2006 01:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEXXZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 19:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWEXXZO
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 19:25:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:25218 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932318AbWEXXZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 19:25:12 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fj2ip-0004k9-Fv; Wed, 24 May 2006 19:25:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65B6E20FB0C; Wed, 24 May 2006 19:25:07 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7wr3tc3.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20709>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> I've swallowed all 10 and pushed them out in "pu", but could you
> >> add tests to check the Porcelainish commands you touched with
> >> this series to make sure they all log correctly?
> >
> > Sure.  I've been putting it off as I've been busy the past few days
> > and have also been thinking about trying to rebuild reflog using a
> > tag/annotation branch style, which might be more generally useful
> > to others.
> 
> It appears that there is more serious breakage caused by the
> lock_ref change.  http-fetch in "next" fails to clone, because
> the call to lock-ref-sha1 in fetch.c::pull() forgets that the
> program might be creating a new ref.

Hmm.  I thought I was doing the same thing fetch used to do which
appeared to only work on refs which already exist, and not creating
new refs...
 
> Another breakage I found (not related to ref-log) is that it
> appears fetch.c, even in "master" branch [*1*], has current_ref
> variable and does things depending on it, but nobody seems to
> set that variable, so there are a lot of dead code that looks as
> if they are doing something useful, enclosed in sections like:
> 
> 	if (somethingelse && current_ref) {
>         	dead code
> 	}
 
I wondered about that code...

-- 
Shawn.
