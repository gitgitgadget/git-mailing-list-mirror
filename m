Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA75C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24920781
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoIUPDHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391252AbgFXOrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389400AbgFXOru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:47:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039ACC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so2527290wrj.13
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OFkQKEmBASs9GmJDYmeQkG+bxfech4wZZcmDiXyvRZM=;
        b=YoIUPDHL+jEHAc5XzcILv6qqPDl0XBiXwCrBnYMH3MFDnKpnD5v6PML7MH7f5s+8cI
         NrO2x8CUUbByBcXYT8SJiGccv93aHoTIMwauWyaFFnREZPIwrgYqUo9DQxFjmjLKbt90
         r5ir3A/4ufH7jjw82j8UxSsP51jll2TqFvqAfBrJd7siasfqWGHFHEUr7vzBHjSVMKFv
         PGcaBAIAyuLL01CWyuZkPe3b4XLmJHt+emuJzZnS+BTNJflmgHlTd025IEewwTAa6TYl
         ZXcgUquwW/Qp9TcZEBVvwsCz81/XUeT1IPj9Yv7BMERlYEn5ad7buQIVhA1XgLPtE9x1
         ArXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OFkQKEmBASs9GmJDYmeQkG+bxfech4wZZcmDiXyvRZM=;
        b=cZjN8Dd7lUXt4wcIcPFom6a7A3vZhh6pGhtLoSbRvr9NwdwWJRK+GQYgqtEpwS4aI9
         c/UMrtT5doGr7c9eL7inACUCDKeCyTABg7ccTz3yuzM+VWkSLfF51Z23X0oTlahfoHnl
         xO0a7QQW7I/qWEgrGKgT39VT385a+cFYQq6JsR7lqXzVT2E1iKrli7vEfyNDXr+eJ6bH
         L4SIR5XBswgs5f0NnZSkEiQekzwKQQYNi/NTrDOFjMpf43g0Q/06W8wPXj+mYhiBHfbY
         gnJN+gGQmJ/ZJ45QQYQS4/IEjunBKeo/LU0MXzgLCGT4PR+rCLEPJv4XhckAE9kG1fXy
         he8w==
X-Gm-Message-State: AOAM533YaZ25UsexdCNKLRFgIppkNKdKkGT3oObyybQeXhdHVv+AP1Nx
        tz5A3P1kQrk36tpd8+HjuYfmuMyvn0E=
X-Google-Smtp-Source: ABdhPJy5kv+E3WCFW8b2H/cQSN4ofz72jfAPLNGXfWObX63TR0Igkb+C+DE2+2ANHx5zZFbtTGquKw==
X-Received: by 2002:a5d:4282:: with SMTP id k2mr31051831wrq.196.1593010068551;
        Wed, 24 Jun 2020 07:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm27378971wrs.75.2020.06.24.07.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:47:48 -0700 (PDT)
Message-Id: <8c27c78831be23fb560f3c012c014b11d32e75ca.1593010066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
References: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:47:44 +0000
Subject: [PATCH v3 1/3] diff-files --raw: handle intent-to-add files correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In `run_diff_files()`, files that have been staged with the intention to
add are queued without a valid OID in the `diff_filepair`.

When the output mode is, say, `DIFF_FORMAT_PATCH`, the
`diff_fill_oid_info()` function, called from `run_diff()`, will remedy
that situation by reading the file contents from disk.

However, when the output mode is `DIFF_FORMAT_RAW`, that does not hold
true, and the output will contain a bogus OID (and the flag `M` for
"modified" instead of the correct `A` for "added").

As a consequence, `git difftool -d` (which relies on `git diff-files
--raw`'s output) does not work correctly.

Let's fix this specifically by imitating `diff_fill_oid_info()`.

Note: we can only do that for diff formats that do not actually need the
file contents, such as `DIFF_FORMAT_PATCH`: `run_diff()` would try to
read the blob contents, but that blob might not have been written to
Git's object database.

This fixes https://github.com/git-for-windows/git/issues/2677

This patch _also_ fixes the expectations set by the regression test
introduced in feea6946a5b (diff-files: treat "i-t-a" files as
"not-in-index", 2020-06-20).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c             | 14 ++++++++++++++
 t/t2203-add-intent.sh  |  5 ++---
 t/t4000-diff-format.sh | 10 ++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 61812f48c2..ea23169afa 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -217,6 +217,20 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					       !is_null_oid(&ce->oid),
 					       ce->name, 0);
 				continue;
+			} else if (ce_intent_to_add(ce) &&
+				   !(revs->diffopt.output_format &
+				     ~(DIFF_FORMAT_RAW | DIFF_FORMAT_NAME_STATUS))) {
+				struct object_id oid;
+				int ret = lstat(ce->name, &st);
+
+				if (ret < 0)
+					oidclr(&oid);
+				else
+					ret = index_path(istate, &oid,
+						 ce->name, &st, 0);
+				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
+					       &oid, ret >= 0, ce->name, 0);
+				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8a5d55054f..7d379bdbc6 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -240,7 +240,6 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
 
 	hash_e=$(git hash-object empty) &&
 	hash_n=$(git hash-object not-empty) &&
-	hash_t=$(git hash-object -t tree /dev/null) &&
 
 	cat >expect.diff_p <<-EOF &&
 	diff --git a/empty b/empty
@@ -259,8 +258,8 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
 	 create mode 100644 not-empty
 	EOF
 	cat >expect.diff_a <<-EOF &&
-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")empty
-	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t")not-empty
+	:000000 100644 0000000 $(git rev-parse --short $hash_e) A$(printf "\t")empty
+	:000000 100644 0000000 $(git rev-parse --short $hash_n) A$(printf "\t")not-empty
 	EOF
 
 	git add -N empty not-empty &&
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index e5116a76a1..48ff4e250b 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -89,4 +89,14 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+test_expect_success 'git diff-files --raw handles intent-to-add files correctly' '
+	echo 123 >ita &&
+	git add -N ita &&
+	printf ":000000 100644 %s %s A\\tita\n" \
+		$ZERO_OID $(git hash-object --stdin <ita) >expect &&
+	git diff-files --raw ita >actual &&
+	test_cmp expect actual
+'
+
+
 test_done
-- 
gitgitgadget

