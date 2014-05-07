From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 24/28] disp no longer processes backslashes.
Date: Wed, 7 May 2014 17:15:02 -0400
Message-ID: <20140507211502.GC1459@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-25-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 07 23:15:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi9B9-0005cO-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbaEGVO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:14:59 -0400
Received: from josefsipek.net ([64.9.206.49]:1731 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbaEGVO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:14:58 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id BEAD355654;
	Wed,  7 May 2014 17:14:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-25-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248379>

On Fri, Mar 21, 2014 at 08:32:02AM +0100, Per Cederqvist wrote:
> Only one invocation of "disp" or "_disp" actually needed backslash
> processing.  In quite a few instances, it was wrong to do backslash
> processing, as the message contained data derived from the user.
> 
> Created the new function "disp_e" that should be used when backslash
> processing is required, and changed "disp" and "disp_" to use printf

s/disp_/_disp/

otherwise LGTM

> code %s instead of "%b".
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/guilt b/guilt
> index ca922aa..36cfd1e 100755
> --- a/guilt
> +++ b/guilt
> @@ -36,15 +36,24 @@ usage()
>  	exit 1
>  }
>  
> -# echo -n is a bashism, use printf instead
> +# Print arguments, but no trailing newline.
> +# (echo -n is a bashism, use printf instead)
>  _disp()
>  {
> -	printf "%b" "$*"
> +	printf "%s" "$*"
>  }
>  
> -# echo -e is a bashism, use printf instead
> +# Print arguments.
> +# (echo -E is a bashism, use printf instead)
>  disp()
>  {
> +	printf "%s\n" "$*"
> +}
> +
> +# Print arguments, processing backslash sequences.
> +# (echo -e is a bashism, use printf instead)
> +disp_e()
> +{
>  	printf "%b\n" "$*"
>  }
>  
> @@ -117,7 +126,7 @@ else
>  
>  	disp ""
>  	disp "Example:"
> -	disp "\tguilt push"
> +	disp_e "\tguilt push"
>  
>  	# now, let's exit
>  	exit 1
> -- 
> 1.8.3.1
> 

-- 
We have joy, we have fun, we have Linux on a Sun...
