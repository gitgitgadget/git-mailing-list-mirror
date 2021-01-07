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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A0C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAAF23444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbhAGUC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbhAGUC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:28 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C76C0612A4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:47 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q75so6581185wme.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nAuK0icYeCv6YS0QrluSPaIZD6FjfdByI7t/kR1s2e0=;
        b=O7RL340E+h2QThQPBG0Him3tp0CXHTktL3+aB5WoKL6UKf2l2m4MFEhdhY9t2wpEQY
         PrpOHs/iiuvqJAXtKpfcEA3tEuDi4BplIyXvbzVBclu0rn4kkwhmsxo6lVK5DmIbPdKS
         cXwdLwlv/5ljVk43gYRCWD7yIJPuFqMTl7yWtQbMXA1lxzIwW4X8I/HVbK6QSdyJaN6A
         ZSLBJyGkzIZIacJSBcUME82jntLsd0GSD1Zw2uFrlag4tDrb3LHJ+FPN46dVC4T8QawY
         vnKUV7U1C+oPrjOtbhi0xRzL8+YRXXPz+mIxfV6RLjL49961WyZJBWzfFrjGLp/U8eb3
         0q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nAuK0icYeCv6YS0QrluSPaIZD6FjfdByI7t/kR1s2e0=;
        b=sV33vO22Drb5fQHmGO/4BQvK4dvfbit8Vv7w9dHpw5BVuHDgo3QAsSGCUOX3Q+fzAB
         5YV5RlWiFPX7j6qu/CmiAuoDbQM1/lf+hWusje1qWU89X3BhOAnezTXGuw5t/Kvu12QQ
         W3K7YAR+z/QBCgyOB+hzjuvD71XoEVwN23w6EysqlWApP6lWHxKwvrjpa85e1F6pRFLt
         fK1BU93M51E4Ml8DC39Gd8rCimK/iNjOAyY4O7AqqbMzZr5Ea1zMLWI8WBUumGNiTdYY
         eBOLPQA8HfLMWLUuMeJhlxdSQ3smHnyPFo906U5B9mIKK0mfnv8LTT9svA36mfTaAz5K
         jWPQ==
X-Gm-Message-State: AOAM5335xUf/zJsBNqwLwfhy7U1paEVCrMlEkgWL2aenobJiWbzwzWyQ
        z2GuZnxjBJFOiPndjeYAy/DqKk3sUDQ=
X-Google-Smtp-Source: ABdhPJyYKD/+jaNC8xy7ZX+7RIEZuqBjEWMKcO8owRteh5k1hVc/7r1kfh0XnrlwS5h4cWA9KzB4XQ==
X-Received: by 2002:a1c:3c09:: with SMTP id j9mr166579wma.180.1610049705962;
        Thu, 07 Jan 2021 12:01:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm10181608wra.53.2021.01.07.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:45 -0800 (PST)
Message-Id: <786dc8f0c449958174a4cf5e98704d36f3ae4076.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:27 +0000
Subject: [PATCH 18/18] DO NOT SUBMIT: directory rename stuff for
 redo_after_renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

I believe the
   ci->dirmask & sidemask
stuff was leftovers from before I added dirs_removed.  I think it's
dead, useless code; just need to check.

Also, the
   !mi || mi->clean
portions should only be triggerable once I do the redo_after_renames
stuff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 55a835f8b97..1eb3a2e0fbb 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1031,6 +1031,48 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 	}
 }
 
+static void remove_invalid_dir_renames(struct merge_options *opt,
+				       struct strmap *side_dir_renames,
+				       unsigned side_mask)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list removable = STRING_LIST_INIT_NODUP;
+	int i;
+
+	strmap_for_each_entry(side_dir_renames, &iter, entry) {
+		struct merged_info *mi;
+		struct conflict_info *ci;
+
+		mi = strmap_get(&opt->priv->paths, entry->key);
+		INITIALIZE_CI(ci, mi);
+		if (!mi ||
+		    mi->clean ||
+		    (ci->dirmask & side_mask)) {
+			/*
+			 * !mi: This rename came from a directory that was
+			 * unchanged on the other side of history, and NULL on
+			 * our side.  No directory rename detection needed.
+			 *
+			 * mi->clean: Due to redo_after_renames, on the second
+			 * run, collect_merge_info_callback was able to
+			 * cleanly resolve the trivial directory merge without
+			 * recursing.  As such, we know we don't need
+			 * directory rename detection for it.
+			 *
+			 * ci->dirmask & side_mask: this directory "rename"
+			 * isn't valid because the source directory name still
+			 * exists on the destination side.
+			 */
+			string_list_append(&removable, entry->key);
+		}
+	}
+
+	for (i=0; i<removable.nr; ++i)
+		strmap_remove(side_dir_renames, removable.items[i].string, 0);
+	string_list_clear(&removable, 0);
+}
+
 static void handle_directory_level_conflicts(struct merge_options *opt)
 {
 	struct hashmap_iter iter;
@@ -1050,6 +1092,9 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
 	}
 	string_list_clear(&duplicated, 0);
+
+	remove_invalid_dir_renames(opt, side1_dir_renames, (1 << MERGE_SIDE1));
+	remove_invalid_dir_renames(opt, side2_dir_renames, (1 << MERGE_SIDE2));
 }
 
 static struct strmap_entry *check_dir_renamed(const char *path,
-- 
gitgitgadget
