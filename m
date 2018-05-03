Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0EF5200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeECPar (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:58119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeECPaq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:46 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M6874-1ePKKu3eQ6-00y6jd; Thu, 03 May 2018 17:30:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/18] branch-diff: improve the order of the shown commits
Date:   Thu,  3 May 2018 17:30:36 +0200
Message-Id: <6a618d6010f5767590ba88480e22835b1257316b.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q2bgot8K7O3T2meieijBco7rLEpkrGy32BsiJbfVmIbOHj9phKL
 CQr9/6iKySDDRi58Zpiq+7KxVQEIUXcqPD37kJ3l8NQ+DHbgLMmYCnXrzfiNq17AZH/QM1i
 N8UorLymZhC6nqFpqv1Zen3Rao/xBoGmNg9STjBVvILQHrxlt0eapnNl1hacT0Nry0ciyY+
 57BvpQG+M7xu0u1Cp9BoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GMm3gPQlCQI=:LK8lgvoOOgXn1Zu9BF8MXe
 7DC6Go9e6lRFeG2bPs1c+uoQWzc62hLoBtqXcs++Zu+cNulVhflVDVbNaFY3RKzdOZ2wwSzKY
 dx51bQ6+H3UiSUwZDeddhHEXm3RSVDDXOEVtkvnWrpIpThXW/Y6g1ei+WE03eXoOnGeVLXAje
 viw+bpR28I4/LX4uglsy7qmDwPvLJoezlYtt+dm5CsMPXN8Jzmw2cLFL5qxw12smgwwIffxlE
 cqjEv2ob1rHV2aABrZepiEbvXpiMmDFLY2eSNdXW9EK97stL2vMSq+7yqiHrtVluFDDz0suXX
 Z3LMCM6TBvNR5oVsYg3WhtWmXIXFfGHorjgFND8oX3vubXTTOq4VohEKC2v8UII6UzuJ6YlOg
 gtwMdg3hlEW9cHrjK07muyovV6lVFfD8NuSjFgQsr7ClkHulTIQBkoXpd2HHluasz0kT+snUP
 bpgVgfUMxaZLuBGJx93JAR7kI8sChzJIbG0eiW/tWxPfBkyBpHvYMhvloU5ulX0wH6Lh/RChI
 XmuBOFExFw1XoxlJ4RTe+8/lwBKP4QlhfI7HXKc/nwWSm0Kl0vhWZl413D8bdaXQKReSGL8mf
 cPIfrCrt1rHSTivI1nvF1jnqyMZjaOQn5kpyNT+vOiK2BaUCBUlkB2oY2afL3WxeWCLU3E7fP
 UyiD/8+lV3R9HF28nt3tRNvKjqMwshvC2HEGezJMPOsCPd1DrlMUN4DfCt0E4OjW74vrTBveE
 oghc9NO4mzGL1Hg+IJUQaDbdDPE8zlNZ2KHg/nZ//S24vNectbuZh+RhIM0rQhFYB3aeXj2bL
 klh5vAr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch lets branch-diff use the same order as tbdiff.

The idea is simple: for left-to-right readers, it is natural to assume
that the branch-diff is performed between an older vs a newer version of
the branch. As such, the user is probably more interested in the
question "where did this come from?" rather than "where did that one
go?".

To that end, we list the commits in the order of the second commit range
("the newer version"), inserting the unmatched commits of the first
commit range as soon as all their predecessors have been shown.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 59 +++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 02dc06a57ca..59423498194 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -28,7 +28,7 @@ struct patch_util {
 	struct hashmap_entry e;
 	const char *diff, *patch;
 
-	int i;
+	int i, shown;
 	int diffsize;
 	size_t diff_offset;
 	/* the index of the matching item in the other branch, or -1 */
@@ -271,28 +271,49 @@ static const char *short_oid(struct patch_util *util)
 
 static void output(struct string_list *a, struct string_list *b)
 {
-	int i;
-
-	for (i = 0; i < b->nr; i++) {
-		struct patch_util *util = b->items[i].util, *prev;
+	int i = 0, j = 0;
+
+	/*
+	 * We assume the user is really more interested in the second argument
+	 * ("newer" version). To that end, we print the output in the order of
+	 * the RHS (the `b` parameter). To put the LHS (the `a` parameter)
+	 * commits that are no longer in the RHS into a good place, we place
+	 * them once we have shown all of their predecessors in the LHS.
+	 */
+
+	while (i < a->nr || j < b->nr) {
+		struct patch_util *a_util, *b_util;
+		a_util = i < a->nr ? a->items[i].util : NULL;
+		b_util = j < b->nr ? b->items[j].util : NULL;
+
+		/* Skip all the already-shown commits from the LHS. */
+		while (i < a->nr && a_util->shown)
+			a_util = ++i < a->nr ? a->items[i].util : NULL;
+
+		/* Show unmatched LHS commit whose predecessors were shown. */
+		if (i < a->nr && a_util->matching < 0) {
+			printf("%d: %s < -: --------\n",
+			       i + 1, short_oid(a_util));
+			i++;
+			continue;
+		}
 
-		if (util->matching < 0)
+		/* Show unmatched RHS commits. */
+		while (j < b->nr && b_util->matching < 0) {
 			printf("-: -------- > %d: %s\n",
-					i + 1, short_oid(util));
-		else {
-			prev = a->items[util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       util->matching + 1, short_oid(prev),
-			       i + 1, short_oid(util));
+			       j + 1, short_oid(b_util));
+			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
-	}
-
-	for (i = 0; i < a->nr; i++) {
-		struct patch_util *util = a->items[i].util;
 
-		if (util->matching < 0)
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(util));
+		/* Show matching LHS/RHS pair. */
+		if (j < b->nr) {
+			a_util = a->items[b_util->matching].util;
+			printf("%d: %s ! %d: %s\n",
+			       b_util->matching + 1, short_oid(a_util),
+			       j + 1, short_oid(b_util));
+			a_util->shown = 1;
+			j++;
+		}
 	}
 }
 
-- 
2.17.0.395.g6a618d6010f.dirty


