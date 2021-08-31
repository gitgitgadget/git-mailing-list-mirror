Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D6C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED626101C
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbhHaC1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbhHaC1j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A9C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e26so4634762wmk.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N8TOWxc3JZtQX6JZVO9uq92OKX21jlAP9iiHOL50Ay0=;
        b=ehbIQpeom85Ypgx3tJ/fPkbBapUXpqWvnhzMIOVqaiWY89GJfAerPLPl7eMHPykG6N
         Qnix8oj4KvebDYXBjSKeq7P/MTbzcmZWZgBkYzla6Le2wWRf6VCGsCzB2Z0OpZpNrG1B
         UPIQLADedg01+Mzj75LXmGqSp3wVgbI9sUNgFfL+8xOkXbw50sw3pOOb6vUbV7Z8nIOo
         32D+Kx2PHxQU5hSiVnK+f7qWWlg27unyQO697aeIJa4r3b1JHsHEx/jxNFvJP92Q8loq
         AhUWT4ln7Z+KUykupgt/cbmDFaupF8115PrhELzKGuZEKOgYfPULwFgasYL1W06yZ71d
         5nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N8TOWxc3JZtQX6JZVO9uq92OKX21jlAP9iiHOL50Ay0=;
        b=mJLnKoabDZ1Z0h0JQZGrmrdH5ANMtdA7GuR4L9QaYZiy9MlmIn95klBQnKNemEYNLs
         I5SYyENIq5slkfbTIIbwx6feSHSBeEg30FzYq1RwVVW5Got/NOIrcucdp+sFFSPW4i35
         a9lpKH4VYR4zVeZLEhPk7bZxZS6dXMq8ZRy0vgFnzNLzx1f/Sk9a51yCFwql2JcdciHl
         IHmZ+FAKCqa92+uEfjneJ4SoNydfZE+XYtx1AqorSOlnyPNjx6JkGr2yMkN0KQU3YR0t
         TYvPcTvqdc8J9mGXePYYWnLDNS9E1dmc2mPr7BZYEIfjmqcwFo6qFXH+w9XUY/pWOAPN
         39BQ==
X-Gm-Message-State: AOAM530lbqF3bo22wd6ul2AJo8ioPjFT5sF2zoroj/qDbF07Zw0uMXDU
        uZcl2ylGh97Gis0jL7ahn7cMMsMcqXg=
X-Google-Smtp-Source: ABdhPJzx2vUEqJMPZTtKY0OE0KyyRxbZ7EZ5+7eGMApbZTe/JH+QXl0tp1K7eNVlOW+4lH44pPWq1w==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr1745019wmh.60.1630376803870;
        Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v28sm16830697wrv.93.2021.08.30.19.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 19:26:43 -0700 (PDT)
Message-Id: <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 02:26:37 +0000
Subject: [PATCH 4/7] merge-ort: capture and print ll-merge warnings in our
 preferred fashion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Instead of immediately printing ll-merge warnings to stderr, we save
them in our output strbuf.  Besides allowing us to move these warnings
to a special file for --remerge-diff, this has two other benefits for
regular merges done by merge-ort:

  * The deferral of messages ensures we can print all messages about
    any given path together (merge-recursive was known to sometimes
    intersperse messages about other paths, particularly when renames
    were involved).

  * The deferral of messages means we can avoid printing spurious
    conflict messages when we just end up aborting due to local user
    modifications in the way.  (In contrast to merge-recursive.c which
    prematurely checks for local modifications in the way via
    unpack_trees() and gets the check wrong both in terms of false
    positives and false negatives relative to renames, merge-ort does
    not perform the local modifications in the way check until the
    checkout() step after the full merge has been computed.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                | 11 ++++++++---
 t/t6404-recursive-merge.sh | 10 ++++++++--
 t/t6406-merge-attr.sh      | 10 ++++++++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a9e69d9cbb0..831f8f3e049 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1741,6 +1741,7 @@ static int merge_3way(struct merge_options *opt,
 	struct ll_merge_options ll_opts = {0};
 	char *base, *name1, *name2;
 	int merge_status;
+	struct strbuf warnings = STRBUF_INIT;
 
 	if (!opt->priv->attr_index.initialized)
 		initialize_attr_index(opt);
@@ -1781,10 +1782,14 @@ static int merge_3way(struct merge_options *opt,
 	read_mmblob(&src1, a);
 	read_mmblob(&src2, b);
 
-	merge_status = ll_merge(result_buf, path, &orig, base,
-				&src1, name1, &src2, name2,
-				&opt->priv->attr_index, &ll_opts);
+	merge_status = ll_merge_with_warnings(result_buf, &warnings, path,
+					      &orig, base,
+					      &src1, name1, &src2, name2,
+					      &opt->priv->attr_index, &ll_opts);
+	if (warnings.len > 0)
+		path_msg(opt, path, 0, "%s", warnings.buf);
 
+	strbuf_release(&warnings);
 	free(base);
 	free(name1);
 	free(name2);
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index eaf48e941e2..a986eec0420 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -108,8 +108,14 @@ test_expect_success 'refuse to merge binary files' '
 	printf "\0\0" >binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	test_must_fail git merge F >merge.out 2>merge.err &&
-	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_must_fail git merge F >merge.out &&
+		grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.out
+	else
+		test_must_fail git merge F >merge.out 2>merge.err &&
+		grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge.err
+	fi
 '
 
 test_expect_success 'mark rename/delete as unmerged' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 84946458371..75a7994988a 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -221,8 +221,14 @@ test_expect_success 'binary files with union attribute' '
 	printf "two\0" >bin.txt &&
 	git commit -am two &&
 
-	test_must_fail git merge bin-main 2>stderr &&
-	grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_must_fail git merge bin-main >stdout &&
+		grep -i "warning.*cannot merge.*HEAD vs. bin-main" stdout
+	else
+		test_must_fail git merge bin-main 2>stderr &&
+		grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
+	fi
 '
 
 test_done
-- 
gitgitgadget

