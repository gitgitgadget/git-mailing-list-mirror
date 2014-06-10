From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 03/20] contrib/examples/git-commit.sh: avoid "test
 <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 11:36:39 -0700
Message-ID: <20140610183638.GA72751@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
 <1402066563-28519-4-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuQul-0004EK-Ca
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbaFJSgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:36:50 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36578 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbaFJSgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:36:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so6335538pdj.7
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qwclfPCD2XIHRvFvFxM6IaPWLaA350BklkpzuYo7jiw=;
        b=An1zNz7kvOpK6vd3xK4qpFKnL39Qr4WeNEoowXBEe/O73ejbXJ7VvXqJVscsjSe37Y
         mr+iIOFcMlGRi7gVtKR+n1a8i0j0j/5BT91eGbQg7Xr7h8nPYopKzrp3OMfr4GIQ6Dqg
         KpGGaU8HiBeX46uTlH6jWNasBBvhjOqYmWMsK5Zaj+tyrZa3/rvu157jkLDOHX3kP2vw
         2UkozA5E+0OpYaEVZWhs4IMivC/2n8QDDWJcw2QTNAOpVb/yYMYaXC2VKlTDQZaau1Pb
         doM0EKSaPWR0DLAcPTLNPR1HPTG5r8PXjmmdUe/w3ATLbgEc54vmJJem/LGZCv96438x
         DPRg==
X-Received: by 10.66.65.225 with SMTP id a1mr7278333pat.139.1402425409206;
        Tue, 10 Jun 2014 11:36:49 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id bz4sm70807968pbb.12.2014.06.10.11.36.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 11:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402066563-28519-4-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251208>

On Fri, Jun 06, 2014 at 07:55:46AM -0700, Elia Pinto wrote:
> The construct is error-prone; "test" being built-in in most modern
> shells, the reason to avoid "test <cond> && test <cond>" spawning
> one extra process by using a single "test <cond> -a <cond>" no
> longer exists.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/examples/git-commit.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/examples/git-commit.sh b/contrib/examples/git-commit.sh
> index 5cafe2e..934505b 100755
> --- a/contrib/examples/git-commit.sh
> +++ b/contrib/examples/git-commit.sh
> @@ -51,7 +51,7 @@ run_status () {
>  		export GIT_INDEX_FILE
>  	fi
>  
> -	if test "$status_only" = "t" -o "$use_status_color" = "t"; then
> +	if test "$status_only" = "t" || test "$use_status_color" = "t"; then
>  		color=
>  	else
>  		color=--nocolor

It might be worth moving the "then" to the next line so that it's
consistent with the preferred sh style and with the rest of the script.

If we do that then there's one less line that would need to be touched
by a future style-fix patch.

> @@ -296,7 +296,7 @@ t,,,[1-9]*)
>  	die "No paths with -i does not make sense." ;;
>  esac
>  
> -if test ! -z "$templatefile" -a -z "$log_given"
> +if test ! -z "$templatefile" && test -z "$log_given"
>  then
>  	if test ! -f "$templatefile"
>  	then
> -- 
> 1.7.10.4

-- 
David
