From: Junio C Hamano <junkio@cox.net>
Subject: Re: no "uname -o" on Mac OSX
Date: Sun, 09 Oct 2005 12:27:00 -0700
Message-ID: <7voe5yebjv.fsf@assigned-by-dhcp.cox.net>
References: <86k6gnm0sz.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: merlyn@stonehenge.com (Randal L. Schwartz), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 21:28:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOgpA-0003d2-RI
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 21:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJIT1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVJIT1E
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 15:27:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33527 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932256AbVJIT1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 15:27:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051009192643.HJP2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Oct 2005 15:26:43 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <86k6gnm0sz.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "09 Oct 2005 03:39:40 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9868>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Recently, a change was made to git/Makefile to invoke "uname -o".
> This isn't portable to OSX/Darwin.  Is there a chance this information
> can be obtained some other way, or not invoked on darwni?

Peter, I noticed the same on Solaris recently.

The following seems to work but is quite yucky, and I prefer
somebody to come up with a better alternative.

    ------------
Makefile: 'uname -o' is not portable.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Makefile b/Makefile
index 7ba3eeb..ba048cb 100644
--- a/Makefile
+++ b/Makefile
@@ -180,7 +180,7 @@ ifeq ($(shell uname -s),SunOS)
 	TAR = gtar
 	PLATFORM_DEFINES += -D__EXTENSIONS__
 endif
-ifeq ($(shell uname -o),Cygwin)
+ifeq ($(shell sh -c 'uname -o 2>/dev/null || echo not'),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_IPV6 = YesPlease
