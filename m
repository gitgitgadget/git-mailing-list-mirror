Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD6C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E15610CB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhGMTgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbhGMTgE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:36:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1816C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1079357wmf.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 12:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=35ri/oVrMbO6uA75NOizGkqjB2GcqWgsCqqYDqf0wbs=;
        b=PrMxo0flnzhyUSk9x4sjR4L+YjttVIdpdy6z2nTVNX1FE/hLnkxH2s9mOmrri6kJhY
         humu3M01rg8eGSzo6ggpt+JZpeTLPBHBCkF0t1Jq+q/NJEAbkPdV+10Kwl6ChzXrPKoz
         D9dxmzoufgJEj8NGldi6tU4vankrgrDXlZoCDZx1yRz6z30i6cBM7rzoUOTHKqWqbpfp
         JcrWXsg+s/4Gmad/DlqEDKShKAZZ2UJOcvG6KM24z5xigTWzK7zmUYvUiqb0T8vGNIgW
         gOXsGd1Qt9fKsM+StM1QRAURrpmMiU/Jq7Su+kdGmzkSAs9l++m3Xaw4XJqB0k9PNVUS
         /5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=35ri/oVrMbO6uA75NOizGkqjB2GcqWgsCqqYDqf0wbs=;
        b=bCokp8BGS/bgHQ75yAuAkfi/5uA6j9C8ngtzbz9rRb2uT5NXINOyfn23H8NbEpUKR1
         XI7dC034bSgeTUvo5t3hLoCxe9T2Sr7WHGgbVoA2+5tGOchtciquXzkMdOxKkvT6irYt
         3hJP82aqAF+En3xhHk4wH8zJtEN8c4HgxE1lDuZCDpnNkHEKogo53rjm3pOc0eDbWYsj
         K3g4W1+Jdvru6tk9gx8dGzV0XCZmqgRYydkcV7YBuVlWuofliAIJM1o25Pb7SqXWyTcZ
         bPNEQEOssufl668KGUriSXOz0kh9ynCGuX/f4nYW9wkoPcuxvrk9DDMk6T5nBqMKhmdU
         3DWw==
X-Gm-Message-State: AOAM531d2h3e0lAVWB2rkMFBQrYHAa7KL1W0C0sTcFZfHVsGOVgA2rFY
        MFz9uw0juFU0XRujQQDPQrL8AxB24K8=
X-Google-Smtp-Source: ABdhPJyjgiQsiOofyKidDUR3h2ogC0hNT7QvYfCfIUFtpKRFLv411xltBNtnOcrvZb8UcWmbhJ3drA==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr6826318wml.59.1626204788329;
        Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm17640180wro.78.2021.07.13.12.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 12:33:08 -0700 (PDT)
Message-Id: <7e28323b624ad2d8d12123783f00f5a8fbb248e8.1626204784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
        <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Jul 2021 19:33:00 +0000
Subject: [PATCH v2 4/7] merge-ort: add a handle_deferred_entries() helper
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to allow trivial directory resolution, we first need to be able
to gather more information to determine if the optimization is safe.  To
enable that, we need a way of deferring the recursion into the directory
until a later time.  Naturally, deferring the entry into a subtree means
that we need some function that will later recurse into the subdirectory
exactly the same way that collect_merge_info_callback() would have done.

Add a helper function that does this.  For now this function is not used
but a subsequent commit will change that.  Future commits will also make
the function sometimes resolve directories instead of traversing inside.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 3d3f00b3b45..eb0e18d7546 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1196,6 +1196,70 @@ static int collect_merge_info_callback(int n,
 	return mask;
 }
 
+MAYBE_UNUSED
+static int handle_deferred_entries(struct merge_options *opt,
+				   struct traverse_info *info)
+{
+	struct rename_info *renames = &opt->priv->renames;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int side, ret = 0;
+
+	for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
+		renames->trivial_merges_okay[side] = 0;
+		strintmap_for_each_entry(&renames->possible_trivial_merges[side],
+					 &iter, entry) {
+			const char *path = entry->key;
+			unsigned dir_rename_mask = (intptr_t)entry->value;
+			struct conflict_info *ci;
+			unsigned dirmask;
+			struct tree_desc t[3];
+			void *buf[3] = {NULL,};
+			int i;
+
+			ci = strmap_get(&opt->priv->paths, path);
+			VERIFY_CI(ci);
+			dirmask = ci->dirmask;
+
+			info->name = path;
+			info->namelen = strlen(path);
+			info->pathlen = info->namelen + 1;
+
+			for (i = 0; i < 3; i++, dirmask >>= 1) {
+				if (i == 1 && ci->match_mask == 3)
+					t[1] = t[0];
+				else if (i == 2 && ci->match_mask == 5)
+					t[2] = t[0];
+				else if (i == 2 && ci->match_mask == 6)
+					t[2] = t[1];
+				else {
+					const struct object_id *oid = NULL;
+					if (dirmask & 1)
+						oid = &ci->stages[i].oid;
+					buf[i] = fill_tree_descriptor(opt->repo,
+								      t+i, oid);
+				}
+			}
+
+			ci->match_mask &= ci->filemask;
+			opt->priv->current_dir_name = path;
+			renames->dir_rename_mask = dir_rename_mask;
+			if (renames->dir_rename_mask == 0 ||
+			    renames->dir_rename_mask == 0x07)
+				ret = traverse_trees(NULL, 3, t, info);
+			else
+				ret = traverse_trees_wrapper(NULL, 3, t, info);
+
+			for (i = MERGE_BASE; i <= MERGE_SIDE2; i++)
+				free(buf[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return ret;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
-- 
gitgitgadget

