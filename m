Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7312720A36
	for <e@80x24.org>; Tue,  7 Nov 2017 20:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbdKGUj4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 15:39:56 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:53077 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbdKGUjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 15:39:53 -0500
Received: by mail-wr0-f194.google.com with SMTP id j23so431293wra.9
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 12:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=broZAH0LYs6Zy1TLTudoOs0KAj3AznT5q8E1p/ElPCA=;
        b=t3RrHxixoWHzWC8ZN8v+mgti8HrpC0UMi+IAgJYNbw2t1xsXcuvhr9l3ZiF08IiDHD
         Z4Ch5M/2B7Kvn1w8kwhyj6N4+926v7U6tNj5RN+rwOY/PSArvfthGRIZhi/8AnqOm079
         TnLNswJIFtAX4mscgKHnugYphdq3jW+Q1485N2VYO/RrqrxE8e2IuZxU3g9txmnXz8kf
         KLI9qe0JNBiwf9VhI0GLKh1xw+kx0CtHei2HD5I2yPFYchPaxkx78n/x7oQIurTe+f+F
         JJT1u+KkGV+wveC0cGQs9ORoPsthvhU5h19tNlFc4sdO9o9Nlamo3/v8WDXHCWyMYOEH
         rUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=broZAH0LYs6Zy1TLTudoOs0KAj3AznT5q8E1p/ElPCA=;
        b=YoRVqTyvqOR2bYZeiSqXnxbS2fdCFS9FYmBObjIU3feLUeSJfVCcthEj3GEDYzoNI6
         CLD66XQDndM8cxqKTpM9HYfgsnKQqHrxcPsSVKO3TT2zVn2Y/uJoQOeAwNyOiKVvFLHP
         6wOw+L0OCaQVt+Arz+KsEC0EUZEVeNcnX6Yy55/b7+xN2ox5DT6OxjdhzWMzaIA3m1t6
         9dkytMMC47zqUtgKViLqdsb9nQfYYUkPfsQoW1bUxcUy9knQusSwvy/NX1pmFd8Zcs8d
         2+rmNq4skS8lr54NGoDC75TpDhGefosMEdqXdQLMNm4WgBJlxTAqVWnvJqXQzUW/cSUH
         m4dw==
X-Gm-Message-State: AMCzsaW267Wp2ACftDfjC0nkUID9u+lYpzqh3oQ6ITg7PEfKn27T9yzp
        DS9OzgI2vYGCP6Hrwbbpbo9R2wNM
X-Google-Smtp-Source: ABhQp+QEbOSMqi6P3e+rJ55LlDgWim+txhZBWudTRlJ48lRX+FUecbEe9mA5MBw4wbrOStkwk/0F7A==
X-Received: by 10.223.198.134 with SMTP id j6mr15559974wrg.213.1510087191299;
        Tue, 07 Nov 2017 12:39:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id r123sm1088584wmf.41.2017.11.07.12.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Nov 2017 12:39:50 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 1/2] builtin/merge-base: free commit lists
Date:   Tue,  7 Nov 2017 21:39:44 +0100
Message-Id: <a5f5a259f4cbe3661eb1960e83e9bcce5080b580.1510083859.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
References: <20171106110549.dkv725bjikcms3aj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several functions, we iterate through a commit list by assigning
`result = result->next`. As a consequence, we lose the original pointer
and eventually leak the list.

Rewrite the loops so that we keep the original pointers, then call
`free_commit_list()`. Various alternatives were considered:

1) Use `UNLEAK(result)` before the loop. Simple change, but not very
pretty. These would definitely be new lows among our usages of UNLEAK.
2) Use `pop_commit()` when looping. Slightly less simple change, but it
feels slightly preferable to first display the list, then free it.
3) As in this patch, but with `UNLEAK()` instead of freeing. We'd still
go through all the trouble of refactoring the loop, and because it's not
super-obvious that we're about to exit, let's just free the lists -- it
probably doesn't affect the runtime much.

In `handle_independent()` we can drop `result` while we're here and
reuse the `revs`-variable instead. That matches several other users of
`reduce_heads()`. The memory-leak that this hides will be addressed in
the next commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v3: Like v2 but s/UNLEAK/free_commit_list/ and rebased onto maint.

> Like Junio, though, I kind of wonder if just calling free_commit_list()
> would be the most readable thing.

Thanks Junio and Peff for insightful considerations around UNLEAK vs
free. I'd rather miss one or two opportunities too UNLEAK than use it
too often. I've got a couple of patches in the pipeline that will be
better thanks to your comments. Thanks.

 builtin/merge-base.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 6dbd167d3b..e17835fabb 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -9,20 +9,20 @@
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
-	struct commit_list *result;
+	struct commit_list *result, *r;
 
 	result = get_merge_bases_many_dirty(rev[0], rev_nr - 1, rev + 1);
 
 	if (!result)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
+	for (r = result; r; r = r->next) {
+		printf("%s\n", oid_to_hex(&r->item->object.oid));
 		if (!show_all)
-			return 0;
-		result = result->next;
+			break;
 	}
 
+	free_commit_list(result);
 	return 0;
 }
 
@@ -51,28 +51,28 @@ static struct commit *get_commit_reference(const char *arg)
 
 static int handle_independent(int count, const char **args)
 {
-	struct commit_list *revs = NULL;
-	struct commit_list *result;
+	struct commit_list *revs = NULL, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = reduce_heads(revs);
-	if (!result)
+	revs = reduce_heads(revs);
+
+	if (!revs)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
-		result = result->next;
-	}
+	for (rev = revs; rev; rev = rev->next)
+		printf("%s\n", oid_to_hex(&rev->item->object.oid));
+
+	free_commit_list(revs);
 	return 0;
 }
 
 static int handle_octopus(int count, const char **args, int show_all)
 {
 	struct commit_list *revs = NULL;
-	struct commit_list *result;
+	struct commit_list *result, *rev;
 	int i;
 
 	for (i = count - 1; i >= 0; i--)
@@ -83,13 +83,13 @@ static int handle_octopus(int count, const char **args, int show_all)
 	if (!result)
 		return 1;
 
-	while (result) {
-		printf("%s\n", oid_to_hex(&result->item->object.oid));
+	for (rev = result; rev; rev = rev->next) {
+		printf("%s\n", oid_to_hex(&rev->item->object.oid));
 		if (!show_all)
-			return 0;
-		result = result->next;
+			break;
 	}
 
+	free_commit_list(result);
 	return 0;
 }
 
-- 
2.15.0.415.gac1375d7e

