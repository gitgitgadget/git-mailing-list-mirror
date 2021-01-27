Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EBC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC9F20724
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhA0IJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbhA0IF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:05:58 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA27C06178B
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so900716wrt.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQSEliMEDBrpy36NuctS6TIVFb8YhMsxYxTwLT6cPyo=;
        b=chd6W4aVPBN/nu4jWQyOHBbU1/FbLAHpxkmiM2cgbV6DJzXYtLSFTF0dPBNO7C2GAC
         PWJF05pgfHhIQftTpkH//18r2dt1qwWEM8fg6/04eSkEDnLG1MMdoesCLwObnSbGNSUY
         2XDw5bHHNaLGwOpHqQrDSv049PjSp6rR0PWALSKIgcB9977/Edrlq82TwZWbZvjSFIAN
         5/nYZZb5PzPOIcA1XCuXYoitB/wGzIIqvkz8PIhYoGERypuHSdnJgS/qjJTqjO0pqKgf
         jI7b3Xyb5mjPY49gY/ZMez9eL1ZUNvSHZM1qB98uqNdcsKmWMBapOgl2cr/R3GnRhR4V
         Ca6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQSEliMEDBrpy36NuctS6TIVFb8YhMsxYxTwLT6cPyo=;
        b=cfNc9nCeVrPlDvL1zQ1seZIuogXIr2gnkQL3YEaBOtqLr02iGk6f4tj3AMYV6iUzba
         UnZ3UjWSYg32f7wJRdkCm8miZaGCMYqErJes4Q9gyeiuhbh+aaCiP7HkkUNqKYBWg2Ah
         l2OcMlhUkxphyefZ3WAroyvp+ZAGQzKetPtwXGqNzRLcQplH9U2GQxvlTKzaxG6e5Y7T
         iPp95sgCiVVbEDAYwZCJQBNuAvaiON7KjZNmsubymuttzirS/bybxSauRUHaYuHiNjvy
         X9b6FEb6f7fyCJ51KiSCgbsbDL1D31nxqrp1I2PQbNqS54F2TT9RewZdhQdylHTdgUxi
         Vmcw==
X-Gm-Message-State: AOAM530ak5lzuItAEyVPuUjRL0213GtQIKqa7PqLCkKyEHtBMJRnj8iF
        k9xJ7jl08wEU54uwytGQwk/s8eS0HINcpENr
X-Google-Smtp-Source: ABdhPJy6h/ArF1MbfQjOVp/2cC5N9KaEGH3Slvzq+Xs2WBmLmRInEVjXtTzlzHTwbzX3/vRS76VMSQ==
X-Received: by 2002:adf:decb:: with SMTP id i11mr8390896wrn.78.1611734649571;
        Wed, 27 Jan 2021 00:04:09 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id m8sm1850237wrv.37.2021.01.27.00.04.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:04:08 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v4 5/7] worktree: teach `list --porcelain` to annotate locked worktree
Date:   Wed, 27 Jan 2021 09:03:08 +0100
Message-Id: <20210127080310.89639-6-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.395.g7821b4e95a
In-Reply-To: <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
References: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <20210127080310.89639-1-rafaeloliveira.cs@gmail.com>
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

In porcelain mode, if the lock reason contains special characters
such as newlines, they are escaped with backslashes and the entire
reason is enclosed in double quotes. For example:

   $ git worktree list --porcelain
   ...
   locked "worktree's path mounted in\nremovable device"
   ...

Furthermore, let's update the documentation to state that some
attributes in the porcelain format might be listed alone or together
with its value depending whether the value is available or not. Thus
documenting the case of the new "locked" attribute.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 Documentation/git-worktree.txt | 28 ++++++++++++++++++++++++++--
 builtin/worktree.c             | 13 +++++++++++++
 t/t2402-worktree-list.sh       | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 02a706c4c0..426e9b4f76 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -377,8 +377,10 @@ Porcelain Format
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are present only
-if the value is true.  The first attribute of a working tree is always
-`worktree`, an empty line indicates the end of the record.  For example:
+if the value is true.  Some attributes (like `locked`) can be listed as a label
+only or with a value depending upon whether a reason is available.  The first
+attribute of a working tree is always `worktree`, an empty line indicates the
+end of the record.  For example:
 
 ------------
 $ git worktree list --porcelain
@@ -393,6 +395,28 @@ worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
 
+worktree /path/to/linked-worktree-locked-no-reason
+HEAD 5678abc5678abc5678abc5678abc5678abc5678c
+branch refs/heads/locked-no-reason
+locked
+
+worktree /path/to/linked-worktree-locked-with-reason
+HEAD 3456def3456def3456def3456def3456def3456b
+branch refs/heads/locked-with-reason
+locked reason why is locked
+
+------------
+
+If the lock reason contains "unusual" characters such as newline, they
+are escaped and the entire reason is quoted as explained for the
+configuration variable `core.quotePath` (see linkgit:git-config[1]).
+For Example:
+
+------------
+$ git worktree list --porcelain
+...
+locked "reason\nwhy is locked"
+...
 ------------
 
 EXAMPLES
diff --git a/builtin/worktree.c b/builtin/worktree.c
index df90a5acca..98177f91d4 100644
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
+		quote_c_style(reason, &sb, NULL, 0);
+		printf("locked %s\n", sb.buf);
+		strbuf_release(&sb);
+	} else if (reason)
+		printf("locked\n");
+
 	printf("\n");
 }
 
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 1866ea09f6..39596e4aa9 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -72,6 +72,38 @@ test_expect_success '"list" all worktrees with locked annotation' '
 	! grep "/unlocked  *[0-9a-f].* locked$" out
 '
 
+test_expect_success '"list" all worktrees --porcelain with locked' '
+	test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
+	echo "locked" >expect &&
+	echo "locked with reason" >>expect &&
+	git worktree add --detach locked1 &&
+	git worktree add --detach locked2 &&
+	# unlocked worktree should not be annotated with "locked"
+	git worktree add --detach unlocked &&
+	git worktree lock locked1 &&
+	test_when_finished "git worktree unlock locked1" &&
+	git worktree lock locked2 --reason "with reason" &&
+	test_when_finished "git worktree unlock locked2" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
+	test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
+	printf "locked \"locked\\\\r\\\\nreason\"\n" >expect &&
+	printf "locked \"locked\\\\nreason\"\n" >>expect &&
+	git worktree add --detach locked_lf &&
+	git worktree add --detach locked_crlf &&
+	git worktree lock locked_lf --reason "$(printf "locked\nreason")" &&
+	test_when_finished "git worktree unlock locked_lf" &&
+	git worktree lock locked_crlf --reason "$(printf "locked\r\nreason")" &&
+	test_when_finished "git worktree unlock locked_crlf" &&
+	git worktree list --porcelain >out &&
+	grep "^locked" out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repo setup' '
 	git init --bare bare1 &&
 	echo "data" >file1 &&
-- 
2.30.0.373.geade8fefe8

