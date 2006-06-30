From: Junio C Hamano <junkio@cox.net>
Subject: Re: fc046a75d539a78e6b2c16534c4078617a69a327 fails on OpenBSD 3.8
Date: Fri, 30 Jun 2006 10:38:06 -0700
Message-ID: <7vk66yilxd.fsf@assigned-by-dhcp.cox.net>
References: <86wtayy42o.fsf@blue.stonehenge.com>
	<7vy7veindn.fsf@assigned-by-dhcp.cox.net>
	<86sllmy3ia.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 19:38:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMwY-0004gj-Bd
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbWF3RiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932863AbWF3RiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:38:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9447 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932854AbWF3RiI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 13:38:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630173807.SMKY19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 13:38:07 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86sllmy3ia.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "30 Jun 2006 10:09:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23004>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>...
>>> In file included from /usr/include/sys/poll.h:54,
>>> from upload-pack.c:9:
>>> /usr/include/ctype.h:91:1: unterminated #if
>>> /usr/include/ctype.h:40:1: unterminated #ifndef
>
> Junio> Crap.  Including <sys/poll.h> pollutes your namespace with ctype
> Junio> macros?

I should stop imitating others -- not my style.  Sorry.
Would this work for you?

diff --git a/upload-pack.c b/upload-pack.c
index 2b70c3d..b18eb9b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,3 +1,6 @@
+#include <signal.h>
+#include <sys/wait.h>
+#include <sys/poll.h>
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
@@ -5,9 +8,6 @@ #include "tag.h"
 #include "object.h"
 #include "commit.h"
 #include "exec_cmd.h"
-#include <signal.h>
-#include <sys/poll.h>
-#include <sys/wait.h>
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
