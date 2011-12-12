From: mhagger@alum.mit.edu
Subject: [PATCH v2 25/51] free_ref_entry(): new function
Date: Mon, 12 Dec 2011 06:38:32 +0100
Message-ID: <1323668338-1764-26-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycg-0000Sq-Ky
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab1LLFkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34744 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1LLFkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:15 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ac015577;
	Mon, 12 Dec 2011 06:40:06 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186841>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a function free_ref_entry().  This function will become nontrivial
when ref_entry (soon) becomes polymorphic.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 3cc3e4f..99667fc 100644
--- a/refs.c
+++ b/refs.c
@@ -136,6 +136,11 @@ static struct ref_entry *create_ref_entry(const char *refname,
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
@@ -147,7 +152,7 @@ static void clear_ref_array(struct ref_array *array)
 {
 	int i;
 	for (i = 0; i < array->nr; i++)
-		free(array->refs[i]);
+		free_ref_entry(array->refs[i]);
 	free(array->refs);
 	array->nr = array->alloc = 0;
 	array->refs = NULL;
@@ -218,7 +223,7 @@ static void sort_ref_array(struct ref_array *array)
 	i = 0;
 	for (j = 1; j < array->nr; j++) {
 		if (is_dup_ref(array->refs[i], array->refs[j])) {
-			free(array->refs[j]);
+			free_ref_entry(array->refs[j]);
 			continue;
 		}
 		array->refs[++i] = array->refs[j];
-- 
1.7.8
