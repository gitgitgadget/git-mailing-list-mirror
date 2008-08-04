From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH] Flush output in start_async
Date: Mon,  4 Aug 2008 02:30:03 +0200
Message-ID: <1217809803-23391-1-git-send-email-mail@cup.kalibalik.dk>
References: <7vej557hlq.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 04 02:31:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPnyh-0004Fn-8E
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 02:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYHDAaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYHDAaG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 20:30:06 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:53032 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbYHDAaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 20:30:06 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 8011014062;
	Mon,  4 Aug 2008 02:30:02 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 5A1791405A;
	Mon,  4 Aug 2008 02:30:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <7vej557hlq.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91299>

This prevents double output in case stdout is redirected.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 run-command.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index a3b28a6..6af83c5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -304,6 +304,9 @@ int start_async(struct async *async)
 	async->out = pipe_out[0];
 
 #ifndef __MINGW32__
+	/* Flush stdio before fork() to avoid cloning buffers */
+	fflush(NULL);
+
 	async->pid = fork();
 	if (async->pid < 0) {
 		error("fork (async) failed: %s", strerror(errno));
-- 
1.5.6.4
