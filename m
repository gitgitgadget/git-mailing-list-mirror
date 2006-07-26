From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] git-instaweb: Fall back to Apache when LigHTTP was not found
Date: Wed, 26 Jul 2006 12:22:31 -0700
Message-ID: <7vr708qih4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607261633560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 21:22:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5oxo-0008T8-1C
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 21:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGZTWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 15:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWGZTWd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 15:22:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13290 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751037AbWGZTWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 15:22:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726192232.PYKP6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 15:22:32 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607261633560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 26 Jul 2006 16:34:10 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24240>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Apache is more likely to be installed...
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  git-instaweb.sh |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 1d3ea73..242b55e 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -25,9 +25,6 @@ conf=$GIT_DIR/gitweb/httpd.conf
>  
>  # Defaults:
>  
> -# if installed, it doesn't need further configuration (module_path)
> -test -z "$httpd" && httpd='lighttpd -f'
> -
>  # probably the most popular browser among gitweb users
>  test -z "$browser" && browser='firefox'
>  
> @@ -135,6 +132,15 @@ do
>  	shift
>  done
>  
> +# if installed, it doesn't need further configuration (module_path)
> +if [ -z "$httpd" ]; then
> +	httpd='lighttpd -f'
> +	which "$httpd" >/dev/null 2>&1 || httpd='apache2 -f'
> +	which "$httpd" >/dev/null 2>&1 || httpd='apache -f'
> +	which "$httpd" >/dev/null 2>&1 || httpd='httpd -f'
> +	which "$httpd" >/dev/null || exit 1
> +fi
> +

Please don't use "which" in scripts.  Consult this thread:

http://thread.gmane.org/gmane.comp.version-control.git/23382/focus=23394
