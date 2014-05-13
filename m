From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 10/29] Run test_failed if the exit status of a test
 script is bad.
Date: Tue, 13 May 2014 17:58:50 -0400
Message-ID: <20140513215850.GM4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-11-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:58:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKim-0006Fv-3X
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaEMV6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:58:45 -0400
Received: from josefsipek.net ([64.9.206.49]:1560 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbaEMV6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:58:44 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 7B9A755654;
	Tue, 13 May 2014 17:58:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-11-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248870>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Tue, May 13, 2014 at 10:30:46PM +0200, Per Cederqvist wrote:
> There were two problems with the old code:
> 
>  - Since "set -e" is in effect (that is set in scaffold) the run-test
>    script exited immediately if a t-*.sh script failed.  This is not
>    nice, as we want the error report that test_failed prints.
> 
>  - The code ran "cd -" between running the t-*.sh script and checking
>    the exit status, so the exit status was lost.  (Actually, the exit
>    status was saved in $ERR, but nothing ever looked at $ERR.)
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/run-tests | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/regression/run-tests b/regression/run-tests
> index a10e796..8e0af9f 100755
> --- a/regression/run-tests
> +++ b/regression/run-tests
> @@ -55,11 +55,15 @@ function run_test
>  
>  	# run the test
>  	cd "$REPODIR" > /dev/null
> -	"$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"
> -	ERR=$?
> +	if "$REG_DIR/t-$1.sh" 2>&1 > "$LOGFILE"; then
> +		ERR=false
> +	else
> +		ERR=true
> +	fi
> +
>  	cd - > /dev/null
>  
> -	[ $? -ne 0 ] && test_failed
> +	$ERR && test_failed
>  	diff -u "t-$1.out" "$LOGFILE" || test_failed
>  
>  	echo "done."
> -- 
> 1.8.3.1
> 

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
