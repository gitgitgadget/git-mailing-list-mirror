From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] git-tar-tree: no more void pointer arithmetic
Date: Sun, 18 Jun 2006 12:58:01 +0200
Message-ID: <11506282812751-git-send-email-rene.scharfe@lsrfire.ath.cx>
Reply-To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 18 12:58:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fruz7-0007M4-59
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 12:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFRK6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 06:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWFRK6E
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 06:58:04 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40878
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751142AbWFRK6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 06:58:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by neapel230.server4you.de (Postfix) with ESMTP id C9E9A27025;
	Sun, 18 Jun 2006 12:58:01 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22070>

Noticed by Florian Forster: Use a char pointer when adding offsets,
because void pointer arithmetic is a GNU extension.   Const'ify the
function arguments while we're at it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-tar-tree.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f646c5b..03dd8be 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -22,8 +22,10 @@ static unsigned long offset;
 static time_t archive_time;
 
 /* tries hard to write, either succeeds or dies in the attempt */
-static void reliable_write(void *buf, unsigned long size)
+static void reliable_write(const void *data, unsigned long size)
 {
+	const char *buf = data;
+
 	while (size > 0) {
 		long ret = xwrite(1, buf, size);
 		if (ret < 0) {
@@ -51,8 +53,9 @@ static void write_if_needed(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static void write_blocked(void *buf, unsigned long size)
+static void write_blocked(const void *data, unsigned long size)
 {
+	const char *buf = data;
 	unsigned long tail;
 
 	if (offset) {
-- 
1.4.0
