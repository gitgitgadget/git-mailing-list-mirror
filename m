From: Junio C Hamano <junkio@cox.net>
Subject: Re: daemon.c fails to build on Darwin
Date: Thu, 28 Sep 2006 09:15:48 -0700
Message-ID: <7vbqp0vuff.fsf@assigned-by-dhcp.cox.net>
References: <86ejtw3sbv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyYE-000320-If
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWI1QPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWI1QPv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:15:51 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3226 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751728AbWI1QPu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:15:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928161549.EMLD6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 12:15:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TsFr1V00J1kojtg0000000
	Thu, 28 Sep 2006 12:15:51 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86ejtw3sbv.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "28 Sep 2006 08:48:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28014>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> If this is obvious, can someone fix it?  If not, I'll try to sort it out later
> tonight.
>
>     gcc -o daemon.o -c -g -O2 -Wall -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY daemon.c
>     daemon.c: In function 'fill_in_extra_table_entries':
>     daemon.c:460: error: 'HOST_NAME_MAX' undeclared (first use in this function)
>     daemon.c:460: error: (Each undeclared identifier is reported only once
>     daemon.c:460: error: for each function it appears in.)
>     daemon.c:460: warning: unused variable 'addrbuf'
>     make: *** [daemon.o] Error 1
>
> This is with 2d5b459107cf07bbb307cfb196c2007c497a6dd2.

Sorry about that.  Johannes sent a fix which I'll apply.

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] daemon: default to 256 for HOST_NAME_MAX if it is not defined
Date: Thu, 28 Sep 2006 12:00:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281200200.14200@wbgn013.biozentrum.uni-wuerzburg.de>

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	... or should we make it wider available, by putting it into
	cache.h?

 daemon.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 5335d21..fc3951c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -15,6 +15,10 @@ #include "cache.h"
 #include "exec_cmd.h"
 #include "interpolate.h"
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-- 
1.4.2.1.g430572-dirty
