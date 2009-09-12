From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 10/14] Teach notes code to free its internal data structures
 on request.
Date: Sat, 12 Sep 2009 18:08:44 +0200
Message-ID: <1252771728-27206-11-git-send-email-johan@herland.net>
References: <200909121752.07523.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 18:09:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVAd-0008SS-JD
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZILQJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754752AbZILQJg
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:09:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39547 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754682AbZILQJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:09:25 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003BM8VTQZ70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:29 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0048W8V0EM30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:29 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.155718
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <200909121752.07523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128261>

There's no need to be rude to memory-concious callers...

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    7 +++++++
 notes.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index 84c30c1..008c3d4 100644
--- a/notes.c
+++ b/notes.c
@@ -160,3 +160,10 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 
 	free(msg);
 }
+
+void free_commit_notes()
+{
+	free(hash_map.entries);
+	memset(&hash_map, 0, sizeof(struct hash_map));
+	initialized = 0;
+}
diff --git a/notes.h b/notes.h
index 7f3eed4..41802e5 100644
--- a/notes.h
+++ b/notes.h
@@ -7,4 +7,6 @@
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		const char *output_encoding, int flags);
 
+void free_commit_notes();
+
 #endif
-- 
1.6.4.304.g1365c.dirty
