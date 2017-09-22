Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95CA3202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 23:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdIVXf2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 19:35:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35184 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdIVXf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 19:35:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id n64so1321746wrb.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nO/zoGGeyeLgxL0nsYu12ep1qBhsXtZYBdPrGbhhZpc=;
        b=XmsbseybieklZY+uwcFMukx3zF6o8F/yEfXDOJTM8X7GVuzF9G6iNj3fwt7PYTzDWh
         PxhYRhDPEBXrgoUJT+PZvXtvMOnHEqX8hxqqDNdESgHuPUdqBwWg6UKfZmI5yNbNBm5t
         s5XHMsojVgNthCFyEnHU+Zo8WMjWz/HFdmvyR8nopUaFMY82fOD/g9qxnOJHdRtl5PW1
         uJzFPzl8Mc9kJWG1FyGtp4dwqJ8GW6zpXTJON/4W/JIvIxrCFUWf8BELhZyfRSCu4Tn4
         4uTkoX0LiGDOKPAR28o36O+8B0Qn9eDk/sdYp3R+UMRzkawS0FUyqcKf9N/8XcfiPCtk
         lJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nO/zoGGeyeLgxL0nsYu12ep1qBhsXtZYBdPrGbhhZpc=;
        b=ov1cEqiG5N9YRiHkkNxYIFrk/3mKs3j2W4L6tGQ4mHykksXY5Qr8uflqKVU+dXK7zC
         W/H61p7DTEzv4fZO0nUArl2YRHpyq0zJKq4aKkqfGm7ZqXrWZY4MBY3t4Mnm0lPr8x9i
         qAK3Dscsx9gMlAef2ouAot1gXZgYzZLU+tn4/WR+sH60xUCyUSsHwHJlsNhDjct7Oa6G
         ANVm2Gvo5XVmuf9gytXHY2juC5WrjiOElnLOyeXbKR5qXFLhILOYtAKRQ7hJVG6WQV1j
         5lpovdu2RLidhJUprlR92GSDdja6LVJFRhVRHuGAmplZ9fwQ4e+2Xiaw2w9toxW2tn4u
         c4qA==
X-Gm-Message-State: AHPjjUjXHIXfcYzN5Pdr2b124w9THOkGR3TQ41775YYPqGov4+8f9iv+
        oLFSsP0Rpkbmpqh3bM4QDheeDg==
X-Google-Smtp-Source: AOwi7QAIlrCeEbYs9364PItWTkJIYLYffvwta7teb7LB34ZuMOiE3F0VwyN0pcx408pNPngKYuE9cw==
X-Received: by 10.223.159.11 with SMTP id l11mr505640wrf.148.1506123325132;
        Fri, 22 Sep 2017 16:35:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id e77sm2071333wmf.27.2017.09.22.16.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 16:35:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 3/6] leak_pending: use `object_array_clear()`, not `free()`
Date:   Sat, 23 Sep 2017 01:34:51 +0200
Message-Id: <d4df674923b0dbc5c2e232cdc56a75205653d275.1506120292.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net> <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting `leak_pending = 1` tells `prepare_revision_walk()` not to
release the `pending` array, and makes that the caller's responsibility.
See 4a43d374f (revision: add leak_pending flag, 2011-10-01) and
353f5657a (bisect: use leak_pending flag, 2011-10-01).

Commit 1da1e07c8 (clean up name allocation in prepare_revision_walk,
2014-10-15) fixed a memory leak in `prepare_revision_walk()` by
switching from `free()` to `object_array_clear()`. However, where we use
the `leak_pending`-mechanism, we're still only calling `free()`.

Use `object_array_clear()` instead. Copy some helpful comments from
353f5657a to the other callers that we update to clarify the memory
responsibilities, and to highlight that the commits are not affected
when we clear the array -- it is indeed correct to both tidy up the
commit flags and clear the object array.

Document `leak_pending` in revision.h to help future users get this
right.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.c           |  3 ++-
 builtin/checkout.c |  9 ++++++++-
 bundle.c           |  9 ++++++++-
 revision.h         | 11 +++++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index a9fd9fbc6..fc797f6ae 100644
--- a/bisect.c
+++ b/bisect.c
@@ -826,7 +826,8 @@ static int check_ancestors(const char *prefix)
 
 	/* Clean up objects used, as they will be reused. */
 	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
-	free(pending_copy.objects);
+
+	object_array_clear(&pending_copy);
 
 	return res;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d75ac66c..52f1b6770 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -796,9 +796,14 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	for_each_ref(add_pending_uninteresting_ref, &revs);
 	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
 
+	/* Save pending objects, so they can be cleaned up later. */
 	refs = revs.pending;
 	revs.leak_pending = 1;
 
+	/*
+	 * prepare_revision_walk (together with .leak_pending = 1) makes us
+	 * the sole owner of the list of pending objects.
+	 */
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(old->object.flags & UNINTERESTING))
@@ -806,8 +811,10 @@ static void orphaned_commit_warning(struct commit *old, struct commit *new)
 	else
 		describe_detached_head(_("Previous HEAD position was"), old);
 
+	/* Clean up objects used, as they will be reused. */
 	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
-	free(refs.objects);
+
+	object_array_clear(&refs);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/bundle.c b/bundle.c
index d15db03c8..c092d5d68 100644
--- a/bundle.c
+++ b/bundle.c
@@ -157,9 +157,14 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
+	/* Save pending objects, so they can be cleaned up later. */
 	refs = revs.pending;
 	revs.leak_pending = 1;
 
+	/*
+	 * prepare_revision_walk (together with .leak_pending = 1) makes us
+	 * the sole owner of the list of pending objects.
+	 */
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
@@ -176,8 +181,10 @@ int verify_bundle(struct bundle_header *header, int verbose)
 				refs.objects[i].name);
 		}
 
+	/* Clean up objects used, as they will be reused. */
 	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
-	free(refs.objects);
+
+	object_array_clear(&refs);
 
 	if (verbose) {
 		struct ref_list *r;
diff --git a/revision.h b/revision.h
index bc18487d6..3162cc78e 100644
--- a/revision.h
+++ b/revision.h
@@ -149,6 +149,17 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
+	/*
+	 * Set `leak_pending` to prevent `prepare_revision_walk()` from clearing
+	 * the array of pending objects (`pending`). It will still forget about
+	 * the array and its entries, so they really are leaked. This can be
+	 * useful if the `struct object_array` `pending` is copied before
+	 * calling `prepare_revision_walk()`. By setting `leak_pending`, you
+	 * effectively claim ownership of the old array, so you should most
+	 * likely call `object_array_clear(&pending_copy)` once you are done.
+	 * Observe that this is about ownership of the array and its entries,
+	 * not the commits referenced by those entries.
+	 */
 	unsigned int	leak_pending:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
-- 
2.14.1.727.g9ddaf86

