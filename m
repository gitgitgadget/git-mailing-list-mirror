Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69A7420179
	for <e@80x24.org>; Mon,  4 Jul 2016 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbcGDRwl (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 13:52:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34490 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbcGDRwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 13:52:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id l102so5413238lfi.1
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 10:52:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls9IEMvQETY4XDpliyErE6rLzYGT5bypIL7f+fXGGvw=;
        b=IHVnkwqAt9QmHe/4Un8d0xBMTZTjVJusNvOzrGFWg6Rq/rnn0tu6ToYRBleproj7JG
         JV8Iu8owLfEyKMScMxTAe7V/mCVsybL973aS04u6y1rJ/ZvpTWXfsYLVgBsPSqzktOzb
         /37HEaduHIeCjpK7iTs8ZXG00vgGuu9AZvIC7bLYnSvIIXu0txCm88fo0VNGxiwZZkGL
         hSrFnoWzjEKZQxUe4sm0wr7UUyIa0O0iRDK39pwwRHgOeDHCsjFROiOqEKT+rzrE8JBA
         X3KnOaXwpDWLONmaERbhl4m0KmNlbypDHeChfURD288Km47hf6v+ER9JbQUWr2MZHbVo
         QLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls9IEMvQETY4XDpliyErE6rLzYGT5bypIL7f+fXGGvw=;
        b=DdzxCVShs+BnSyLErnL1qWYPI4rrKEJP7BGnOLV5uDF3YcXOxMXxt7X6ZnKVh10W0L
         gUmBPR4j4Nm9IvcTglK6OolaXuFVK8bJWB3ijwd5wZOr/yg5PlBjeE+p6FAuVrSSKit0
         qfavko3V9crhXSa+kg0eCSj2BtkRtvecdBkZ8vfdzE3gQlA9X6nLWaN+qKmROn6dPIxx
         mZktynOHN78orFTUXD5KoVJJNg6qSyZ4YsEslMnweLYU7Op8HX/gLHL93YMFM1YFbZAL
         ndLlh//79ne3/A6u5H707rCXrmFD3wzPObGgq0zyK2O7Sw8PzJsCQfc6RMJplSuukLhe
         CAvA==
X-Gm-Message-State: ALyK8tIBmuS3+qBNq2WSQrSodC09HYrPoBZp2ry3zxj573EbkTqZlSvCZLjVnyCQgsC73w==
X-Received: by 10.25.133.135 with SMTP id h129mr3476059lfd.28.1467654758780;
        Mon, 04 Jul 2016 10:52:38 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id o137sm4785256lfe.2.2016.07.04.10.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jul 2016 10:52:37 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] cache-tree.c: fix i-t-a check skipping directory updates sometimes
Date:	Mon,  4 Jul 2016 19:48:07 +0200
Message-Id: <20160704174807.6578-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
References: <CAMhVC3Y9iT9X=JbB5tguXm8MRX4v2fDEqMwrMuDR6TD2+2+HLQ@mail.gmail.com>
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
 t/t2203-add-intent.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index 2a4a749..12d701c 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -82,5 +82,18 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 	test_cmp expect actual
 '
 
+test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir 2 &&
+		touch 1 2/1 2/2 3 &&
+		git add 1 2/2 3 &&
+		git add -N 2/1 &&
+		git commit -m comitted &&
+		git ls-tree -r HEAD | grep 2/2
+	)
+'
+
 test_done
 
-- 
2.8.2.537.g0965dd9

