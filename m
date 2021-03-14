Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B33C432C3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2319364EB3
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhCNSs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhCNSru (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 14:47:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C702C061762
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso18952003wme.0
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ANLefIfNT6KqxHw34lbYaw6i8B+a8Qc8myrPM3OnlpI=;
        b=YHbH7OXYhX4WqIbrRzRLHdLhphhYfj7zHaqDCaLo2UxQXNo/M1M9SDl/fX1rMChR4I
         DNyTaecJrpg6W6Occ8I0a8058M49pH1iZyds8pQrFAANjVBF0h1uiBIGnws6L3IO+UnQ
         U+pxpEa8gqSZI7miJ1KnoDFL1V7w+QQ1DOuk6O+XgpfDR8zaI15NMwsJoKRk9O7drMZk
         xmnmJ367IvXWm8XDYhpW0nt8JYJJcUnSJk3I3sRktn1JVyMUGOL3IfjkCfitWLltds37
         3z/cqHd1D+2BWMy2mGap9Faj9ojtQYgQyfjiOtSTAELXWOSffx7VPlB/IIpYUsQDmdZu
         dItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ANLefIfNT6KqxHw34lbYaw6i8B+a8Qc8myrPM3OnlpI=;
        b=pdnaVWMFfuCm8dWcMXNR9RHHTaKVAYBbQIPLP9I0oH5p0m/aYuTuA6OlahU7429uPb
         9jlc4aP/fqNC/NOfloZyBq6jXPjxCBAvSqBT2QlmjhzRwTrvfOafMCAu9cnKqPGxrx3H
         NZu8kFgWDat6LeTbqjGwyFI73mMvayx8bMCmh472NoqHIZxW7A8+D0WsVYbXKq2bynDg
         sJ+z6AtlQldcBuLMkDlTWfLZdV+GFQCZqemkReFl/aXwlomd8sMZtAZuVHudEPUIgusy
         YOw82MHm+ebZU3WBDmiUFZL4plQBgZsqgeKQ6jE2uwSBbK+uSf62kfmD5qBO+wCCpf98
         s4vw==
X-Gm-Message-State: AOAM530mTEk2hEHAAJ/k5I2ryhGIfLDqS1Ej4wsAzp8FIMGyplpxK2e9
        2wbBRer8k7X1PkIPeFMFrGT8PzG466Q=
X-Google-Smtp-Source: ABdhPJxQZh8fyOMN1XznYmHADTtx7vic1qRSWjrPjvvNVW1e8hPAeHOloDp2XrxJrV36MN0++E5Ymg==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr22435360wmq.175.1615747668322;
        Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm9573632wmd.21.2021.03.14.11.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:47:48 -0700 (PDT)
Message-Id: <a907f2460d42dbc959e6059f96ba0448e458ca51.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 18:47:42 +0000
Subject: [PATCH v2 9/9] transport: also free remote_refs in
 transport_disconnect()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

transport_get_remote_refs() can populate the transport struct's
remote_refs. transport_disconnect() is already responsible for most of
transport's cleanup - therefore we also take care of freeing remote_refs
there.

There are 2 locations where transport_disconnect() is called before
we're done using the returned remote_refs. This patch changes those
callsites to only call transport_disconnect() after the returned refs
are no longer being used - which is necessary to safely be able to
free remote_refs during transport_disconnect().

This commit fixes the following leak which was found while running
t0000, but is expected to also fix the same pattern of leak in all
locations that use transport_get_remote_refs():

Direct leak of 165 byte(s) in 1 object(s) allocated from:
    #0 0x49a6b2 in calloc /home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_malloc_linux.cpp:154:3
    #1 0x9a72f2 in xcalloc /home/ahunt/oss-fuzz/git/wrapper.c:140:8
    #2 0x8ce203 in alloc_ref_with_prefix /home/ahunt/oss-fuzz/git/remote.c:867:20
    #3 0x8ce1a2 in alloc_ref /home/ahunt/oss-fuzz/git/remote.c:875:9
    #4 0x72f63e in process_ref_v2 /home/ahunt/oss-fuzz/git/connect.c:426:8
    #5 0x72f21a in get_remote_refs /home/ahunt/oss-fuzz/git/connect.c:525:8
    #6 0x979ab7 in handshake /home/ahunt/oss-fuzz/git/transport.c:305:4
    #7 0x97872d in get_refs_via_connect /home/ahunt/oss-fuzz/git/transport.c:339:9
    #8 0x9774b5 in transport_get_remote_refs /home/ahunt/oss-fuzz/git/transport.c:1388:4
    #9 0x51cf80 in cmd_clone /home/ahunt/oss-fuzz/git/builtin/clone.c:1271:9
    #10 0x4cd60d in run_builtin /home/ahunt/oss-fuzz/git/git.c:453:11
    #11 0x4cb2da in handle_builtin /home/ahunt/oss-fuzz/git/git.c:704:3
    #12 0x4ccc37 in run_argv /home/ahunt/oss-fuzz/git/git.c:771:4
    #13 0x4cac29 in cmd_main /home/ahunt/oss-fuzz/git/git.c:902:19
    #14 0x69c45e in main /home/ahunt/oss-fuzz/git/common-main.c:52:11
    #15 0x7f6a459d5349 in __libc_start_main (/lib64/libc.so.6+0x24349)

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/ls-remote.c | 4 ++--
 builtin/remote.c    | 8 ++++----
 transport.c         | 2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index ef604752a044..5432d239a681 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -124,8 +124,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
-	if (transport_disconnect(transport))
-		return 1;
 
 	if (!dest && !quiet)
 		fprintf(stderr, "From %s\n", *remote->url);
@@ -151,5 +149,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	ref_array_clear(&ref_array);
+	if (transport_disconnect(transport))
+		return 1;
 	return status;
 }
diff --git a/builtin/remote.c b/builtin/remote.c
index d11a5589e49d..e31d9c99470e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -938,9 +938,6 @@ static int get_remote_ref_states(const char *name,
 				 struct ref_states *states,
 				 int query)
 {
-	struct transport *transport;
-	const struct ref *remote_refs;
-
 	states->remote = remote_get(name);
 	if (!states->remote)
 		return error(_("No such remote: '%s'"), name);
@@ -948,10 +945,12 @@ static int get_remote_ref_states(const char *name,
 	read_branches();
 
 	if (query) {
+		struct transport *transport;
+		const struct ref *remote_refs;
+
 		transport = transport_get(states->remote, states->remote->url_nr > 0 ?
 			states->remote->url[0] : NULL);
 		remote_refs = transport_get_remote_refs(transport, NULL);
-		transport_disconnect(transport);
 
 		states->queried = 1;
 		if (query & GET_REF_STATES)
@@ -960,6 +959,7 @@ static int get_remote_ref_states(const char *name,
 			get_head_names(remote_refs, states);
 		if (query & GET_PUSH_REF_STATES)
 			get_push_ref_states(remote_refs, states);
+		transport_disconnect(transport);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		string_list_sort(&states->tracked);
diff --git a/transport.c b/transport.c
index b13fab5dc3b1..62362d79dd87 100644
--- a/transport.c
+++ b/transport.c
@@ -1452,6 +1452,8 @@ int transport_disconnect(struct transport *transport)
 	int ret = 0;
 	if (transport->vtable->disconnect)
 		ret = transport->vtable->disconnect(transport);
+	if (transport->got_remote_refs)
+		free_refs((void *)transport->remote_refs);
 	free(transport);
 	return ret;
 }
-- 
gitgitgadget
