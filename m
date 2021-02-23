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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6607EC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3906764E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhBWURY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbhBWUQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:16:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BFC06121F
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p3so3629542wmc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=vIR8o5iFDjewIncSaJiOB4+xe4Ycui9LpRvQqQSeE0LrrkTMhNc8GRdztwwtGFT9Va
         AY+Ao1y6kOZ58qdru4mwjemJu5QCqB9eA2+bgLDJxIE5Om/H+bSAF3TpqIa0vAx+q6nn
         fGLTduSq82IMT9BTGeuo9ahiywulhC8f96jcoZcHZiq+Ze7JBulCZircqWzinXWUx8t2
         09nWVl4M0lzdbSB7H8RNAS11Fs8Sl8cV3RGfcIbe7p2pZsFWjlxJgQnqcuqNMnjdQxjM
         kPWqD0IDRCPCB5Oeea+XyBVfQqxllnrV8aCH95qOnFF18rojJkAtyI5HABo+uRTT4zQY
         RThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=sPjpElkff+O/E8gDmiezjdgGAu0Ps8uXWCf+hovQV6qdWGpSOuY5+Mh8z9s48CTnHL
         gtWcabA1bA3KBaDyE9M6yZCSSNrPM4QESu/wrUsJ1yHFr9Dnz5s+/OoN+eV8ru63GQ5s
         UO2pjnPs1QWrphmwiQD40hlPeFhp7lV08l5ucgs82igRlQQjlUQZymptjzDlemeGsC1I
         4qlvUutxZ5O0XIG+BRMOsgv2FWSefuAPCjA8uQ1kregUTGnlxRMGHGw/kugCP9HB7msV
         XZT6p4OYUPiM7NGS6o3129gNmjnEGHSPzgjkW+XoidS4k93GgGFvL8z0Foz2zYi0mlgn
         bKCw==
X-Gm-Message-State: AOAM533O8l+KUhpBavlIkFotbu6d1oj2U7at4Hww2UEr0V08E3MLUM1O
        YJKBXxM7tbt0sGrjASkRtd+TOFZrxtg=
X-Google-Smtp-Source: ABdhPJyu+vsMDwSikXfqnwC5AsxALgtYNpkHcf+iUukLJk8IaW9PNXkn1omuJ5np49W4QK9r4yX0Ug==
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr391535wmq.139.1614111281426;
        Tue, 23 Feb 2021 12:14:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm23636214wrt.69.2021.02.23.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:41 -0800 (PST)
Message-Id: <bcf960ef2362e32e2f8d7e06a31a925936f62bc1.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:26 +0000
Subject: [PATCH 17/20] sparse-checkout: disable sparse-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We use 'git sparse-checkout init --cone --sparse-index' to toggle the
sparse-index feature. It makes sense to also disable it when running
'git sparse-checkout disable'. This is particularly important because it
removes the extensions.sparseIndex config option, allowing other tools
to use this Git repository again.

This does mean that 'git sparse-checkout init' will not re-enable the
sparse-index feature, even if it was previously enabled.

While testing this feature, I noticed that the sparse-index was not
being written on the first run, but by a second. This was caught by the
call to 'test-tool read-cache --table'. This requires adjusting some
assignments to core_apply_sparse_checkout and pl.use_cone_patterns in
the sparse_checkout_init() logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 10 +++++++++-
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index ca63e2c64e95..585343fa1972 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -280,6 +280,9 @@ static int set_config(enum sparse_checkout_mode mode)
 				      "core.sparseCheckoutCone",
 				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
 
+	if (mode == MODE_NO_PATTERNS)
+		set_sparse_index_config(the_repository, 0);
+
 	return 0;
 }
 
@@ -341,10 +344,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 		the_repository->index->updated_workdir = 1;
 	}
 
+	core_apply_sparse_checkout = 1;
+
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
-		core_apply_sparse_checkout = 1;
 		return update_working_directory(NULL);
 	}
 
@@ -366,6 +370,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
 	strbuf_addstr(&pattern, "!/*/");
 	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
+	pl.use_cone_patterns = init_opts.cone_mode;
 
 	return write_patterns_and_update(&pl);
 }
@@ -632,6 +637,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	strbuf_addstr(&match_all, "/*");
 	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.sparse_index = 0;
+
 	if (update_working_directory(&pl))
 		die(_("error while refreshing working directory"));
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index fc64e9ed99f4..ff1ad570a255 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -205,6 +205,19 @@ test_expect_success 'sparse-checkout disable' '
 	check_files repo a deep folder1 folder2
 '
 
+test_expect_success 'sparse-index enabled and disabled' '
+	git -C repo sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C repo true extensions.sparseIndex &&
+	test-tool -C repo read-cache --table >cache &&
+	grep " tree " cache &&
+
+	git -C repo sparse-checkout disable &&
+	test-tool -C repo read-cache --table >cache &&
+	! grep " tree " cache &&
+	git -C repo config --list >config &&
+	! grep extensions.sparseindex config
+'
+
 test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
-- 
gitgitgadget

