Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BDEC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236EF22CBB
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN7J0FK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHEVwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgHEVvz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:51:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BAC061757
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:51:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so7778764wmb.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L08+yYfUa4/4fG9INuh22rKNPpKoqshaYos5skwuxCo=;
        b=jN7J0FK701TnzVFpk24xPMk95jPrxvkDO8o+YhHpXEDVDI3AXgB/yQSQ524+rj63tu
         J9wRrFmqjRBaJUjdkyoImjNpACNsmdUojdwacTEehlg4Ztp40AjQfDmDGwOrXk0eHKSL
         1HOOvqtE0Yf8lmjelC/m8P6J6JXiavB519xeyVSLK7ZSMlsmC3qikBc6NW5ZlQf3j+uv
         beW8MFjhm7/XDAf+VcqJdQByT/mTlNZA2Pg7oZ1tDAJOVsO84QWR36tVMx3zIxBtgefG
         zKT3vgqIaiqdi5+exebc9rpFoWMTUZG59a9Vn5Ct2MCnZ943HhbTSCTQOzh829pFsdSj
         fQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L08+yYfUa4/4fG9INuh22rKNPpKoqshaYos5skwuxCo=;
        b=EgtDpzrmxDvW1pKKOXLai8OEM7mULvzfvwGdI8m7scFGVFZGLbavQEJmcH79jdVdcf
         bXLi4FCngwcuEUIsCfb2BYvWR1zoiUvPlls6KXbvIX0YENt8oMyhGcUAqtGPxNqjn/nF
         IOZXYe/t1jLyhEjh9Y3OACtxIp//isw1LLbrP1H9Od1n72WVriknmJHBuvZHpfV5CX+q
         cMA4IP+I2yhQEwGzCqVsNnsmF36xOk37OTHmJtDdx5mBOJCG3r0Q1yZziu0vO5vUpmki
         eOataA/BK34pOxC62A6Gi3MWETnrxhUF8KT7+k8fhxedAwccg88mrBo4I3yTvVt4//hF
         Bpzw==
X-Gm-Message-State: AOAM530LYRo7Lr8P0Qe4ptKtbaCrKczMSChnEAhr1BDnLDdCYOfqcb6v
        eTujGpGm8aKwcg538BkCGcjkqTRy
X-Google-Smtp-Source: ABdhPJzEe/nHpbTfmTDvHtyzjItHzJ1oASRIUqwnLD+SQYZNr77a6mvsw3zAd2QuO6Cg5j7Ygoz2Ow==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr4906935wmj.5.1596664313487;
        Wed, 05 Aug 2020 14:51:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm3924389wmj.18.2020.08.05.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:51:53 -0700 (PDT)
Message-Id: <764bb23b5974214335cc6a93fb4eab46e8f2a49b.1596664306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
References: <pull.684.git.1595882588.gitgitgadget@gmail.com>
        <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 21:51:42 +0000
Subject: [PATCH v2 6/9] ref-filter: add `short` modifier to 'parent' atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Sometimes while using 'parent' atom, user might want to see abbrev hash
instead of full 40 character hash.

Just like 'objectname', it might be convenient for users to have the
`:short` and `:short=<length>` option for printing 'parent' hash.

Let's introduce `short` option to 'parent' atom.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt | 2 +-
 ref-filter.c                       | 8 ++++----
 t/t6300-for-each-ref.sh            | 6 ++++++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 40ebdfcc41..dd09763e7d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -222,7 +222,7 @@ worktreepath::
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
-Field `tree` can also be used with modifier `:short` and
+Fields `tree` and `parent` can also be used with modifier `:short` and
 `:short=<length>` just like `objectname`.
 
 For commit and tag objects, the special `creatordate` and `creator`
diff --git a/ref-filter.c b/ref-filter.c
index f9d85661eb..6d5bbb14a2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -498,7 +498,7 @@ static struct {
 	{ "objectname", SOURCE_OTHER, FIELD_STR, oid_atom_parser },
 	{ "deltabase", SOURCE_OTHER, FIELD_STR, deltabase_atom_parser },
 	{ "tree", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
-	{ "parent", SOURCE_OBJ },
+	{ "parent", SOURCE_OBJ, FIELD_STR, oid_atom_parser },
 	{ "numparent", SOURCE_OBJ, FIELD_ULONG },
 	{ "object", SOURCE_OBJ },
 	{ "type", SOURCE_OBJ },
@@ -1011,14 +1011,14 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->value = commit_list_count(commit->parents);
 			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
-		else if (!strcmp(name, "parent")) {
+		else if (starts_with(name, "parent")) {
 			struct commit_list *parents;
 			struct strbuf s = STRBUF_INIT;
 			for (parents = commit->parents; parents; parents = parents->next) {
-				struct commit *parent = parents->item;
+				struct object_id *oid = &parents->item->object.oid;
 				if (parents != commit->parents)
 					strbuf_addch(&s, ' ');
-				strbuf_addstr(&s, oid_to_hex(&parent->object.oid));
+				strbuf_addstr(&s, do_grab_oid("parent", oid, &used_atom[i]));
 			}
 			v->s = strbuf_detach(&s, NULL);
 		}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e30bbff6d9..79d5b29387 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -120,6 +120,9 @@ test_atom head tree:short $(git rev-parse --short refs/heads/master^{tree})
 test_atom head tree:short=1 $(git rev-parse --short=1 refs/heads/master^{tree})
 test_atom head tree:short=10 $(git rev-parse --short=10 refs/heads/master^{tree})
 test_atom head parent ''
+test_atom head parent:short ''
+test_atom head parent:short=1 ''
+test_atom head parent:short=10 ''
 test_atom head numparent 0
 test_atom head object ''
 test_atom head type ''
@@ -174,6 +177,9 @@ test_atom tag tree:short ''
 test_atom tag tree:short=1 ''
 test_atom tag tree:short=10 ''
 test_atom tag parent ''
+test_atom tag parent:short ''
+test_atom tag parent:short=1 ''
+test_atom tag parent:short=10 ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-- 
gitgitgadget

