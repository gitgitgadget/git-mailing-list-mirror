Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180EC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B426137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhJSLlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhJSLlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54919C061745
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om14so14467519pjb.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLo4u9s1X5zLPxhCO8ORjhQf3Y7caS52Un+IAadkMZY=;
        b=V7EFPCPgOREC9CgkFZkNxRcCB3+WwaeNEziGteMwqKZdfSXzo4QMf4Z1Dj+oKAW+Nq
         hMiq8AAOVknVClmrsIWmaQurPKtWgcShIwgFdAdrADKw9o9DCpdWBZGZxMdICo355s+B
         7tx8csfALvz+f7eQcpkcaoT2f46iEncMxiVfeJRIlB9HEIp3eNYriw6Ktm/4B4tiASj5
         XM1TqYOfNlcJx/R2tmpPuOBi0Daq2feAOhY56eV9M6kSoB2kmDiNC2rLWQtszGV9ws8A
         tl2IlmgH92alDQLX7DKKRsj+XyTSaaLPtXXTLc6OPBmA7klywcQ3tsPrh8sSBawqEXXP
         9eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLo4u9s1X5zLPxhCO8ORjhQf3Y7caS52Un+IAadkMZY=;
        b=1IglOtxgH2ySO0xzQPmtaqri8Q0eQfgrqskavdq81DL/z/Zb30bFvfunGjK8l6Afix
         hz54AArjEXyEr1kB4Kny8wuW3dM+3tOsav7hlxquyqH7WErjKfnNo3FPb77eaRtgUJSg
         l1X0gM2YRx4J3YnO5tGNbdA/s7DzHTSQ1GUjdd2rqG1pDHi7TJe9yFJdm8XdMlFs8axC
         lFaBiWc27MfQkK/WcxXDg74jiTjlHQN+aPU5dOWiCVkFaIJCsse9Aq7Di4TW0KXORI71
         TtrXF25wF+nG+ikon26noEME52QwYDeRI6TKDaj4uxLhfsQzJA1ti48W9pr4YdD4WGWL
         14iA==
X-Gm-Message-State: AOAM532RtYcxSusJkkvKST4QhledHCmhzaHBl9BQtBKpRFVQXlRLJ5jl
        JoTK+vvuQvUvzxz/ASHm1xnKiWMVeCs=
X-Google-Smtp-Source: ABdhPJxMqxbdMGveqNNFG4mrD9UBYpOP+z9Umz0rpMCHPNeWrK59EN4z/JGUTd3B3yxnK6azFNaaCg==
X-Received: by 2002:a17:903:24c:b0:13f:2377:ef3a with SMTP id j12-20020a170903024c00b0013f2377ef3amr33204590plh.59.1634643549592;
        Tue, 19 Oct 2021 04:39:09 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 01/12] objects.c: introduce `exclude_level` enum
Date:   Tue, 19 Oct 2021 19:38:25 +0800
Message-Id: <3a885678c9cee6ed4a70a7c88c15a7fa1b332150.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Currently packfile-uri supports the exclusion of blob objects, but
in some scenarios, users may wish to exclude more types of objects,
such as commits, trees and tags, the difference with blob is they are
more complicated. In addition to the meaning of a single object itself,
it may also represent a collection of the objects that it includes
(trees and blob in a root-tree) or reaches (ancestors of a commit).
The exclusion range is designed by an enum named `exclude_level` in
"pack-objects.c" that enumerate three values, "ET_SELF", "ET_INCLUDE"
and "ET_REACHABLE".

Here are some explanations for their differences:

- Scene 1: "ET_SELF" for excluding object itself.

Reason to support the "ET_SELF" is because the definition of
exclusion-level should be better to be consistent, no matter what
the object type is. Excluding a single object itself has meaning for
blobs, because blob is the smallest granularity among object types, and
indeed, sometimes there are some frequently used big-size blobs in
repository.

