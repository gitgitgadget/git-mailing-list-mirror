Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0A3C433E6
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2280222CA0
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 02:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbhAXCfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAXCfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 21:35:21 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4038C06178B
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id w22so5273686pll.6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 18:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L5G3YxsqDIJmFyDCs25WvIUAb2GYtYzYmGV7CT5cWmg=;
        b=Cxq9uWe2fU8ZWzCM0YN1ya2BgwM/+I0xymnvqUccS3XzYUcT+iEVDIurK0HXK/HJXq
         I/dkZ4dSbYIicDi3DlnKSyoNkJgmMHP/hxN+U1KvUYXcuUzKx2caE3Qfo3p8z8/0LPqO
         MLLagggXnTfQl40OC6rjgA1NL2CoXa1Kya5cPkia9JoOvITu6JjcxoLOGA0rxs5pTn/t
         obzQCZtSQXmUlp72Pi5fkrCqo+fuykuNuIwp1XxvxHk+b7rgxi3vWQ/ZO7iYo/Qi2iKr
         vo95jOjDFeeaGxgfScFPSYXAcZJz6La8I8e5Ap+kFHqpe0gvlb+3y2ndbsJ8cA3FlWWj
         uENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L5G3YxsqDIJmFyDCs25WvIUAb2GYtYzYmGV7CT5cWmg=;
        b=s7d4a1pm5XPuF4K+x1GUya6RIYPqQ19bSN1kd4L6SVzWc7kHeoHUwLUGFWRnbOxi4A
         iNTRG9RgTOf8XFFYs+mThz5jDh6Fn5d8YBn8BishBzy6CBI0DBrGYis+0fvq+4bxGZr0
         eTXHefKtj8mVjXVcFE9R4dSAlmgwdNMQrkqu1DFIxiHrCNfCJ1/3wk/yqbwz085/MwBd
         ut19q4BwqBnNF3EoA5RzGD8wqB0TCw3d5yID2g/7XltluhIGR69DilXscXg8E/7WN3Tv
         GTummqT8cCChPzhtdwkAnrNoAW3t0K8PBnWzbpB/TbVKeBDNwXVOk+fjN0odR0TlZjiS
         YCmA==
X-Gm-Message-State: AOAM53102V6lFrK9tjqbaPkgCBntUItb/0ilTIQLcjwQPqWw72QQrBmL
        UlSeSrI00qcpajupr7lhnp2iTlzhnJUXcV9Id4IhRIE8Yp+9NL+4oqrTsnVTqtIoJyexXQbGdu3
        joLYc++CvD0aB2oApfP9hOOpaTsPmaCzRg1pNU0QNIrXbJxjDrxfsfYUm2SZNM+R7Hlwc/ylkEm
        L4
X-Google-Smtp-Source: ABdhPJyp2H3rN2TNzR5qQItcy/LjR1K0RC0yApU7keGoyTEqg7WXqE0TV6PeVyD8aM2jAYx5bU70xsTN9LIHEROziEpb
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr1562530pjn.1.1611455680023; Sat, 23 Jan 2021 18:34:40 -0800 (PST)
Date:   Sat, 23 Jan 2021 18:34:29 -0800
In-Reply-To: <cover.1611455251.git.jonathantanmy@google.com>
Message-Id: <c985fc598240cb9566345cf71bb353508f525469.1611455251.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210115234300.350442-1-jonathantanmy@google.com> <cover.1611455251.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 3/4] fetch-pack: with packfile URIs, use index-pack arg
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
---
 fetch-pack.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 274ae602f7..fe69635eb5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -797,12 +797,13 @@ static void write_promisor_file(const char *keep_name,
 }
 
 /*
- * Pass 1 as "only_packfile" if the pack received is the only pack in this
- * fetch request (that is, if there were no packfile URIs provided).
+ * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
+ * The string to pass as the --index-pack-args argument to http-fetch will be
+ * stored there. (It must be freed by the caller.)
  */
 static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], struct string_list *pack_lockfiles,
-		    int only_packfile,
+		    char **index_pack_args,
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
@@ -913,6 +914,19 @@ static int get_pack(struct fetch_pack_args *args,
 				     fsck_msg_types.buf);
 	}
 
+	if (index_pack_args) {
+		struct strbuf joined = STRBUF_INIT;
+		int i;
+
+		for (i = 0; i < cmd.args.nr; i++) {
+			if (i)
+				strbuf_addch(&joined, ' ');
+			strbuf_addstr_urlencode(&joined, cmd.args.v[i],
+						is_rfc3986_unreserved);
+		}
+		*index_pack_args = strbuf_detach(&joined, NULL);
+	}
+
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
@@ -1084,7 +1098,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		alternate_shallow_file = setup_temporary_shallow(si->shallow);
 	else
 		alternate_shallow_file = NULL;
-	if (get_pack(args, fd, pack_lockfiles, 1, sought, nr_sought))
+	if (get_pack(args, fd, pack_lockfiles, NULL, sought, nr_sought))
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
@@ -1535,6 +1549,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int seen_ack = 0;
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
+	char *index_pack_args = NULL;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
@@ -1624,7 +1639,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				receive_packfile_uris(&reader, &packfile_uris);
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfiles,
-				     !packfile_uris.nr, sought, nr_sought))
+				     packfile_uris.nr ? &index_pack_args : NULL,
+				     sought, nr_sought))
 				die(_("git fetch-pack: fetch failed."));
 			do_check_stateless_delimiter(args, &reader);
 
@@ -1645,7 +1661,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		strvec_pushf(&cmd.args, "--packfile=%.*s",
 			     (int) the_hash_algo->hexsz,
 			     packfile_uris.items[i].string);
-		strvec_push(&cmd.args, "--index-pack-args=index-pack --stdin --keep");
+		strvec_pushf(&cmd.args, "--index-pack-args=%s", index_pack_args);
 		strvec_push(&cmd.args, uri);
 		cmd.git_cmd = 1;
 		cmd.no_stdin = 1;
@@ -1681,6 +1697,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						 packname));
 	}
 	string_list_clear(&packfile_uris, 0);
+	FREE_AND_NULL(index_pack_args);
 
 	if (negotiator)
 		negotiator->release(negotiator);
-- 
2.30.0.280.ga3ce27912f-goog

