Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF761F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJXGXL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:23:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42481 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXGXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:23:10 -0400
Received: by mail-qt1-f201.google.com with SMTP id j17-v6so3470088qtp.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HRewR4F/cbN3qOxkxkC8NBuKv9Q+EgZsSyix8BLFWpM=;
        b=sbXu0CyDUeBbKk3mERbcy/ndQUcJwmFDvA5pF+gwW3UYpabsjymaL2hCH9hptmQaGl
         igZ7zk9GNu6GrZnv0mnH9zY8FolxajXh+lDShC+BCSBWiGe3azXiRWukQG9tByciNJY7
         Nc5Ne7qqFTZ/4L+mpMnM3F3PJGqpVRBZ8tyOZzr0mKk2vCuQ1UF8FGpCjYt0+9A1e57P
         iwPmcc1uSG5xyzJzYhrVHjWhIS/uVsDuGs9GQRLZ5TcVnn0IT+jBUwtut1yXmPgvGgSE
         TrQC4f1MvN0SRKFZpl/z/sAx1l5a5qJAbSCFNUHqqZ/FYTxBksR+VhBWgqUreQL9btXv
         FDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HRewR4F/cbN3qOxkxkC8NBuKv9Q+EgZsSyix8BLFWpM=;
        b=jtIWbCa0WyB+CM1jhcumIZYKPw1l/J1RXF+OkwUlLn47GcVS4woZsdwmPhxpkQmo9E
         tBBEBcevAcY3DttUMQVHSID5gr6yC14vwjTzB8gmYk+Q1oo2ZmVwcyttcYKd9TpV8Uwp
         LTux+44tMEbnK5CTfIHzEZLC76xlrZGg3NNPrrrdRvpSG/J+5XxEFmGcB7lfIarUFcaa
         m+Pzuh8CpHDwtgZip8dnX/KrcQiqTGXqDe4L5MTSJwQIS7/7MuPqwZyM3bKKtGil6dxC
         XndRno2rlxGHQCo4HKS/HhzZRuQB9IRYbTlwVSYx2pL/4p6uC0MRS/Y46HC9dnYx6i5R
         +22Q==
X-Gm-Message-State: AGRZ1gL1R4nHwrkczKCU+wfs1/sfeD8YgSpUSypsm1FrN9pOgXxqXFa1
        N+DqmxMYiBfRlO0msCwPw5Ev8eoRDIUdNKcQ5mRy/7L0P2FvqMtX6GRhTqASJi923Khl+u1IMOc
        DODGIjT3OeVBBnQ1Nyhinsm7KELFwasAmxQvDUZaxBhsyRrf/hwJ+kmZeY7w=
X-Google-Smtp-Source: AJdET5cVg41REbNpEHgGJgsaWvsNxENJZVLMUABxlSWChEYyidlA5E2bcgDRTMT/UDRQgN5SGjz7SgtprrOA
X-Received: by 2002:aed:227a:: with SMTP id o55-v6mr25359qtc.15.1540331873477;
 Tue, 23 Oct 2018 14:57:53 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:57:45 -0700
Message-Id: <20181023215745.245333-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] revision.c: drop missing objects from cmdline
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, gitster@pobox.com,
        jonathantanmy@google.com, jeffhost@microsoft.com,
        ramsay@ramsayjones.plus.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No code which reads cmdline in struct rev_info can handle NULL objects
in cmdline.rev[i].item, so stop adding them to the cmdline.rev array.
Objects in cmdline are NULL when the given object is promisor and
--exclude-promisor-objects is enabled.

This new behavior avoids a segmentation fault in the added test case in
t0410.

We could simply die if add_rev_cmdline is called with a NULL item,
(rather than warn if --exclude-promisor-objects is set) but because the
amended test case already expects the command to finish successfully,
difference and show a warning. Note that this command:

	git rev-list --objects --missing=print $missing_hash

Already fails with a "fatal: bad object HASH" message and this patch
does not change that.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 revision.c               | 12 ++++++++++++
 t/t0410-partial-clone.sh | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a1ddb9e11c..8724dca2e2 100644
--- a/revision.c
+++ b/revision.c
@@ -1148,6 +1148,18 @@ static void add_rev_cmdline(struct rev_info *revs,
 			    int whence,
 			    unsigned flags)
 {
+	if (!item) {
+		/*
+		 * item is likely a promisor object returned from get_reference.
+		 */
+		if (revs->exclude_promisor_objects) {
+			warning(_("ignoring missing object %s"), name);
+			return;
+		} else {
+			die(_("missing object %s"), name);
+		}
+	}
+
 	struct rev_cmdline_info *info = &revs->cmdline;
 	unsigned int nr = info->nr;
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..e02cd3f818 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -366,7 +366,16 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+
+	printf "warning: ignoring missing object %s\n" \
+	       "$COMMIT" "$TREE" "$BLOB" >expect &&
+	git -C repo rev-list --objects \
+		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB" 2>actual &&
+	test_cmp expect actual &&
+
+	git -C repo rev-list --objects-edge-aggressive \
+		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB" 2>actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
-- 
2.19.1.568.g152ad8e336-goog

