From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] clean up pathspec matching
Date: Wed, 14 Jan 2009 15:54:34 +0100
Message-ID: <1231944876-29930-2-git-send-email-drizzd@aon.at>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, johannes@familieschneider.info,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 15:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN79v-0004vJ-AE
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbZANOy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbZANOy1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:54:27 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:43210 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbZANOy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:54:26 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 15:54:22 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN78e-0007o7-R0; Wed, 14 Jan 2009 15:54:36 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1231944876-29930-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 14 Jan 2009 14:54:23.0279 (UTC) FILETIME=[FCD48BF0:01C97657]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105637>

If pathspec already matched exactly, it cannot match any more.
Originally, we had to continue anyways, because we did not
differentiate between exact, recursive and globbing matches.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 7c59829..87a9758 100644
--- a/dir.c
+++ b/dir.c
@@ -118,7 +118,7 @@ int match_pathspec(const char **pathspec, const char *name, int namelen, int pre
 
 	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
 		int how;
-		if (retval && *seen == MATCHED_EXACTLY)
+		if (*seen == MATCHED_EXACTLY)
 			continue;
 		match += prefix;
 		how = match_one(match, name, namelen);
-- 
1.6.1
