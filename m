Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B9E20285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbdHZI2c (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:60463 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751970AbdHZI2b (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:31 -0400
X-AuditID: 1207440c-7e5ff7000000143e-96-59a1312d14ef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E0.4A.05182.D2131A95; Sat, 26 Aug 2017 04:28:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHik004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/12] load_subtree(): fix incorrect comment
Date:   Sat, 26 Aug 2017 10:28:04 +0200
Message-Id: <3eb7cba0331bfaf46f60d9a44a74a931272c5304.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqKtruDDSoHeNukXXlW4mi4beK8wW
        8+7uYrLoX97FZnF7xXxmB1aPv+8/MHl8+BjncenldzaPi5eUPT5vkgtgjeKySUnNySxLLdK3
        S+DK+PfctKBHsOL7buEGxvW8XYycHBICJhI3dq1m7WLk4hAS2MEk0fyugQXCOcUk8fLjQyaQ
        KjYBXYlFPc1gtoiAmsTEtkNgRcwCyxklOt6eB0pwcAgL2EgsXOcOUsMioCpxtes2WD2vQJTE
        zq2H2SC2yUvsarvICmJzClhI3Nj6GSwuJGAu0fdzEcsERp4FjAyrGOUSc0pzdXMTM3OKU5N1
        i5MT8/JSi3QN9XIzS/RSU0o3MUKChmcH47d1MocYBTgYlXh4IwoXRAqxJpYVV+YeYpTkYFIS
        5XXQWBgpxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3hRJQjjclsbIqtSgfJiXNwaIkzqu6RN1P
        SCA9sSQ1OzW1ILUIJivDwaEkwduhD9QoWJSanlqRlplTgpBm4uAEGc4DNDwDpIa3uCAxtzgz
        HSJ/ilFRSpzXASQhAJLIKM2D64VF9StGcaBXhHnlDICqeIAJAa77FdBgJqDBioJgg0sSEVJS
        DYxuGZJzDbZYs6/7zRj6ap/YE/8Q/4tKmZv1Zz3VSjh4OjyjJSr3cfWxx4cjz16/v/aTiMXP
        9x+FNuopM2/uZi69bhG8mXlS1v7pzq6vYhMmtLzlPz81jHvZxFZBBt9utkqxGOno6U3XZuzT
        136eV8T85ZZ92V0HQ56NEg8WxnZW3z3jL+z38L0SS3FGoqEWc1FxIgDLWBi/xQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment was added in 851c2b3791 (Teach notes code to properly
preserve non-notes in the notes tree, 2010-02-13) when the
corresponding code was added. But I believe it was incorrect even
then. The condition `path_len != 2` a dozen lines up prevents a path
like "dead/beef" from being converted to "de/ad/beef", and indeed the
test added in commit 851c2b3 verifies that this case works correctly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/notes.c b/notes.c
index fbed8c3013..62ab3f4ce3 100644
--- a/notes.c
+++ b/notes.c
@@ -468,23 +468,13 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 
 handle_non_note:
 		/*
-		 * Determine full path for this non-note entry:
-		 * The filename is already found in entry.path, but the
-		 * directory part of the path must be deduced from the subtree
-		 * containing this entry. We assume here that the overall notes
-		 * tree follows a strict byte-based progressive fanout
-		 * structure (i.e. using 2/38, 2/2/36, etc. fanouts, and not
-		 * e.g. 4/36 fanout). This means that if a non-note is found at
-		 * path "dead/beef", the following code will register it as
-		 * being found on "de/ad/beef".
-		 * On the other hand, if you use such non-obvious non-note
-		 * paths in the middle of a notes tree, you deserve what's
-		 * coming to you ;). Note that for non-notes that are not
-		 * SHA1-like at the top level, there will be no problems.
-		 *
-		 * To conclude, it is strongly advised to make sure non-notes
-		 * have at least one non-hex character in the top-level path
-		 * component.
+		 * Determine full path for this non-note entry. The
+		 * filename is already found in entry.path, but the
+		 * directory part of the path must be deduced from the
+		 * subtree containing this entry based on our
+		 * knowledge that the overall notes tree follows a
+		 * strict byte-based progressive fanout structure
+		 * (i.e. using 2/38, 2/2/36, etc. fanouts).
 		 */
 		{
 			struct strbuf non_note_path = STRBUF_INIT;
-- 
2.11.0

