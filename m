Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41280C4320E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F3A61176
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhHYCX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbhHYCXW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE5C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so3698873pjb.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwtCwIG/1ACR64LjTJvIyq9ilPKyGe7sZY3fnNRh6sM=;
        b=uQxsL1cSFUkQ4V2k6h7u6T4EjSvmhH0PlMTT/ZsyP2dFgXMgHfZo8IgGICsCwusPmU
         rXJcB8QDFd0zwZJpKnzNn72qQCxRBGvkKkfJT9wjqma7DqaCZ/o0BP24xpHJ5lAEItrD
         FLTND1L8KU53uXSkPjllFRCUa+iyqlyNONPpYxHTkCxDg+EnBXrUQbUnYQTBTijB57NX
         MpAtl66m6lXbb1Sumw/KoO46QxNWRK191Fvno9674WKi5csrrFsAlY8nukojepY+IJ34
         kcL/VmWXIPIP9ytaCDtGM2dfDgSBC9Le53SqFJ2mR9qjkRTb5wH+QbHTeQndIZKLFn49
         Y6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwtCwIG/1ACR64LjTJvIyq9ilPKyGe7sZY3fnNRh6sM=;
        b=qMsNUuJEOhuwQlU0x7QP4YqsGUwzEg5ng8847VMBd8QYjWbVpmWpeSKil0nBE+P6xV
         Qb4twCDelKHbliq9duggsv5eZafMEA06u0HNfemmt5tY2H8o3zNDqxQ+JI9h9ZnPZE7I
         v2L8pAHgCSXlCEFIGCISSmqr/QGhHSXGpEkyZ05BiN2uMgjWYHL64ZC2dhIDftHaLeKN
         QO+FzmzMosK14dM8NqTCjGMOffONj+rr5B29bOXu6aHp2QlKbRtXmuqiR2szcZVT0A4c
         5UNBbDmSEEnmlJ6BKp0reI/ZjNhkCLYstWQDIX6lcxC9ompHd7ooKF/waN10W4yLHKC0
         kPxw==
X-Gm-Message-State: AOAM532QUAFI2QM3fjVLTilh5P2M/oAZNxEnYNLJr2Kk7qimK3OzRc45
        wlkXacGkLCC2PbVaQ2WPjAE=
X-Google-Smtp-Source: ABdhPJwtSZqwFl2nmU8wu4juCqW1p84Da/ajvrXqOBZTeV6Iyc/oxy7yXYF1RlbDRcArjjyoveldVg==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr7677612pjg.79.1629858157168;
        Tue, 24 Aug 2021 19:22:37 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:36 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 11/14] packfile-uri: support for excluding tag objects
Date:   Wed, 25 Aug 2021 10:21:55 +0800
Message-Id: <43aa811b659651611c041db8e9d6c63a9aedfce3.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit supports the use of `uploadpack.excludeobject` to exclude
tag objects, both lightweight tag and annotated tag are supported:

-If a lightweight tag (such as a commit object) have been configured,
the mechanism of exclusion is the same as the commit object (the commit
object and all objects it contains will be recusively excluded).

-If an annotated tag (created with -a, -s, or -u) have been configured,
the annotated tag and all the objects that it contains will be excluded,

For an example of the annotated tag:

	Create an annotated tag from HEAD:

		git tag -a A -m "tag A description"

	Output the SHA (<tag_oid>) of tag "A" :

		git rev-parse A^{object}

	Dereference <tag_oid>, output the SHA <commit_oid> of commit:

		git rev-parse A^{}

In the above case, when the tag object (<tag_oid>) is configured with
`uploadpack.excludeobject` which means <tag_oid>, the dereference
commit object (<commit_oid>), and all the objects that <commit_oid>
recursively contains (trees, blobs), will be excluded (using a packfile
URI instead).

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 20 ++++++++++++++++++--
 list-objects.c         |  9 ++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d38b24e375..d5e3f2c229 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1317,9 +1317,11 @@ static int want_object_in_pack(const struct object_id *oid,
 	int want;
 	struct list_head *pos;
 	struct multi_pack_index *m;
+	struct configured_exclusion *tag_ex;
 	struct configured_exclusion *commit_ex;
 	struct configured_exclusion *tree_ex;
 	struct configured_exclusion *ex;
+	struct object_list *p;
 
 	if (!exclude && local && has_loose_object_nonlocal(oid))
 		return 0;
@@ -1355,14 +1357,27 @@ static int want_object_in_pack(const struct object_id *oid,
 	}
 
 	if (uri_protocols.nr) {
+		if (referred_objs && referred_objs->tags) {
+			for (p = referred_objs->tags; p; p = p->next) {
+				tag_ex = oidmap_get(&configured_exclusions, &p->item->oid);
+				if (match_packfile_uri_exclusions(tag_ex))
+					return 0;
+			}
+		}
+
 		if (referred_objs && referred_objs->commit) {
 			commit_ex = oidmap_get(&configured_exclusions, &referred_objs->commit->oid);
 			if (match_packfile_uri_exclusions(commit_ex))
 				return 0;
+			struct commit *commit = (struct commit*) referred_objs->commit;
+			for (p = commit->wraps; p; p = p->next) {
+				tag_ex = oidmap_get(&configured_exclusions, &p->item->oid);
+				if (match_packfile_uri_exclusions(tag_ex))
+					return 0;
+			}
 		}
 
 		if (referred_objs && referred_objs->trees) {
-			struct object_list *p;
 			for (p = referred_objs->trees; p; p = p->next) {
 				tree_ex = oidmap_get(&configured_exclusions, &p->item->oid);
 				if (match_packfile_uri_exclusions(tree_ex))
@@ -3260,7 +3275,8 @@ static void read_object_list_from_stdin(void)
 
 static void show_commit(struct commit *commit, void *show_data, void *carry_data)
 {
-	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, NULL);
+	struct referred_objects *referred_objs = carry_data;
+	add_object_entry(&commit->object.oid, OBJ_COMMIT, NULL, 0, referred_objs);
 	commit->object.flags |= OBJECT_ADDED;
 
 	if (write_bitmap_index)
diff --git a/list-objects.c b/list-objects.c
index 2e53a01458..52f38c9151 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -367,6 +367,7 @@ static void do_traverse(struct traversal_context *ctx)
 {
 	struct commit *commit;
 	struct strbuf csp; /* callee's scratch pad */
+	struct referred_objects *referred_objs;
 	strbuf_init(&csp, PATH_MAX);
 
 	while ((commit = get_revision(ctx->revs)) != NULL) {
@@ -384,7 +385,13 @@ static void do_traverse(struct traversal_context *ctx)
 			die(_("unable to load root tree for commit %s"),
 			      oid_to_hex(&commit->object.oid));
 		}
-		ctx->show_commit(commit, ctx->show_data, NULL);
+		referred_objs = xmalloc(sizeof(struct referred_objects));
+		referred_objs->commit = NULL;
+		referred_objs->trees = NULL;
+		referred_objs->tags = commit->wraps;
+
+		ctx->show_commit(commit, ctx->show_data, referred_objs);
+		free(referred_objs);
 
 		if (ctx->revs->tree_blobs_in_commit_order)
 			/*
-- 
2.31.1.456.gec51e24953

