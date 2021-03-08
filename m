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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6EC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FED46521F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhCHPHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHPHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1FC061760
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l11so8416834wrp.7
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LkmuWBCtFzTqo+05uB6OBB8XVwpv+VAUv1vZy5ADS4=;
        b=mNpnlJBqS5xxRYJmNytcKafhl7DBQbq6wXIjXP9ogcI0GT3oldpZTslTMLHCWgLPv3
         M1lmLpJVTyvls5bggyoDiUzzZBzEBRq+DcyCRNGSd8lWPjcqWCy9WEmnrU9VJHGgny9a
         7B54/EUUWAWocHjFsl3q14iwwAq4LVrShl3Jzh792mBZoYkdNeTqPKlN2HkbWRTsDUZD
         e4ON7JfAIgUkoOidShGnjZcy0zAOX7iJaUGy5afPfm1EWmjznBiVJUplMJqQ80fvPasg
         X7sC1w+mS4RqsxqbzF8FOBuJXizqlS12p199SaTCt8brpoyTcsd+nHsHYj+E7XyPCzLJ
         MQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LkmuWBCtFzTqo+05uB6OBB8XVwpv+VAUv1vZy5ADS4=;
        b=i3V1vBxCB4jGY7UfimW/JRe1R89yRdzIjWktmuVORXm4P81IIKhD6o2tkGcEWElOvL
         G71+1rksC466yoZL/wSLJM9Wk30pMbDihPHhp7WDrdzVZI/P/r4xQca0lIZSuN9VBw2Z
         nsoERy8TknlrWu0XdikNuueE3gauNop4KTA16sHHqAD11qEYmc4rBfLN5kjOKF0fbOUs
         USTkUZISEXwJez5hen07qQzXxbW8ifX6TViwYaDJ+xqbIRwJasBDZ4YDFpymGjRrNv5A
         RhrDUDcP3triWjfrTJdjSbzdE5BVx8E0yhp7ciRYcCD3PcvoDF8Uvt0OuT/eh9q+Mx+6
         eg4w==
X-Gm-Message-State: AOAM531E5bDrOKFU7P3fVpOiOTve2b4UdDoe4fdyMKY6uAMi7q5Lhndd
        aW79R39DFWHUNxvVYv9BWVKBrgyyt1C3MA==
X-Google-Smtp-Source: ABdhPJwftsSo6BFwYYrAtLOzdiamWEz90j1TU/ph3UpI2J2JeAI25FHHwlSFltnHu2gCvuQGP0irPA==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr23725837wrn.204.1615216030524;
        Mon, 08 Mar 2021 07:07:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:09 -0800 (PST)
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
Subject: [PATCH 02/30] notes & match-trees: use name_entry's "pathlen" member
Date:   Mon,  8 Mar 2021 16:06:22 +0100
Message-Id: <20210308150650.18626-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
2.31.0.rc0.126.g04f22c5b82

