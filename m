From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2] safe_create_leading_directories(): on Windows, \ can separate path components
Date: Sun, 19 Jan 2014 00:40:44 +0100
Message-ID: <1390088444-11439-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 00:41:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4fW6-0008Ig-6B
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 00:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaARXlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 18:41:18 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59424 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891AbaARXlP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 18:41:15 -0500
X-AuditID: 1207440c-b7f566d000004272-14-52db111af8f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BA.5F.17010.A111BD25; Sat, 18 Jan 2014 18:41:14 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0INenjq032137
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 18:41:13 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqCsleDvI4MhOM4uuK91MFg29V5gt
	+pd3sVncXjGf2eL0zfnsDqwef99/YPLYOesuu8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAndHcv4mx4LlgxZNJZ5gaGBfydTFyckgImEg8PriaEcIWk7hwbz1bFyMXh5DAZUaJWxM3
	MEI4J5gkPu0+yAxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWWADo0TPxtfsIAlhgUSJnmm/wMay
	CKhKXLvdwwZi8wq4SDz4sRvI5gBapyCx+rrQBEbuBYwMqxjlEnNKc3VzEzNzilOTdYuTE/Py
	Uot0DfVyM0v0UlNKNzFCQoRnB+O3dTKHGAU4GJV4eDMYbgcJsSaWFVfmHmKU5GBSEuV1EAAK
	8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuEN3nArSIg3JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEk
	NTs1tSC1CCYrw8GhJMHrCjJUsCg1PbUiLTOnBCHNxMEJIrhANvAAbRAEKeQtLkjMLc5Mhyg6
	xagoJc4bD5IQAElklObBDYBF8ytGcaB/hHkDQap4gIkArvsV0GAmoMEisTdBBpckIqSkGhg1
	hV6qcgoaiPROC4i7t796zZzqD9dPOO9pvDNnzw0nYb4Tco+PWwXNM5r47KnVuW/2p60OHk45
	F7FstY9fzVSxl1dv75rxbds7hwimrysX2Ndcs3vydWNqTVeFxAP+NjO+zyq+vBW7uxIuO2xc
	sGaajhGztw3v3pv9FTGvdsTlekxacrcjIWaNEktxRqKhFnNRcSIAtgFSzcECAAA= 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240669>

When cloning to a directory "C:\foo\bar" from Windows' cmd.exe where
"foo" does not exist yet, Git would throw an error like

    fatal: could not create work tree dir 'c:\foo\bar'.: No such file or directory

Fix this by not hard-coding a platform specific directory separator
into safe_create_leading_directories().

This patch, including its entire commit message, is derived from a
patch by Sebastian Schuberth.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch applies on top of v3 of mh/safe-create-leading-directories.

The only logical change from Sebastian's patch is that this version
restores the original slash character rather than always restoring it
to '/' (as suggested by Junio).

Please note that I have merely adapted Sebastian's patch to apply on
top of my changes.  I do not have an opinion about whether slashes
should rather be normalized before they are passed to this function.
And I cannot test the patch under Windows (though it passes the test
suite under Linux).

 sha1_file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 8b0849f..6e8c05d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -112,17 +112,21 @@ enum scld_error safe_create_leading_directories(char *path)
 
 	while (ret == SCLD_OK && next_component) {
 		struct stat st;
-		char *slash = strchr(next_component, '/');
+		char *slash = next_component, slash_character;
 
-		if (!slash)
+		while (*slash && !is_dir_sep(*slash))
+			slash++;
+
+		if (!*slash)
 			break;
 
 		next_component = slash + 1;
-		while (*next_component == '/')
+		while (is_dir_sep(*next_component))
 			next_component++;
 		if (!*next_component)
 			break;
 
+		slash_character = *slash;
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
@@ -148,7 +152,7 @@ enum scld_error safe_create_leading_directories(char *path)
 		} else if (adjust_shared_perm(path)) {
 			ret = SCLD_PERMS;
 		}
-		*slash = '/';
+		*slash = slash_character;
 	}
 	return ret;
 }
-- 
1.8.5.2
