Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696BDC54E49
	for <git@archiver.kernel.org>; Sun, 10 May 2020 08:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F99208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 08:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRM/P+7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgEJI0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 04:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEJI0F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 May 2020 04:26:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E4C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 01:26:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so6907947wrn.6
        for <git@vger.kernel.org>; Sun, 10 May 2020 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AqkyayGpqqYlRY+DCt0MPkwxL4CueIsl8iwwq/jPsdk=;
        b=tRM/P+7nwv08Toc9tC6WILXMHwtMSGthzKmLNWtE3H5HpRTWt08E9rRbdT6OOxYKYo
         7HWydS5Wq7K2Zp/5Q4EWGD45A6nhPyBkAY29UlTgpTww8wOR9bEtW4MrnM00kfIz782N
         3U63x3aH93kbAKc91ve4vZ4RowS+WTWvnAwRWqAwisqc5QjGuU8/v07/nCJctKhweKAW
         GE9vxjtap/Zk9YWdqXno9T2r1rZS6jEyLakqqmcY6hugz+FhdWoaptO9WxHuYqzgLMT9
         5HV7w5zUNmXEt4vVbmpXfi7+4UNRh4mD/Cu0wf5kv9Ki4gB/Q4vdT3bVdsUnr4kMRwTu
         5+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AqkyayGpqqYlRY+DCt0MPkwxL4CueIsl8iwwq/jPsdk=;
        b=d7M7WLGAC6BPGgrNJJg2PeQZoeo/qS6LGkiau2zMDwn/wxyG+8o5q31EAVAe+/aqkZ
         RwmpYVaDnZyMpllwCv7k+L4KwzipjMNM64dQDLO9hMxVgvbqygUBv3MA8GJlFuof+WlX
         +bE5WeRDmul2EI7q4yueVFe8MJQMCW3ODMSBW9f1dZF2LLjFQez1dLsAt6F3/mnenlGV
         J5vj9MVjqEC8PpJsp/ZOkuNFRVYV+nBlkBmCeQEZCAzgKnDqgOzSDGLDQHNNIbTMJt8E
         Xc0k84qg1YcB4qxi8CTa6mIJKB7a2Eo+7yncxdERTrp4FlXhJnulquN7KiBJ28uJPV2e
         GAoA==
X-Gm-Message-State: AGi0PuZvloST7p8y1o57vUQBhIsy15/QKBVCtesNZzgwwFSVmTKiKE06
        jMAwazoh/vMibobzgGgRbHqqgvI3
X-Google-Smtp-Source: APiQypJ9RonyAfSF5ibz5NRzzyem9F5f3uTJ9Cx3fBW1LGZElvTc4pw+r+EypBvZh4bY2OPR2bBa7Q==
X-Received: by 2002:a05:6000:46:: with SMTP id k6mr11690439wrx.146.1589099163974;
        Sun, 10 May 2020 01:26:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f123sm7578630wmf.44.2020.05.10.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 01:26:03 -0700 (PDT)
Message-Id: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
From:   "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 May 2020 08:26:02 +0000
Subject: [PATCH] submodule--helper.c: add only-active to foreach
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Guillaume G." <guillaume.galeazzi@gmail.com>,
        Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>

On repository with some submodule not active, it could be needed to run
a command only for active submodule. Today it can be achived with the
command:

git submodule foreach 'git -C $toplevel submodule--helper is-active \
$sm_path && pwd || :'

Goal of this change is to make it more accessible by adding the flag
--only-active to the submodule--helper command. Previous example
become:

git submodule--helper foreach --only-active pwd

Signed-off-by: Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
---
    submodule--helper.c: add only-active to foreach
    
    On repository with some submodule not active, it could be needed to run
    a command only for active submodule. Today it can be achived with the
    command:
    
    git submodule foreach 'git -C $toplevel submodule--helper is-active 
    $sm_path && pwd || :'
    
    Goal of this change is to make it more accessible by adding the flag
    --only-active to the submodule--helper command. Previous example become:
    
    git submodule--helper foreach --only-active pwd
    
    Signed-off-by: Guillaume Galeazzi guillaume.galeazzi@gmail.com
    [guillaume.galeazzi@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-631%2Fgzzi%2Fsubmodule-only-active-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-631/gzzi/submodule-only-active-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/631

 builtin/submodule--helper.c  |  8 +++++++-
 t/t7407-submodule-foreach.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a4b391c882..1a275403764 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -450,6 +450,7 @@ struct foreach_cb {
 	const char *prefix;
 	int quiet;
 	int recursive;
+	int only_active;
 };
 #define FOREACH_CB_INIT { 0 }
 
@@ -464,6 +465,9 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *displaypath;
 
+	if (info->only_active && !is_submodule_active(the_repository, path))
+		return;
+
 	displaypath = get_submodule_displaypath(path, info->prefix);
 
 	sub = submodule_from_path(the_repository, &null_oid, path);
@@ -565,11 +569,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&info.quiet, N_("Suppress output of entering each submodule command")),
 		OPT_BOOL(0, "recursive", &info.recursive,
 			 N_("Recurse into nested submodules")),
+		OPT_BOOL(0, "only-active", &info.only_active,
+			 N_("Call command only for active submodules")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule--helper foreach [--quiet] [--recursive] [--only-active] [--] <command>"),
 		NULL
 	};
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e11..f90a16e3e67 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -80,6 +80,22 @@ test_expect_success 'test basic "submodule foreach" usage' '
 	test_i18ncmp expect actual
 '
 
+sub3sha1=$(cd super/sub3 && git rev-parse HEAD)
+cat > expect <<EOF
+Entering 'sub3'
+$pwd/clone-foo3-sub3-$sub3sha1
+EOF
+
+test_expect_success 'test "submodule--helper foreach --only-active" usage' '
+	test_when_finished "git -C clone config --unset submodule.foo1.active" &&
+	(
+		cd clone &&
+		git config --bool submodule.foo1.active "false" &&
+		git submodule--helper foreach --only-active "echo \$toplevel-\$name-\$path-\$sha1" > ../actual
+	) &&
+	test_i18ncmp expect actual
+'
+
 cat >expect <<EOF
 Entering '../sub1'
 $pwd/clone-foo1-sub1-../sub1-$sub1sha1

base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
-- 
gitgitgadget
