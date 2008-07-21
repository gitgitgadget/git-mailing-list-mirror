From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow pager of diff command be enabled/disabled
Date: Mon, 21 Jul 2008 23:28:49 +0200
Message-ID: <20080721212849.GB4748@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 23:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL2x5-0004nZ-Ne
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYGUV2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYGUV2w
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:28:52 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:57144 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbYGUV2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:28:51 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4EbVSQ==
Received: from tigra.home (Faa8f.f.strato-dslnet.de [195.4.170.143])
	by post.webmailer.de (fruni mo24) (RZmta 16.47)
	with ESMTP id v021f1k6LIVHCK ; Mon, 21 Jul 2008 23:28:49 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 664BD277BD;
	Mon, 21 Jul 2008 23:28:49 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 5BF7736D17; Mon, 21 Jul 2008 23:28:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89406>

See for example, status and show commands. Besides,
Documentation/RelNotes-1.6.0.txt mentions that pager.<cmd>
can be used to enable/disable paging behavior per command.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Also, really export check_pager_config, which just got another call
site.

 builtin-diff.c |    3 ++-
 builtin.h      |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index faaa85a..7ffea97 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -296,7 +296,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * If the user asked for our exit code then don't start a
 	 * pager or we would end up reporting its exit code instead.
 	 */
-	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
+	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS) &&
+	    check_pager_config("diff") != 0)
 		setup_pager();
 
 	/*
diff --git a/builtin.h b/builtin.h
index 0e605d4..f3502d3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -18,6 +18,7 @@ extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret);
+extern int check_pager_config(const char *cmd);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
-- 
1.6.0.rc0.24.g1329.dirty
