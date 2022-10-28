Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAABAECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 17:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ1RR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1RR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 13:17:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941086D9E1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:17:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5087472pjc.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnA+vCYMbnWmAtlfYZTmPUnU/uQcpg87kaWk0NMI7Pw=;
        b=IKtEvOLTUQC/dtBFYHbkH3bQEShKKMZDgDrvk52NUi3E0G5yWu5IbYusFuSfSUkfjs
         t/p7lIXbmE1xPOgaR5GDfdRBRR1PnEg6I9dwfe+jzLtemzXIRJ72k7uGLUYs3TGQOmi3
         RsKjhF3JJsEpE6wg8YUjVn2MSzqbzW3Pwlkmig5gcpj6ec4HtH/UEJlkQiLzDcU+5B34
         O/dvK5NwL9CGUJLoBeDBlsOXRfBhgeuGZvN7rJQ/KEfRMfSa5XYkelOtN+mU/yUGvE6K
         +C7kQJfRRErC5Q0EpbrdCiHMwmNskaTLhoraUjeq6gvhfUTEGuA/17yC4jqgTeUOc+Gr
         ZhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tnA+vCYMbnWmAtlfYZTmPUnU/uQcpg87kaWk0NMI7Pw=;
        b=TDpHiFFVzyIqJQQFn2CjIvLW3QXE20vwFi1514fynT3EXtbdve6HsitMzsStoLHctA
         KlqJnqiFKgX5rLDOutmVj2LcyURfmSfcjvsd1pJi5jOMcnnOoCO/5+5CbkGqlduu0psy
         sVdldYzpfUc8HIWtKXB6/7x7Uwt4x6gVtErAG9fpsdr3A+g3Hnmd8v+D5oHHeOSrr0a8
         3RgFNMZenKFvV/S7o7v0JWHkaAySaL87NqsmPub0XZesBJYo0hiBeK+73lsE0ZSuOSH5
         RrnMVUrlQAJwAiTyjIuk2JuJbk+uF0B31NhNbWmzzmQTwZTPebSp2E/fmZRRGhJwvYYu
         pg6g==
X-Gm-Message-State: ACrzQf0WssZAkawOVriYXQeu0Sof1o9a8bUfJiHBCcSJsMh46lTmCtrE
        mDKjbTwfABPRLGFPHXv6fjU=
X-Google-Smtp-Source: AMsMyM5THlXNgwyiQdBQCDbuUDArhOY8yO6hA6pIBn/Bc9hN/Fkc742TIbAkEN6qLBtpseuKgtLNZw==
X-Received: by 2002:a17:90a:7849:b0:20d:2d54:65d with SMTP id y9-20020a17090a784900b0020d2d54065dmr17467391pjl.219.1666977476969;
        Fri, 28 Oct 2022 10:17:56 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b00186fb8f931asm1508891plh.206.2022.10.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:17:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Anh Le via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>, Anh Le <anh@canva.com>
Subject: Re: [PATCH v2] index: add trace2 region for clear skip worktree
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
        <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
        <313a6619-273c-066e-c3da-a519b38c03af@github.com>
Date:   Fri, 28 Oct 2022 10:17:56 -0700
In-Reply-To: <313a6619-273c-066e-c3da-a519b38c03af@github.com> (Derrick
        Stolee's message of "Fri, 28 Oct 2022 11:49:20 -0400")
Message-ID: <xmqqy1szj29n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> A few style things:
>
> 1. Use "if (path_counts[0])" to detect a non-zero value.
> 2. Don't use { } around a single-line block.
> 3. Your lines are quite long, due a lot from your long keys.
>    Shorten the keys (maybe "sparse_path_count" and "restarted_count"
>    is enough context) and consider using a line break in
>    the middle of the parameters.

All good suggestions.  Let me add another one.

  4. Call an array you primarily access its individual elements in
     singular.  That way, you can say path_count[0] (i.e. the count
     for the zeroth round).  An array that exists mostly to be
     passed around as a whole to represent a "set of things", on the
     other hand, can be called in plural.

Taking them all together, perhaps something like this is what you
meant?

 sparse-index.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git c/sparse-index.c w/sparse-index.c
index dbf647949c..8c269dab80 100644
--- c/sparse-index.c
+++ w/sparse-index.c
@@ -493,22 +493,25 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	int dir_found = 1;
 
 	int i;
-	int path_counts[2] = {0, 0};
+	int path_count[2] = {0, 0};
 	int restarted = 0;
 
 	if (!core_apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
-	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
+			    istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_skip_worktree(ce)) {
-			path_counts[restarted]++;
+			path_count[restarted]++;
 			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					if (restarted)
+						BUG("ensure-full-index did not fully flatten?");
 					ensure_full_index(istate);
 					restarted = 1;
 					goto restart;
@@ -518,13 +521,14 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 		}
 	}
 
-	if (path_counts[0] > 0) {
-		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
-	}
-	if (restarted) {
-		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
-	}
-	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
+	if (path_count[0])
+		trace2_data_intmax("index", istate->repo,
+				   "sparse_path_count", path_count[0]);
+	if (restarted)
+		trace2_data_intmax("index", istate->repo,
+				   "sparse_path_count_full", path_count[1]);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
+			    istate->repo);
 }
 
 /*

