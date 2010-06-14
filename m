From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix strcat() on uninitialized memory
Date: Mon, 14 Jun 2010 18:19:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006141032250.2689@bonsai2>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 18:19:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCO4-0007aQ-Oh
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab0FNQTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:19:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:55935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756006Ab0FNQTi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:19:38 -0400
Received: (qmail invoked by alias); 14 Jun 2010 16:19:35 -0000
Received: from ASt-Lambert-153-1-65-129.w83-204.abo.wanadoo.fr (EHLO bonsai2.local) [83.204.196.129]
  by mail.gmx.net (mp037) with SMTP; 14 Jun 2010 18:19:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hqvo6okQhosoOdSipf3Qe+M57JJt1nTzPp8mqzY
	Jk46ky3VLtjgs9
X-X-Sender: gene099@bonsai2
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149123>


Under certain circumstances, this bug would trigger a buffer overflow
error with libc, and fail test 5516.

Strbufs would have avoided the issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 05071c3..1644424 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -569,9 +569,9 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	dst_cmd->skip_update = 1;
 
 	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
-	strcat(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
+	strcpy(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
 	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV));
-	strcat(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
+	strcpy(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name, cmd_oldh, cmd_newh,
-- 
1.7.1.msysgit.0.2.g2fefc8
