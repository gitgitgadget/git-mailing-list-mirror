Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FBC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 17:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiKGRsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKGRsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 12:48:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542C17A97
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 09:48:13 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so11357997pfb.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWvURItKNW6uA4AGu51CdgTB4kAqIhGAFfws4LymkXc=;
        b=FJv2E+67xEEoCaKM4anIoMdTo9yCHfZwbm3lvNwbB5e3wtYfY8CNOU5aFIY8ytPrYt
         WsU1i+ILgW7MnLO6LyaFnDnX057TLkVlpLjDdtyPjCwmGsgCV1OMWe6Iqfk2/XD1jU92
         6YOczJHOwhk4Fmv7rpTp9sg1NzLQNV6UAf8pmmPTftsA/CTLvoPykt8xP8NC7DflWUjW
         0JPfhOC19LplIncXHc7Pe1rTQOMKyu6wtl5Zbp5c0MqG4HK5KKI2eBumr1ghc88op+V8
         6f6tHHWUujB4PM1gVxPobyz7MMdBWJLi3fpVBWNxEzBZQ3Tgu6jY9OIm1UmSK52fVnxz
         mKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWvURItKNW6uA4AGu51CdgTB4kAqIhGAFfws4LymkXc=;
        b=kdXBLr4/z3G5JrEREVP/riljOBF9W7/W2R26AGaB9jkyzEHucfpPVgG4fNbzMT2i+x
         e9qqRYJYRnqhM9WqTLXsLwJaJ+MYVnI+6oJNSrpUC7XL/t0hF0TuW/esj63J4IQm22OH
         ASSic667Hf71aXkAwSJFyVanECLZfwVT+roIgUCPVCmx1VejXjvqobYTBQBwReYMb5Qo
         EdbFn/mGTPzwhCD74OCnlBioNk75e6VnA46A+t+1FghuSC9rCbf3CDgIfBlClFG8/1sI
         wzqerWxHQ2AjGHEhTB6xplff9lp9KpASYHc32Mxfz4QZiPNtPrZLnR0Va9LakhicBIwJ
         Xsrw==
X-Gm-Message-State: ACrzQf3zF35Bs9Mj+6/0G6yb73oh2J6trVpC+Acji5kBgpSdJ9JAlskb
        zCz03TYH+cRy0YHV73rsBLH0he4IiMgmyxzGNTx9svV8ENXC23LCfT5v30XNiHAIoOq88bDsQBS
        pIMoWGNCQSewIcadM3gt9UWHuoAkuuQHqeTeQ+45J3nqTf5arnz3Zg41uiw==
X-Google-Smtp-Source: AMsMyM4opZnZXrp/8e68cukqdpWJfFMsBRwla6NvDdBJL6ZHSXo3nGe05Rwy/mvoMiMwyqUkMTdinw==
X-Received: by 2002:a65:5a0b:0:b0:46b:158e:ad7c with SMTP id y11-20020a655a0b000000b0046b158ead7cmr44601475pgs.272.1667843292408;
        Mon, 07 Nov 2022 09:48:12 -0800 (PST)
