From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Fri, 30 Mar 2012 22:48:02 -0500
Message-ID: <20120331034802.GB2475@burratino>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, j.sixt@viscovery.net, gitster@pobox.com,
	git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Mar 31 05:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDpIU-0006oJ-3I
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 05:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab2CaDsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 23:48:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48226 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389Ab2CaDsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 23:48:07 -0400
Received: by iagz16 with SMTP id z16so1801178iag.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 20:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T//MyBmmyk7fFsjW+jga2JMyCDNHa0cGpyr40vFXCS4=;
        b=kmd9NHqZzPd2h8HIcEK6Zx41+bPxsU9nWQTZHeZIb7PV0I1lWNzHlwKRpxbcjY2zD+
         2jJ6McyYv7Xnh206cYrCH8nxM6zyQBnKFAhLIKtkE/xoeEakPdvi/UcYSqCf1LfNdQC+
         GucxaKXfXq54/FfXRHbHXWgvZQhkoa/IhS4N1nVDB8KxJr60qiYPvTNkSjdJlBXscqXA
         C53F/vQa0Spcpz8MSCpwmyBAVjk0e+WPf8MOG7iTQzALsbNGoognPxX4vfQCrngH4TGn
         FdkUE/hcQMTpKDkwmdQI9yOOnytTKariynx+BaOHmGWjPa8xS727DF6HYaOuomhevEhz
         qJxw==
Received: by 10.50.161.228 with SMTP id xv4mr656699igb.19.1333165686614;
        Fri, 30 Mar 2012 20:48:06 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vr4sm12171387igb.1.2012.03.30.20.48.05
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 20:48:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194429>

Ben Walton wrote:

> During the testing of the 1.7.10 rc series on Solaris for OpenCSW, it
> was discovered that t7006-pager was failing
[...]
> --- a/run-command.c
> +++ b/run-command.c
> @@ -4,6 +4,10 @@
>  #include "sigchain.h"
>  #include "argv-array.h"
>  
> +#ifndef SHELL_PATH
> +# define SHELL_PATH "/bin/sh"
> +#endif
> +
>  struct child_to_clean {
>  	pid_t pid;
>  	struct child_to_clean *next;
> @@ -90,7 +94,7 @@ static const char **prepare_shell_cmd(const char **argv)
>  		die("BUG: shell command is empty");
>  
>  	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
> -		nargv[nargc++] = "sh";
> +		nargv[nargc++] = SHELL_PATH;

The underlying problem is an old one.  Thanks for fixing it.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> Essentially, the shell is a
> special case of tool that should not rely on SANE_TOOL_PATH and must
> be called explicitly.

It is probably annoying to hear me say this, but:

The above doesn't tell me _why_ it is a special case and that on
Solaris users have been burned by "sh" being the original Bourne shell
or a temperamental version of ksh so SHELL_PATH usually points to bash
or ksh93 instead.

I trust the reader enough to fill in the blank, though, so I think the
patch is ok as is.
