From: Jeff King <peff@peff.net>
Subject: [PATCH] rev-list: fix segfault with --{author,committer,grep}
Date: Mon, 18 Sep 2006 02:52:42 -0400
Message-ID: <20060918065242.GA13691@coredump.intra.peff.net>
References: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 08:52:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCzo-0007cW-6r
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965496AbWIRGwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965499AbWIRGwp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:52:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:63178 "HELO
	peff.net") by vger.kernel.org with SMTP id S965496AbWIRGwp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 02:52:45 -0400
Received: (qmail 27926 invoked from network); 18 Sep 2006 02:51:56 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 18 Sep 2006 02:51:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Sep 2006 02:52:42 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pv6yphp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27238>

We need to save the commit buffer if we're going to match against it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-rev-list.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 1f3333d..dbfee75 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -269,7 +269,9 @@ int cmd_rev_list(int argc, const char **
 	    revs.diff)
 		usage(rev_list_usage);
 
-	save_commit_buffer = revs.verbose_header;
+	save_commit_buffer = revs.verbose_header ||
+		revs.header_filter ||
+		revs.message_filter;
 	track_object_refs = 0;
 	if (bisect_list)
 		revs.limited = 1;
-- 
1.4.2.1.g9f1c-dirty
