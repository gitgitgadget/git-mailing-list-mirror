Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F1F20195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcGPFGy (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:06:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33004 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbcGPFGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 01:06:48 -0400
Received: by mail-lf0-f65.google.com with SMTP id f93so8092084lfi.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:06:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldpPGWvp7uSX4OgVkyYYkXHzEVs+gbUvDGkbNeU/x3o=;
        b=qVoZVPf1SAcHk+CgucPwV6pn8ZMxekdpVBtCjYCO8Z7P6ayT8pm41ny5GRaoNBGPjy
         X9FgBnYSiq8BpFia5G93hSJN2cn31KUIKeyporNYJCy3zEkq3o8zSjK5oApJ7sUFyygt
         /WNT7uD60At5hfODHvqFCqro+wfOcaDQqGNvw7FaXZFsKshsD/Jh+QjrMu/+ES5I8iMY
         j7PDAmLIV9bPsPgQs0YAxtw3+5Bra+8mlHV4iHnkvNQBalroxR1Ffb640Ot93kAELjur
         hg/n4m915clF80pyqkpONdDARsaSQlBg5W6OV2nkcjoxEAGjmBFhkkqrU5GB0T8K7FNQ
         t3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldpPGWvp7uSX4OgVkyYYkXHzEVs+gbUvDGkbNeU/x3o=;
        b=PoAoPRqvtnQQhXj14jmKDG43cHmZI5kvG/HXl6/pyNQTOCzJ0nkXjr3UN1IEoHMygi
         f7/S45p+xFgDvACdlXwK4JwkJEGItIpqqRgqas3vwc8KCIp/6Wv1c3WDfe/klEfvQ86e
         PlqEGs6bFmVOiYHCdB+B1jhZNCg1CSmPmDQGcmTDB1ZMuaGIpSiR6vfT3zhR8dTqjFfi
         bxK7+5C1lKb8uuWCzuAHfbvIpt4SN4VN+jEJRSq/obMbAtRvdDpzMqKMqGmSFZnnvVze
         V+jdUVSKOxwO6THzBSReER80vrmnj7XC3/dN+r2OIBDnCz4o3y97tSkINBhf8hgTrROF
         wetg==
X-Gm-Message-State: ALyK8tJI5PzP4ZT9oXtXi6I708QseLclPI38E13n02BuF5RZKYSAu3VUHU7LQK1NpYQO4A==
X-Received: by 10.46.0.39 with SMTP id 39mr8772633lja.48.1468645606349;
        Fri, 15 Jul 2016 22:06:46 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g40sm634654ljg.22.2016.07.15.22.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jul 2016 22:06:45 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/4] cache-tree.c: fix i-t-a entry skipping directory updates sometimes
Date:	Sat, 16 Jul 2016 07:06:26 +0200
Message-Id: <20160716050627.9416-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <20160716050627.9416-1-pclouds@gmail.com>
References: <20160709052356.30570-1-pclouds@gmail.com>
 <20160716050627.9416-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.9.1.566.gbd532d4

