Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6C72070E
	for <e@80x24.org>; Wed,  6 Jul 2016 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbcGFStK (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 14:49:10 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36038 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbcGFStE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 14:49:04 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so23037969lfe.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 11:49:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaBIEArK8v4VMc6Y6Pcbv6UUb3q+8S8dKIGm5agEwGM=;
        b=tCv1ZnZ9gZZcGRXBnJELr8QVS03kzdsphagB/0iQochIVWinTuwxW7noCpj+HZHqcx
         8A+0sCz5Dhq3Hs8Dh5f++TQawbo0w5lDkoFJL8P6XXBtW0EzPMGSELEQY18wnU4Fq+MT
         qbFXVEt3IxTlhwqibORO27pAp4MBfLcijp/G7+pIFFRryvoPzgBJ91jWS8OKjVb+dOm7
         1i8qWN0HWXYTuu2khgmm5nhNv8GxjHDst1H/bWMDQB9SS0UK/qC0mlUTDDaDxdfqj0Ro
         4v/kLTnMEUs9MjbuRajQg1ONRvUSQINX/6zyLJAaeJ/Ha12C5E0biC0gh7qlL1BR9O2I
         Iebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaBIEArK8v4VMc6Y6Pcbv6UUb3q+8S8dKIGm5agEwGM=;
        b=QgiqAPQbtBK0Xe4iha/zWWHr33LH3jhmpKq//ET9pKLtUnGyoSIKDM0m5jW7bHJwvy
         hovcwVLAD3z18ZqeXzLH3qQbaMBzeX1xsTC0/N24srjZxvTRe7l6Hkon4UfdaDsJg14l
         fAmSXW2iiaD3ixXVIoQGJcNF7hRTkOUV4ps7zDEs3gfSeiCTSvVYEymJKjzx+PalBc1P
         TU1wMshAa8MZqMrAeGh5ROoqwNokzaW/zz5RSKSZCNhXkMKCEDnosXv36U4ZGN9Kc6E9
         tHeHV5hiI2Mcoc8VwAIhEpjhL/Ox0lWWjEZ/tiI2NSTngmKqMTmEZmCzPLdbWF9YV/+C
         GV3Q==
X-Gm-Message-State: ALyK8tKhFCBRoDz1tEUdXEChwkNy3YMkZwT9BBXMVDM32KwvWSzhcXw0XedWKHwfSj9yUg==
X-Received: by 10.25.85.75 with SMTP id j72mr7491005lfb.31.1467830942890;
        Wed, 06 Jul 2016 11:49:02 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 76sm6686199ljj.3.2016.07.06.11.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 11:49:02 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, yuri.kanivetsky@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] cache-tree: do not generate empty trees as a result of all i-t-a subentries
Date:	Wed,  6 Jul 2016 20:48:29 +0200
Message-Id: <20160706184829.31825-3-pclouds@gmail.com>
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

If a subdirectory contains nothing but i-t-a entries, we generate an
empty tree object and add it to its parent tree. Which is wrong. Such
a subdirectory should not be added. We ignore i-t-a files _and_
directories.

Note that this has a cascading effect. If subdir 'a/b/c' contains
nothing but i-t-a entries, we ignore it. But then if 'a/b' contains
only (the non-existing) 'a/b/c', then we should ignore 'a/b' while
building 'a' too. And it goes all the way up to top directory.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache-tree.c          | 16 ++++++++++++++++
 t/t2203-add-intent.sh | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index c2676e8..75e73d7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -380,6 +380,13 @@ static int update_one(struct cache_tree *it,
 			continue;
 		}
 
+		/*
+		 * "sub" can be an empty tree if all subentries are i-t-a.
+		 */
+		if (sub && sub->cache_tree->entry_count < 0 &&
+		    !hashcmp(sha1, EMPTY_TREE_SHA1_BIN))
+			continue;
+
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
 		strbuf_add(&buffer, sha1, 20);
@@ -426,6 +433,15 @@ int cache_tree_update(struct index_state *istate, int flags)
 	i = update_one(it, cache, entries, "", 0, &skip, flags);
 	if (i < 0)
 		return i;
+	/*
+	 * Top dir can become empty if all entries are i-t-a (even
+	 * from subdirs). Note that we do allow to create an empty
+	 * tree from an empty index. Only error when an empty tree is
+	 * a result of the i-t-a thing.
+	 */
+	if (it->entry_count < 0 &&
+	    !hashcmp(it->sha1, EMPTY_TREE_SHA1_BIN))
+		return error(_("cannot build a tree from just intent-to-add entries"));
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	return 0;
 }
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 24aed2e..a19f06b 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -99,5 +99,17 @@ test_expect_success 'cache-tree does not ignore dir that has i-t-a entries' '
 	)
 '
 
+test_expect_success 'cache-tree does skip dir that becomes empty' '
+	rm -fr ita-in-dir &&
+	git init ita-in-dir &&
+	(
+		cd ita-in-dir &&
+		mkdir -p 1/2/3 &&
+		echo 4 >1/2/3/4 &&
+		git add -N 1/2/3/4 &&
+		test_must_fail git commit -m committed
+	)
+'
+
 test_done
 
-- 
2.8.2.537.g0965dd9

