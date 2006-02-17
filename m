From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make git-reset delete empty directories
Date: Fri, 17 Feb 2006 10:16:54 -0500
Message-ID: <20060217151654.GA26362@spearce.org>
References: <20060217072616.GA15358@spearce.org> <7v7j7u8koz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 16:17:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA7MW-0004cQ-1b
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 16:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWBQPQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 10:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWBQPQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 10:16:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:16065 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751444AbWBQPQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 10:16:58 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FA7Lo-0003pn-4k; Fri, 17 Feb 2006 10:16:52 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id EE60020FBA0; Fri, 17 Feb 2006 10:16:54 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j7u8koz.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16353>

Junio C Hamano <junkio@cox.net> wrote:
> I thought I said it would be a few-liner, but it appears I did
> not send that message.

You did.  Somehow I forgot that request.  I wrote a simple approach
similar to what you show below then tried to make it slightly
more efficient by only attempting to delete each directory once.
Obviously that wasn't wise on my part.  :-)
 
> This untested one is far simpler, if less efficient, isn't it?
> 
> ---
> 
> diff --git a/git-reset.sh b/git-reset.sh
> index fe53fc8..195d043 100755
> --- a/git-reset.sh
> +++ b/git-reset.sh
> @@ -88,6 +88,9 @@ case "$reset_type" in
>  				# it is ok if this fails -- it may already
>  				# have been culled by checkout-index.
>  				unlink $_;
> +				while (s|/[^/]*$|| && $_ ne "") {
> +					rmdir($_) or last;
> +				}
>  			}
>  		}
>  	' $tmp-exists

I just ran it through the test script (t7101-reset.sh) that I
included in my patch and it passed, so clearly the version above
would be the better version to include.

Since it was untested before you are welcome to include the test
script with your version.  :-)

-- 
Shawn.
