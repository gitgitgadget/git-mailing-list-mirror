Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1BC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F461152
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 23:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhJNXja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhJNXj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 19:39:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B1C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so23227046wro.3
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhq6D6AGMSMJVpPSOAYmx/RXfAVyPuuxNwMaVszI/7A=;
        b=G9yDCusqe/KVPXAbYO6lyl1AT6rYLpfUQQP+t+mi8wXhzdJYF0w9ZEdSUDEZLC0Z+e
         HDsL7G2g6rSnKUKFSbOdYuYfyRYvJ7lWdumtjr31I9rZItruxmyTgguMEzr+ab/iAzuY
         WLq2nRsoORPH6GvwF+YJuP/5IhdsJWnXBp+XqhNVjUcrzM/0JU5HXy473myVEJl6LDKG
         G3arWv98Uqvgz/uskTzxvTUgTkMhNUav+8vEphNv/PdgOQDLQS2FHaYBn+OBYhBrbBHs
         w5ALbtFpQ6VvRLVrBMkX9Dch8mfqA6o0V6xg+RrlWn2jNNVQSzPSdeu8iXtfbhSVR62A
         faZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhq6D6AGMSMJVpPSOAYmx/RXfAVyPuuxNwMaVszI/7A=;
        b=GwaYHTw+siSlljEXwILwgE8XXzOpW7DidWvaqFiwTYs3QxdYotaO9TomxjIS2hIMGJ
         hPajB0+cvz0PHlA9c5SGJOyZ3SaZ4+5aUJKzRuwiaZJ+WqrU2VElsNqNFvck2GcbC4Ln
         icgtAZhDeF9dd10xDofT5gOSJUWTdtPk5XQJMqeCSW5q8ShCnEUfZ+JRCtwRrTapWuaS
         Qz1AGDjm4Beh+KzmvlpmiKdfAkKM19XoKu558brGaCr8jWjJQLXw6JFjD+hAsCox2g37
         uA9e9Zf3DoYXyGWsQg0MH3YPo6xmYy4R4VLYkDFBf5oQKFsNcQgaetMDBmJVvj5bmE3k
         RDoA==
X-Gm-Message-State: AOAM533Yrw/7MKkhuP/X1HL6IkuF0ZK5nKZEw14NffcFTOjRSEFpDgCR
        sduZXthD0bo/iENRPHn8C1Knsj7hAqtaXg==
X-Google-Smtp-Source: ABdhPJzmIn+L8QHLhPJuQO14OUKOglwUJhv7FH8Jb8cDc3DsrzAp5Wl57vCVowDABvraKqYxXNNNIg==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr10476079wro.102.1634254639820;
        Thu, 14 Oct 2021 16:37:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g16sm3547658wrs.90.2021.10.14.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:37:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] commit-graph: don't consider "replace" objects with "verify"
Date:   Fri, 15 Oct 2021 01:37:16 +0200
Message-Id: <patch-3.3-56bb70518cb-20211014T233343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211014T233343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the code added in d6538246d3d (commit-graph: not compatible
with replace objects, 2018-08-20) which ignored replace objects in the
"write" command to ignore it in the "verify" command too.

We can just move this assignment to the cmd_commit_graph(), it
dispatches to "write" and "verify", and we're unlikely to ever get a
sub-command that would like to consider replace refs.

This will make tests added in eddc1f556cd (mktag tests: test
update-ref and reachable fsck, 2021-06-17) pass in combination with
the "GIT_TEST_COMMIT_GRAPH" mode added in 859fdc0c3cf (commit-graph:
define GIT_TEST_COMMIT_GRAPH, 2018-08-29), except that mode is
currently broken (but is being fixed concurrently). See the discussion
starting at [1].

1. https://lore.kernel.org/git/87wnmihswp.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c  | 2 +-
 t/t5318-commit-graph.sh | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3c3de3a156f..fb8e166a26f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -263,7 +263,6 @@ static int graph_write(int argc, const char **argv)
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	read_replace_refs = 0;
 	odb = find_odb(the_repository, opts.obj_dir);
 
 	if (opts.reachable) {
@@ -318,6 +317,7 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		goto usage;
 
+	read_replace_refs = 0;
 	save_commit_buffer = 0;
 
 	if (!strcmp(argv[0], "verify"))
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 88fbe004a38..84d122a7ae7 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -385,6 +385,7 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 		git commit-graph write --reachable &&
 		test_path_is_file .git/objects/info/commit-graph &&
 		git replace HEAD~1 HEAD~2 &&
+		graph_git_two_modes "commit-graph verify" &&
 		git -c core.commitGraph=false log >expect &&
 		git -c core.commitGraph=true log >actual &&
 		test_cmp expect actual &&
-- 
2.33.1.1338.g20da966911a

