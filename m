Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B01C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD6720663
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOiW0vYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfL3PdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:33:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44525 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfL3PdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:33:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so32868642edb.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gRn2xZ8iCH5bNrIgznAyfXDwnRhraDnkX/dVJpSRd4Y=;
        b=LOiW0vYgjQwYPpUhBB7X4tYzwR65VwK/5bIqVun2oOFrV0ikX8pT3REMdCanbhCV/Z
         xp9uAF/N6f+OJYGSJEun4dTPBzG6/s66mRlnqA19LMkoqGXRI7G/OpR8Bzxudt2gNM5I
         ml10LmNCLHHTaH3upqm7rZANLzip+5fWxU1VAU5guzH9D0c8sjFx0lxeq+Alt1vqw09l
         4x+1VXKc1OvuLN1Y24va5rfgll8ZJ1OcZulha6rwLPrrdayLWexTy2ovVFg5eFBihF0q
         zcvM+Vlw88dilnlclwrJ/T8LkjYk2Zu1+u+XFbE2zDAO0eAqSHVaqsXxKtfAze6jUZWi
         B4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gRn2xZ8iCH5bNrIgznAyfXDwnRhraDnkX/dVJpSRd4Y=;
        b=F4CayGHdrSGK+aaT7gY44Yzaj+FVVRXBn+TQdHdbbeFEigXBZUCb8Fq/j00MXHH20z
         U74+FJNMOW/sK3KvT3AIhF4jmM9GSsoemO/2aKxoexWhxJSqRxfWDSd4qVT7sZWO2Wih
         Zpvb8crHoRSgw36dkiocwXhvLqzGyY9yiVQIZhCbMDT88MRTGtv+kN+/+bDFbIb4LHZT
         0ejPlTTNeO+lQEMAe67x5+rwYu3djTBzCfD/lZ0a/8Rb3BcWUP7e1DR55oDHKlvMYHhm
         bIT4OW4QLFpyvdHNfw4mFcgnhIQsHMgW0GuZmuDuGYQZ8rxoYJO4cATckbHqevH4M3Wy
         D7Jg==
X-Gm-Message-State: APjAAAW3VfE1+BAAS59sBThjD2+acea9w+FNGrBYX49NEvBlPXiRx0Zg
        onQYpapsatfJL1mzkOhfnbQ2+Tcq
X-Google-Smtp-Source: APXvYqyov/9xuTy1vHy4SE6QVQ2FF2+apLhM8ErQjWHutSJvYasYtKhLnjFMv47do7cR82M0qxrU3A==
X-Received: by 2002:a17:906:1354:: with SMTP id x20mr70912735ejb.279.1577719996196;
        Mon, 30 Dec 2019 07:33:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dd17sm5510087edb.9.2019.12.30.07.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:33:15 -0800 (PST)
Message-Id: <7d4295bd06868a86b7d1b32e8735c11795dbbab2.1577719993.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
References: <pull.500.v2.git.1577472469.gitgitgadget@gmail.com>
        <pull.500.v3.git.1577719993.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:33:12 +0000
Subject: [PATCH v3 1/2] sparse-checkout: list directories in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
command takes a list of directories as input, then creates an ordered
list of sparse-checkout patterns such that those directories are
recursively included and all sibling entries along the parent directories
are also included. Listing the patterns is less user-friendly than the
directories themselves.

In cone mode, and as long as the patterns match the expected cone-mode
pattern types, change the output of 'git sparse-checkout list' to only
show the directories that created the patterns.

With this change, the following piped commands would not change the
working directory:

	git sparse-checkout list | git sparse-checkout set --stdin

The only time this would not work is if core.sparseCheckoutCone is
true, but the sparse-checkout file contains patterns that do not
match the expected pattern types for cone mode.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 11 ++++++++++-
 builtin/sparse-checkout.c             | 21 +++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 11 +++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 9c3c66cc37..67be5247b9 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -28,7 +28,7 @@ THE FUTURE.
 COMMANDS
 --------
 'list'::
-	Provide a list of the contents in the sparse-checkout file.
+	Describe the patterns in the sparse-checkout file.
 
 'init'::
 	Enable the `core.sparseCheckout` setting. If the
@@ -150,6 +150,15 @@ expecting patterns of these types. Git will warn if the patterns do not match.
 If the patterns do match the expected format, then Git will use faster hash-
 based algorithms to compute inclusion in the sparse-checkout.
 
+In the cone mode case, the `git sparse-checkout list` subcommand will list the
+directories that define the recursive patterns. For the example sparse-checkout
+file above, the output is as follows:
+
+--------------------------
+$ git sparse-checkout list
+A/B/C
+--------------------------
+
 If `core.ignoreCase=true`, then the pattern-matching algorithm will use a
 case-insensitive check. This corrects for case mismatched filenames in the
 'git sparse-checkout set' command to reflect the expected cone in the working
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5d62f7a66d..b3bed891cb 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -53,6 +53,8 @@ static int sparse_checkout_list(int argc, const char **argv)
 
 	memset(&pl, 0, sizeof(pl));
 
+	pl.use_cone_patterns = core_sparse_checkout_cone;
+
 	sparse_filename = get_sparse_checkout_filename();
 	res = add_patterns_from_file_to_list(sparse_filename, "", 0, &pl, NULL);
 	free(sparse_filename);
@@ -62,6 +64,25 @@ static int sparse_checkout_list(int argc, const char **argv)
 		return 0;
 	}
 
+	if (pl.use_cone_patterns) {
+		int i;
+		struct pattern_entry *pe;
+		struct hashmap_iter iter;
+		struct string_list sl = STRING_LIST_INIT_DUP;
+
+		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
+			/* pe->pattern starts with "/", skip it */
+			string_list_insert(&sl, pe->pattern + 1);
+		}
+
+		string_list_sort(&sl);
+
+		for (i = 0; i < sl.nr; i++)
+			printf("%s\n", sl.items[i].string);
+
+		return 0;
+	}
+
 	write_patterns_to_file(stdout, &pl);
 	clear_pattern_list(&pl);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 6f7e2d0c9e..37f6d8fa90 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -246,6 +246,17 @@ test_expect_success 'cone mode: init and set' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: list' '
+	cat >expect <<-EOF &&
+		folder1
+		folder2
+	EOF
+	git -C repo sparse-checkout set --stdin <expect &&
+	git -C repo sparse-checkout list >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cone mode: set with nested folders' '
 	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
 	test_line_count = 0 err &&
-- 
gitgitgadget

