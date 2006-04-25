From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 3/5] commit.c: parse 'prior' link
Date: Tue, 25 Apr 2006 16:31:07 +1200
Message-ID: <20060425043106.18382.7251.stgit@localhost.localdomain>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-From: git-owner@vger.kernel.org Tue Apr 25 06:32:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFDV-0000IJ-8L
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 06:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWDYEbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 00:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWDYEbx
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 00:31:53 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:48362 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751301AbWDYEbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 00:31:52 -0400
Received: from samv by mail1.catalyst.net.nz with local (Exim 4.50)
	id 1FYFDK-0004Do-K7
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:31:50 +1200
To: git@vger.kernel.org
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19125>

From: Sam Vilain <sam.vilain@catalyst.net.nz>

Parse for the 'prior' link in a commit
---

 commit.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 2717dd8..e4bc396 100644
--- a/commit.c
+++ b/commit.c
@@ -260,6 +260,18 @@ int parse_commit_buffer(struct commit *i
 			n_refs++;
 		}
 	}
+	if (!memcmp(bufptr, "prior ", 6)) {
+		unsigned char prior[20];
+		if (get_sha1_hex(bufptr + 6, prior) || bufptr[46] != '\n')
+			return error("bad prior in commit %s", sha1_to_hex(item->object.sha1));
+		bufptr += 47;
+
+		item->prior = xmalloc(21);
+		strncpy(item->prior, (char*)&prior, 20);
+		item->prior[20] = '\0';
+	} else {
+		item->prior = 0;
+	}
 	if (graft) {
 		int i;
 		struct commit *new_parent;
