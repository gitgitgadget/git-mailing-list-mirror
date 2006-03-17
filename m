From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exit code from git fetch
Date: Thu, 16 Mar 2006 22:23:00 -0800
Message-ID: <20060316222300.6f5dc9d9.akpm@osdl.org>
References: <7vek116253.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 17 07:26:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK8PM-0000YH-JL
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 07:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbWCQGZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 01:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbWCQGZt
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 01:25:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752547AbWCQGZs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 01:25:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2H6PiDZ032638
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 16 Mar 2006 22:25:44 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k2H6PiFI010941;
	Thu, 16 Mar 2006 22:25:44 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek116253.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17660>

Junio C Hamano <junkio@cox.net> wrote:
>
> When "git fetch" fails because the remote unexpectedly rewound
> its head and fast-forward check triggers, we issued a warning
> but kept going anyway.  This proposed patch makes the command
> exit with non-zero status.
> 
> I think this is a sensible change and makes it easier to use
> from scripts, but it might have other issues.  For example when
> you are tracking more than one heads from the remote, and the
> first one fast-forwards but the second one doesn't, it updates
> the first one and then stops.  If we happen to process the
> rewound one first, neither is updated because we stop at the
> first one.  I think this particular discrepancy probably is not
> worth worrying about, but there may be other more serious
> fallouts we need to fix if we did this.
> 
> Comments?
> 
> ---
> diff --git a/git-fetch.sh b/git-fetch.sh
> index 0346d4a..6835634 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -179,6 +179,7 @@ fast_forward_local () {
>  			;;
>  		*)
>  			echo >&2 "  not updating."
> +			exit 1
>  			;;
>  		esac
>  	    }

Thanks ;)

I guess you could exit with different exit codes according to what
went wrong.  So if a script writer really cared about the fine details,
appropriate decisions could be made.
