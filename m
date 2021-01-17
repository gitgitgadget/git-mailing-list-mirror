Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637F2C433E6
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33400206E3
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 23:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbhAQXpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 18:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbhAQXoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F523C0613C1
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g3so1833768ejb.6
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwhimOFkUCE/aVJgrTw6SY+VMA550OVQFWbC2+zj31Q=;
        b=iSMlaU781+iv7mWwgCox/kY14d8KZs2gkezmtaxitIDboo/KK3nnXvsRNJ4urSZCtw
         WiMbkzc3Q2ueX5ywvsYOJCiKZNkHXMCK/4g3eQ7inHOCeaC2AA69qU1ACrPTWv/NnbyJ
         8MAJWFJIkDsW+DeklqPl914qebxa3bjlTQXBY34gkyVwJBlLmdcmOTS2U3eMDE6LYdMT
         vTUuPKKBWs2mgE3teBWtIpN63Zkg28qwEOWXQr+ojyiHLqydOsedsk+039yrr5zocLff
         3SQr5UKKDmbJsDZXoqeFKnFtVLA+Qndb71r/kRR/ln6+M4esyNJfg1c/VkxX9mxlE928
         V7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwhimOFkUCE/aVJgrTw6SY+VMA550OVQFWbC2+zj31Q=;
        b=NxU3+Uvirw7oyhsCNtsXV2YrIP3xeh52y97aoNe4A8u94bGc4H5SqBixPiHBcB0ekt
         3vHKC3350rNKj1WjfA0Jb4EUWcb3axdVDr2V64oQGUJzGnJzuEvFyJMRNosE5otmNUr4
         Vj/JxMla2R3xlfHCwDjraoJ+2TrPIz4wTAJPOryz5t4ZV9hGCtDLRnSFfqEyhhdbarx1
         ogkD9/HF5ej9eg6ZAZ+kkmF5r+KEsrGTdyFuqRQAtlLqHYtReCrjFXAW11uX1GECxJgd
         6UEdD2oLfPMCWOedXPt/cKp8zUY6eAOF6XfS1lxMgCWY84ahzWmaihFns+hfdp8s9RZe
         D0SA==
X-Gm-Message-State: AOAM532sqHZvUhWGw2bK9PMR1ii3Cu+TOB9pQ5HsMRRBgKwH2LHIcB2y
        PH+37qpguiGXHKVe+1bOWMMIzkdQS9k=
X-Google-Smtp-Source: ABdhPJyWs4UijuiDrc4RTLR2pztnQ/ryZiyjsCSU6UBGwarlcRAT6qN50nW/j+BGJzqLFxUAe8/i6Q==
X-Received: by 2002:a17:907:7346:: with SMTP id dq6mr3226904ejc.237.1610927029885;
        Sun, 17 Jan 2021 15:43:49 -0800 (PST)
Received: from localhost.localdomain ([79.140.114.246])
        by smtp.gmail.com with ESMTPSA id f13sm8639932ejf.42.2021.01.17.15.43.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 15:43:49 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 4/6] worktree: teach `list --porcelain` to annotate locked worktree
Date:   Mon, 18 Jan 2021 00:42:42 +0100
Message-Id: <20210117234244.95106-5-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.372.gbc7e965391
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit c57b3367be (worktree: teach `list` to annotate locked worktree,
2020-10-11) taught "git worktree list" to annotate locked worktrees by
appending "locked" text to its output, however, this is not listed in
the --porcelain format.

Teach "list --porcelain" to do the same and add a "locked" attribute
followed by its reason, thus making both default and porcelain format
consistent. If the locked reason is not available then only "locked"
is shown.

The output of the "git worktree list --porcelain" becomes like so:

    $ git worktree list --porcelain
    ...
    worktree /path/to/locked
    HEAD 123abcdea123abcd123acbd123acbda123abcd12
    detached
    locked

    worktree /path/to/locked-with-reason
    HEAD abc123abc123abc123abc123abc123abc123abc1
    detached
    locked reason why it is locked
    ...

The locked reason is quoted to prevent newline characters (i.e: LF or
CRLF) breaking the --porcelain format as each attribute is shown per
line. For example:

   $ git worktree list --porcelain
   ...
   locked worktree's path mounted in\nremovable device
   ...

