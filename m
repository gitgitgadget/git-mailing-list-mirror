Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5DF1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJZI2A (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:28:00 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45640 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeJZI2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:28:00 -0400
Received: by mail-pf1-f202.google.com with SMTP id n9-v6so2942979pfg.12
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JeH/UcJKwUtCnULmbSC1yPpHdzftiQA9Mnym+PkMwSg=;
        b=LR9ZghLR5TXKKXe4wJOpCp8JzAt38BsUc9NAwhgEKHErbFGnqiftaPh0GWN2XRtJnw
         BobihVxvVzka1Z7Vm8R8Fw6w2RfrxeuHLUulDc0P/sV70XYehkNhK7puZBRosYbRxKVQ
         pWU6IG5k/ve5Mq+j3BZcAY7AI5UM2heaLTHB8WBaZb8bgAfC2PCJo9E0q6iqGGHPr8yi
         UDD4zjqCIrTyd7B+0IP0r5g/V9jpiMelTrgxHxCRZZr8AMwii/BWfH/ri60hnTQDD2C0
         ihmdsK0WmVfS4XEY8a20roImtfEqyWy/EFvu0FrbFsZrvmu/p2CSBIHNlsRCTSAwwLqw
         Ilbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JeH/UcJKwUtCnULmbSC1yPpHdzftiQA9Mnym+PkMwSg=;
        b=jpZyyFxkj4q6NsPit4efsLXU/JK5F67w71ftzBzo0d9tPBny3P3Hvw7rnwgXB67WRQ
         vvCzC+MQwkl+PJHUrNGszFqcC3f1GcMgLiPtO3Uu8hj4sYhTPmvOyVd1a3KWRtqVK/Nm
         vmixbjXz/FWmtSd/NkFlcMr+L9C7NVSNDqiPeROX6BfVnLaRvSAdChDIIzG95rVAfKKn
         npU9oYsVNFr0PhdmNnmIo/lUjyDv6QZmp3ctXkLHUoq9VR/nxK4hsttYS/BquHmE2SIj
         iwRgMHQefrJKEssBE9ir2GMQFgTmC2jz123RFzMeY8Mav+kOFrpRH39L7e6wn6mZo4k5
         iptQ==
X-Gm-Message-State: AGRZ1gLhpabeS/Owf6mL5sUrg1kzWVVmOEVVQp2V0AvhpjBdCrVuSxYc
        y3gLZ25mPbQXJtXlVTs5uPGYQfgaLXBexpGMhKj37vUddJsinUy9Pj5ngTk6/8wgfaLD9XIiz6w
        MUdIX6UxMCxaGNHMnLxkGFP326WVHvEydX4mWBO5tlvjJmDzES5Qj/CU9cUA=
X-Google-Smtp-Source: AJdET5fxbjLnrmZ84FQmhcg11FZHA3BHukN1PaUiRYeoP/UdKTvlT8yrYsm++WltCTFdIVUVndN+mSSI1RMR
X-Received: by 2002:a63:1106:: with SMTP id g6-v6mr853497pgl.58.1540511598775;
 Thu, 25 Oct 2018 16:53:18 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:53:14 -0700
In-Reply-To: <20181023215745.245333-1-matvore@google.com>
Message-Id: <20181025235314.63495-1-matvore@google.com>
Mime-Version: 1.0
References: <20181023215745.245333-1-matvore@google.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] list-objects.c: don't segfault for missing cmdline objects
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

When a command is invoked with both --exclude-promisor-objects,
--objects-edge-aggressive, and a missing object on the command line,
the rev_info.cmdline array could get a NULL pointer for the value of
an 'item' field. Prevent dereferencing of a NULL pointer in that
situation.

There are a few other places in the code where rev_info.cmdline is read
and the code doesn't handle NULL objects, but I couldn't prove to myself
that any of them needed to change except this one (since it may not
actually be possible to reach the other code paths with
rev_info.cmdline[] set to NULL).

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects.c           | 3 ++-
 t/t0410-partial-clone.sh | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..27ed2c6cab 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -245,7 +245,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
 		for (i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
 			struct commit *commit = (struct commit *)obj;
-			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
+			if (!obj || obj->type != OBJ_COMMIT ||
+			    !(obj->flags & UNINTERESTING))
 				continue;
 			mark_tree_uninteresting(revs->repo,
 						get_commit_tree(commit));
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178..e52291e674 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -366,7 +366,11 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
+
+	git -C repo rev-list --objects \
+		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB" &&
+	git -C repo rev-list --objects-edge-aggressive \
+		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB"
 '
 
 test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
-- 
2.19.1.568.g152ad8e336-goog

