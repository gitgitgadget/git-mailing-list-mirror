Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263D0C43611
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084F060FE4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhCaTKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhCaTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DCEC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so20786058wrn.0
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+myjrGYPyXeR/oMxoot79E0GF86k3KxCFYSanaD2rKc=;
        b=fBWtbfeu1cBknarpTNKH6Fo6/ZnbVIsXxBfLnNDAJREoJTfXPE/yxjvbnEy9jKqU3U
         8baffqvZ0wEJNqDFkYpwkOfI52PDI5ZmoqNz5ORU/peT7koQ0PDwp2YnPa35rtLV5Xcs
         CoJMCdNjUZTpIKVAM3s0voYCqOKISt+9oALmePsSbhkG7zIY3hOhvrsF3Q8962q85ijn
         gkjrgz26sJpI8N1cSV2LblA2HlPfzxYi6jbIr+qihTfF++uA1flpzWXZ/0wrc7fGlZF5
         4xpPLRUv3nNmQmXBA3UXB1lxxhkQnFozKgc61Ii1AzhW4KESMohbp/vprJnsVXYbR8dk
         0EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+myjrGYPyXeR/oMxoot79E0GF86k3KxCFYSanaD2rKc=;
        b=m+c/E9EkGlgxOCqzEjWrcIc0UvFpZrc00rHKkBLmAnoF1byEYY7cUBfWbpX+SSfOC9
         XZw+l5KWHWlqukoROMeMbYL1skGPTTdglXPgOBr+TU2dHpUypUeqeB7qfXpTf8stR0IS
         tidItGKAt3z/B5vGY4v8ZGfl223vLLBBxBK3O79g9w/i2nM8N6hg+suydtjQKd0CSDxV
         KgUuZiYnJM+flf+eZxP7ufhUUGrybQfaiTN3htvYGsQ1yRWHr67vKv4QbXqwjTGoOqra
         as2Bw7vDvdKrCGcDrP67WJuiAsMweHng3YMNmVxEBEnCaZUlt2rYj9jdbN8dKBwpRaLY
         mZ8w==
X-Gm-Message-State: AOAM533a4NpF3lJC8OVUq4IsSDJ/Xs+SIXJ+5aB08Q+Wf5sgsEg/c489
        C2cbyzMzUEF+rC63hlmxParzNuJsvj0/zg==
X-Google-Smtp-Source: ABdhPJwmmtYj6r13JjT9mQ46nafqeW8gmi23XHoXGjIUEu1q/opVgtYlwfw61ehF91nkw+1/HlULKQ==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr5369352wrq.88.1617217797617;
        Wed, 31 Mar 2021 12:09:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/18] notes & match-trees: use name_entry's "pathlen" member
Date:   Wed, 31 Mar 2021 21:09:37 +0200
Message-Id: <patch-09.19-749be26bf8e-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that was doing a strlen() on the "path" from a name_entry
struct to instead use the pathlen given to us by decode_tree_entry().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 match-trees.c | 7 +++----
 notes.c       | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 48f3e0ed526..4ad0ca18256 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -199,9 +199,10 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	while (desc.size) {
 		const char *name;
 		unsigned short mode;
+		int len = tree_entry_len(&desc.entry);
 
 		tree_entry_extract(&desc, &name, &mode);
-		if (strlen(name) == toplen &&
+		if (len == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree", name,
@@ -216,9 +217,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 			 *   - to discard the "const"; this is OK because we
 			 *     know it points into our non-const "buf"
 			 */
-			rewrite_here = (unsigned char *)(desc.entry.path +
-							 strlen(desc.entry.path) +
-							 1);
+			rewrite_here = (unsigned char *)(name + len + 1);
 			break;
 		}
 		update_tree_entry(&desc);
diff --git a/notes.c b/notes.c
index a19e4ad7943..e2fec12a39e 100644
--- a/notes.c
+++ b/notes.c
@@ -413,7 +413,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
 		struct leaf_node *l;
-		size_t path_len = strlen(entry.path);
+		int path_len = entry.pathlen;
 
 		if (path_len == 2 * (hashsz - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
@@ -483,7 +483,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				strbuf_addch(&non_note_path, *q++);
 				strbuf_addch(&non_note_path, '/');
 			}
-			strbuf_addstr(&non_note_path, entry.path);
+			strbuf_add(&non_note_path, entry.path, path_len);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
 				     entry.mode, entry.oid.hash);
 		}
-- 
2.31.1.474.g72d45d12706

