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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCFC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7B9224B1
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 03:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbhARDYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbhARDYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 22:24:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF5C061574
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u14so8373535wmq.4
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+MVtPk2arwvhNzUei69PICMUC2xYvgIOhPdbgPEhrDo=;
        b=Jry5f2yJGNh6ZnWPaxuINWf3it8yL83CxpvdbGMmy/ccC6CwZs2JnzqXwNVnS6hOgO
         B6Y1U9hd1ZcjUx9JjsplH3e5xAeKMEm5BdxoMTWtgYBQXW8ecpzS3WFDhe3vXfdmQdsO
         q95eJNUtvLQvRXQ7pwqK02rgzyzkMj8bzWyIKWgo1Q74YcOq3+lv/MQskwV8YuKReJd9
         TxGFSL3RfI/d85bezBq6nPWo/soI43BrKeqS0mA8EaBzLpQv/89xgru5LzYbobTryr7a
         Wt/KDenSnibVVSDxoyBHet+j2L8EhnKW/ZvJGkbujFDL12aJNVLdU01eANIa3TffDLQ2
         3xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+MVtPk2arwvhNzUei69PICMUC2xYvgIOhPdbgPEhrDo=;
        b=sVIN8HHYv1EGOvqkRZsiXT06iTmXG4qioox1OU0/m++GMxwIwHXQ7YYeLCiJkw7QKb
         NuN1vwI4et3TUFhvQNCVoXtmxhoi5jR3YlbAWcVO4hGlOH+bAomAp2GvZOzDWrAXRzPd
         deTznJ+QABavk21csT/DzJq8Ige9PtK5is2Jz4xLvnj/M368ZdCBLG9aXfF9uLdQzMpS
         9sU4Ee6DTvgz1kbAvvLQIOJphd+iGA/O+06Zk3oByRSMCrI6nGPM7LlUu5s7iehOBaxV
         aBgml3X7Lh/FaJat97Fd0nYeLVWl6ClakkrXnrgdSSE6c4lW5Rd6y4uG5Ycd8PuKxHDa
         J7yw==
X-Gm-Message-State: AOAM533zdONwz11QVb/4l5sX9EYBXfOAB+ZytE6xDyuzqqGL6k2ZW+EK
        uef6TPf9sm/7cCvl3tMSK8nH1ebWvHI=
X-Google-Smtp-Source: ABdhPJxw7CjB+D2//vGQUwPS7o6odfu+qErSm+s3t7ZnjMQ1tKDjWjVVv2Dcm6PAPdTSIOGs7QYINg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr6827460wme.44.1610940219039;
        Sun, 17 Jan 2021 19:23:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm27646169wru.50.2021.01.17.19.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 19:23:38 -0800 (PST)
Message-Id: <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1610940216.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.838.git.1610940216.gitgitgadget@gmail.com>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Jan 2021 03:23:35 +0000
Subject: [PATCH 1/2] maintenance: set log.excludeDecoration durin prefetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'prefetch' task fetches refs from all remotes and places them in the
refs/prefetch/<remote>/ refspace. As this task is intended to run in the
background, this allows users to keep their local data very close to the
remote servers' data while not updating the users' understanding of the
remote refs in refs/remotes/<remote>/.

However, this can clutter 'git log' decorations with copies of the refs
with the full name 'refs/prefetch/<remote>/<branch>'.

The log.excludeDecoration config option was added in a6be5e67 (log: add
log.excludeDecoration config option, 2020-05-16) for exactly this
purpose.

Ensure we set this only for users that would benefit from it by
assigning it at the beginning of the prefetch task. Other alternatives
would be during 'git maintenance register' or 'git maintenance start',
but those might assign the config even when the prefetch task is
disabled by existing config. Further, users could run 'git maintenance
run --task=prefetch' using their own scripting or scheduling. This
provides the best coverage to automatically update the config when
valuable.

It is improbable, but possible, that users might want to run the
prefetch task _and_ see these refs in their log decorations. This seems
incredibly unlikely to me, but users can always opt-in on a
command-by-command basis using --decorate-refs=refs/prefetch/.

Test that this works in a few cases. In particular, ensure that our
assignment of log.excludeDecoration=refs/prefetch/ is additive to other
existing exclusions. Further, ensure we do not add multiple copies in
multiple runs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index b315b2ad588..54bae7f0c4c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -897,6 +897,12 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 	struct string_list_item *item;
 	struct string_list remotes = STRING_LIST_INIT_DUP;
 
+	git_config_set_multivar_gently("log.excludedecoration",
+					"refs/prefetch/",
+					"refs/prefetch/",
+					CONFIG_FLAGS_FIXED_VALUE |
+					CONFIG_FLAGS_MULTI_REPLACE);
+
 	if (for_each_remote(append_remote, &remotes)) {
 		error(_("failed to fill remotes"));
 		result = 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1074009cc05..f9031cbb44b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -149,7 +149,31 @@ test_expect_success 'prefetch multiple remotes' '
 	git log prefetch/remote2/two &&
 	git fetch --all &&
 	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
-	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
+	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
+
+	test_cmp_config refs/prefetch/ log.excludedecoration &&
+	git log --oneline --decorate --all >log &&
+	! grep "prefetch" log
+'
+
+test_expect_success 'prefetch and existing log.excludeDecoration values' '
+	git config --unset-all log.excludeDecoration &&
+	git config log.excludeDecoration refs/remotes/remote1/ &&
+	git maintenance run --task=prefetch &&
+
+	git config --get-all log.excludeDecoration >out &&
+	grep refs/remotes/remote1/ out &&
+	grep refs/prefetch/ out &&
+
+	git log --oneline --decorate --all >log &&
+	! grep "prefetch" log &&
+	! grep "remote1" log &&
+	grep "remote2" log &&
+
+	# a second run does not change the config
+	git maintenance run --task=prefetch &&
+	git log --oneline --decorate --all >log2 &&
+	test_cmp log log2
 '
 
 test_expect_success 'loose-objects task' '
-- 
gitgitgadget

