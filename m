Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB9C433DB
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCB864E32
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhBVT0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhBVTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 14:20:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87574C0617A9
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v62so17535466ybb.15
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 11:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H14SKziskvi0fDy74D291MDC23rTB7aIJmAsEUUk8wk=;
        b=f0tQTmHXoGva6B8jNLyiDYKWmON1OfLRqD/CmuLwmCpOafbAZr8YVEeFKrlw+KX4j8
         tmXGaD+vF1O7gLVAopM8OOaUF5K+XDqccopqx2eHwOCcTQNL9fNul9KwoUahIZwfAoCi
         eIj6fSCUoPjx8DZL5aXwGUAlN6Isnb/ftsvOLi15n96Hpu540LP7cFD28JfZtto6RFE7
         ng0e7Ytuypf5s216ljqXw58rKiiUBoKxtp310dlswB3126XCqM3ctUJBFUrS6uJsm5rp
         KskIsfKezmrb2kWPympXp4gNHvlIB2E3SltnJGWB/yB+TiJnXOWeLbeuZMvjuWFpZQSG
         K63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H14SKziskvi0fDy74D291MDC23rTB7aIJmAsEUUk8wk=;
        b=BQ2s+jxvMBula+z+EizC/o9L8uwTG4R19KHvPRc47YzLMVYYyS3EYJ/kXqwAVB2gUj
         NZF/ppFDJf6irWgzaJUgUsyhZSlY6X9n7Szc/ljKMiaZviTJTxEivGvRk8ZDjou6aa9R
         3FMe9BCNQAfkbRzSQ1o3wVQFjmtgQDMGPdXs/BlwnuHUFw7+UazLLSjFlHlJbjD2d0ma
         5KP+AgOwnyu6BBZFzrOCCqkgZjxGZLRbisJSuJBz2y15qHn+deUZX/z/iZFxqazRdINg
         80LZzghnwYqfyYxUoh4syr/gnq6DdoXRPWJ/V5pNc75nPKoHpyHYqN6e2a8uUaT7gNAI
         Gqew==
X-Gm-Message-State: AOAM531WCUzgrOs/if6BgVCIFmGkZ9hxCWzqdzM6qIoczCZJ7PnXWERG
        xyrHhOYvrW8aCfPIiaWrLx47/FniS+k5vXUqn4zsqs6iPlioM5D8/evGNynFzZFSiw8SxHgPqvA
        6RdHiqROZodA3WM6k75Z/pCHTq7hCdPcf/WVH0V9LogW+MRq8x9mGyOKyEcXAd51O2qNKzyzMxW
        Rj
X-Google-Smtp-Source: ABdhPJz7IV5mgVMMRJ8rjZY+COZlldsQGSfLlh7M6kvJ4AvhSmTdQGnRpY9OwUqBPbsGaCUVy687Vmq6BQ/s2IE+Giaf
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:730b:: with SMTP id
 o11mr34889344ybc.415.1614021618748; Mon, 22 Feb 2021 11:20:18 -0800 (PST)
Date:   Mon, 22 Feb 2021 11:20:08 -0800
In-Reply-To: <cover.1614021092.git.jonathantanmy@google.com>
Message-Id: <aa873354649b73c83544399a92dc8d8ecc489e44.1614021093.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1614021092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 3/4] fetch-pack: with packfile URIs, use index-pack arg
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unify the index-pack arguments used when processing the inline pack and
when downloading packfiles referenced by URIs. This is done by teaching
get_pack() to also store the index-pack arguments whenever at least one
packfile URI is given, and then when processing the packfile URI(s),
using the stored arguments.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index aeac010b0b..dd0a6c4b34 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -797,12 +797,13 @@ static void write_promisor_file(const char *keep_name,
 }
 
 /*
- * Pass 1 as "only_packfile" if the pack received is the only pack in this
- * fetch request (that is, if there were no packfile URIs provided).
+ * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
+ * The strings to pass as the --index-pack-arg arguments to http-fetch will be
+ * stored there. (It must be freed by the caller.)
  */
 static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], struct string_list *pack_lockfiles,
-		    int only_packfile,
+		    struct strvec *index_pack_args,
 		    struct ref **sought, int nr_sought)
 {
 	struct async demux;
@@ -845,7 +846,7 @@ static int get_pack(struct fetch_pack_args *args,
 		strvec_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (do_keep || args->from_promisor) {
+	if (do_keep || args->from_promisor || index_pack_args) {
 		if (pack_lockfiles)
 			cmd.out = -1;
 		cmd_name = "index-pack";
@@ -863,7 +864,7 @@ static int get_pack(struct fetch_pack_args *args,
 				     "--keep=fetch-pack %"PRIuMAX " on %s",
 				     (uintmax_t)getpid(), hostname);
 		}
-		if (only_packfile && args->check_self_contained_and_connected)
+		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
 			/*
@@ -901,7 +902,7 @@ static int get_pack(struct fetch_pack_args *args,
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
 	    : 0) {
-		if (args->from_promisor || !only_packfile)
+		if (args->from_promisor || index_pack_args)
 			/*
 			 * We cannot use --strict in index-pack because it
 			 * checks both broken objects and links, but we only
@@ -913,6 +914,13 @@ static int get_pack(struct fetch_pack_args *args,
 				     fsck_msg_types.buf);
 	}
 
+	if (index_pack_args) {
+		int i;
+
+		for (i = 0; i < cmd.args.nr; i++)
+			strvec_push(index_pack_args, cmd.args.v[i]);
+	}
+
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
@@ -1084,7 +1092,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfiles, 1, sought, nr_sought))
+	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1535,6 +1543,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int seen_ack = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
+	struct strvec index_pack_args = STRVEC_INIT;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1624,7 +1633,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_packfile_uris(&reader, &packfile_uris);
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfiles,
-				     !packfile_uris.nr, sought, nr_sought))
+				     packfile_uris.nr ? &index_pack_args : NULL,
+				     sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args, &reader);
 
@@ -1636,6 +1646,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	}
 
 	for (i = 0; i < packfile_uris.nr; i++) {
+		int j;
 		struct child_process cmd = CHILD_PROCESS_INIT;
 		char packname[GIT_MAX_HEXSZ + 1];
 		const char *uri = packfile_uris.items[i].string +
@@ -1645,9 +1656,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
 			     packfile_uris.items[i].string);
-		strvec_push(&cmd.args, "--index-pack-arg=index-pack");
-		strvec_push(&cmd.args, "--index-pack-arg=--stdin");
-		strvec_push(&cmd.args, "--index-pack-arg=--keep");
+		for (j = 0; j < index_pack_args.nr; j++)
+			strvec_pushf(&cmd.args, "--index-pack-arg=%s",
+				     index_pack_args.v[j]);
 		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
@@ -1683,6 +1694,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 packname));
 	}
 	string_list_clear(&packfile_uris, 0);
+	strvec_clear(&index_pack_args);
 
 	if (negotiator)
 		negotiator->release(negotiator);
-- 
2.30.0.617.g56c4b15f3c-goog

