From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 10/22] Teach notes code to free its internal data
 structures on request
Date: Fri, 09 Oct 2009 12:22:06 +0200
Message-ID: <1255083738-23263-12-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:31:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClR-0004PL-SQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760689AbZJIKYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760686AbZJIKYH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:58012 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760685AbZJIKYG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:06 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BSDSTZ8I20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:47 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:47 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129771>

There's no need to be rude to memory-concious callers...

This patch has been improved by the following contributions:
- Junio C Hamano: avoid old-style declaration

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    7 +++++++
 notes.h |    3 +++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index b7d79e1..a5d888d 100644
--- a/notes.c
+++ b/notes.c
@@ -105,6 +105,13 @@ static unsigned char *lookup_notes(const unsigned char *commit_sha1)
 	return hash_map.entries[index].notes_sha1;
 }

+void free_notes(void)
+{
+	free(hash_map.entries);
+	memset(&hash_map, 0, sizeof(struct hash_map));
+	initialized = 0;
+}
+
 void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		const char *output_encoding, int flags)
 {
diff --git a/notes.h b/notes.h
index 7f3eed4..a1421e3 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,9 @@
 #ifndef NOTES_H
 #define NOTES_H

+/* Free (and de-initialize) the internal notes tree structure */
+void free_notes(void);
+
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2

--
1.6.4.304.g1365c.dirty
