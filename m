Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C4220281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbdI2UM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:44597 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdI2UML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:11 -0400
Received: by mail-pf0-f178.google.com with SMTP id e1so342547pfk.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aLDAGtZhGoBLHToj025VHudf4+KGNMs1+TwLR0Z2mnk=;
        b=TkfNqhxl+YM0QG96inz9IMU0xlTAQcnRBP1ILWUd2s+EObypvn/E4lvSrEnqqbVezm
         fsi1wV/xBP3lQb8zLMzpOpOae+UbOATI5/GHfa/Rws66o6Yu0A6NqGC0P74V/epKBKKZ
         6yL6VEWY2f3MLaYH3GH+VVuS0sC8OUFHW8+mc/dGOgSTw7bWm0znbyOHX/WxDcaoyLcF
         38D+xVeeP/HkytG7KmXTTPD6LGILQzB2CJTX/M2VXdN6UuB1vNxryO0yCom4O8F8vMM2
         5+3LL3VvvWmFs+KXSztSyR3ctjRLrLWYxPRvoH5kzAjeYiFDbvIXIhr686atME0Czk5h
         BGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aLDAGtZhGoBLHToj025VHudf4+KGNMs1+TwLR0Z2mnk=;
        b=LzcioRZiam5ZeIKiQYuBVeTnf5kTcvpob5YdWDnbqf4rqpETbXm0nNvgiswU2EMi83
         6bd35H4Vi6AEgK01R0jHPVFYOLC4o/JEkD/K9vL4gvj7vQj693jpSugrtIMG2X1TXpfP
         oh4edO9Baf9r8/iJrg6frb34xP7i7xlla3IYFrWnd9As4agFThc3uXmkzJo/fHFkoY/f
         M30ztIZ0nZG2f9WtLnXQkfsm8+zC79LNu/MVCuBwVyqAEdu8oAcsEmBKUSaa5gkvBlIm
         gnecw+kocgw4+Riby+tJx5CFAxhJn4vva7hSBynT+kILtWOQFgswJytiBL5mDoeVqNYf
         vvYg==
X-Gm-Message-State: AHPjjUhjSQ4RTTqEbFcvLHWYjXZabkafGPddpDwfdPCEsJz0CfIwIhrV
        tEoXJ4hnrGQ8hAfbaV6RwbbZozQ8eMY=
X-Google-Smtp-Source: AOwi7QDDLieNH33hONYPmV8u2l3wik88NfMMJFi6aFEB0DXvCmpHUUN+W8O+KWheunCyuVvqwH5Jkw==
X-Received: by 10.98.63.140 with SMTP id z12mr8874162pfj.218.1506715930600;
        Fri, 29 Sep 2017 13:12:10 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 02/18] fsck: support refs pointing to promisor objects
Date:   Fri, 29 Sep 2017 13:11:38 -0700
Message-Id: <9cb7d457b8c06905d1fdab25576d8e7e899c0cd4.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat refs referring to missing promisor objects as an
error when extensions.partialclone is set.

For the purposes of warning about no default refs, such refs are still
treated as legitimate refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c           |  8 ++++++++
 t/t0410-partial-clone.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 97d1e621e..f1529527b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -439,6 +439,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 
 	obj = parse_object(oid);
 	if (!obj) {
+		if (is_promisor_object(oid)) {
+			/*
+			 * Increment default_refs anyway, because this is a
+			 * valid ref.
+			 */
+			 default_refs++;
+			 return 0;
+		}
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 3ddb3b98f..bf75162c1 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -13,6 +13,14 @@ pack_as_from_promisor () {
 	>repo/.git/objects/pack/pack-$HASH.promisor
 }
 
+promise_and_delete () {
+	HASH=$(git -C repo rev-parse "$1") &&
+	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
+	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
+	git -C repo tag -d my_annotated_tag &&
+	delete_object repo "$HASH"
+}
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
 	test_create_repo repo &&
 	test_commit -C repo my_commit &&
@@ -78,4 +86,20 @@ test_expect_success 'missing reflog object alone fails fsck, even with extension
 	test_must_fail git -C repo fsck
 '
 
+test_expect_success 'missing ref object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+
+	# Reference $A only from ref
+	git -C repo branch my_branch "$A" &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.14.2.822.g60be5d43e6-goog

