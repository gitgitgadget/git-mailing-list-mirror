From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/19] repack_without_refs(): make function private
Date: Mon, 22 Jun 2015 16:03:00 +0200
Message-ID: <5fa0fb8a71db99b3e96c4ea2946b2efb186aac8b.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Kq-0005yL-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933714AbbFVOEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50631 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756361AbbFVOD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:28 -0400
X-AuditID: 12074414-f794f6d000007852-30-558815ae6ae6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.0D.30802.EA518855; Mon, 22 Jun 2015 10:03:26 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc7030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:25 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLtOtCPU4NxOQ4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ6zrUCr4wVNx73JOA+Nari5GTg4JAROJ4x+us0PYYhIX7q1nA7GFBC4zSuy/I9LFyAVk
	n2SS2HL4PzNIgk1AV2JRTzMTiC0ioCYxse0QC0gRs0AHo8SF5dvAJgkLuEnsWN0A1sAioCrR
	930BI4jNKxAlcfhwEwvENjmJ88d/gtVwClhIzN/3nx1is7nExJmPWCYw8i5gZFjFKJeYU5qr
	m5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERJOIjsYj5yUO8QowMGoxMPrYNseKsSaWFZc
	mXuIUZKDSUmU98BroBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3pazQDnelMTKqtSifJiUNAeL
	kjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQleP5GOUCHBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UFzEFwMjAyTFA7TXBKSdt7ggMRcoCtF6ilFRSpzXHyQhAJLIKM2DGwtLEq8Y
	xYG+FOYtBqniASYYuO5XQIOZgAZ/yW0DGVySiJCSamBUuPZVs/KrpkxuTn7taifvHvkXOxa+
	vPJr1kyLyww3s9wtpS8Wmu35uTT/w/dnG1bWtVbdnPPopZdJ6Z5j8gGWwucq/PIXn9/LMdFV
	XN92cbpDuGLEZifvct44WyfPuJMbqjpMtu+79YYjO3SRZ61Sj8nOb4f4V3n8CPm/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272360>

It is no longer called from outside of the refs module. Also move its
docstring and change it to imperative voice.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  9 ++++++++-
 refs.h | 11 -----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 19afc4d..b21bb55 100644
--- a/refs.c
+++ b/refs.c
@@ -2724,7 +2724,14 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+/*
+ * Rewrite the packed-refs file, omitting any refs listed in
+ * 'refnames'. On error, leave packed-refs unchanged, write an error
+ * message to 'err', and return a nonzero value.
+ *
+ * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
+ */
+static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
diff --git a/refs.h b/refs.h
index 1a5d44a..5f3bea7 100644
--- a/refs.h
+++ b/refs.h
@@ -154,17 +154,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-/*
- * Rewrite the packed-refs file, omitting any refs listed in
- * 'refnames'. On error, packed-refs will be unchanged, the return
- * value is nonzero, and a message about the error is written to the
- * 'err' strbuf.
- *
- * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
- */
-extern int repack_without_refs(struct string_list *refnames,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 extern int is_branch(const char *refname);
-- 
2.1.4
