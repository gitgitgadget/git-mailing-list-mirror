Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D55DC433FE
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2300661153
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhIJKbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhIJKbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:31:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D4C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n5so1896591wro.12
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GH6nrsUFHu7om6s8UrMsfmqyjq2cbgH8DSvRRAsRb/s=;
        b=VrrfpQfeX7/ZOD7gk3vD7O/XrSRh+MTkCAi49+kHfWnMDiEjYJb4WzowtPs/ESoNFl
         FZbWt7A2Qlmx43BHWBgk2YSNdlsLZd9oCJU95HR61x1iSuagJc2ONplVbp8tddoMjOxb
         I1KxV9RHMoWL9NWLRaYpgQ2Q5eBrYp9LTkLs1KaLaWpuwFcSIliL6m9PEJL3phHA8F74
         qgWRqSwyMbVv6FtcYlt1xuhcZ4x6IRgavdauGLY9fxbil8Q/YuwNDqvYe+4BnIokLAeQ
         6HuVVa4xGptOiDkEgsZjQczF5PyERe70qnPLjSWta6BTBrCHhG57mJYM5L76VU5zosuJ
         0tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GH6nrsUFHu7om6s8UrMsfmqyjq2cbgH8DSvRRAsRb/s=;
        b=O6BTcJBgb2QeGvZu2tgYiKVpm+vvAJI4QXfTQf6L3RPNuwoFdXgEgBY9ivGrNkeyZ6
         fplhsKC24k40fMtC6to37OYR/KTi36feLe2RB18PI5aObvmbyFHB686N8m8Wjx26w+5O
         TSes/zAV2GgB8X1uIjJJFExxJZv3mrGZFZ5xxzEvjqF93RmOUzBtvpknj9bOnxR2c+1y
         ZxCqTxysE8ZFLsrAYem30GFz1POVlbccrFq5/XtBAvmbylKFzuSegg7FpbK40YKJkGZG
         7MMcd1PS6dCB3oqBSa9sdnTjs4veBEtUQ4kfUhooU24w4yCnRM3cGwQSFRDTXeIdNCBY
         id2w==
X-Gm-Message-State: AOAM530km4BA7lFPU8nA/HhgyknEqu/080xNw84lPuE57NmkWtk64hr7
        YkmS66PJkwUatPJ/gqfMYnlbRXC1E+g=
X-Google-Smtp-Source: ABdhPJw2vK6g/iyGv9qOCtSf8wdmvtVQ6J5yOWAjUsLTf4mNAEf5ClgacNvtsUiTH8YIxldJghDsrw==
X-Received: by 2002:adf:c506:: with SMTP id q6mr8958773wrf.78.1631269799407;
        Fri, 10 Sep 2021 03:29:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29sm4468396wrb.89.2021.09.10.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 03:29:59 -0700 (PDT)
Message-Id: <31e38c6c33cea596cb926a2df13cf0df34766a7a.1631269796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
        <pull.1086.v2.git.git.1631269796.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 10:29:55 +0000
Subject: [PATCH v2 2/3] stash: avoid feeding directories to update-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When a file is removed from the cache, but there is a file of the same
name present in the working directory, we would normally treat that file
in the working directory as untracked.  However, in the case of stash,
doing that would prevent a simple 'git stash push', because the untracked
file would be in the way of restoring the deleted file.

git stash, however, blindly assumes that whatever is in the working
directory for a deleted file is wanted and passes that path along to
update-index.  That causes problems when the working directory contains
a directory with the same name as the deleted file.  Add some code for
this special case that will avoid passing directory names to
update-index.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c  | 14 ++++++++++++++
 t/t3903-stash.sh |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..9ad2940f87a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -313,6 +313,17 @@ static int reset_head(void)
 	return run_command(&cp);
 }
 
+static int is_path_a_directory(const char *path)
+{
+	/*
+	 * This function differs from abspath.c:is_directory() in that
+	 * here we use lstat() instead of stat(); we do not want to
+	 * follow symbolic links here.
+	 */
+	struct stat st;
+	return (!lstat(path, &st) && S_ISDIR(st.st_mode));
+}
+
 static void add_diff_to_buf(struct diff_queue_struct *q,
 			    struct diff_options *options,
 			    void *data)
@@ -320,6 +331,9 @@ static void add_diff_to_buf(struct diff_queue_struct *q,
 	int i;
 
 	for (i = 0; i < q->nr; i++) {
+		if (is_path_a_directory(q->queue[i]->one->path))
+			continue;
+
 		strbuf_addstr(data, q->queue[i]->one->path);
 
 		/* NUL-terminate: will be fed to update-index -z */
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7346f8d1037..34d1ad9837f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1307,7 +1307,7 @@ test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	test_must_be_empty err
 '
 
-test_expect_failure 'git stash succeeds despite directory/file change' '
+test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
 		cd directory_file_switch_v1 &&
-- 
gitgitgadget

