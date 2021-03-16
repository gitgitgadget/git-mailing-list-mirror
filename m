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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A765FC43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8249D64FE6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhCPP7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbhCPP6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A31C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o16so7701373wrn.0
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdeNALThxh+UgsUi+SbhDygj/MqiDi9xam9o7FK3Y1U=;
        b=uVI3nl+vwLXhlKoD4ZmRMZDravl10UyQCevnVwhMe9O1FqrAmP1kukpYTDKu8/5brO
         ed3pFdG+1iJJRm7lzSigzI5tIYp8CV3mB+VQQIsLJY/Ton/O8ErEv1yMtWq4m1ehp2QG
         qYWdK4fvGdFCO3rJQU+wUC2gJq9GdMXUPndh6wRv9eTbCY9W4uQY386KR4Jk6CnPGxBn
         sPUkG3U4E5UsAjeulcGa+wc98eTtAUAy7XjgJeo2+YPb8SBrV9K5H0ZBcgC8vEatW1pv
         ZpGwJ0FnByFzrg6EWIi22+U0ast+Q+SKVeGsmuoFRTRAkd9TqcZurWAc+zXSM+cFvIzQ
         kQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdeNALThxh+UgsUi+SbhDygj/MqiDi9xam9o7FK3Y1U=;
        b=VuZQAeRofLPzKlueHW5XkWpQ5Q0HT514J4rVSAfU9pm4WzLazPJQDBUxHgyNrxkJyL
         yZE2z9L1mkoKDVH5bgEsa9qcIFW0kqq9OIWz0uOIxAxvCB3IXabN9WbmzpYKgXe9Zhlo
         cbqNFE52Y06KILbeNpkeGeLY1VdRZZ6qoH7BhydFKw2Zep+k0Scx6SAxy9lH1BRXeel1
         BwkIKJOdZ9n8gRHJxOpJlmN+pTMxfLHGZtw4oLzswPCRjgQigAvXzlgR/SR1b5wyHScj
         aUuvySRwsNL4gn/5H1KFEi/FDndjqIGOUouHIWnWd37ufoAhikIixVr6VrE3k/3Zn824
         J36w==
X-Gm-Message-State: AOAM533XBo+7B74rGw1iPBzd0Tn8ACr7ibHBhQYDeopM+VwDqeJ9UaIV
        IJ2h9prtUhiY3gtx/OfTQ7Rw0IzHdoKfhA==
X-Google-Smtp-Source: ABdhPJwyHwEDtHC6dN2nRMJb1WFgNfJTGbWLCLDmxxY6rveKOWt0JPiwihop1ospkdAEWqUrucBWGA==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr5737099wrp.345.1615910319128;
        Tue, 16 Mar 2021 08:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/32] notes & match-trees: use name_entry's "pathlen" member
Date:   Tue, 16 Mar 2021 16:57:59 +0100
Message-Id: <20210316155829.31242-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
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
index f6c194c1cc..1011357ad0 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -197,9 +197,10 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
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
@@ -214,9 +215,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
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
index d5ac081e76..0a5b4fa1db 100644
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
2.31.0.256.gf0ddda3145

