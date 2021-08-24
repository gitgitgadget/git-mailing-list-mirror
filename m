Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5513C43216
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE203613BD
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhHXVzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhHXVzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4BCC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e5so16784962wrp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IqUFbOHd+GmBlHz4kSGwrATqMDgKd8EWpt8BWJr4eEU=;
        b=gykNgV4UbRLPTnukdlQf53eLAmD6nW/FA82FWC9uPlNk7sTITXgPmk3VNApgwOnn1k
         Vww6PnXqFR7TNqDAv1PpE39Fs2P2QqUB+U7Nx/m5mHRx6IrI4pEO3uLPFbFGWQGYoajF
         rA8wQ/eb7Y5vLCeihFyTlXSZCEAiZ42wttJtVOvVUMaESWqLoM1jOWdlsmeNSjKwq8/Z
         LNPBw4c7Ohxfmb4cLmmweNemvJYi2zeHG+AkLcwsmk3mtY2RbI/pHnZWxkIDqhwCOS9r
         oJlGDoKK66U6U1nTtwcFxLE3yTUKpPDeAFfwZK1D5jbE0nyHQBKH5VBB28mOs3k3YOmF
         uX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IqUFbOHd+GmBlHz4kSGwrATqMDgKd8EWpt8BWJr4eEU=;
        b=k3rucJJY0P+Ob5H4To/yBkQavkA04fu8h92Z9F5iIcROmJcUKQF+Dk93oMEJv4vq9p
         7nUSn4SxNa5/RcoouW6I0EtX45GpYxygKrpDgS671T+GzAPmpLUgSonYo/iF2AIt48i3
         R1gYaYtrqijwSkFv4WeVjmyeUcojUEm/Qf0HHQ3tfp8l1PTnrm6evXzCjwlZvo5aUKJg
         6VncHvhFeEAthxw/XV6UITyfoVHw/0mP957SL8Ylq+sdmUTqm7pto88QvZWwERVkL+7n
         AMk7SKDTo1Vkmxuhiddyv9U6yJPLvtR7Da+S4ReagYZr5V3spA2ohXvIYKUx2t1yaPiC
         DMMg==
X-Gm-Message-State: AOAM5306j3njikoD7Os9QSzk9n8dkXtnBHYsbtVEJLqLoUvp1TWSij9n
        eHTM3ynOFNoXgROsqGD/pmxbqEYYwHY=
X-Google-Smtp-Source: ABdhPJzXOi0FxnCcKKGSkx+1FfEqqpBGgC5jUnrPYy8vOMup8EVU5qraCDWO0vhRCP9DYQFnfUY2cw==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr1471078wrp.409.1629842092211;
        Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm3831657wrs.3.2021.08.24.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Message-Id: <5153accded46c8ced8784ec135dbc77d5bc1a306.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:42 +0000
Subject: [PATCH 10/13] rm: skip sparse paths with missing SKIP_WORKTREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a path does not match the sparse-checkout cone but is somehow missing
the SKIP_WORKTREE bit, then 'git rm' currently succeeds in removing the
file. One reason a user might be in this situation is a merge conflict
outside of the sparse-checkout cone. Removing such a file might be
problematic for users who are not sure what they are doing.

Add a check to path_in_sparse_checkout() when 'git rm' is checking if a
path should be considered for deletion. Of course, this check is ignored
if the '--sparse' option is specified, allowing users who accept the
risks to continue with the removal.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/rm.c                  |  4 +++-
 t/t3602-rm-sparse-checkout.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4208f3f9a5f..a6da03da2be 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -301,7 +301,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
 			continue;
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index a34b978bfd8..44f3e923164 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -87,4 +87,15 @@ test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
 	git ls-files --error-unmatch b
 '
 
+test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone' '
+	git reset --hard &&
+	git sparse-checkout set a &&
+	git update-index --no-skip-worktree b &&
+	test_must_fail git rm b 2>stderr &&
+	test_cmp b_error_and_hint stderr &&
+	git rm --sparse b 2>stderr &&
+	test_must_be_empty stderr &&
+	test_path_is_missing b
+'
+
 test_done
-- 
gitgitgadget

