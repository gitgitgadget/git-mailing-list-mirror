From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 05/11] Use is_absolute_path() in sha1_file.c.
Date: Tue, 13 Nov 2007 21:05:00 +0100
Message-ID: <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21C-0001Be-Nz
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762488AbXKMUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762467AbXKMUFT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:19 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49200 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762488AbXKMUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:10 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 694C310ACA2;
	Tue, 13 Nov 2007 21:05:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64853>

There are some places that test for an absolute path. Use the helper
function to ease porting.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 sha1_file.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f007874..560c0e0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -86,7 +86,7 @@ int safe_create_leading_directories(char *path)
 	char *pos = path;
 	struct stat st;
 
-	if (*pos == '/')
+	if (is_absolute_path(path))
 		pos++;
 
 	while (pos) {
@@ -253,7 +253,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	int entlen = pfxlen + 43;
 	int base_len = -1;
 
-	if (*entry != '/' && relative_base) {
+	if (!is_absolute_path(entry) && relative_base) {
 		/* Relative alt-odb */
 		if (base_len < 0)
 			base_len = strlen(relative_base) + 1;
@@ -262,7 +262,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	}
 	ent = xmalloc(sizeof(*ent) + entlen);
 
-	if (*entry != '/' && relative_base) {
+	if (!is_absolute_path(entry) && relative_base) {
 		memcpy(ent->base, relative_base, base_len - 1);
 		ent->base[base_len - 1] = '/';
 		memcpy(ent->base + base_len, entry, len);
@@ -333,7 +333,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 		while (cp < ep && *cp != sep)
 			cp++;
 		if (last != cp) {
-			if ((*last != '/') && depth) {
+			if (!is_absolute_path(last) && depth) {
 				error("%s: ignoring relative alternate object store %s",
 						relative_base, last);
 			} else {
-- 
1.5.3.5.1592.g0d6db
