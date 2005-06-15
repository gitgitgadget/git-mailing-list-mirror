From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [COGITO PATCH] Optimized print_help()
Date: Wed, 15 Jun 2005 02:00:01 +0200
Message-ID: <20050615000001.GB17152@diku.dk>
References: <1118791576.3890.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:55:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiLFW-0006fJ-5g
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 01:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFOAAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 20:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVFOAAL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 20:00:11 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:35818 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261428AbVFOAAD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2005 20:00:03 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 8C74A6E1FB2; Wed, 15 Jun 2005 01:59:06 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 53E3D6E1D39; Wed, 15 Jun 2005 01:59:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0C29861FE0; Wed, 15 Jun 2005 02:00:02 +0200 (CEST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1118791576.3890.4.camel@dv>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin <proski@gnu.org> wrote Tue, Jun 14, 2005:
> Hello!
> 
> print_help() in cg-Xlib should not be calling "which" 3 times.  It's an
> external command.  The patch caches the result in a local variable.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> diff --git a/cg-Xlib b/cg-Xlib
> --- a/cg-Xlib
> +++ b/cg-Xlib
> @@ -130,10 +130,11 @@ update_index () {
>  
>  
>  print_help () {
> -	which "cg-$1" >/dev/null 2>&1 || exit 1
> -	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $(which cg-$1) 
> +	local toolpath=$(which cg-$1 2>/dev/null)
> +	[ -z "$toolpath" ] && exit 1
> +	sed -n '/^USAGE=/,0s/.*"\(.*\)"/Usage: \1/p' < $toolpath

Shouldn't $toolpath be quoted here to make it safer? Although it seems
the make install don't handle irregular toolpaths at the moment.

>  	echo
> -	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
> +	cat $toolpath | sed -n '3,/^$/s/^# *//p'

What about also removing UUOC from this line ...

	sed -n '3,/^$/s/^# *//p' < "$toolpath"

>  	exit
>  }

-- 
Jonas Fonseca
