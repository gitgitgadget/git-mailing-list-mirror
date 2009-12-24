From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Patch which adds syslog support to git-shell
Date: Thu, 24 Dec 2009 12:38:57 +0100
Message-ID: <40aa078e0912240338g7765d17cyf948650deab2aa01@mail.gmail.com>
References: <200912231832.03541.gerhard.gappmeier@ascolab.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 12:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNm27-0007z1-11
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 12:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176AbZLXLjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 06:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZLXLjA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 06:39:00 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:58135 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbZLXLi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 06:38:59 -0500
Received: by ey-out-2122.google.com with SMTP id 4so317332eyf.5
        for <git@vger.kernel.org>; Thu, 24 Dec 2009 03:38:57 -0800 (PST)
Received: by 10.216.90.21 with SMTP id d21mr3698639wef.85.1261654737086; Thu, 
	24 Dec 2009 03:38:57 -0800 (PST)
In-Reply-To: <200912231832.03541.gerhard.gappmeier@ascolab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135652>

Please read Documentation/SubmittingPatches. We prefer inline patches,
as they are easier to review.

On Wed, Dec 23, 2009 at 6:32 PM, Gerhard Gappmeier
<gerhard.gappmeier@ascolab.com> wrote:
> Hi
>
> I'm not sure if this is the right list, but here is my first GIT patch.
>

It's the right list :)

> I had a problem with git-shell and wanted to analyze it.
> Unfortunately it does not contain any trace capabilities.
> So I cloned git and added some basic syslog support.
> After that I recognized that the current git version just works ;-)
> but the syslog functionality is always a nice thing I think.
> So here is the patch.

Looking at your patch, I see there's a lot of white-space changes. Stuff like:

> -	const char *cvsserver_argv[3] = {
> -		"cvsserver", "server", NULL
> -	};
> +    const char *cvsserver_argv[3] = {
> +        "cvsserver", "server", NULL
> +    };

just makes this harder to review. Besides, we use tabs for indentation in git.

Also, I think it would be better to use set_die_routine() from usage.h
than to change all the die call-sites. This is what git-daemon does:

--->8---
	if (log_syslog) {
		openlog("git-daemon", LOG_PID, LOG_DAEMON);
		set_die_routine(daemon_die);
	}
--->8---
Look at daemon.c for the implementation of daemon_die().

+/* Syslog defines */
+#define GIT_SYSLOG_IDENT    "git-shell"
+#define GIT_SYSLOG_OPTION   0
+#define GIT_SYSLOG_FACILITY LOG_LOCAL0
+

Is this really needed? These are only used at one place. Just doing
+    openlog("git-shell", 0, LOG_LOCAL0);
would IMO be cleaner.

Anyway, this is all I bother to point out before I see an inlined,
white-space fixed patch.

> Merry X-Mas.

Happy holidays to you too :)

-- 
Erik "kusma" Faye-Lund
