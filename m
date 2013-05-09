From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 3/3] Initialize variables with values
Date: Thu, 9 May 2013 14:40:22 +0200
Message-ID: <20130509124022.GA8685@shrek.podlesie.net>
References: <518AF79A.5000408@cs-ware.de>
 <518AF843.6040501@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Thu May 09 14:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaQGS-0006dP-LV
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 14:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab3EIMr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 08:47:59 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:49695 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3EIMr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 08:47:59 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2013 08:47:58 EDT
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 7554C7B1; Thu,  9 May 2013 14:40:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <518AF843.6040501@cs-ware.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223728>

On Thu, May 09, 2013 at 03:13:39AM +0200, Sven Strickroth wrote:
> With MSVC initializing a variable with "int a=a" causes a warning about
> using an uninitialized value.
> 
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---
>  builtin/rev-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 67701be..13afacd 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -338,7 +338,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		mark_edges_uninteresting(revs.commits, &revs, show_edge);
>  
>  	if (bisect_list) {
> -		int reaches = reaches, all = all;
> +		int reaches = 0, all = 0;
>  
>  		revs.commits = find_bisection(revs.commits, &reaches, &all,
>  					      bisect_find_all);

But this generates worse code, at least using gcc 4.7.2:

--- old	2013-05-09 14:33:22.000000000 +0200
+++ new	2013-05-09 14:33:02.000000000 +0200
@@ -1,2 +1,2 @@
    text	   data	    bss	    dec	    hex	filename
-   4283	      0	      0	   4283	   10bb	builtin/rev-list.o
+   4299	      0	      0	   4299	   10cb	builtin/rev-list.o

Krzysiek
