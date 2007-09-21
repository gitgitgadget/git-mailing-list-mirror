From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 4/4] t6000lib: workaround a possible dash bug
Date: Fri, 21 Sep 2007 21:28:08 +0800
Message-ID: <20070921132808.GB9778@gondor.apana.org.au>
References: <11486091793385-git-send-email-normalperson@yhbt.net> <11486091792604-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 15:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYiZP-0000Ar-7C
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 15:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954AbXIUN2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbXIUN2z
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 09:28:55 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:1226 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756252AbXIUN2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 09:28:54 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 4.50 #1 (Debian))
	id 1IYiYX-0001jT-5A; Fri, 21 Sep 2007 23:28:29 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1IYiYD-0002bT-00; Fri, 21 Sep 2007 21:28:09 +0800
Content-Disposition: inline
In-Reply-To: <11486091792604-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58850>

Hi Eric:

On Thu, May 25, 2006 at 07:06:18PM -0700, Eric Wong wrote:
> pdksh doesn't need this patch, of course bash works fine since
> that what most users use.
> 
> Normally, 'var=val command' seems to work fine with dash, but
> perhaps there's something weird going on with "$@".  dash is
> pretty widespread, so it'll be good to support this even though
> it does seem like a bug in dash.

Just going through dash issues right now.  Do you recall
what the bug is in this case? Doing a quick test doesn't
seem to show much:

dash -c 'set -- env; a=b "$@"'

> diff --git a/t/t6000lib.sh b/t/t6000lib.sh
> index c6752af..d402621 100755
> --- a/t/t6000lib.sh
> +++ b/t/t6000lib.sh
> @@ -69,7 +69,9 @@ on_committer_date()
>  {
>      _date=$1
>      shift 1
> -    GIT_COMMITTER_DATE=$_date "$@"
> +    export GIT_COMMITTER_DATE="$_date"
> +    "$@"
> +    unset GIT_COMMITTER_DATE
>  }
>  
>  # Execute a command and suppress any error output.
> -- 
> 1.3.2.g7d11

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
