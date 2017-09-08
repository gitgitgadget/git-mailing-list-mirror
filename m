Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B119B2082D
	for <e@80x24.org>; Fri,  8 Sep 2017 16:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbdIHQK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 12:10:59 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58687 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753577AbdIHQK6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 12:10:58 -0400
X-AuditID: 12074411-f7dff70000007f0a-cb-59b2c111b413
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id DA.FF.32522.111C2B95; Fri,  8 Sep 2017 12:10:57 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88GApYl010839
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 12:10:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] load_subtree(): check that `prefix_len` is in the expected range
Date:   Fri,  8 Sep 2017 18:10:10 +0200
Message-Id: <ca6046b8b955df6a798b690fdecb0b8ba47d57a9.1504886586.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsUixO6iqCt4cFOkwaeD8hZdV7qZLBp6rzBb
        zLu7i8mif3kXm8XtFfOZHVg9/r7/wOTx4WOcx6WX39k8Ll5S9vi8SS6ANYrLJiU1J7MstUjf
        LoEr4918yYJp3BWLFx5hbGCcz9nFyMEhIWAisWh/RhcjF4eQwA4miWPvZjNDOCeZJN4v2MHY
        xcjJwSagK7Gop5kJxBYRUJOY2HaIBaSIWWA5o0TH2/NgCWGBQIl7z66CNbAIqEp8WvyOFcTm
        FYiS6G1+xgZiSwjIS5x7cJt5AiPXAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6
        qSmlmxghYSC4g3HGSblDjAIcjEo8vBXbN0UKsSaWFVfmHmKU5GBSEuWV6QEK8SXlp1RmJBZn
        xBeV5qQWH2KU4GBWEuFV2Q2U401JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2Cycpw
        cChJ8NocAGoULEpNT61Iy8wpQUgzcXCCDOcBGn4WpIa3uCAxtzgzHSJ/ilGXo+Pm3T9MQix5
        +XmpUuK8+SBFAiBFGaV5cHNg8fuKURzoLWHepfuBqniAsQ836RXQEiagJSXPN4AsKUlESEk1
        MGq9ehK4oKv/yD3Thr+VPW5pKnMmBBx8d8a710u6u4BlA4tQi4mW2/WI14fu1qYL/Thm4qn/
        /T77mxndVQ6hMovrmZgL11X5bVuwY1Km5F0tidM/o3X2LDhWm7Juu+3KGx1fOGLdz/8Jr1/b
        KqRh79oWU3ie/Y375ELXsrlSR614j7y4WdcbrsRSnJFoqMVcVJwIAHFrkd66AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This value, which is stashed in the last byte of an object_id hash,
gets handed around a lot. So add a sanity check before using it in
`load_subtree()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch is an addendum to v1 of the mh/notes-cleanup patch series
[1]. It adds the assertion that was suggested by Junio [2].

Since the first patch series is already in next, this patch is
constructed to apply on top of that branch.

Thanks to Junio and Johan for their review of v1.

Michael

[1] https://public-inbox.org/git/cover.1503734566.git.mhagger@alum.mit.edu/
[2] https://public-inbox.org/git/xmqqh8wuqo6e.fsf@gitster.mtv.corp.google.com/

 notes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 40d9ba6252..27d232f294 100644
--- a/notes.c
+++ b/notes.c
@@ -417,7 +417,10 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		     oid_to_hex(&subtree->val_oid));
 
 	prefix_len = subtree->key_oid.hash[KEY_INDEX];
-	assert(prefix_len * 2 >= n);
+	if (prefix_len >= GIT_SHA1_RAWSZ)
+		BUG("prefix_len (%"PRIuMAX") is out of range", (uintmax_t)prefix_len);
+	if (prefix_len * 2 < n)
+		BUG("prefix_len (%"PRIuMAX") is too small", (uintmax_t)prefix_len);
 	memcpy(object_oid.hash, subtree->key_oid.hash, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
-- 
2.14.1

