From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFT] upload-pack.c: <sys/poll.h> includes <ctype.h> on OpenBSD 3.8
Date: Fri, 30 Jun 2006 11:30:29 -0700
Message-ID: <7vr716h4xm.fsf_-_@assigned-by-dhcp.cox.net>
References: <86wtayy42o.fsf@blue.stonehenge.com>
	<7vy7veindn.fsf@assigned-by-dhcp.cox.net>
	<86sllmy3ia.fsf@blue.stonehenge.com>
	<7vk66yilxd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Fri Jun 30 20:30:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwNlE-0004Yx-3Y
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 20:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007AbWF3Sad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933021AbWF3Sad
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 14:30:33 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27551 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S933007AbWF3Sac (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 14:30:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630183030.GWYS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 14:30:30 -0400
To: git@vger.kernel.org
In-Reply-To: <7vk66yilxd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 30 Jun 2006 10:38:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23013>

Merlyn reports that <sys/poll.h> on OpenBSD 3.8 includes <ctype.h>
and having our custom ctype (done in git-compat-util.h which is
included via cache.h) makes upload-pack.c uncompilable.  Try to
work it around by including the system headers first.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Can somebody with OpenBSD who can reproduce the original
   problem confirm or reject this patch, so that the issue can
   be resolved before 1.4.1, please?

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
 
