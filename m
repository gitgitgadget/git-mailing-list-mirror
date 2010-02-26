From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 3/4] git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
Date: Fri, 26 Feb 2010 14:50:09 -0500
Message-ID: <f500555aab2c44879c159e80e5388e965848bb59.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 20:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6D0-000758-Km
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 20:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965921Ab0BZTuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 14:50:18 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:37692 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965905Ab0BZTuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 14:50:15 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 79B93822021; Fri, 26 Feb 2010 14:50:11 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
In-Reply-To: <cover.1267211537.git.larry@elder-gods.org>
References: <cover.1267211537.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141143>

git-push prints the line "To <remoteurl>" before above each of the ref status
lines.  In --porcelain mode, these "To <remoteurl>" lines go to the standard
error, but the ref status lines go to the standard output.  This makes it
difficult for the process reading standard output to know which ref status lines
correspond to which remote.  This patch sends the "To <remoteurl>" lines to the
the standard output instead.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 08e4fa0..32885f7 100644
--- a/transport.c
+++ b/transport.c
@@ -675,7 +675,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
 	if (!count)
-		fprintf(stderr, "To %s\n", dest);
+		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
-- 
1.7.0.rc2.40.g7d8aa
