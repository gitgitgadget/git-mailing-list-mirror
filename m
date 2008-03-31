From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/4] git-gc: add a --no-verify option to bypass the
	pre-auto-gc hook
Date: Mon, 31 Mar 2008 11:36:13 +0200
Message-ID: <e755e3fd6b48cd43c61ae6c0c610aaa7b5e166f0.1206929014.git.vmiklos@frugalware.org>
References: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGRm-0002pR-QV
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbYCaJgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbYCaJgP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:36:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11265 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623AbYCaJgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:36:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 016261B2586;
	Mon, 31 Mar 2008 11:36:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CD31144698;
	Mon, 31 Mar 2008 11:33:05 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DBF581190547; Mon, 31 Mar 2008 11:36:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78576>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-gc.txt |    4 ++++
 builtin-gc.c             |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index d424a4e..396da5c 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -62,6 +62,10 @@ automatic consolidation of packs.
 --quiet::
 	Suppress all progress reports.
 
+--no-verify::
+	This option bypasses the pre-auto-gc hook.
+	See also link:hooks.html[hooks].
+
 Configuration
 -------------
 
diff --git a/builtin-gc.c b/builtin-gc.c
index acd63be..1eca6b2 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -27,6 +27,7 @@ static int aggressive_window = -1;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static char *prune_expire = "2.weeks.ago";
+static int no_verify;
 
 #define MAX_ADD 10
 static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
@@ -196,7 +197,7 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
 
-	if (run_hook())
+	if (!no_verify && run_hook())
 		return 0;
 	return 1;
 }
@@ -214,6 +215,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
 		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
+		OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-auto-gc hook"),
 		OPT_END()
 	};
 
-- 
1.5.5.rc2.4.g283c6