Furthermore, let's update the documentation to state that some
attributes in the porcelain format might be listed alone or together
with its value depending whether the value is available or not. Thus
documenting the case of the new "locked" attribute.

Additionally, c57b3367be (worktree: teach `list` to annotate locked
worktree, 2020-10-11) introduced a new test to ensure locked worktrees
are listed with "locked" annotation. However, the test does not clean up
after itself as "git worktree prune" is not going to remove the locked
worktree in the first place. This not only leaves the test in an unclean
state it also potentially breaks following tests that relies on the
"git worktree list" output. Let's fix that by unlocking the worktree
before the "prune" command.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 16 ++++++++++++++--
 builtin/worktree.c             | 13 +++++++++++++
 t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 02a706c4c0..d352a002f2 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -377,8 +377,10 @@ Porcelain Format
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
-if the value is true.  The first attribute of a working tree is always
-`worktree`, an empty line indicates the end of the record.  For example:
+if the value is true.  Some attributes (like `locked`) can be listed as a label
+only or with a value depending whether a reason is available.  The first
+attribute of a working tree is always `worktree`, an empty line indicates the
+end of the record.  For example:
 
 ------------
 $ git worktree list --porcelain
@@ -393,6 +395,16 @@ worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
 
+worktree /path/to/linked-worktree-locked
+HEAD 5678abc5678abc5678abc5678abc5678abc5678c
+branch refs/heads/locked
+locked
+
+worktree /path/to/linked-worktree-locked-with-reason
+HEAD 3456def3456def3456def3456def3456def3456b
+branch refs/heads/locked-with-reason
+locked reason why is locked
+
 ------------
 
 EXAMPLES
diff --git a/builtin/worktree.c b/builtin/worktree.c
index dd886d5029..37ae277352 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -12,6 +12,7 @@
 #include "submodule.h"
 #include "utf8.h"
 #include "worktree.h"
+#include "quote.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
@@ -569,6 +570,8 @@ static int add(int ac, const char **av, const char *prefix)
 
 static void show_worktree_porcelain(struct worktree *wt)
 {
+	const char *reason;
+
 	printf("worktree %s\n", wt->path);
 	if (wt->is_bare)
 		printf("bare\n");
@@ -579,6 +582,16 @@ static void show_worktree_porcelain(struct worktree *wt)
 		else if (wt->head_ref)
 			printf("branch %s\n", wt->head_ref);
 	}
+
+	reason = worktree_lock_reason(wt);
+	if (reason && *reason) {
+		struct strbuf sb = STRBUF_INIT;
+		quote_c_style(reason, &sb, NULL, CQUOTE_NODQ);
+		printf("locked %s\n", sb.buf);
+		strbuf_release(&sb);
+	} else if (reason)
+		printf("locked\n");
+
 	printf("\n");
 }
 
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..c522190feb 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -66,11 +66,43 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	git worktree add --detach locked master &&
 	git worktree add --detach unlocked master &&
 	git worktree lock locked &&
+	test_when_finished "git worktree unlock locked" &&
 	git worktree list >out &&
 	grep "/locked  *[0-9a-f].* locked$" out &&
 	! grep "/unlocked  *[0-9a-f].* locked$" out
 '
 
+test_expect_success '"list" all worktrees --porcelain with locked' '
+	test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
+	echo "locked" >expect &&
+	echo "locked with reason" >>expect &&
+	git worktree add --detach locked1 &&
+	git worktree add --detach locked2 &&
+	git worktree add --detach unlocked &&
+	git worktree lock locked1 &&
+	git worktree lock locked2 --reason "with reason" &&
+	test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
+	test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
+	printf "locked locked\\\\r\\\\nreason\n" >expect &&
+	printf "locked locked\\\\nreason\n" >>expect &&
+	git worktree add --detach locked_lf &&
+	git worktree add --detach locked_crlf &&
+	printf "locked\nreason\n\n" >reason_lf &&
+	printf "locked\r\nreason\n\n" >reason_crlf &&
+	git worktree lock locked_lf --reason "$(cat reason_lf)" &&
+	git worktree lock locked_crlf --reason "$(cat reason_crlf)" &&
+	test_when_finished "git worktree unlock locked_lf && git worktree unlock locked_crlf" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.30.0.372.gbc7e965391

