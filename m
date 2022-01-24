Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17454C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiAXSJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiAXSJN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:09:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24CFC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:09:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r13-20020a638f4d000000b0034c8f73f9efso10323002pgn.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A2nh+lO32ZSEVxvj+FbzfnhkDjxaydfaJ/37L/vg3/I=;
        b=mMBx/BlJwsc3Q6JXZU2SeP4bX+4Om89l7Cwcw2zhptWFWBJckaoJ4AhB9m/0VaJ2gF
         A53i/hqxs6kTtGHjuhfuQ8OVg+pSIm5BVDN4Z96SBxK1ypExTSQ6gKxWo0mpk9JKl5c9
         JWnp2UMsHfCjZlcpTCYcjdoKgeFOPRX+7YoEsVTr5jOwpGwN5i9FdaZA/IM4qlo0Te+R
         alGqrm4c2M17f/hDJBBcnT47FyASX2L8P3dHnnX8z/ZfrwYp4MZpZkFCluuVGTZ4vn0n
         zqygRQDNJ8niuljQX7JVMfkX33q6/vOIKujzjvq+lg5oCYAnVyMNYk/euIYC7rdaTBUt
         l6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A2nh+lO32ZSEVxvj+FbzfnhkDjxaydfaJ/37L/vg3/I=;
        b=cowz9rbJjFJjJSoObMXkDYAAiCR5h+OavgkvdSa8pebDmPS/LHgBGeQebw/fJRItq+
         ath6nllCd+ojmvrxdobNvYTbherPGuBPBM4dcrqaPTTPkPgHzJ7CLyOUvM00ZLKlBNqV
         m9Rso5wjORpjzu47XXWjgAm5CPXtbdZWfQnmY3Yjm461gccM19x747mgjwdQsYRrdeZK
         70/TJP/Qw4gK9pIjiDgNkgbT1d6hyJUo3sqF3e3uwCfyloiZ3HtRG/cxDnFAjnooCUqh
         LANMM+msYi10keosfWzBjHP9F7gdjjZegmOT9ItWe32N10w68FKLmnhJRco6a7qtm0l8
         4QzQ==
X-Gm-Message-State: AOAM531tC2WQqOuCe2rU4izt07XwdWBoXnVwu+ulWI2Gh/qAYDJrrdTv
        fnfEcjYuizsfndebqDr/ESWaod/1LvZvf1WFiMdIijueWCsOnRKcwigm6j9pWz6Iba0xaUZ3+54
        2yXxbBYLW2ns+gf9jVKZV8r16ycMxMlBo2Gr+335943Dn6jJFBNfoxwjTj6RYWjjlH1iD3qQObS
        om
X-Google-Smtp-Source: ABdhPJwxayK7CGdskA4gDcCR7gp8HtOxgNfg+IJW9dBDK5VNBMJrZY5vyPD26ryfDHJemAAGompSl2u1HA1+qEt3bfqj
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:b387:: with SMTP id
 e7mr3026923pjr.190.1643047752202; Mon, 24 Jan 2022 10:09:12 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:09:09 -0800
Message-Id: <20220124180909.2437002-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] clone: support unusual remote ref configurations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a branchless and tagless but not refless remote using
protocol v0 or v1, Git calls transport_fetch_refs() with an empty ref
list. This makes the clone fail with the message "remote transport
reported error".

Git should have refrained from calling transport_fetch_refs(), just like
it does in the case that the remote is refless. Therefore, teach Git to
do this.

In protocol v2, this does not happen because the client passes
ref-prefix arguments that filter out non-branches and non-tags in the
ref advertisement, making the remote appear empty.

Note that this bug concerns logic in builtin/clone.c and only affects
cloning, not fetching.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's a bug we noticed at $DAYJOB regarding protocol v0/v1, and a
bugfix.

It may be confusing that the message currently printed is "remote
transport reported error". This is due to transport_fetch_refs() not
distinguishing between an empty input ref list and a transport error -
perhaps in the future, an empty input ref list could be signaled by a
BUG().
---
 builtin/clone.c        | 12 ++++++------
 t/t5700-protocol-v1.sh | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 727e16e0ae..3df441eb71 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -862,7 +862,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *refs, *remote_head;
 	struct ref *remote_head_points_at = NULL;
 	const struct ref *our_head_points_at;
-	struct ref *mapped_refs;
+	struct ref *mapped_refs = NULL;
 	const struct ref *ref;
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
@@ -1184,7 +1184,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
-	if (refs) {
+	if (refs)
+		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
+
+	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
 		/*
@@ -1193,8 +1196,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 */
 		initialize_repository_version(hash_algo, 1);
 		repo_set_hash_algo(the_repository, hash_algo);
-
-		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1240,7 +1241,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					option_branch, remote_name);
 
 		warning(_("You appear to have cloned an empty repository."));
-		mapped_refs = NULL;
 		our_head_points_at = NULL;
 		remote_head_points_at = NULL;
 		remote_head = NULL;
@@ -1271,7 +1271,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (is_local)
 		clone_local(path, git_dir);
-	else if (refs && complete_refs_before_fetch) {
+	else if (mapped_refs && complete_refs_before_fetch) {
 		if (transport_fetch_refs(transport, mapped_refs))
 			die(_("remote transport reported error"));
 	}
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 468bd3e13e..6c8d4c6cf1 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -149,6 +149,21 @@ test_expect_success 'push with file:// using protocol v1' '
 	grep "push< version 1" log
 '
 
+test_expect_success 'cloning branchless tagless but not refless remote' '
+	rm -rf server client &&
+
+	git -c init.defaultbranch=main init server &&
+	echo foo >server/foo.txt &&
+	git -C server add foo.txt &&
+	git -C server commit -m "message" &&
+	git -C server update-ref refs/notbranch/alsonottag HEAD &&
+	git -C server checkout --detach &&
+	git -C server branch -D main &&
+	git -C server symbolic-ref HEAD refs/heads/nonexistentbranch &&
+
+	git -c protocol.version=1 clone "file://$(pwd)/server" client
+'
+
 # Test protocol v1 with 'ssh://' transport
 #
 test_expect_success 'setup ssh wrapper' '
-- 
2.35.0.rc0.227.g00780c9af4-goog

