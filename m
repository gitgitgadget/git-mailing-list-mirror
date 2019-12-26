Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F6DC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61826206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3EoEwPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLZUtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:49:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40180 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLZUtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:49:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id b8so23685999edx.7
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 12:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q4qU1VApBDYc6mZYlNgINDkTZw+LWLaWlaRl4aE+X5c=;
        b=j3EoEwPoZt6fykv57fxWWkIj65IIhd922vm4AENxs65mn5GrwCybVu4EQ6ADObYCm0
         mobuTBfPL0+9YRNCRY43j9SP3MDnsA7byPfXwOAWLtsTS1r48K3bU9d22QqHAIGQMeKx
         GA36dFdj1ElWj+EIg9wM5nPI3fTMQAVBQZMmIz4NarxAAyKmw96oFSQr8XyU9b/mGzG+
         NURDKm8qhXLxHb/MFh7Kg45L+BP9dqbBOGRWbzLQrCquqiHtfOK0E1vlX1Kyfn8vhpVh
         THEsfGkWv86vpg7M6apZ7RPMQJSA7SCh72U8HOivh6AOwgeXyNaRwrOBEsl88psHzyzL
         t3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q4qU1VApBDYc6mZYlNgINDkTZw+LWLaWlaRl4aE+X5c=;
        b=YilDNtJF7XE4+A/d9nJfBUGu5YKIEcdCy3EQ5t+dXU3khrwD/hJTFlBmcrnfGX1SU1
         jlVeuBAWcbduA3zvp08vToZjHFuG+1ZpHeNKNRNd+kt1XGOu4OMEdYZmA5BL78DJ4hMT
         9hNRdHHThFK5PStOS4mP7mIGYYQ8HjjVqUYCEXn7JmEOTbWTlknephgAwMYLBWNmWkEV
         deK9SUKwA6D+IKs9Ef5maCVVLlV9aC/4PHsvTLHZJ+NO87Qud1VcM6kIALiwv1FEJs0H
         FA0CRV5J615b9naIfKoO3NbAPGTfJmnG2egaLWwaf7jukHD4HtmKp9Y1zj3cJfR4b1aC
         fUpg==
X-Gm-Message-State: APjAAAUQV1gRmvFXbwvXBfZr6bQJivpGacYPZuoElL2TC3HRDCeO5F8q
        wpWEDITJRTwGfDeJCKJRJ/SuSWLj
X-Google-Smtp-Source: APXvYqwjVKuWlHfLeXRO7gFf6iuMLMgBl8jLEo+zTI4TBXZXaXOy0M6zsoATJw2T0jbF3gv2Hs4szQ==
X-Received: by 2002:a17:906:3796:: with SMTP id n22mr49664437ejc.222.1577393349352;
        Thu, 26 Dec 2019 12:49:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm3727066edn.52.2019.12.26.12.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 12:49:08 -0800 (PST)
Message-Id: <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.500.git.1577393347.gitgitgadget@gmail.com>
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 20:49:07 +0000
Subject: [PATCH 1/1] sparse-checkout: list folders in cone mode
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
command taks a list of folders as input, then creates an ordered
list of sparse-checkout patterns such that those folders are
recursively included and all sibling blobs along the parent folders
are also included. Listing the patterns is less user-friendly than the
folders themselves.

In cone mode, and as long as the patterns match the expected cone-mode
pattern types, change the output of 'git sparse-checkout list' to only
show the folders that created the patterns.

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
index 9c3c66cc37..dcca9ee826 100644
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
+folders that define the recursive patterns. For the example sparse-checkout file
+above, the output is as follows:
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
