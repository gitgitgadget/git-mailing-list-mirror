Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A5C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 17:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244001AbiEURPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiEURPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 13:15:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53366AE8
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso5748595wmq.1
        for <git@vger.kernel.org>; Sat, 21 May 2022 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26OPc/IWX8SJR7d6DqYrd4Zx4/7RJqNnYY2MrayQs5U=;
        b=SmUhLVCAq0KvAV/U+FBaIhzfGAJRDqVkXdYFTwC2ASrS+LqpiYTWd0fSmj0h5DazJI
         yCMzmSdZBTay6T8F60gS998cf352pED5Xv74hlkpqpxegUwb0O8AqmHalpZugKqm3+q7
         meWyE4f3/rB1DGIAdmD/mdyvkyCFOvXek+N92v+Ngr9dLEWqbtpVcQubtX5VfeD4HEht
         S++P/GCPmOU+lRclrD8nPKNVPXNpzhvtXYjHl5fSrZcIX1FrKHLAIN6D87KY95kyDZDj
         W0QeCxvoAV85gX+U4BMwlo4DWwmGrfE7YKnCnxp8iza6nZxuq32Xh56l67dcHxnJLW5o
         PiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26OPc/IWX8SJR7d6DqYrd4Zx4/7RJqNnYY2MrayQs5U=;
        b=0rTIjpXCxzkWDEfRM2QptZzrq6MPq7VDLA/qz9o+3ngSOUPZt+g2DnZT7JreVcEO+G
         dq6msB1R6WxMpZCwlft3tiHBcGZZhO4ktFgNORsG5SlgRE3mRKmFqam5oFvehsIk/1HL
         nqqvYzFbx0GOme4rgl/E9De9bEtJ5ovoy3JcHZHx7diwY8DejOfgSXWoZX9j189cz6ZA
         tpiuQUt1UtoQHraN1xYekB+ptakFC3BrpCL25zkIdTDQefEqcB23DfUQpB9n0GwiaGhV
         wjOlUtVE38/Lypq/AEMtYGnt/+mT/oNibTgUYdy1j4RY9GgpnlxEUShWk2ogzMrEs5c4
         lzKQ==
X-Gm-Message-State: AOAM532TnfxWzArI8bOEZ2YVTmkDFXMX+wUy4v02a89Eu+GsMYDxhOt+
        aoJRQEfkV4AYGqR6i9eyaheU9XjoyEz9ow==
X-Google-Smtp-Source: ABdhPJwafsXFo7CkCi3OVoqrKwrc7wuyy+cvBX+CuvFRH0w64GF0F9jTvS17SnAnh7wJIZkEv+Wv5A==
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id m17-20020a7bcb91000000b0039732250244mr11585382wmi.68.1653153328313;
        Sat, 21 May 2022 10:15:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a7bc24f000000b0039736892653sm4964685wmj.27.2022.05.21.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 10:15:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] cache-tree.c: use bug() and BUG_if_bug()
Date:   Sat, 21 May 2022 19:14:42 +0200
Message-Id: <patch-5.5-bb5a53f3b73-20220521T170939Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.960.g7a4e2fc85c9
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "BUG" output originally added in a97e4075a16 (Keep
rename/rename conflicts of intermediate merges while doing recursive
merge, 2007-03-31), and later made to say it was a "BUG" in
19c6a4f8369 (merge-recursive: do not return NULL only to cause
segfault, 2010-01-21) to use the new bug() function.

This gets the same job done with less code, this changes the output a
bit, but since we're emitting BUG output let's say it's OK to prefix
every line with the "unmerged index entry" message, instead of
optimizing for readability. doing it this way gets rid of any state
management in the loop itself in favor of BUG_if_bug().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 6752f69d515..9e96097500d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -692,14 +692,13 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
 		int i;
-		fprintf(stderr, "BUG: There are unmerged index entries:\n");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
 			if (ce_stage(ce))
-				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
-					(int)ce_namelen(ce), ce->name);
+				bug("unmerged index entry on in-memory index write: %d %.*s",
+				    ce_stage(ce), (int)ce_namelen(ce), ce->name);
 		}
-		BUG("unmerged index entries when writing inmemory index");
+		BUG_if_bug();
 	}
 
 	return lookup_tree(repo, &index_state->cache_tree->oid);
-- 
2.36.1.960.g7a4e2fc85c9

