Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581AB20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbdLFWDL (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:03:11 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38588 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdLFWDK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:03:10 -0500
Received: by mail-it0-f48.google.com with SMTP id r6so9842122itr.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYYE14Ag8slzokW18qvTwxysuKkjwy4sFGXXI6GHd2A=;
        b=juzht93kCIaSlBTgCfNb0/x6FAhCCm7Eiu80BFo5XAzmLcJ4gvIrsEwpEqM6lE9548
         umrwpaksjvfMvxdPGPNBqYhtrPmnx7QmNCjvu6AqTveD3I++o/2HGXCzrrwy7y5vJ6mK
         IdbtO4faagXnIcXmmermt10RiHMjd48nGo2MXndtarcUwdTmS8VaawnqEZ8rm4YPVzui
         VNhLY0l/OFIhpSxEdlPrTvlzYRpetjN2E9tBYomOjhugG+bpi4wgfsvBMyw0NPP+wVgo
         HSIDM8Sik8VG2HauDpN6OsElYbqpuLD65av7gU49XKCZqVHyNlwuOGCeb5zCnVEh53nw
         V8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYYE14Ag8slzokW18qvTwxysuKkjwy4sFGXXI6GHd2A=;
        b=KjGED05ixhoq7zFjPlQ4yeYKAxqolNlq/dAvAiLYaNLi+h7WB9eNzNQbdOywv3l9+1
         3AUUJe3a/yQESq/r/nzY2xn1yRjESUG2dnhyk52JphqMO0sMXwvz6mVIRUAw70lqMW8S
         tr9dU/BouH/Ry1MBK0KnDVRd7E0EkU6mgdvPgwCHswWdNEQzF0bImADbKqKXsnZexPJd
         9UrlkHGbk9XIcfqermldYz2v70il5/pPNEO/SNhGvOQNc9ckBreV2GtWfwlZ3HcicXmE
         cnYGAZEpKOpsSzCimY9g6LRW031rLdQfX9Dy1yfTzVK22thitzM4Pm1nl9UJJixiiisT
         UMjw==
X-Gm-Message-State: AJaThX7Z90gWUq7S6v63veMCHNG+oTkA7uggbMT2M3rpH+DVR2RzLP8Z
        jdk4urrR2oC04/84urFt3WLPvlIvnsI=
X-Google-Smtp-Source: AGs4zMbZUM2ek1rVD021ocdYT6XX/0hu07V20bAnaYK478PJbka15zkm5/PsoGoUL7G4M2HpK694Qg==
X-Received: by 10.107.142.137 with SMTP id q131mr34538752iod.109.1512597788924;
        Wed, 06 Dec 2017 14:03:08 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q132sm1742736iod.26.2017.12.06.14.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 14:03:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, ben.boeckel@kitware.com,
        sunshine@sunshineco.com, sbeller@google.com, gitster@pobox.com
Subject: [PATCH v2] diff-tree: read the index so attribute checks work in bare repositories
Date:   Wed,  6 Dec 2017 14:02:56 -0800
Message-Id: <20171206220256.44482-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171205221337.140548-1-bmwill@google.com>
References: <20171205221337.140548-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression was introduced in 557a5998d (submodule: remove
gitmodules_config, 2017-08-03) to how attribute processing was handled
in bare repositories when running the diff-tree command.

By default the attribute system will first try to read ".gitattribute"
files from the working tree and then falls back to reading them from the
index if there isn't a copy checked out in the worktree.  Prior to
557a5998d the index was read as a side effect of the call to
'gitmodules_config()' which ensured that the index was already populated
before entering the attribute subsystem.

Since the call to 'gitmodules_config()' was removed the index is no
longer being read so when the attribute system tries to read from the
in-memory index it doesn't find any ".gitattribute" entries effectively
ignoring any configured attributes.

Fix this by explicitly reading the index during the setup of diff-tree.

Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/diff-tree.c        |  2 ++
 t/t4015-diff-whitespace.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index d66499909..b775a7564 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -110,6 +110,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	init_revisions(opt, prefix);
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
 	opt->abbrev = 0;
 	opt->diff = 1;
 	opt->disable_stdin = 1;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 559a7541a..17df491a3 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -636,6 +636,23 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
 	test_must_fail git diff-tree --check HEAD^ HEAD
 '
 
+test_expect_success 'check with ignored trailing whitespace attr (diff-tree)' '
+	test_when_finished "git reset --hard HEAD^" &&
+
+	# create a whitespace error that should be ignored
+	echo "* -whitespace" >.gitattributes &&
+	git add .gitattributes &&
+	echo "foo(); " >x &&
+	git add x &&
+	git commit -m "add trailing space" &&
+
+	# with a worktree diff-tree ignores the whitespace error
+	git diff-tree --root --check HEAD &&
+
+	# without a worktree diff-tree still ignores the whitespace error
+	git -C .git diff-tree --root --check HEAD
+'
+
 test_expect_success 'check trailing whitespace (trailing-space: off)' '
 	git config core.whitespace "-trailing-space" &&
 	echo "foo ();   " >x &&
-- 
2.15.1.424.g9478a66081-goog

