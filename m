Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02891F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeFFUrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41641 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeFFUrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so3572011pgl.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3Jr6vhAbpJ7m6oej2zefNmLWIrJR7sdSDXstnVH56M=;
        b=GoKXa69aKWJtieE7uuQHjI7dyWvPB9HiHql9xKHc8tvhPmBZL64LhTmu9sRBImm2eM
         v3o8wyvtGwOpLs6la0yyLSXL2eeoPMBZ8Tb3meheLuCKz02gPVtzn5s1Mer6FAUkDFji
         blzGCI9aTTjwllwK1DaBvSJEdL//gTS0nnDQrO7m4md7krUxnwDVFJFKYCkzqZ1s5TyP
         2k0HmmQMRkzzMHHr29UXMR0HC3vZfYgTc42zGW9LETwrNzLvmy0cRwRuOIK7fgKeDjss
         /QU/AV0a/t18ejpUZ1v70YbfIF3YphvEOXRVhu3A1wgAcer3/oIOriUk74URIQZ4exx+
         R6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q3Jr6vhAbpJ7m6oej2zefNmLWIrJR7sdSDXstnVH56M=;
        b=OqSBwvMJb+DlPCmsdqJA+bQz9ZsCWWZpnn4Lvb3ID8wOR8MtjeUcWl0IeP7TTDm2vB
         s+oYBcXSCXH6Ty2StGgGIioK1oenJd9UmvocfWV2TyDijwxLfaTdGgxKhb/Bovt6PAwu
         2lShRu5gwcQt5TwmUODwtHwTv2nD0PorphLIdawfauZor4LK9hYRCGUdVJ9RZ9QGDC2Z
         X77JFRQq3X7XILKCcXQ/1a8HEbpXv9JqGtVRR1FSCGBsjW5o2EOBgHef6cnE9Lq5zu1a
         VvU0GSUnGdthX1QuzHTsRU07679PKW+bYMlEapW1tnvxVaXYpxWHMPWWAcfVKACfYO/X
         XNgw==
X-Gm-Message-State: APt69E0Z1Cl2sM+dI8obmBUPm3BvAR+8lC8ThyeY5xcgSYEKrfSlcvPe
        voAKw9vU8Vm9FVl7YU0vdiNfbrx4Hco=
X-Google-Smtp-Source: ADUXVKL8lqAlZ7ChpNBC4Zi9APdaxZGPH6/HVWn65HacWljyTCnJfiC4Pb/48De8CoQSHWW//ZRM1A==
X-Received: by 2002:a65:5c02:: with SMTP id u2-v6mr3821313pgr.304.1528318042225;
        Wed, 06 Jun 2018 13:47:22 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 1/8] fetch-pack: split up everything_local()
Date:   Wed,  6 Jun 2018 13:47:07 -0700
Message-Id: <5687c0b22bf3b2bdbbe29b09788cc305a89710fc.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function everything_local(), despite its name, also (1) marks
commits as COMPLETE and COMMON_REF and (2) invokes filter_refs() as
important side effects. Extract (1) into its own function
(mark_complete_and_common_ref()) and remove
(2).

The restoring of save_commit_buffer, which was introduced in a1c6d7c1a7
("fetch-pack: restore save_commit_buffer after use", 2017-12-08), is a
concern of the parse_object() call in mark_complete_and_common_ref(), so
it has been moved from the end of everything_local() to the end of
mark_complete_and_common_ref().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a320ce987..5c87bb8bb 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -734,12 +734,20 @@ static int add_loose_objects_to_set(const struct object_id *oid,
 	return 0;
 }
 
-static int everything_local(struct fetch_pack_args *args,
-			    struct ref **refs,
-			    struct ref **sought, int nr_sought)
+/*
+ * Mark recent commits available locally and reachable from a local ref as
+ * COMPLETE. If args->no_dependents is false, also mark COMPLETE remote refs as
+ * COMMON_REF (otherwise, we are not planning to participate in negotiation, and
+ * thus do not need COMMON_REF marks).
+ *
+ * The cutoff time for recency is determined by this heuristic: it is the
+ * earliest commit time of the objects in refs that are commits and that we know
+ * the commit time of.
+ */
+static void mark_complete_and_common_ref(struct fetch_pack_args *args,
+					 struct ref **refs)
 {
 	struct ref *ref;
-	int retval;
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 	struct oidset loose_oid_set = OIDSET_INIT;
@@ -812,7 +820,18 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
-	filter_refs(args, refs, sought, nr_sought);
+	save_commit_buffer = old_save_commit_buffer;
+}
+
+/*
+ * Returns 1 if every object pointed to by the given remote refs is available
+ * locally and reachable from a local ref, and 0 otherwise.
+ */
+static int everything_local(struct fetch_pack_args *args,
+			    struct ref **refs)
+{
+	struct ref *ref;
+	int retval;
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const struct object_id *remote = &ref->old_oid;
@@ -829,8 +848,6 @@ static int everything_local(struct fetch_pack_args *args,
 			      ref->name);
 	}
 
-	save_commit_buffer = old_save_commit_buffer;
-
 	return retval;
 }
 
@@ -1053,7 +1070,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	if (everything_local(args, &ref, sought, nr_sought)) {
+	mark_complete_and_common_ref(args, &ref);
+	filter_refs(args, &ref, sought, nr_sought);
+	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1377,7 +1396,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			for_each_cached_alternate(insert_one_alternate_object);
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			if (everything_local(args, &ref, sought, nr_sought))
+			mark_complete_and_common_ref(args, &ref);
+			filter_refs(args, &ref, sought, nr_sought);
+			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
-- 
2.17.0.768.g1526ddbba1.dirty

