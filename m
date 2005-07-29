From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] socklen_t needs to be defined and libssl to be linked on old Mac OS X
Date: Thu, 28 Jul 2005 19:24:17 -0700
Message-ID: <7vfytyqrhq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0507281649230.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 04:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKYE-0008R7-KS
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVG2CYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVG2CYc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:24:32 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:26255 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262228AbVG2CY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:24:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022421.ZJRK7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:21 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On older Mac OS X (10.2.8), no socklen_t is defined, and therefore
> daemon.c does not compile. However, Mac OS X 10.4 seems to define
> socklen_t differently.
>
> Also, linking fails due to some symbols defined in libssl (not just
> libcrypto).

Hmph.  While I would want things to be portable, I prefer to
avoid platform specific #ifdef and conditional Makefile
constructs.

>    SHA1_HEADER=<openssl/sha.h>
> +ifeq ($(shell uname -s),Darwin)
> +  LIBS += -lcrypto -lssl
> +else
>    LIBS += -lcrypto
> +endif
>  endif
>  #include <arpa/inet.h>
> +#ifdef __APPLE__
> +typedef int socklen_t;
> +#endif

I'll keep this in the proposed updates queue until somebody
comes up with a bit cleaner solution.

By the way, Johannes, what mailer do you use?  Many of your
patches seem to be whitespace damaged.  For example:

> diff --git a/daemon.c b/daemon.c
> --- a/daemon.c
> +++ b/daemon.c
> @@ -5,6 +5,9 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
> +#ifdef __APPLE__
> +typedef int socklen_t;
> +#endif
>
>  static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";

The empty line before daemon_usage[] line should start with a
single SP but your message does not seem to have it.  I double
checked with the copy marc has:

    http://marc.theaimsgroup.com/?l=git&m=112256286508546&q=raw
