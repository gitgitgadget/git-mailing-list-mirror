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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA777C4361A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6376101E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhCaTKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhCaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BDBC06174A
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so20731153wrc.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EM3ibQs6oUUJaPk8iyFkHhcsprTCVj0YgILZX1jmfTA=;
        b=Yzpjd2gSGZUPIMQcN5BaMd6kzDhc1vI+V+N/2/jrwUpxzGD8t351zm4xlsa6e0cRe+
         kbqhj5PiVm/BEQHou3ieda5YJ1AmEYbDGvQVl/5iJpJRLXXOrYDUifIe4c3iBe0plSsw
         p6KXoHtdp4n9Jv+GXIR6DyrhRj7SYCJHI3WfD8NjACRKdXrmvV2fgj04ko46p5s5sGeb
         v0F14rAvZMMx9wQL0oLigBr//WsmuZI0ydYJf0rdwtXlifbDvhLYiSrvY/sFqukNV1OR
         D4PUd806u9BfOD7jwOiEaph9khvqbg/fTwxJoq5YeDnxXbMg7Xzm+rW2/X4X3ZNSjBW3
         nzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EM3ibQs6oUUJaPk8iyFkHhcsprTCVj0YgILZX1jmfTA=;
        b=PFN4We//gFx53dhOZQz0np7Xuv3v5coj6g+DIJADVvhc1TPvdtRqMW0ENxG51bzE+F
         bQ71He8tgUNV/fiKvhs5x/ZikDwGRYBsIlwnCbrz/as7SIm/bCX0BNbtmJyFq7wTl/ZO
         lccUPWGh5dkmmuB1SBIdSOvcjMn64G7N00175sY7k2y1OHJ3M5Cfszn1gKfnQOc8DMna
         LmgZqsalryHSDnLphtWZdVLGANPVxO6mjrqmnBvppwBY2NYfUrNzSJH0xe1CiadpVvde
         oXCkak7TTwWCKtAMhZ5ykqDXXTE11CNQo4m78KL1ZwP+XGk0AaQxUQl49qLT4L2qG3DK
         7MSA==
X-Gm-Message-State: AOAM530s0nbGz/+Hg94oW5RO0Q/2FWbWYW5moMbqy90p7sdiwZhub8G/
        ikbtWEspk5Vdur+mMWIICU78TjnsFZc82g==
X-Google-Smtp-Source: ABdhPJxWPiB6rR+Y/aNlvHGn76aDlziRpErHzLNB71HDD8c+6ZQUyYjjg750o844Hz8T3RJKR5EOEA==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr5316437wrw.328.1617217801044;
        Wed, 31 Mar 2021 12:10:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:10:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/18] tree-walk.h API: formatting changes for subsequent commit
Date:   Wed, 31 Mar 2021 21:09:41 +0200
Message-Id: <patch-13.19-9c96d472472-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do formatting (mainly whitespace) changes of code around the
get_tree_entry() function to make a subsequent change where we'll add
a sister function easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.c |  9 ++++++---
 tree-walk.h | 12 ++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 2d6226d5f18..fc2ce547c4e 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -589,7 +589,8 @@ static int find_tree_entry(struct repository *r, struct tree_desc *t,
 			oidcpy(result, &oid);
 			return 0;
 		}
-		return get_tree_entry(r, &oid, name + entrylen, result, mode);
+		return get_tree_entry(r, &oid, name + entrylen, result,
+				      mode);
 	}
 	return -1;
 }
@@ -620,7 +621,8 @@ int get_tree_entry(struct repository *r,
 	} else {
 		struct tree_desc t;
 		init_tree_desc(&t, tree, size);
-		retval = find_tree_entry(r, &t, name, oid, mode);
+		retval = find_tree_entry(r, &t, name, oid,
+					 mode);
 	}
 	free(tree);
 	return retval;
@@ -746,7 +748,8 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r,
 
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(r, &t, namebuf.buf,
-					      &current_tree_oid, mode);
+					      &current_tree_oid,
+					      mode);
 		if (find_result) {
 			goto done;
 		}
diff --git a/tree-walk.h b/tree-walk.h
index a5058469e9b..09e40d9221d 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -167,10 +167,14 @@ struct traverse_info {
 
 /**
  * Find an entry in a tree given a pathname and the sha1 of a tree to
- * search. Returns 0 if the entry is found and -1 otherwise. The third
- * and fourth parameters are set to the entry's sha1 and mode respectively.
- */
-int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
+ * search. Returns 0 if the entry is found and -1 otherwise.
+ *
+ * The third and fourth parameters are set to the entry's sha1 and
+ * mode respectively.
+ */
+int get_tree_entry(struct repository *, const struct object_id *, const char *,
+		   struct object_id *,
+		   unsigned short *);
 
 /**
  * Generate the full pathname of a tree entry based from the root of the
-- 
2.31.1.474.g72d45d12706

