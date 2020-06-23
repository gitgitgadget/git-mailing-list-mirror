Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA3C433E3
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4214F2072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp6ljiWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgFWMsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbgFWMsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:48:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543EC061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g18so11338253wrm.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4TNL+ZyCk52rCJzdeOmuJCB59GlJxPW9J7MNBLE7XVM=;
        b=Kp6ljiWmqHRY3uwTKS6ssneHYWaqyCjJqDVm1ikR1PRoPojMDjvX4utEPMitSbBfGn
         0fLvh7anlh/Hy4ianMpFZIe0aP/bGA8KjpObfwGZQsJAyxE3YJkCkAoBknaHHfodDS2e
         RX/JDgiqtpkR9qUrMbBD/XrraBwAU7HDtjNgjyfES5/xwimMI1MVMkExguN/pLUwrwLE
         ftjzA1RH5Nhd0P7KgkiGu6nx4Sh5tCgNWHXMwVmrJtjjh/xIXB9SvZpEn5PuLEDGpv7W
         a6rS3SJwSxW4fl2uRUbcVTlEbul1l+2MWbSyDqTl+Ce0uUEbmtiWjDxiqMsdHyoNpiuO
         8vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4TNL+ZyCk52rCJzdeOmuJCB59GlJxPW9J7MNBLE7XVM=;
        b=VICo88F3cb2BfZvDM0Qlp++sSYGyVDZMPXwWofG8FmpMARugV1gj2T7Q9pq8Xidag4
         SCM2ZQrLORn3cnXLwf40YFvzB83eu1GwJHSWXKOwORgATYKSmKXU+xbrkfl7E6EDtsHf
         TEUbRfEzUqPfrRQxc/MDf+FQB6ZioZeDCXnckR21FlBRgMKItpgx1vOuC6hIXh8fp8Y+
         eqom19/5CzBqE7MLRVp07e6mf3vXT+fpopRc4T0Hsm3F7nogsoV9gPVLrEXDsg8KmgM3
         qC4qv5M1AXLVfBRKjcJCak1srCtOwIsH/ej239f1nrZpTm6A7dFR4XCi3tg0RUzkaIU+
         CCDQ==
X-Gm-Message-State: AOAM531tSbIPpXKUlFCo1UbsNdtZuMDQx8FuFFr7Jfd9yoPDhhVkDXcF
        K+xoCb1Afb19G92KSA6uwJR2yjjT
X-Google-Smtp-Source: ABdhPJze8gjooYvL4skKU6aUiGOsY2ZS75CndOsaZEntMZJt5WrYmEt6xtrBs5dj8GOp4Ce+hfyftQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr25388217wro.317.1592916488157;
        Tue, 23 Jun 2020 05:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm3670070wmb.24.2020.06.23.05.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:48:07 -0700 (PDT)
Message-Id: <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 12:48:03 +0000
Subject: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files correctly
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
 t/t2203-add-intent.sh  |  4 ++--
 t/t4000-diff-format.sh | 10 ++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 61812f48c27..ea23169afa2 100644
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
index 8a5d55054f2..b000a2bdd1d 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -259,8 +259,8 @@ test_expect_success 'i-t-a files shown as new for "diff", "diff-files"; not-new
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
index e5116a76a1c..48ff4e250b5 100755
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

