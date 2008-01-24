From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] HP-UX traditionally has no sys/select.h
Date: Thu, 24 Jan 2008 18:03:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801241758130.5731@racer.site>
References: <20080124175300.GI30676@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6Qj-0001Ta-0M
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYAXSDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYAXSDZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:03:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:55351 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752379AbYAXSDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:03:25 -0500
Received: (qmail invoked by alias); 24 Jan 2008 18:03:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 24 Jan 2008 19:03:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183/RF1UR83ffTPaSbwxIRvzT9tf/RqaCTXEHmrS/
	ZVFayuG7uXK0Zk
X-X-Sender: gene099@racer.site
In-Reply-To: <20080124175300.GI30676@schiele.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71637>

Hi,

On Thu, 24 Jan 2008, Robert Schiele wrote:

> The select stuff is already in sys/time.h on traditional HP-UX
> systems thus we should not include sys/select.h there because older
> releases don't have it.

Thank you for your patch.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index b6ef544..77de915 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -68,7 +68,9 @@
>  #include <sys/poll.h>
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
> +#ifndef __hpux
>  #include <sys/select.h>
> +#endif
>  #include <assert.h>
>  #include <regex.h>
>  #include <netinet/in.h>

We try to avoid using constructs like this.  Rather, we have a section in 
the Makefile which sets things like NO_IPV6=YesPlease, 
OLD_ICONV=UnfortunatelyYes, etc.

Later in the Makefile, dependent on this Makefile variable, symbols 
are defined. In the source code, we check for these symbols.

It is not only a matter of being able to reuse the same symbol for another 
platform/setup, it is also a nice way of documentation.

In your case, I suggest NO_SYS_SELECT_H=UnfortunatelyYes.

Thanks,
Dscho
