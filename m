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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31378C636CB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184DF613F1
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 05:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhGPFZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 01:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhGPFZh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 01:25:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E4C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n4so5037728wms.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3pQTiqqi0z3pbO2bG82jfMNlolewzMY5DieUUyyiGZ4=;
        b=UzSgDn5C5c8/zGqdFWh6s9APDcuHzpkCEcsRR/LYXSKvlFZXsODuLACF4pvy5E7pdu
         CrKuWmqZOBdGc6RiAG1aIAVWKUedJL/GuS9th5jJnVLfMCOLr4cjfr3ZtYod7W1Jqa2I
         gOj5MoQm90RjfSNfX+W8Q+A4qimflNFWRoVkPx1qotyLDF1MTY3VaeMgCHZ6bYNJL636
         wz73YrsIjjiZ9g3yZ1d9CaGKccQXbxUtOaiRliA5RwejiTiwfEuaIvFFjnDcBHtvGGMj
         gZ9wyaBqi0cLfTnKtDFH9IsMxJLoAQbUAZ752fnONVPjiUTSb1gPnlXhRNwndSx+losk
         JgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3pQTiqqi0z3pbO2bG82jfMNlolewzMY5DieUUyyiGZ4=;
        b=n8P46ueJyIB6NWfZ23RBW3Vm+xOrUIo8ZGvgg7o3Jofes3fhh/mqg40FV5vT2MlIKh
         wAjJYx4wVwBcrHT2UT3A5UWPNWBanCsiEJRyOZYjEK8yxx+EU3v+4EwE6dYJoeBC8zEN
         YI/R0E+tc/BTISftD7tHt9nwY24GW1fIIJGDzpUj/p4+/vA+7987LQGp8Zu7Hxe/rWBJ
         oQKW7i+oVfFXfHSnygBDUm0sU7W9ghBPTvWKwNinTrwecZTPt4WJpRT7qzq3Xrao7XMn
         /CLsIH48BtcXEWoqWIvZo3wAY4xLZu+gho9QwrD52rXEPKDujLvrj15VJVIPZmXdWgv9
         W6Fw==
X-Gm-Message-State: AOAM533bmQnuvm0ANnspihcaWYv1WsvIluBBxNL6IwgvUac9KQicUaYS
        MbPARVMxqJzkJYnAjv8f96XiqkQ2ASU=
X-Google-Smtp-Source: ABdhPJx5PQRTQ6ebm5+ICkieBl8tFSXxHvXlCiovZKcD5uokOjztxiRZmCMNKMqRVf+9NxPWGLYLyQ==
X-Received: by 2002:a05:600c:190a:: with SMTP id j10mr14100355wmq.109.1626412961859;
        Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm9931013wmc.2.2021.07.15.22.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 22:22:41 -0700 (PDT)
Message-Id: <1cf4a47562a891ff5fd009c6c5ba836bf798da87.1626412958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
References: <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
        <pull.988.v3.git.1626412958.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Jul 2021 05:22:34 +0000
Subject: [PATCH v3 4/7] merge-ort: add a handle_deferred_entries() helper
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index d9263ec5aca..f0a07684df6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1202,6 +1202,70 @@ static int collect_merge_info_callback(int n,
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
+		renames->deferred[side].trivial_merges_okay = 0;
+		strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
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

