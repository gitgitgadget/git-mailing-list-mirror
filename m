From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH resend 1/2] Make git-svn tests behave better on OS X
Date: Thu, 20 Mar 2008 23:58:24 -0700
Message-ID: <20080321065824.GB28144@muzzle>
References: <1206043729-61810-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:59:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcbDW-00008e-Qm
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 07:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbYCUG6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 02:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbYCUG6Z
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 02:58:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:36533 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbYCUG6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 02:58:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 766A87F4153;
	Thu, 20 Mar 2008 23:58:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1206043729-61810-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77724>

Kevin Ballard <kevin@sb.org> wrote:
> Give lib-git-svn.sh some better defaults for OS X.
> Explicitly define the LockFile so httpd will actually start under OS X
> 
> Signed-off-by: Kevin Ballard <kevin@sb.org>

Thanks,

Acked-by: Eric Wong <normalperson@yhbt.net>

I seem to recall seeing a RHEL or CentOS machine using /usr/sbin/httpd,
somewhere, too.  Any non-Debian users care to comment/add more paths?

> ---
>  t/lib-git-svn.sh |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 9ee35e7..1266609 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -49,8 +49,14 @@ poke() {
>  	test-chmtime +1 "$1"
>  }
>  
> -SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
> -SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
> +if test `uname -s` = Darwin
> +then
> +	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/libexec/apache2'}
> +	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/httpd'}
> +else
> +	SVN_HTTPD_MODULE_PATH=${SVN_HTTPD_MODULE_PATH-'/usr/lib/apache2/modules'}
> +	SVN_HTTPD_PATH=${SVN_HTTPD_PATH-'/usr/sbin/apache2'}
> +fi
>  
>  start_httpd () {
>  	if test -z "$SVN_HTTPD_PORT"
> @@ -66,6 +72,7 @@ ServerName "git-svn test"
>  ServerRoot "$GIT_DIR"
>  DocumentRoot "$GIT_DIR"
>  PidFile "$GIT_DIR/httpd.pid"
> +LockFile logs/accept.lock
>  Listen 127.0.0.1:$SVN_HTTPD_PORT
>  LoadModule dav_module $SVN_HTTPD_MODULE_PATH/mod_dav.so
>  LoadModule dav_svn_module $SVN_HTTPD_MODULE_PATH/mod_dav_svn.so
> -- 
