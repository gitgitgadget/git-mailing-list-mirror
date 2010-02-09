From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 3/4] git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
Date: Tue,  9 Feb 2010 00:54:01 -0500
Message-ID: <45357037fd8f928759c9e9064736c62e793b84be.1265694627.git.larry@elder-gods.org>
References: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 06:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nej3M-0006T5-Qg
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 06:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab0BIFyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 00:54:08 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:36726 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0BIFyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 00:54:06 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id E9547822015; Tue,  9 Feb 2010 00:54:02 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc1.33.g07cf0f.dirty
In-Reply-To: <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org>
In-Reply-To: <20100209054820.GA30907@cthulhu>
References: <20100209054820.GA30907@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139366>

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
index 3846aac..fb653c6 100644
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
1.7.0.rc1.33.g07cf0f.dirty
