From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 2/4] git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
Date: Fri, 26 Feb 2010 22:59:49 -0500
Message-ID: <0ecbc2ed26f4fe0a253bd34f94ffae8f71f81aea.1267243044.git.larry@elder-gods.org>
References: <cover.1267242789.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 05:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlDqj-0003aU-Mv
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967779Ab0B0D7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 22:59:54 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:59104 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967749Ab0B0D7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 22:59:53 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 165C182201E; Fri, 26 Feb 2010 22:59:53 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
In-Reply-To: <cover.1267242789.git.larry@elder-gods.org>
In-Reply-To: <cover.1267243044.git.larry@elder-gods.org>
References: <cover.1267243044.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141173>

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
