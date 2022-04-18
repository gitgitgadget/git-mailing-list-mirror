Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202ADC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346872AbiDRRPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346895AbiDRRPY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BB30577
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:12:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x18so11417711wrc.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=bWpYDzyVsimRHnerMX4g2RJeaj1qlFj+OgG+PPQbuDc=;
        b=ojoYcp4+Bxg6Bs+2nPPP/oRxGtaeBH77/uhkP3UK09FkAkFQdphkafO6k7ifmhOk+G
         J3xtnHa3EZDMH4G6mFsrDiNn/ZLN/TbYtbKQT5G+QN29Nwf16Nutetlc59u6iMJIBHnL
         B5deXTzDFqyf+JgHVbaWf+j5/FORzhDtLCBIFLXDDDntahct9jc6a8fVl/wlMIsWz/DP
         myXTKv0VtnjoH+2s10mIvMt+ob/rpnPNE9GvopkppvDpnNCDoGq9XSSYCxCso9P1QaFs
         Wt0N2/+JoXOGZ+f0Zy3nNefLrZkCFYl519oxGFe12D3gwFx3coelTlK7VU30KFx6unl2
         2bHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bWpYDzyVsimRHnerMX4g2RJeaj1qlFj+OgG+PPQbuDc=;
        b=cthzidFdXbiT3JFUzN/AbBEnhiKf7Z5EOY7hl8vJ0xRMQrpVqzpmqnj9Pp69eXDM8B
         5JAzl3dgSd0LVIs1G5wGCOJJvFoa6XsD0Rtfd77b3PqUN2a9R0UtPap1VoeZ8Nweoo6p
         210zSJERznwvUhzTuy8F//78CciaMh3/zAtTJ8efQow5x2BCVyQE6rKL+UlyqsRkIIlD
         FNrEagfpIzvROqT1hRr3itTH5kpfmPya57uAqSd6bgE6+uwUrGatHuzWqV3crk0qxNd3
         ZQzqiqXZ39sQBL1rewJUk/s6jHqWZTK9lbQVOapXoZrdtCbPzXGmDrK+6QXMFFoakgdP
         zW/Q==
X-Gm-Message-State: AOAM530Fy05mxK2m+cIrUk0TE0nSV5iwKltZDIhEJahSIhvwvIkEoU23
        NoycO3Z9g1rQ1+LS2hkkcZj+X9ci6f4=
X-Google-Smtp-Source: ABdhPJwFJi37es++Gm4u5qWmH3A2EeTOk4OLhsZdiK5O2zKHxSbkOx+dFjJCS07NLxvTkWaIW1UPUg==
X-Received: by 2002:a5d:6389:0:b0:207:a7d8:2b64 with SMTP id p9-20020a5d6389000000b00207a7d82b64mr8884834wru.12.1650301961468;
        Mon, 18 Apr 2022 10:12:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020adfd1e5000000b0020a97e7ba9fsm3328099wrd.92.2022.04.18.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:40 -0700 (PDT)
Message-Id: <pull.1214.git.1650301959803.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Apr 2022 17:12:39 +0000
Subject: [PATCH] clone: ignore invalid local refs in remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When cloning directly from a local repository, we load a list of refs
based on scanning the $GIT_DIR/refs/ directory of the "server"
repository. If files exist in that directory that do not parse as
hexadecimal hashes, then the ref array used by write_remote_refs()
ends up with some entries with null OIDs. This causes us to hit a BUG()
statement in ref_transaction_create():

  BUG: create called without valid new_oid

This BUG() call used to be a die() until 033abf97f (Replace all
die("BUG: ...") calls by BUG() ones, 2018-05-02). Before that, the die()
was added by f04c5b552 (ref_transaction_create(): check that new_sha1 is
valid, 2015-02-17).

The original report for this bug [1] mentioned that this problem did not
exist in Git 2.27.0. The failure bisects unsurprisingly to 968f12fda
(refs: turn on GIT_REF_PARANOIA by default, 2021-09-24). When
GIT_REF_PARANOIA is enabled, this case always fails as far back as I am
able to successfully compile and test the Git codebase.

[1] https://github.com/git-for-windows/git/issues/3781

There are two approaches to consider here. One would be to remove this
BUG() statement in favor of returning with an error. There are only two
callers to ref_transaction_create(), so this would have a limited
impact.

The other approach would be to add special casing in 'git clone' to
avoid this faulty input to the method.

While I originally started with changing 'git clone', I decided that
modifying ref_transaction_create() was a more complete solution. This
prevents failing with a BUG() statement when we already have a good way
to report an error (including a reason for that error) within the
method. Both callers properly check the return value and die() with the
error message, so this is an appropriate direction.

The added test helps check against a regression, but does check that our
intended error message is handled correctly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    clone: ignore invalid local refs in remote

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1214%2Fderrickstolee%2Frefs-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1214/derrickstolee/refs-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1214

 refs.c                 | 6 ++++--
 t/t5605-clone-local.sh | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 1a964505f92..f300f83e4d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1111,8 +1111,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid))
-		BUG("create called without valid new_oid");
+	if (!new_oid || is_null_oid(new_oid)) {
+		strbuf_addf(err, "'%s' has a null OID", refname);
+		return 1;
+	}
 	return ref_transaction_update(transaction, refname, new_oid,
 				      null_oid(), flags, msg, err);
 }
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 7d63365f93a..21ab6192839 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -141,4 +141,13 @@ test_expect_success 'cloning locally respects "-u" for fetching refs' '
 	test_must_fail git clone --bare -u false a should_not_work.git
 '
 
+test_expect_success 'local clone from repo with corrupt refs fails gracefully' '
+	git init corrupt &&
+	test_commit -C corrupt one &&
+	echo a >corrupt/.git/refs/heads/topic &&
+
+	test_must_fail git clone corrupt working 2>err &&
+	grep "has a null OID" err
+'
+
 test_done

base-commit: 11cfe552610386954886543f5de87dcc49ad5735
-- 
gitgitgadget
