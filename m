Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1FBC2D0D5
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24EC206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIhMSnnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXTzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:07 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43493 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLXTzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so18649632edb.10
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mI8fjeSdKsXqLIxIijlISP0IXKZR1ghClmld4gvxCyc=;
        b=JIhMSnncjVLpmt6iw1yFOniIBBiL7X6autTmISGI1k6FMiyKHdlMtow4ahetmzEsXk
         N/9XZLuIaswEyr6wNBSbf0EcXx8g3wlPG1M+86a0BcKXOMPhu7XNW2RM25BEDvyZ+Fdx
         I3IaqhEzMdr0VsqzRMmDjU5t3HH/xBiRlG2YWCDFV0rFbebz2zQhwUrxiQQe9xKM+sSj
         CWgtNuqd9owwKRfO/VOAkbenoM/Ui2HkRnuGNOv91jj5zHM56+RaTbWFZMjWHRFExkrw
         zzHEKW2/vrNq77+bXsCgkor8ckPAFi6Hn2mZaUylyfW2go/bqUE96E5+CvzPnTP9sMDA
         CylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mI8fjeSdKsXqLIxIijlISP0IXKZR1ghClmld4gvxCyc=;
        b=dcNmxFiqcpJ4hNZgiHKXaxQ8Ie6bfiBTWINEogb8yMbAFOVL4O3XfKU14xwyvZZzIF
         7Ckdix1yWKoa38Qv8L3Bb62K6tiYK4YOJo/6EG2mR/eMs8sn3t/TnCHc5EG05r+E0iov
         w2P0zWnxCKIqjnhQqwW0Vn63Alb5ehrVViVPLotrPT69cPwJTLLT20kzC8WOuJ6hMRE3
         HLjD9iUY8741qE38Q2Ldkmys8gvdLqbGp8PruXSHLWA0sl8VE8r17Kh7GRR+GC1THxGW
         qC7OeHDHHQz365aZOME6o6dzJhWSHyVc8dAtdr1MQQERgL6YwI2TPymcbdISZfiiNRqn
         DTzA==
X-Gm-Message-State: APjAAAXFLxUM996JDsIQzWyP1HY0zU75i1One7zKXoQOD/Kmk8p0IB87
        EIxlU6/N31ItB+765hCdM1LXb33e
X-Google-Smtp-Source: APXvYqyhxmdLSZxDGuBvnceN7E95uLSxa5+imPKIENA66L4R0greYBRTDsK7531p4iGsbOuOHWphsQ==
X-Received: by 2002:a05:6402:17fb:: with SMTP id t27mr40818385edy.159.1577217304884;
        Tue, 24 Dec 2019 11:55:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm2796639ejq.38.2019.12.24.11.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:04 -0800 (PST)
Message-Id: <ee26f5a161c2e21ee9a1723bd2851f323f93cb05.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:49 +0000
Subject: [PATCH v3 05/15] rebase: fix handling of restrict_revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

restrict_revision in the original shell script was an excluded revision
range.  It is also treated that way by the am-backend.  In the
conversion from shell to C (see commit 6ab54d17be3f ("rebase -i:
implement the logic to initialize $revisions in C", 2018-08-28)), the
interactive-backend accidentally treated it as a positive revision
rather than a negated one.

This was missed as there were no tests in the testsuite that tested an
interactive rebase with fork-point behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c  |  4 ++--
 t/t3400-rebase.sh | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5014c9a437..f1de5c8186 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -364,8 +364,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 	argv_array_pushl(&make_script_args, "", revisions, NULL);
 	if (opts->restrict_revision)
-		argv_array_push(&make_script_args,
-				oid_to_hex(&opts->restrict_revision->object.oid));
+		argv_array_pushf(&make_script_args, "^%s",
+				 oid_to_hex(&opts->restrict_revision->object.oid));
 
 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 79762b989a..71fd6396cd 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -165,11 +165,29 @@ test_expect_success 'rebase works with format.useAutoBase' '
 	git rebase master
 '
 
-test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--merge)' '
 	git checkout -b default-base master &&
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual &&
+	git checkout default-base &&
+	git reset --hard HEAD^ &&
+	git checkout default &&
+	git rebase --merge &&
+	git rev-parse --verify default-base >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+	git checkout -B default-base master &&
+	git checkout -B default topic &&
+	git config branch.default.remote . &&
+	git config branch.default.merge refs/heads/default-base &&
 	git rebase &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
-- 
gitgitgadget