If you want to exclude more ownership or reachable objects, it can be
considered to use "ET_INCLUDE" or "ET_REACHABLE".

- Scene 2: "ET_INCLUDE" for excluding object itself and objects it
contains.

When a commit is specified to be excluded as packfile-uri,
more offen, it's hoped to exclude the trees and blobs contained in
its top-level tree, as well as the commit itself, but not the
ancestors of the commit. This applies to scenarios where we want to
exclude a specified non-blob object that includes some big-size
objects.

Commit, tag and tree are suitable for this scenario. When a tag
is specified, it will exclude the dereference commit, and all trees and
blobs contained in its top-tree, as well as the tag itself if it's not a
lightweight one.

- Scene 3: "ET_REACHABLE" for excluding object itself, all the objects
it contains, and its ancestors.

For further exclusion range, the ancestors are needed to excluded
together, for example, the clone scenes.

This commit only defines the `exclude_level` enum type. The implementations
of non-blob object types will be added in subsequent commits.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..73b92a0c90 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -127,9 +127,52 @@ enum missing_action {
 };
 static enum missing_action arg_missing_action;
 static show_object_fn fn_show_object;
+/*
+ * exclude_level defines how to make the exclusion when the object matches
+ * a packfile-uri (uploadpack.excludeobject or uploadpack.blobpackfileuri)
+ * configuration.
+ *
+ * - ET_SELF;
+ *   This type means only the object itself will be excluded, and all other
+ *   objects it includes or reachable will not. For example, if object type is:
+ *   	- BLOB:  The blob object will be excluded
+ *   	- TREE:  The tree object will be excluded, the sub-trees and blobs it
+ *   	  includes will not be excluded.
+ *   	- COMMIT: The commit object will be excluded, all the trees and blobs
+ *   	  that be included in its top-level tree will not be excluded.
+ *   	- TAG: TAG object will be excluded, the referrenced commit object will
+ *   	  not be excluded.
+ * - ET_INCLUDE;
+ *   This type means that not only the object itself will be excluded, but
+ *   also the objects it includes. For example, if object type is:
+ *   	- BLOB:  Same with 'ET_SELF'
+ *   	- TREE:  The tree object, and also the sub-trees and blobs that
+ *   	  the object includes will be excluded.
+ *   	- COMMIT: The commit object, and also all the trees and blobs
+ *   	  contained in its top-level tree will be excluded.
+ *   	- TAG: The TAG object will be excluded, and also the referrenced
+ *   	  commit will be excluded (the referrenced commit exclusion will
+ *   	  treat as a 'ET_INCLUDE' way).
+ * - ET_REACHABLE;
+ *   This type means that not only the object and all the objects it includes
+ *   will be excluded, but also the reachable objects. For exmple, if object
+ *   type is:
+ *   	- BLOB:  Same with 'ET_INCLUDE'
+ *   	- TREE:  Same with 'ET_INCLUDE'
+ *   	- COMMIT: The Objects in the case of 'ET_INCLUDE' will be excluded,
+ *   	  and also the ancestors of the commit will be excluded.
+ *   	- TAG: The Objects in the case of 'ET_INCLUDE' will be excluded, and
+ *   	  also the ancestors of the referrenced commit will be excluded.
+ */
 
+enum exclude_level {
+    ET_SELF,
+    ET_INCLUDE,
+    ET_REACHABLE,
+};
 struct configured_exclusion {
 	struct oidmap_entry e;
+	int level;
 	char *pack_hash_hex;
 	char *uri;
 };
@@ -3003,6 +3046,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		if (oidmap_get(&configured_exclusions, &ex->e.oid))
 			die(_("object already configured in another "
 			      "uploadpack.blobpackfileuri (got '%s')"), v);
+		ex->level = ET_SELF;
 		ex->pack_hash_hex = xcalloc(1, pack_end - oid_end);
 		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
 		ex->uri = xstrdup(pack_end + 1);
-- 
2.31.1.453.g945ddc3a74.dirty

