From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 10/14] Teach notes code to free its internal data structures
 on request.
Date: Tue, 08 Sep 2009 04:26:58 +0200
Message-ID: <1252376822-6138-11-git-send-email-johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 04:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkqRh-0005lE-ND
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 04:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbZIHC1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 22:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbZIHC1x
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 22:27:53 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34059 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753438AbZIHC1b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 22:27:31 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM00CZ6S5WLI90@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:32 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPM0072GS5GQN30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 04:27:32 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.9.8.21525
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1252376822-6138-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127964>

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
