Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F393E1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933640AbeFTVdA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:33:00 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:38952 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933629AbeFTVc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:32:56 -0400
Received: by mail-qt0-f202.google.com with SMTP id c1-v6so809523qtj.6
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=YJOqG3KZ5i3oJd6zc9StAqyjtzCf9pSHCPbroQvRdoY=;
        b=LoQcXWMHgFezetLjTn5Wv6u2SB/UvE9FRUoZKiNb94k254nZ2N5hNbEwQuT/N/3T2Q
         5u/8R8Jd1js74ylyNQIPO++tSAzJMryMNbh/OyIR1F+YfEmuIZRNtibEfrN4CyVNqMHD
         xyC1ZgoxWs8fCfRd2Fz8lyPqNQhASkPT8gnKbDmkSrMSia+S1qJn8D0KdIFWQospQ5FG
         Veik5JEEYwo34uIYjdbU/b4BsFNRYE4joAms944dyFET8o+0SOk69C4cDxdFXFOvEsjb
         swuCq9XKr+ztHAT5YHXFd7P/Qk7Fa5MuA+8jaDltEVllxatBL1ziPjZlrEXxArd8LMva
         LYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=YJOqG3KZ5i3oJd6zc9StAqyjtzCf9pSHCPbroQvRdoY=;
        b=et8sKtx835ov8CYQsumgbdirakaifFNEn8fepdZM7Xz+3YCJ53SwCENmM1xVSGxEUb
         Ck9oGtqgv1X4Uq9WkBwzPeNASwA/1Npk5B3ASyWPiFq7HyXAQaOlCVaa3qq1u9g5WsP7
         CNskiOJy7sp4J0V/GVxTCYZhaatIezXv/9TOrcEQ22d88FbpIiNegPSle+u6oxz+0TV/
         xF9u2tVX304H71CB1kAHv6F8Dge5m8dkuiB/o0DQ0kTMAQjkqZGRT6NdOSDVT56PLg/T
         OCvpHLNWOvL+4Y/od43xQtq/jUumPinu7RXGnvAFR56Eo1uFkSfI9DD5aL/zCyncqv33
         r8Hg==
X-Gm-Message-State: APt69E3cGrBe+ETvqT5984ubCAQt0eSk8YwaQgiZT3NchNAjMcBShg+X
        Lqi9xp45N1Q/MsWv6zSMveW1cIqTvD2mAK5DTEfXHmM/g2O2GMzBKyoXb/kE1FfVze7JV03r/O6
        IV/DlMNzY6nV+sZk0I8MqeXm2x5puZ3Jk7+1XL3xZSdW911tFqpYuHca/vw==
X-Google-Smtp-Source: ADUXVKK1INhqMG0qS6F3Pu+i38abQNTDtdHhQ/MRLuG0e7lRH/amSYDxqaqs26uGbIaykDpmcUF/DfEADnk=
MIME-Version: 1.0
X-Received: by 2002:a37:1f27:: with SMTP id f39-v6mr12608722qkf.19.1529530375739;
 Wed, 20 Jun 2018 14:32:55 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:33 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180620213235.10952-7-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com> <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 6/8] fetch: refactor to make function args narrower
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor find_non_local_tags and get_ref_map to only take the
information they need instead of the entire transport struct. Besides
improving code clarity, this also improves their flexibility, allowing
for a different set of refs to be used instead of relying on the ones
stored in the transport struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ee8b87c78..b600e1f10 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -254,9 +254,9 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
-static void find_non_local_tags(struct transport *transport,
-			struct ref **head,
-			struct ref ***tail)
+static void find_non_local_tags(const struct ref *refs,
+				struct ref **head,
+				struct ref ***tail)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
@@ -264,7 +264,7 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport, NULL); ref; ref = ref->next) {
+	for (ref = refs; ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
 
@@ -338,7 +338,8 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&remote_refs, 0);
 }
 
-static struct ref *get_ref_map(struct transport *transport,
+static struct ref *get_ref_map(struct remote *remote,
+			       const struct ref *remote_refs,
 			       struct refspec *rs,
 			       int tags, int *autotags)
 {
@@ -346,27 +347,11 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
-	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
-	const struct ref *remote_refs;
-
-	if (rs->nr)
-		refspec_ref_prefixes(rs, &ref_prefixes);
-	else if (transport->remote && transport->remote->fetch.nr)
-		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
-
-	if (ref_prefixes.argc &&
-	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
-		argv_array_push(&ref_prefixes, "refs/tags/");
-	}
-
-	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
-
-	argv_array_clear(&ref_prefixes);
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
@@ -403,7 +388,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		if (refmap.nr)
 			fetch_refspec = &refmap;
 		else
-			fetch_refspec = &transport->remote->fetch;
+			fetch_refspec = &remote->fetch;
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
@@ -411,7 +396,6 @@ static struct ref *get_ref_map(struct transport *transport,
 		die("--refmap option is only meaningful with command-line refspec(s).");
 	} else {
 		/* Use the defaults */
-		struct remote *remote = transport->remote;
 		struct branch *branch = branch_get(NULL);
 		int has_merge = branch_has_merge_config(branch);
 		if (remote &&
@@ -450,7 +434,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	else if (tags == TAGS_DEFAULT && *autotags)
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 
 	/* Now append any refs to be updated opportunistically: */
 	*tail = orefs;
@@ -1137,6 +1121,8 @@ static int do_fetch(struct transport *transport,
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
+	const struct ref *remote_refs;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1152,7 +1138,21 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	ref_map = get_ref_map(transport, rs, tags, &autotags);
+	if (rs->nr)
+		refspec_ref_prefixes(rs, &ref_prefixes);
+	else if (transport->remote && transport->remote->fetch.nr)
+		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
+
+	if (ref_prefixes.argc &&
+	    (tags == TAGS_SET || (tags == TAGS_DEFAULT && !rs->nr))) {
+		argv_array_push(&ref_prefixes, "refs/tags/");
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+	argv_array_clear(&ref_prefixes);
+
+	ref_map = get_ref_map(transport->remote, remote_refs, rs,
+			      tags, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -1184,7 +1184,7 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_DEFAULT && autotags) {
 		struct ref **tail = &ref_map;
 		ref_map = NULL;
-		find_non_local_tags(transport, &ref_map, &tail);
+		find_non_local_tags(remote_refs, &ref_map, &tail);
 		if (ref_map)
 			backfill_tags(transport, ref_map);
 		free_refs(ref_map);
-- 
2.18.0.rc1.244.gcf134e6275-goog

