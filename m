From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git branch -D: give a better error message when lockfile creation fails
Date: Sat, 26 Sep 2009 01:53:06 +0200
Message-ID: <1253922786-23600-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 10:39:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrSoQ-0006oF-TK
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 10:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZIZIdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 04:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbZIZIdA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 04:33:00 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46093 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZIZIdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 04:33:00 -0400
Received: from vmobile.example.net (catv-89-134-193-228.catv.broadband.hu [89.134.193.228])
	by yugo.frugalware.org (Postfix) with ESMTPA id DB7B41A405
	for <git@vger.kernel.org>; Sat, 26 Sep 2009 10:33:02 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6DBF1183FA9; Sat, 26 Sep 2009 01:53:07 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129145>

Previously the old error message just told the user that it was not
possible to delete the ref from the packed-refs file. Give instructions
on how to resolve the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 24865cf..221d49c 100644
--- a/refs.c
+++ b/refs.c
@@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
 	if (!found)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0)
+	if (fd < 0) {
+		unable_to_lock_index_die(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
+	}
 
 	for (list = packed_ref_list; list; list = list->next) {
 		char line[PATH_MAX + 100];
-- 
1.6.5.rc1.44.ga1675.dirty