Received: from localhost.localdomain (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ce8100b0016cf3f124e1sm5271873plg.234.2022.11.07.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:48:11 -0800 (PST)
From:   Victoria Dye <vdye@github.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "herr.kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] rebase --update-refs: avoid unintended ref deletion
Date:   Mon,  7 Nov 2022 09:47:52 -0800
Message-Id: <20221107174752.91186-1-vdye@github.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221104165735.68899-1-vdye@github.com>
References: <20221104165735.68899-1-vdye@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
removes potential ref updates from the "update refs state" if a ref does not
have a corresponding 'update-ref' line.

However, because 'write_update_refs_state()' will not update the state if
the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
result in the state remaining unchanged from how it was initialized (with
all refs' "after" OID being null). Then, when the ref update is applied, all
refs will be updated to null and consequently deleted.

To fix this, delete the 'update-refs' state file when 'refs_to_oids' is
empty. Additionally, add a tests covering "all update-ref lines removed"
cases.

Reported-by: herr.kaste <herr.kaste@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
Changes since v1:
- Modified approach to handling empty 'refs_to_oids' from "optional force write
  empty file" to "always unlink"
- Added/updated tests

 sequencer.c                   |   9 ++-
 t/t3404-rebase-interactive.sh | 107 ++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8ff..798a9702961 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4130,11 +4130,14 @@ static int write_update_refs_state(struct string_list *refs_to_oids)
 	struct string_list_item *item;
 	char *path;

-	if (!refs_to_oids->nr)
-		return 0;
-
 	path = rebase_path_update_refs(the_repository->gitdir);

+	if (!refs_to_oids->nr) {
+		if (unlink(path) && errno != ENOENT)
+			result = error_errno(_("could not unlink: %s"), path);
+		goto cleanup;
+	}
+
 	if (safe_create_leading_directories(path)) {
 		result = error(_("unable to create leading directories of %s"),
 			       path);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4f5abb5ad25..462cefd25df 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1964,6 +1964,113 @@ test_expect_success 'respect user edits to update-ref steps' '
 	test_cmp_rev HEAD refs/heads/no-conflict-branch
 '

+test_expect_success '--update-refs: all update-ref lines removed' '
+	git checkout -b test-refs-not-removed no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git branch -f tip &&
+
+	test_commit test-refs-not-removed &&
+	git commit --amend --fixup first &&
+
+	git rev-parse first second third tip no-conflict-branch >expect-oids &&
+
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs base >todo.raw &&
+		sed -e "/^update-ref/d" <todo.raw >todo
+	) &&
+	(
+		set_replace_editor todo &&
+		git rebase -i --update-refs base
+	) &&
+
+	# Ensure refs are not deleted and their OIDs have not changed
+	git rev-parse first second third tip no-conflict-branch >actual-oids &&
+	test_cmp expect-oids actual-oids
+'
+
+test_expect_success '--update-refs: all update-ref lines removed, then some re-added' '
+	git checkout -b test-refs-not-removed2 no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git branch -f tip &&
+
+	test_commit test-refs-not-removed2 &&
+	git commit --amend --fixup first &&
+
+	git rev-parse first second third >expect-oids &&
+
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i \
+			--autosquash --update-refs \
+			base >todo.raw &&
+		sed -e "/^update-ref/d" <todo.raw >todo
+	) &&
+
+	# Add a break to the end of the todo so we can edit later
+	echo "break" >>todo &&
+
+	(
+		set_replace_editor todo &&
+		git rebase -i --autosquash --update-refs base &&
+		echo "update-ref refs/heads/tip" >todo &&
+		git rebase --edit-todo &&
+		git rebase --continue
+	) &&
+
+	# Ensure first/second/third are unchanged, but tip is updated
+	git rev-parse first second third >actual-oids &&
+	test_cmp expect-oids actual-oids &&
+	test_cmp_rev HEAD tip
+'
+
+test_expect_success '--update-refs: --edit-todo with no update-ref lines' '
+	git checkout -b test-refs-not-removed3 no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git branch -f tip &&
+
+	test_commit test-refs-not-removed3 &&
+	git commit --amend --fixup first &&
+
+	git rev-parse first second third tip no-conflict-branch >expect-oids &&
+
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i \
+			--autosquash --update-refs \
+			base >todo.raw &&
+		sed -e "/^update-ref/d" <todo.raw >todo
+	) &&
+
+	# Add a break to the beginning of the todo so we can resume with no
+	# update-ref lines
+	echo "break" >todo.new &&
+	cat todo >>todo.new &&
+
+	(
+		set_replace_editor todo.new &&
+		git rebase -i --autosquash --update-refs base &&
+
+		# Make no changes when editing so update-refs is still empty
+		cat todo >todo.new &&
+		git rebase --edit-todo &&
+		git rebase --continue
+	) &&
+
+	# Ensure refs are not deleted and their OIDs have not changed
+	git rev-parse first second third tip no-conflict-branch >actual-oids &&
+	test_cmp expect-oids actual-oids
+'
+
 test_expect_success '--update-refs: check failed ref update' '
 	git checkout -B update-refs-error no-conflict-branch &&
 	git branch -f base HEAD~4 &&
--
2.38.0

