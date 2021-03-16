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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA04C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2101A65011
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCPCNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhCPCNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58567C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g25so9210772wmh.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=203EGFNjtbQwVpgUWcr8qhue7eTXdL6ELa6yPA7UK3s=;
        b=TzxF/teNbujjcKhb5bGswKui/0HQIa9/wMsjrYAEQvEhQUGEGMEm3qfDUV2c/WRVli
         RQLt93epNzZ2Lk/uELGi/BzP5meXJ6lfhQdgcjSlt0lvwzZl/kN/Uxa0YCIHZ6HmEWLX
         fEMhDy6zoi2Kc3mxB9H9CEEPH0A1ey24j9sXaRLhG/7McCdqhomH4d9uamIaPD5HY3y5
         5DIDcUPvcdPNdsAKu+r4m6dWgEWhgybABb6hHYVG9mdgSQUFnjGLhvCmKYUXI8iWAXVc
         GLR/IwaBj0Eac08ud6MQA2km4h6e60A635bQpeXPqlqwOC9ZvReP6l08WUOMPDFPuewM
         moYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=203EGFNjtbQwVpgUWcr8qhue7eTXdL6ELa6yPA7UK3s=;
        b=r0pgizpNMmM1yaRSfxS5HJJu6er6AgtrXVKpYMPXP4m4+grYj5MAp0TeBJaSkjkiqC
         Jy0ICLM4kif6G0wIsWdLDy3+P2bHJBi7m9cXMsjnJnTecAny3zWx96LDPE0EgCNP9F1C
         F1+EqVtuH6fxFkigr91aia9cHzFJWmaMcsTKPOc+VK9uz+i/ThOj1ipI3hwkv+qKdV1U
         5S0gFlqTwSFUMPxglmU3kDTz41RnFC2KEFFmTXnqYozwC/UX00dPMAZPf2sqZ2OTpCDx
         htFSN9k16HPiwVh3hloNjmSDFTnUsJJRd2hcBTUChpWNrksPpxV4W3X+Sr1qzIx4klw8
         n8SA==
X-Gm-Message-State: AOAM531uWcWaEYrsg6zu0rmE7v7pWuRhZTL8DYsIR2rvNVQVrbmgx8mk
        /GHnF6U57d2rAiQeUT3sEQKZuoScnw7OdQ==
X-Google-Smtp-Source: ABdhPJxx4efZoB+4u2wMzCDEpjBAvbIVi3QyYRsXTTsoEP98owvTDttvvAFBk4Ih53D4U3Jao2D3WQ==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr2200739wmc.75.1615860812828;
        Mon, 15 Mar 2021 19:13:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:32 -0700 (PDT)
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
Subject: [PATCH v2 02/29] notes & match-trees: use name_entry's "pathlen" member
Date:   Tue, 16 Mar 2021 03:12:45 +0100
Message-Id: <20210316021312.13927-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
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
index f6c194c1cca..1011357ad0c 100644
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
index d5ac081e76d..0a5b4fa1dbb 100644
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
2.31.0.rc2.211.g1d0b8788b3

