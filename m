From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] configure.ac: check 'tv_nsec' field in 'struct stat'
Date: Fri, 9 Jan 2015 00:36:15 -0500
Message-ID: <CAPig+cRpD0B2YRZYyJVUiM70AFcduTPOuJsuRFFKZE+bXttW1Q@mail.gmail.com>
References: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 06:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9SFC-0003fS-6U
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 06:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbbAIFgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 00:36:17 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:37895 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbAIFgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 00:36:16 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so3170755ykp.11
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 21:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kUKiUjamWV5/EDASrZ4MhsN3f5jf+IHwvLHOIz7Dz18=;
        b=TaAIItXB9Gp+znm3K2GuAgbd7zahuYw99DFyqo4rjzCWuk1WExbtFQZ2EQSOvo8lzF
         8gUr5E12YvhAaBeB+SVoH8wVTuiXWsLlPJ8gMqCqFpYcL2InwH8wFoqNaaPYCqQO9Hkv
         FUHT+GHwJ87xeB1ee4jnOZyMjIKtEx+Bi3yx5cLO4t356QZfYasCGNwzG82kCCTbtln5
         z8QvIZ7eqpBcfwlRqY8S8V3x2PF/W7JaZg8d7jpoMPGMZ3QjqK64QxiA9W7tiXUNgtG2
         EyoXptr6pj2EEuweFtmbSAXQXoXoTVuSZDqIXsvB/sU0lzR+4dhnpAVVo8QUn8zrBxGY
         +7Qg==
X-Received: by 10.236.202.238 with SMTP id d74mr9755373yho.166.1420781776001;
 Thu, 08 Jan 2015 21:36:16 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Thu, 8 Jan 2015 21:36:15 -0800 (PST)
In-Reply-To: <1420747257-16132-1-git-send-email-reubenhwk@gmail.com>
X-Google-Sender-Auth: iGs0raLiLQQQOlCJ6lqLtTDXBKY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262228>

On Thu, Jan 8, 2015 at 3:00 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> Detect 'tv_nsec' field in 'struct stat' and set Makefile variable
> NO_NSEC appropriately.
>
> A side-effect of the above detection is that we also determine
> whether 'stat.st_mtimespec' is available, so, as a bonus, set the
> Makefile variable USE_ST_TIMESPEC, as well.
>
> Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>

These patches may or may not deserve a Helped-by:.

With or without the Helped-by: and the minor style fix-up below...

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thanks for the perseverance.

For convenience of other reviewers: This is v3. v1 through v3 are
threaded together here:
http://thread.gmane.org/gmane.comp.version-control.git/261619

> ---
> diff --git a/configure.ac b/configure.ac
> index 6af9647..210eb4e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -754,6 +754,19 @@ AC_CHECK_TYPES([struct itimerval],
>  [#include <sys/time.h>])
>  GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
>  #
> +# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exists.
> +# Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor
> +# stat.st_mtimespec.tv_nsec exists.
> +AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec])
> +AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])
> +if test x$ac_cv_member_struct_stat_st_mtimespec_tv_nsec = xyes ; then

Style: For consistency with all other 'if' conditionals in
configure.ac, drop the space before the semicolon.

> +       USE_ST_TIMESPEC=YesPlease
> +       GIT_CONF_SUBST([USE_ST_TIMESPEC])
> +elif test x$ac_cv_member_struct_stat_st_mtim_tv_nsec != xyes ; then

Ditto.

> +       NO_NSEC=YesPlease
> +       GIT_CONF_SUBST([NO_NSEC])
> +fi
> +#
>  # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
>  AC_CHECK_MEMBER(struct dirent.d_ino,
>  [NO_D_INO_IN_DIRENT=],
> --
> 2.2.0.68.g8f72f0c.dirty
