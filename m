From: mhagger@alum.mit.edu
Subject: [PATCH 02/28] free_ref_entry(): new function
Date: Fri, 28 Oct 2011 14:28:15 +0200
Message-ID: <1319804921-17545-3-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYv-0003gi-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462Ab1J1M2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55675 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-ED; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184381>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a function free_ref_entry().  This function will become nontrivial
when ref_entry (soon) becomes polymorphic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 56868a5..eff1abe 100644
--- a/refs.c
+++ b/refs.c
@@ -134,6 +134,11 @@ static struct ref_entry *create_ref_entry(const char *refname,
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
@@ -145,7 +150,7 @@ static void clear_ref_array(struct ref_array *array)
 {
 	int i;
 	for (i = 0; i < array->nr; i++)
-		free(array->refs[i]);
+		free_ref_entry(array->refs[i]);
 	free(array->refs);
 	array->nr = array->alloc = 0;
 	array->refs = NULL;
@@ -217,7 +222,7 @@ static void sort_ref_array(struct ref_array *array)
 		struct ref_entry *a = array->refs[i];
 		struct ref_entry *b = array->refs[j];
 		if (is_dup_ref(a, b)) {
-			free(b);
+			free_ref_entry(b);
 			continue;
 		}
 		i++;
-- 
1.7.7
