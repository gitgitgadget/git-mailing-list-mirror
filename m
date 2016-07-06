Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EFD2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 18:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbcGFStG (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:49:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36037 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbcGFStE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:49:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id a2so23037955lfe.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 11:49:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLtOhkztD6Qd6G/gqBtf3Db7jKiQ4CwJYqcTo2CiqAA=;
        b=m9CoFZH1hqKQ6El57CW1WTQQTqg1YzksIDr0ZRyvT1J6U01zzc1xV7QrEswj+SxYDK
         4GGlDU60zFFF6xyKaQFSq3x0ykxWe/dthLwf7c5sQfo48Em5FXe5JkT+Cdd9va77x3y1
         kKfDyrxQDwkT9Yb08IMLN5CYoxvIHiP4GUBiXCHz43QCTqHE/ZrylPIxoXz/kSB5vDDj
         5UITjgwwzjoOvl7yxJABH0cLD3GZB1MDSFmYyFPz48mYV8+5d2WvvsFxRW6VYVesCjzn
         nP+L9I1T9aw+E4G8fDFf/1oHokhpt0DuqnPzaKhgskN+7y8bLKNzARFEbclhxv/LLTkH
         Vm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLtOhkztD6Qd6G/gqBtf3Db7jKiQ4CwJYqcTo2CiqAA=;
        b=Wha6sltvXASaZId21prZWVZXHrA16CTqS/nduAhxM3HcAR339AYFckE8fAr98YD8fJ
         k6VnBrUeAg/J81XG40je6osv0WzkhLQGdU/7kwwKyTa0fQjWDrI9CDD6osxHw9K4giTw
         +0z8O3X6/Dnhx8JH0yprPtgP0778bnNZoyla0rLolSyvyN79RfaQae5hqEaPrp3dOrBG
         FntYWAolh7KRAUqKWhm0s2UGD4q6gbUFw6prIyLKd6F83PLZIatg0q+/65bXtT7E0FRa
         5wMDWxInYP5gHhuUXHcLoyOtuQ2uCOGOxJgCs/mSGLYP+o5/t2RZ9Wi+L6c2RVy2u8Ze
         C9eg==
X-Gm-Message-State: ALyK8tL2gVFxILq5DSgEaZGgUuAwwI7s2dPThiJsOh/4SVCmHUAZ+mAkq2Kqi1mqm4yNqg==
X-Received: by 10.25.157.77 with SMTP id g74mr7119920lfe.10.1467830941799;
        Wed, 06 Jul 2016 11:49:01 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm6686199ljj.3.2016.07.06.11.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 11:49:01 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] cache-tree.c: fix i-t-a entry skipping directory updates sometimes
Date:	Wed,  6 Jul 2016 20:48:28 +0200
Message-Id: <20160706184829.31825-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.537.g0965dd9
In-Reply-To: <20160706184829.31825-1-pclouds@gmail.com>
References: <20160704174807.6578-1-pclouds@gmail.com>
 <20160706184829.31825-1-pclouds@gmail.com>
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

