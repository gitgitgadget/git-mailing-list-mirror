From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Make git-svn tests behave better on OS X
Date: Sat, 22 Mar 2008 12:35:18 -0700
Message-ID: <20080322193518.GA32019@soma>
References: <7vod98r210.fsf@gitster.siamese.dyndns.org> <1206084455-2793-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:36:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9WL-0001Nx-60
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbYCVTfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757267AbYCVTf2
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:35:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37274 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440AbYCVTfU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:35:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2B0127F4153;
	Sat, 22 Mar 2008 12:35:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1206084455-2793-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77841>

Kevin Ballard <kevin@sb.org> wrote:
> This patch works fine for me.
> 
> -->8--
> 
> Give lib-git-svn.sh a few alternate paths to look for apache2.
> Explicitly define the LockFile so httpd will actually start under OS X
> 
> Signed-off-by: Kevin Ballard <kevin@sb.org>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  t/lib-git-svn.sh |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 9ee35e7..9decd2e 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -49,8 +49,28 @@ poke() {
>  	test-chmtime +1 "$1"
>  }
>  
> -SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
> -SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
> +for d in \
> +	"$SVN_HTTPD_PATH" \
> +	/usr/sbin/apache2 \
> +	/usr/sbin/httpd \
> +; do
> +	if test -f "$d"
> +	then
> +		SVN_HTTPD_PATH="$d"
> +		break
> +	fi
> +done
> +for d in \
> +	"$SVN_HTTPD_MODULE_PATH" \
> +	/usr/lib/apache2/modules \
> +	/usr/libexec/apache2 \
> +; do
> +	if test -d "$d"
> +	then
> +		SVN_HTTPD_MODULE_PATH="$d"
> +		break
> +	fi
> +done
>  
>  start_httpd () {
>  	if test -z "$SVN_HTTPD_PORT"
> @@ -66,6 +86,7 @@ ServerName "git-svn test"
>  ServerRoot "$GIT_DIR"
>  DocumentRoot "$GIT_DIR"
>  PidFile "$GIT_DIR/httpd.pid"
> +LockFile logs/accept.lock
>  Listen 127.0.0.1:$SVN_HTTPD_PORT
>  LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
>  LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
> -- 
> 1.5.5.rc0.23.gf91eb
