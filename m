Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E16BC433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051186117A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbhJGJsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbhJGJsK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:48:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8512C061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:46:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t2so17151775wrb.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M0T9wd0WWaQJFbmAZmQdPtXB1nHO4u/JsR6zBWETr14=;
        b=J/CnVDitC6yDcjXEjjP0O0UYdMmXjbVAUGIk/+jmkPDag13TWfi31vLue5Bu/28wLF
         hpSetB18dv4+HoESwcYKKFiF+FtHIlFPGObRPPQjoDKRHj78ScDRjy2QnTlMKoj9q3qa
         dnBOaevvI8DEQxcO9gN6Qer5+kqaBxfCh31MQpQV/e5+ng8aDF4V4vA3eObc8QdhnS++
         djhAWRbcFuzJ1KU65+PulwpzkY1kOgCt9ygXAyxwRFa6xMaEKP/tos2O7XgdY32FC7yJ
         hyrVs33zzQZ/oA5rxxjYs7Qa5X9azzwcV8u+oQHCrA59x6eXNg4ckcKcGXfNTvquDylb
         8dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M0T9wd0WWaQJFbmAZmQdPtXB1nHO4u/JsR6zBWETr14=;
        b=Jg1CU8oeHhiYoB/feA+qidSsgjvLYcyO/7EO9WWL/TwQLAtuxdg/IeMgO77JW8Q685
         MkjND+YrIt+Ju4eKpS+Wr1B7JiWA5E8wNrzMGrz2Aj7sMK6E+YQcZCgK2FMCXR05UaKx
         IKl/kd4lUQL+F4PAGTttNNdVQlkdAxUe3Pyo8t7ZuqF28V+4Dwf/cFA3huk7py4Ylmne
         qTMVTt2uS61+RONxocqVupZWLUOvj9erY9Wa1uZH0inv2SsGpkPt4gZOWkQGB9A1FRI7
         fk9JgYgFWf4rLtg9macLUPJ9V9cuxS6RIyqHj3jblEDWdpkeZW5dpiLv7Bu3L1Fb3fAg
         RMEg==
X-Gm-Message-State: AOAM530OWLsLkicrVD5cfOWlk51CRPbtZ5HcJPThvE/mc4SbLcKSQ/9b
        hcheYg0m52JG2hUJbR8t5Tu6J5/BoSS+Sg==
X-Google-Smtp-Source: ABdhPJz5c7vl4Alr8tVNm0U3SY1B27yZFln6Y6V338IddBePwBDhzL1aEwN2tMlq1LDJrVWQgm+ykw==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr3481583wmh.188.1633599975077;
        Thu, 07 Oct 2021 02:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13sm7720489wme.38.2021.10.07.02.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:46:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] sequencer: add a "goto cleanup" to do_reset()
Date:   Thu,  7 Oct 2021 11:46:10 +0200
Message-Id: <patch-v2-2.3-1d5f5e9fff0-20211007T094019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restructure code that's mostly added in 9055e401dd6 (sequencer:
introduce new commands to reset the revision, 2018-04-25) to avoid
code duplication, and to make freeing other resources easier in a
subsequent commit.

It's safe to initialize "tree_desc" to be zero'd out in order to
unconditionally free desc.buffer, it won't be initialized on the first
couple of "goto"'s.

There are three earlier "return"'s in this function that I'm not
bothering to covert, those don't need to rollback anything, or free
any resources, so let's leave, even though they could safely "goto
cleanup" as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6872b7b00a4..457eba4ab10 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3650,7 +3650,7 @@ static int do_reset(struct repository *r,
 	struct strbuf ref_name = STRBUF_INIT;
 	struct object_id oid;
 	struct lock_file lock = LOCK_INIT;
-	struct tree_desc desc;
+	struct tree_desc desc = { 0 };
 	struct tree *tree;
 	struct unpack_trees_options unpack_tree_opts;
 	int ret = 0;
@@ -3684,10 +3684,8 @@ static int do_reset(struct repository *r,
 		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 		if (get_oid(ref_name.buf, &oid) &&
 		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
-			error(_("could not read '%s'"), ref_name.buf);
-			rollback_lock_file(&lock);
-			strbuf_release(&ref_name);
-			return -1;
+			ret = error(_("could not read '%s'"), ref_name.buf);
+			goto cleanup;
 		}
 	}
 
@@ -3703,24 +3701,18 @@ static int do_reset(struct repository *r,
 	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
-		rollback_lock_file(&lock);
-		strbuf_release(&ref_name);
-		return error_resolve_conflict(_(action_name(opts)));
+		ret = error_resolve_conflict(_(action_name(opts)));
+		goto cleanup;
 	}
 
 	if (!fill_tree_descriptor(r, &desc, &oid)) {
-		error(_("failed to find tree of %s"), oid_to_hex(&oid));
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
+		ret = error(_("failed to find tree of %s"), oid_to_hex(&oid));
+		goto cleanup;
 	}
 
 	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
-		rollback_lock_file(&lock);
-		free((void *)desc.buffer);
-		strbuf_release(&ref_name);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	tree = parse_tree_indirect(&oid);
@@ -3728,13 +3720,15 @@ static int do_reset(struct repository *r,
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
 		ret = error(_("could not write index"));
-	free((void *)desc.buffer);
 
 	if (!ret)
 		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
 						len, name), "HEAD", &oid,
 				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
-
+cleanup:
+	free((void *)desc.buffer);
+	if (ret < 0)
+		rollback_lock_file(&lock);
 	strbuf_release(&ref_name);
 	return ret;
 }
-- 
2.33.0.1446.g6af949f83bd

