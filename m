From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] builtin-fetch.c (store_updated_refs): Honor update_local_ref() return value
Date: Wed, 28 May 2008 00:53:49 +0400
Message-ID: <20080527205348.GC32722@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 23:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K16LV-00009W-8o
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 23:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbYE0VDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756474AbYE0VDp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 17:03:45 -0400
Received: from vint.altlinux.org ([194.107.17.35]:42695 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbYE0VDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 17:03:45 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 May 2008 17:03:45 EDT
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 4D90CB489C3;
	Wed, 28 May 2008 00:53:49 +0400 (MSD)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 3E58BB44BCF; Wed, 28 May 2008 00:53:49 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83051>

Sync with builtin-fetch--tool.c where append_fetch_head()
honors update_local_ref() return value.

This fixes git-fetch exit status,
http://bugzilla.altlinux.org/show_bug.cgi?id=15037
---
 builtin-fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 167f948..db60966 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -292,7 +292,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, note_len, shown_url = 0;
+	int rc = 0, url_len, i, note_len, shown_url = 0;
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
@@ -359,7 +359,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 			note);
 
 		if (ref)
-			update_local_ref(ref, what, verbose, note);
+			rc |= update_local_ref(ref, what, verbose, note);
 		else if (verbose)
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
@@ -376,7 +376,7 @@ static int store_updated_refs(const char *url, struct ref *ref_map)
 		}
 	}
 	fclose(fp);
-	return 0;
+	return rc;
 }
 
 /*
-- 
ldv
