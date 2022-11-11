Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E5C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiKKXzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKXzn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:55:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69E54B1F
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:55:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6502417wma.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rk3+B0vu7d2WUM3WlgnARwI+meexOLHbSR28nT4Hwd0=;
        b=N629EuZj+Ei+dz7PtOi3jzNLzt2ShdxW5lACuCzMNyZIWmb/mpEWsr5WGbMzjgjCCT
         guIp6emJHPgtRdYjy8520zy98taoc1nOFFuB8mC6TUN7XouhetD7iL7OP6DXRR4baGrI
         jPmhrVBXuvK9GsG5VyENTwXDwKspLrwKaoqPKWYrFWOg+ogio5hE34e1J4pJmM6IUSFu
         bYJtUHAlso8XqQS9SUE+HuGATU9eJ0+5Kkwo2BfTZ4+5wcQqVD8ZO85Nf3jVnJ6+TcvK
         2YBTtpt622EVd84OGj3NVshpL0Q0ty9aclJqmGabdoNLI3kk4JirikS9INlH+UXFu8iH
         6/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rk3+B0vu7d2WUM3WlgnARwI+meexOLHbSR28nT4Hwd0=;
        b=O+2DO7Rt7XIB18QtkRSPqTSOX+qXIGelo0pktvj3rzY4aq4bAbq89opbJSLMKEkSL4
         qaZ6z1LsJn0wZ3ajTyg8ZncIFzlAfXs5WDjHuOid+ZHt8wtKTIynRagB49jTNQQD7G/L
         sUW8Pw8Ir6txbaxb8otqyEUu0TuPAvnymVIBOOkfUZjconrfKwYbnR2ejIka2EJZ98OR
         BroxjwvR8OpMEYafAo93KBheoaiFvOpRntiyMdjkZmqZ017Inxo5siMLQAIRhok5D4RA
         zObTpjO5zpcBK08Sb11tO540nSGUI/2Tugk4lKaend81UCfl76SmNVUIrlQs5ySHyKPS
         CvmA==
X-Gm-Message-State: ANoB5pl74EPxy5YCgl71yFdhQurjtd63l9Cgg2GzWl+Zd0YshbyOWG6z
        +Cw2XgPScLfeWYw7huVxnp7LjtHjQMU=
X-Google-Smtp-Source: AA0mqf5ml9hjC6S+5sozyFZmAKH26UL+KKovIeAtlRgzNsoyHLFg2r1MBONf7deIMcBaPb895fY5TA==
X-Received: by 2002:a05:600c:689a:b0:3cf:5731:53db with SMTP id fn26-20020a05600c689a00b003cf573153dbmr2671978wmb.85.1668210936629;
        Fri, 11 Nov 2022 15:55:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m66-20020a1c2645000000b003cfd58409desm487735wmm.13.2022.11.11.15.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:55:36 -0800 (PST)
Message-Id: <pull.1378.git.git.1668210935360.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 23:55:35 +0000
Subject: [PATCH] fetch: support "--super-prefix"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In a repo with partially cloned submodules, "git restore
--recurse-submodules" from the superproject can fail with "fatal: fetch
doesn't support --super-prefix". This error is encountered when the
super prefix is set (either by passing "--super-prefix" or by setting
the GIT_INTERNAL_SUPER_PREFIX env var) on a command that isn't marked
SUPPORT_SUPER_PREFIX. In this case, "git restore --recurse-submodules"
invokes "git read-tree --super-prefix=<path to submodule>", which in
turn, invokes a "git fetch" to fetch promisor objects.

The usefulness of this "--super-prefix" check is up for debate, and
there is WIP to get rid of the option altogether [1], but we can't just
leave "git restore" broken in the meantime, so let's do the barest
minimum to fix this without causing too much trouble for that effort.

Mark cmd_fetch as SUPPORT_SUPER_PREFIX, and add a test that shows that
this fixes the bug described above.

There is precedent for using SUPPORT_SUPER_PREFIX solely as a workaround
for the super prefix check (c.f. [2]), which is all the more reason to
get rid of this check.

[1] https://lore.kernel.org/git/Y27D8QUl3I2d4xNe@nand.local/
[2] 53fcfbc84f (fsmonitor--daemon: allow --super-prefix argument,
    2022-05-26)

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
    fetch: support "--super-prefix"
    
    Since "git read-tree" is seriously broken at the moment, let's not keep
    it hostage to the work on [1]. This is Ævar's suggested change from [2]
    combined with my partial clone test case from [3].
    
    I think we can take this regardless of where we are with the RFCs; it's
    simple and obvious enough that it adds virtually no churn to the RFCs.
    
    [1] https://lore.kernel.org/git/Y27D8QUl3I2d4xNe@nand.local/ [2]
    https://lore.kernel.org/git/221109.86y1skq08e.gmgdl@evledraar.gmail.com
    [3]
    https://lore.kernel.org/git/20221109004708.97668-4-chooglen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1378%2Fchooglen%2Ffetch%2Fsupport-super-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1378/chooglen/fetch/support-super-prefix-v1
Pull-Request: https://github.com/git/git/pull/1378

 builtin/fetch.c          |  6 ++++++
 git.c                    |  2 +-
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..9fd64e2f409 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2114,6 +2114,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	int result = 0;
 	int prune_tags_ok = 1;
 
+	/*
+	 * NEEDSWORK: we don't actually use "--super-prefix". Unset it
+	 * so that we don't accidentally use it or pass it down.
+	 */
+	unsetenv(GIT_SUPER_PREFIX_ENVIRONMENT);
+
 	packet_trace_identity("fetch");
 
 	/* Record the command line for the reflog */
diff --git a/git.c b/git.c
index 6662548986f..b971752f6f0 100644
--- a/git.c
+++ b/git.c
@@ -531,7 +531,7 @@ static struct cmd_struct commands[] = {
 	{ "env--helper", cmd_env__helper },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fast-import", cmd_fast_import, RUN_SETUP | NO_PARSEOPT },
-	{ "fetch", cmd_fetch, RUN_SETUP },
+	{ "fetch", cmd_fetch, RUN_SETUP | SUPPORT_SUPER_PREFIX },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d2..9bec57a0476 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_success 'setup src repo with submodules' '
+	test_config_global protocol.file.allow always &&
+
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two"
+'
+
+test_expect_success 'lazy-fetch in submodule succeeds' '
+	test_when_finished "rm -rf src-super src-sub client" &&
+
+	test_config_global protocol.file.allow always &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
