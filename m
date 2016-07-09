Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 739BA1F744
	for <e@80x24.org>; Sat,  9 Jul 2016 05:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578AbcGIFYX (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 01:24:23 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36460 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbcGIFYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 01:24:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so8671718lfe.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 22:24:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLtOhkztD6Qd6G/gqBtf3Db7jKiQ4CwJYqcTo2CiqAA=;
        b=t0gPkf8Jo4W+1i6LLKbh195SU1/0QOJniwvlRiSyTuvSGPtFP4H8g4JTDsfFz+mpmP
         MSZ3xYx+ufFKgHnzJY0fKExBtssGlvCTuJWF7+cR4bgZGQ8obdoIordy+qbhG4UF0x4M
         beyp6isDueP6Q88jAo6K9lle6junGbWQg3yCFhNhmpNeUS8VHaSeagBxGYTcS0FYwQAW
         PzWlAnbkqu3IC+K+StYT6DhLjHjv4zPyZ/t+cIZ5YfAE+j8WfnowKV+OhLjZ8CjicBWN
         IV+LoOwQXwlzkwAMcgUxlO3cTDDEih1sLMHDN/seuvmzqqd3JZFL//XgyM/9x2Ca7M4V
         STEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLtOhkztD6Qd6G/gqBtf3Db7jKiQ4CwJYqcTo2CiqAA=;
        b=Y33JZDt5Yx7C1BH1Ab6IawBCHQX7qfgiUG1fD1g5jNFHCU/5NxJJmWwS1VL0v8lwwT
         9t4yvBvtqGesdGF++m+d/wMfgXwckC1AvEKnnar3WT4fJxAqW78r3YcohU43T3sYSM99
         FRA/APOe/za3OAN+NiK1Iod9vpDDmOHBiaCRyJuXI1OfbUNH31sZXFKQ3wtc+J/PO5HN
         onlV41IVYcZ3p2KMTDNGnuTIfaGZpkSexstsNudQsq3PMwiheLHKa+1f0DO2FueDp5Yf
         9/FKplb2rb/GDxSGAprptDv1Er4sJedqYhud3u2JbOxw4yFmusHyQduQqbwHDKPDALqn
         H/qw==
X-Gm-Message-State: ALyK8tIUL4uKpiwg1BcSYogRipGJJrk7/2YjnmdCuhGk9MNsE8uRxTV1PRsDoqMfAlKt9w==
X-Received: by 10.25.141.15 with SMTP id p15mr1962589lfd.185.1468041858339;
        Fri, 08 Jul 2016 22:24:18 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f66sm1450237lji.13.2016.07.08.22.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jul 2016 22:24:16 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 3/4] cache-tree.c: fix i-t-a entry skipping directory updates sometimes
Date:	Sat,  9 Jul 2016 07:23:55 +0200
Message-Id: <20160709052356.30570-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160709052356.30570-1-pclouds@gmail.com>
References: <20160706184829.31825-1-pclouds@gmail.com>
 <20160709052356.30570-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Commit 3cf773e (cache-tree: fix writing cache-tree when CE_REMOVE is
present - 2012-12-16) skips i-t-a entries when building trees objects
from the index. Unfortunately it may skip too much.

The code in question checks if an entry is an i-t-a one, then no tree
entry will be written. But it does not take into account that
directories can also be written with the same code. Suppose we have
this in the index.

    a-file
    subdir/file1
    subdir/file2
    subdir/file3
    the-last-file

We write an entry for a-file as normal and move on to subdir/file1,
where we realize the entry name for this level is simply just
"subdir", write down an entry for "subdir" then jump three items ahead
to the-last-file.

That is what happens normally when the first file in subdir is not an
i-t-a entry. If subdir/file1 is an i-t-a, because of the broken
condition in this code, we still think "subdir" is an i-t-a file and
not writing "subdir" down and jump to the-last-file. The result tree
now only has two items: a-file and the-last-file. subdir should be
there too (even though it only records two sub-entries, file2 and
file3).

If the i-t-a entry is subdir/file2 or subdir/file3, this is not a
problem because we jump over them anyway. Which may explain why the
bug is hidden for nearly four years.

Fix it by making sure we only skip i-t-a entries when the entry in
question is actual an index entry, not a directory.

Reported-by: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c          |  4 ++--
 t/t2203-add-intent.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ddf0cc9..c2676e8 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -319,7 +319,7 @@ static int update_one(struct cache_tree *it,
 	i = 0;
 	while (i < entries) {
 		const struct cache_entry *ce = cache[i];
-		struct cache_tree_sub *sub;
+		struct cache_tree_sub *sub = NULL;
 		const char *path, *slash;
 		int pathlen, entlen;
 		const unsigned char *sha1;
@@ -375,7 +375,7 @@ static int update_one(struct cache_tree *it,
 		 * they are not part of generated trees. Invalidate up
 		 * to root to force cache-tree users to read elsewhere.
 		 */
-		if (ce_intent_to_add(ce)) {
+		if (!sub && ce_intent_to_add(ce)) {
 			to_invalidate = 1;
 			continue;
 		}
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..24aed2e 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -82,5 +82,22 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir 2 &&
+		for f in 1 2/1 2/2 3
+		do
+			echo "$f" >"$f"
+		done &&
+		git add 1 2/2 3 &&
+		git add -N 2/1 &&
+		git commit -m committed &&
+		git ls-tree -r HEAD >actual &&
+		grep 2/2 actual
+	)
+'
+
 test_done
 
-- 
2.8.2.537.g0965dd9

