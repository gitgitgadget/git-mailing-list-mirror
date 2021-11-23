Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C08C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKWAXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKWAXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:23:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5FC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so35833916wrb.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aPcoWXZzuGJ8ikTLRnPzPZ3De9Qp5sziMIk+tW+mJQI=;
        b=IeDf46dJ4vnWKojhUwOIhozn0l1cdyow7c4MrtnROijAKDUGl1y7EowOIlapGgd4gK
         YSLUe6tVmq2g0gVTKFueJckcSbd1+f+zE+cvxjekINmC18RiTRlcETrYYUx+rfIeFoxH
         2rpVaLIrPQszYLSgmuxeov+Pvb6km1+hxjhvhLDtVF9TAaURSJkTW7Vivj9vttnCFIqQ
         GDs3z6bwgLvhl00Wp17mY//tJitSJ/biRjP6nKuLRxmLM1ThCWD65WAQ1TuKkP4u33cD
         Ewnd15B2LDA0EFoSgVBkYZBw16K/jTcmrp0KCzZWFPpgbkat00ihJ5/1Lu+83QT8++Vq
         ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aPcoWXZzuGJ8ikTLRnPzPZ3De9Qp5sziMIk+tW+mJQI=;
        b=PUsLgDm+BKm3MGPAitLU4oz3+B91Be0SvZz2dqEERiIq+p60Md8XJVzPQY8FFPsozr
         aSDGLDqEG8BRV+LL89/0xE4l4BvW6v2XjlRPCOYN70Ai4fvPlstwClyM3xHbc/bb0GZe
         4KQAcKuNm2t2Gd9BQ2qxtRmkSfCYI75uR5zUt6gsPOQO3yXMdvgP07+L+aFxIEYW3p9l
         JHPy4lBs+yzQ/gZs1QZoTfPwh649xHvZvWMWR4MM4LGUEP6NI0Z+Gntt9lGFZa9gXwee
         zDzJEiWUhtQd40Vj9aF8SB9m4JwTyo3YnNYZmG/cqPl3Kg68+icRAfjAHraZ2XpvAw7e
         8OTw==
X-Gm-Message-State: AOAM531TIPwU2gl2Zgn8/cM1GxPOPML/eDluUlabP/ZrL1IhyLSGQEle
        yxbaasZnkSSL+Fk0gNqP6UVtP+07WpM=
X-Google-Smtp-Source: ABdhPJyMMt6k8G0NqGjH0TR1HNWjqiQBiGaCbAn+lB8uoR6Z1p2LD27UUN3bszXpYeN6FDv5Gyxu6Q==
X-Received: by 2002:adf:8008:: with SMTP id 8mr1844900wrk.188.1637626837662;
        Mon, 22 Nov 2021 16:20:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25sm11442380wms.17.2021.11.22.16.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:20:37 -0800 (PST)
Message-Id: <3237a519c80327e9b210b60455ff3b51c01c9424.1637626833.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 00:20:33 +0000
Subject: [PATCH v5 4/4] sparse-index: update do_read_index to ensure correct
 sparsity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Unless `command_requires_full_index` forces index expansion, ensure in-core
index sparsity matches config settings on read by calling
`ensure_correct_sparsity`. This makes the behavior of the in-core index more
consistent between different methods of updating sparsity: manually changing
the `index.sparse` config setting vs. executing
`git sparse-checkout --[no-]sparse-index init`

Although index sparsity is normally updated with `git sparse-checkout init`,
ensuring correct sparsity after a manual `index.sparse` change has some
practical benefits:

1. It allows for command-by-command sparsity toggling with
   `-c index.sparse=<true|false>`, e.g. when troubleshooting issues with the
   sparse index.
2. It prevents users from experiencing abnormal slowness after setting
   `index.sparse` to `true` due to use of a full index in all commands until
   the on-disk index is updated.

Helped-by: Junio C Hamano <gitster@pobox.com>
Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             |  8 ++++++
 t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index a78b88a41bf..b3772ba70a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2337,9 +2337,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	if (!istate->repo)
 		istate->repo = the_repository;
+
+	/*
+	 * If the command explicitly requires a full index, force it
+	 * to be full. Otherwise, correct the sparsity based on repository
+	 * settings and other properties of the index (if necessary).
+	 */
 	prepare_repo_settings(istate->repo);
 	if (istate->repo->settings.command_requires_full_index)
 		ensure_full_index(istate);
+	else
+		ensure_correct_sparsity(istate);
 
 	return istate->cache_nr;
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index ca91c6a67f8..59accde1fa3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -694,6 +694,37 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	test_region index ensure_full_index trace2.txt
 '
 
+test_expect_success 'index.sparse disabled inline uses full index' '
+	init_repos &&
+
+	# When index.sparse is disabled inline with `git status`, the
+	# index is expanded at the beginning of the execution then never
+	# converted back to sparse. It is then written to disk as a full index.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index -c index.sparse=false status &&
+	! test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	# Since index.sparse is set to true at a repo level, the index
+	# is converted from full to sparse when read, then never expanded
+	# over the course of `git status`. It is written to disk as a sparse
+	# index.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index status &&
+	test_region index convert_to_sparse trace2.txt &&
+	! test_region index ensure_full_index trace2.txt &&
+
+	# Now that the index has been written to disk as sparse, it is not
+	# converted to sparse (or expanded to full) when read by `git status`.
+	rm -f trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index status &&
+	! test_region index convert_to_sparse trace2.txt &&
+	! test_region index ensure_full_index trace2.txt
+'
+
 ensure_not_expanded () {
 	rm -f trace2.txt &&
 	echo >>sparse-index/untracked.txt &&
-- 
gitgitgadget
