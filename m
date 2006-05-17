From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 18:06:13 -0400
Message-ID: <20060517220613.GC30313@spearce.org>
References: <20060517095609.GF28529@spearce.org> <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 00:06:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgU9v-0003FG-OE
	for gcvg-git@gmane.org; Thu, 18 May 2006 00:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWEQWGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 18:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWEQWGR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 18:06:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55519 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751194AbWEQWGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 18:06:16 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgU9d-0006z9-FT; Wed, 17 May 2006 18:06:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 170D3212667; Wed, 17 May 2006 18:06:13 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20246>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> +	fprintf(stderr, "warning: Log %s only goes back to %s.\n",
> +		logfile, show_rfc2822_date(date, tz));
> +	return 0;
> 
> I am not sure about this part.  If the oldest log entry was 3
> hours ago, the second oldest 2 hours ago, we can tell during
> that one hour period the ref was at that point.  If the user
> asked "ref as of four hours ago", and if the oldest log entry
> had old SHA1 that is not 0{40} (because the log was not enabled
> before that record), it might make more sense to give that back.

If I understand my own code here what I'm doing is walking back
in the log file, realizing I fell off the first line of it, then
loading the old ref from the first line.  This is the oldest ref
I can find so I return it as a valid ref to the caller but I'm
printing out this warning to tell the user that the oldest point
in time I found in the log is effectively the update date as I have
no idea when that old sha1 first became the value of the ref.

So I think I'm doing what you are expecting here.  The log will start
with the value in the ref at the time the log started, not 0{40}
and that value is what gets returned when we have this warning
come out..  That's the best anyone can expect...

> Also I wonder how much complexity would we suffer and how much
> efficiency would we gain if we binary search the logdata (the
> committer info is variable length, so you would need to resync
> in each step).

I thought about doing this but did not think it would be worth the
effort (either developer to code or CPU to execute) at this point
in time.  I don't think users will be pulling refs from the log very
often and if they are they will probably be pulling from recent time,
not very far back.  Thus starting at the end and walking back is
probably "good enough".

But if it proves to be too slow in practice I'm sure I can come up
with a faster way to walk through the log.  :-)

-- 
Shawn.
