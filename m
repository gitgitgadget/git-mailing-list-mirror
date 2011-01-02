From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Sun, 2 Jan 2011 01:59:53 -0600
Message-ID: <20110102075953.GB8937@burratino>
References: <20110102060044.GJ19818@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 02 09:00:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZIs3-0008Bs-5p
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 09:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727Ab1ABIAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 03:00:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59642 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1ABIAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 03:00:00 -0500
Received: by iwn9 with SMTP id 9so12590250iwn.19
        for <git@vger.kernel.org>; Sat, 01 Jan 2011 23:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q3WztsiIpt3rdpmUfbgeYr7jbjf/cu3Kj1kpquUb0ZI=;
        b=a7gvRZMC38ccQoX+pJg1VLpwQ9V9vxMe3DMl5LbvaYbYCexTqVqNMrzV0WZJjaCUSa
         H2t08I9ZW/wzw2S1TuZKMdT209UmHjSQEiKojax61L1vxbLGm9upXaO8CflRN1wNychT
         VJxpH43crL2RQuikuLkCPPfg0Yypi/A3WMiCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ViIAbCK8uSUkUZ3UaN1QHUoNKiB/upO9/jjRrB5cobv1mA98mQ58sYVOR5WtbqD9cF
         ERlLO0LVFK1T1jRO5BopF+icJc+bMSrob62Xx6T67M7ekTdz0mtduEHpoPBzhBjjDxuO
         ynFoUEdpJWWZ0AWW7oBSqDkyNrZoZ1HpKbbMs=
Received: by 10.42.213.136 with SMTP id gw8mr19696951icb.359.1293955199665;
        Sat, 01 Jan 2011 23:59:59 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id d21sm17424046ibg.3.2011.01.01.23.59.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 Jan 2011 23:59:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110102060044.GJ19818@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164412>

Ralf Wildenhues wrote:

> This avoids warnings from Autoconf 2.68 about missing use of
> AC_LANG_PROGRAM and friends.
> 
> Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
> ---
> 
> The patch should not cause any semantic changes in the generated
> configure script.

This part belongs in the commit message too, imho (though no need to
resend just for that, of course).

> --- a/configure.ac
> +++ b/configure.ac
> @@ -345,7 +345,7 @@ esac
>  AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
>     SAVE_LDFLAGS="${LDFLAGS}"
>     LDFLAGS="${SAVE_LDFLAGS} -R /"
> -   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])
> +   AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])], [git_cv_ld_dashr=yes], [git_cv_ld_dashr=no])

Could you say a few words about the effect of this?  Mostly because
it would be useful to people down the line tempted to make the same
mistake again.

> @@ -500,7 +494,7 @@ for l in $lib_order; do
>      old_LIBS="$LIBS"
>      LIBS="$LIBS $l"
>      AC_MSG_CHECKING([for iconv in $l])
> -    AC_LINK_IFELSE(ICONVTEST_SRC,
> +    AC_LINK_IFELSE([ICONVTEST_SRC],

I'm curious about this one, too.

> @@ -931,18 +915,16 @@ AC_SUBST(NO_INITGROUPS)
>  #
>  # Define PTHREAD_LIBS to the linker flag used for Pthread support.
>  AC_DEFUN([PTHREADTEST_SRC], [
> +AC_LANG_PROGRAM([[
>  #include <pthread.h>
> -
> -int main(void)
> -{
> +]], [[
>  	pthread_mutex_t test_mutex;

By the way, what problem is the warning about AC_LANG_PROGRAM meant to
prevent?  (Just curious.  A five-minute google search didn't reveal
anything obvious.)

Thanks,
Jonathan
