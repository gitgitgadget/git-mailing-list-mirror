From: mhagger@alum.mit.edu
Subject: [PATCH 09/15] free_ref_entry(): new function
Date: Tue, 10 Apr 2012 07:30:21 +0200
Message-ID: <1334035827-20331-10-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTg2-0002SQ-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab2DJFbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59266 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2DJFbO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe2000870;
	Tue, 10 Apr 2012 07:30:55 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195072>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a function free_ref_entry().  This function will become nontrivial
when ref_entry (soon) becomes polymorphic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4b94b08..8659c3e 100644
--- a/refs.c
+++ b/refs.c
@@ -145,6 +145,11 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	return ref;
 }
 
+static void free_ref_entry(struct ref_entry *entry)
+{
+	free(entry);
+}
+
 /* Add a ref_entry to the end of the ref_array (unsorted). */
 static void add_ref(struct ref_array *refs, struct ref_entry *ref)
 {
@@ -156,7 +161,7 @@ static void clear_ref_array(struct ref_array *array)
 {
 	int i;
 	for (i = 0; i < array->nr; i++)
-		free(array->refs[i]);
+		free_ref_entry(array->refs[i]);
 	free(array->refs);
 	array->sorted = array->nr = array->alloc = 0;
 	array->refs = NULL;
@@ -235,7 +240,7 @@ static void sort_ref_array(struct ref_array *array)
 	i = 0;
 	for (j = 1; j < array->nr; j++) {
 		if (is_dup_ref(array->refs[i], array->refs[j])) {
-			free(array->refs[j]);
+			free_ref_entry(array->refs[j]);
 			continue;
 		}
 		array->refs[++i] = array->refs[j];
-- 
1.7.10
