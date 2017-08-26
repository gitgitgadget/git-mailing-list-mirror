Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940F020285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdHZI23 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:29 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43749 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbdHZI21 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:27 -0400
X-AuditID: 12074412-1e5ff7000000748d-45-59a1312a1410
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 86.7A.29837.A2131A95; Sat, 26 Aug 2017 04:28:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHii004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:25 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/12] load_subtree(): remove unnecessary conditional
Date:   Sat, 26 Aug 2017 10:28:02 +0200
Message-Id: <c21bedbee9487792f4a336a417aa9874578aaac2.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixO6iqKtluDDSYM8XKYuuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV8WfpLvaCdv6Kcz9OMDcwnuLuYuTkkBAwkXh/YCMziC0ksINJYvcl+S5GLiD7FJPEmr0X
        2EESbAK6Eot6mplAbBEBNYmJbYdYQIqYBZYzSnS8PQ+WEBZwlZh85RrYJBYBVYmHHVfB4rwC
        URKLb01hh9gmL7Gr7SIriM0pYCFxY+tnNojN5hJ9PxexTGDkWcDIsIpRLjGnNFc3NzEzpzg1
        Wbc4OTEvL7VI10wvN7NELzWldBMjJHCEdjCuPyl3iFGAg1GJhzeicEGkEGtiWXFl7iFGSQ4m
        JVFeB42FkUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeFcoAeV4UxIrq1KL8mFS0hwsSuK8Pxer
        +wkJpCeWpGanphakFsFkZTg4lCR4/+gDNQoWpaanVqRl5pQgpJk4OEGG8wANv2IAMry4IDG3
        ODMdIn+KUVFKnHcWSEIAJJFRmgfXC4vsV4ziQK8I88qBVPEAkwJc9yugwUxAgxUFwQaXJCKk
        pBoY5cKvHbRinyHiviS2dbaGe9YWhQYdaa74P20aPv0Hzfv6p1q3pGwtK/2f4XCaSy+iZd+e
        OYLNZiZfFp7WWTRh4wxz74tau/mk+WMWvFCLmij451zhC4km0ee9Pt/jt79b9z6wo2auV5GK
        1OZ5909fKA97E25/9iDb0TM8MgweCS6bF31M9lmhxFKckWioxVxUnAgASUuCb8cCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this point in the code, len is *always* <= 20.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/notes.c b/notes.c
index 00630a9396..f7ce64ff48 100644
--- a/notes.c
+++ b/notes.c
@@ -446,25 +446,24 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		 * If object SHA1 is incomplete (len < 20), and current
 		 * component consists of 2 hex chars, assume note subtree
 		 */
-		if (len <= GIT_SHA1_RAWSZ) {
-			type = PTR_TYPE_NOTE;
-			l = (struct leaf_node *)
-				xcalloc(1, sizeof(struct leaf_node));
-			oidcpy(&l->key_oid, &object_oid);
-			oidcpy(&l->val_oid, entry.oid);
-			if (len < GIT_SHA1_RAWSZ) {
-				if (!S_ISDIR(entry.mode) || path_len != 2)
-					goto handle_non_note; /* not subtree */
-				l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
-				type = PTR_TYPE_SUBTREE;
-			}
-			if (note_tree_insert(t, node, n, l, type,
-					     combine_notes_concatenate))
-				die("Failed to load %s %s into notes tree "
-				    "from %s",
-				    type == PTR_TYPE_NOTE ? "note" : "subtree",
-				    oid_to_hex(&l->key_oid), t->ref);
+		type = PTR_TYPE_NOTE;
+		l = (struct leaf_node *)
+			xcalloc(1, sizeof(struct leaf_node));
+		oidcpy(&l->key_oid, &object_oid);
+		oidcpy(&l->val_oid, entry.oid);
+		if (len < GIT_SHA1_RAWSZ) {
+			if (!S_ISDIR(entry.mode) || path_len != 2)
+				goto handle_non_note; /* not subtree */
+			l->key_oid.hash[KEY_INDEX] = (unsigned char) len;
+			type = PTR_TYPE_SUBTREE;
 		}
+		if (note_tree_insert(t, node, n, l, type,
+				     combine_notes_concatenate))
+			die("Failed to load %s %s into notes tree "
+			    "from %s",
+			    type == PTR_TYPE_NOTE ? "note" : "subtree",
+			    oid_to_hex(&l->key_oid), t->ref);
+
 		continue;
 
 handle_non_note:
-- 
2.11.0

