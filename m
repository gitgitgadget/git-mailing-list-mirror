From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mirror pushing
Date: Thu, 8 Nov 2007 15:03:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081441260.4362@racer.site>
References: <20071108121136.GG9736@shadowen.org> <1194531890.0@pinky>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:03:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8vD-0003U7-QY
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759549AbXKHPDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759479AbXKHPDj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:03:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:38381 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759156AbXKHPDi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:03:38 -0500
Received: (qmail invoked by alias); 08 Nov 2007 15:03:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 08 Nov 2007 16:03:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2TS89x2O2wZXaLh7mkuehPEcpEh6Qc09UdEAjNP
	x3a64l6l4LxI6x
X-X-Sender: gene099@racer.site
In-Reply-To: <1194531890.0@pinky>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64035>

Hi,

On Thu, 8 Nov 2007, Andy Whitcroft wrote:

> -		       nr_refspec, refspec, args.send_all))
> +		       nr_refspec, refspec, args.send_all | (args.send_mirror << 1)))

This line is too long.  But it needsmore love: it's all too magic to have 
a 1 for send_all, and a 2 for mirror.  Please introduce an enum for that 
in remote.h, and use those constants, so that this hunk and the following 
one cannot get out of sync that easily.

> +++ b/remote.c
> @@ -722,10 +722,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
>   * without thinking.
>   */
>  int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
> -	       int nr_refspec, const char **refspec, int all)
> +	       int nr_refspec, const char **refspec, int flags)
>  {
>  	struct refspec *rs =
>  		parse_ref_spec(nr_refspec, (const char **) refspec);
> +	int send_all = flags & 01;
> +	int send_mirror = flags & 02;
>  
>  	if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
>  		return -1;


Thanks,
Dscho
