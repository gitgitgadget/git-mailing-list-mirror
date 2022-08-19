Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E7C3F6B0
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiHSDWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238802AbiHSDV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:21:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D598D91F6
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds12-20020a17090b08cc00b001fae6343d9fso238078pjb.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+7Qt1Vbtb4K4qoLiXFWPZtfwYiT1v2vtwDp2473VM3g=;
        b=WE6ZIJ0XzF6mZdbEcX5A5xnRQkIdY1g8U2v6kQNvJqmwFl7ISWvNxkGi99WQe8f7e7
         jGodcoYcI8hpqltfmqVfxaQy1Bzzt32q5mbIhaRHOHnJnao2R4o6l9/ugJUiamBOGHKU
         EDhQvh4/Twc53w8Y/gRxODQ0gI5kHwH6zvq2a6yEExjcd8ypyVx/coC3z0JL13KTI9tx
         jzsC3XUPskoYhNEMtvhcZkRJtMJLQy3w2O9ky+IfIFu3wuGrch3XE0x27DmEMgne5Vh2
         TwL1zF9BW7IBmYhT3Wxfghkg1f++fKRQZP+NdR/7rEH2LcwZfq6a1ujq9bDddgJFQRY/
         gqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+7Qt1Vbtb4K4qoLiXFWPZtfwYiT1v2vtwDp2473VM3g=;
        b=Tk+owt4gqlSxW/t7TQWNbTdU4Jej476dsMfetWBJpFSavNRffYRwDaGZCZtA8MCzqg
         in3Ayzgx6i4Gen8B2L+0foHnA4Okml242wr1ixTdV7zYa7K7Hz7ZKuNAc9e5nXlCsiyT
         /+ZHoV8D1r+XHn9teY9dBioInkiC+nE8jq4I1r2o8lk0OtAZN50OqOyI0XtgsFQuKUC9
         HDvcpsZYiNS5CyVBeK9z6+lGmlpzKEP64yhW4ya9njT1UDsKqwDHjtMM+5TKyofvMCDa
         MDlDdsx1D+6NzlhgToTZsNO1OnHuxd9ToUWC9amviwKji5ISjPlCJANr6YvLQNWSlHtv
         fWcg==
X-Gm-Message-State: ACgBeo0CeKb2wXqdNTpMVXaQxsmu4gSeLbB0vW+WdCWZB2Q0Ig9zPWR8
        BOlnVEv7WD5yuXDmLbuCpAI=
X-Google-Smtp-Source: AA6agR7bUo0c8b0R/Cb12vXZq8obDCZ9kOYLr4BHXAmoRyGG5Ys6FSyE9pr/8Fk2V1k9dZ1fJeEhKA==
X-Received: by 2002:a17:90b:3b85:b0:1f4:f76a:d5f6 with SMTP id pc5-20020a17090b3b8500b001f4f76ad5f6mr11918784pjb.156.1660879315806;
        Thu, 18 Aug 2022 20:21:55 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:55 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 4/9] refs: do not run transaction hook for git-pack-refs
Date:   Fri, 19 Aug 2022 11:21:42 +0800
Message-Id: <20220819032147.28841-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The git-pack-refs command will call "files_pack_refs()" to pack loose
references into the "packed-refs" file, and there are no real changes
to the repository. Therefore, by initializing a transaction with an
empty "hook_flags" field, the "reference-transaction" hook will not run.

The "prune_refs()" and "prune_ref()" functions are called from
"file_pack_refs()", and they are used to prune loose refereces which
have already been packed into "packed-refs". The transaction instance
in "prune_ref()" should also be initialized with an empty "hook_flags"
field.

The behavior of the following git commands and three testcases have been
fixed in t1416:

 * git gc
 * git pack-refs

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 10 ++++++++--
 t/t1416-ref-transaction-hooks.sh | 12 +++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7c1c25a25c..f0947c9dca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1136,7 +1136,8 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_store_transaction_begin(&refs->base, &err);
+	/* Called by "files_pack_refs()" and should not run any hooks. */
+	transaction = ref_store_transaction_begin_extended(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1207,7 +1208,12 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
+	/*
+	 * No real changes have occurred to the repository and no hooks
+	 * should be run for this transaction.
+	 */
+	transaction = ref_store_transaction_begin_extended(refs->packed_ref_store,
+							   0, &err);
 	if (!transaction)
 		return -1;
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 1ae601a73d..b7ffc9415b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -392,9 +392,7 @@ test_expect_success "update-ref: update HEAD" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the reference-transaction hook was executed even
-# though no refs were changed by running git-pack-refs.
-test_expect_failure "update-ref: prepare packed_ref_store using pack-refs" '
+test_expect_success "update-ref: prepare packed_ref_store using pack-refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir pack-refs --all &&
 	test_path_is_file workdir/.git/packed-refs &&
@@ -737,9 +735,7 @@ test_expect_success "branch: create new branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the reference-transaction hook was executed even
-# though no refs were changed by running git-gc.
-test_expect_failure "branch: prepare packed_ref_store using gc" '
+test_expect_success "branch: prepare packed_ref_store using gc" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir gc &&
 	test_path_is_file workdir/.git/packed-refs &&
@@ -1014,9 +1010,7 @@ test_expect_success "tag: create new tags" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the reference-transaction hook was executed even
-# though no refs were changed by running git-pack-refs.
-test_expect_failure "tag: prepare packed_ref_store using pack-refs" '
+test_expect_success "tag: prepare packed_ref_store using pack-refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 	git -C workdir pack-refs --all &&
 	test_path_is_file workdir/.git/packed-refs &&
-- 
2.36.1.25.gc87d5ad63a.dirty

