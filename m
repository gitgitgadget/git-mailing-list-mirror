Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E5C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91E824681
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMpNdT5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgA1S0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36659 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgA1S0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so17241586wru.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=BMpNdT5PNGH+mUk8BNVJNYYdBrtsLEdx6SUDFQcSS8/4mttTwEzp7GyP9jPSbH2lNZ
         yyS+/drFN2UqtjD8b9uXYVYDYUUBz3FzOf7UoXqci4ObvXoz8gA5rbdgEPg79H/+UheB
         ekXt6Rot6KUdceCYiVfwmEV3eGlsdsYF9Dz9ZVkD1RSB+m10FYNO2QGjrjKCj+mHW1wM
         r4OEv9LvudwB7bB5YgFCBFD3OH6Z4ruymNdcKJGN+DpxqOSRqxwXelBX2UfGTomPY2yD
         ZwrumcWvf3Kd9gdgGIKW59PlQvQksbGbTlkfLg8qmgrl2PCKyOLo8AVobVQnjoPIXIax
         YB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=Xwokp8JE45OG3JqBlyVxkBfENCdln5rm4LRZ2RTjGAWbuwIM/AZq4s26ua3eIp7Eus
         yp/l76xa8KuVDMbGot+/ZznN/kp+VJvTbuKJAQaa9IbBdemSo41N+vz8OkTSUkvNW6q6
         9n0Vs5uqsvSKPLDEDSS9UeOH4lAsTss8P67KijseILLcpQy18BSi6FeMmkwYC2JIqa3t
         Xpa9JWTVWWfQUo39tfGPzOLmGssP0ho6wBCAjnFFz96V/34ddy377mqXciKDR0s3/7eA
         dZy/tjbDN6heY6puc/I4eIumsucIMZ6bMqerAa4Wv6L/Vf3LpmSqtuP9yHvcSiuNN/UR
         Jvlw==
X-Gm-Message-State: APjAAAVys+NhCSCyWvV2UPO5IWIoLlTR58FN1nsLx8OsY3soUvbApd8y
        4SUcs2AwreiIAvff9UqQlkiZuSBI
X-Google-Smtp-Source: APXvYqyI3Pp5vZKmo5IrWJaoXTs8+Z6cUH4c+YDaeKN7V73Yo5xyHpgPmCN4FZXvJSiAzR9TMXhxLQ==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr31765163wrp.292.1580236007181;
        Tue, 28 Jan 2020 10:26:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17sm26172113wrt.91.2020.01.28.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:46 -0800 (PST)
Message-Id: <5497ad8778c29ca936206d2ded6773758c236c12.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:34 +0000
Subject: [PATCH v3 03/12] sparse-checkout: create leading directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git init' command creates the ".git/info" directory and fills it
with some default files. However, 'git worktree add' does not create
the info directory for that worktree. This causes a problem when running
"git sparse-checkout init" inside a worktree. While care was taken to
allow the sparse-checkout config to be specific to a worktree, this
initialization was untested.

Safely create the leading directories for the sparse-checkout file. This
is the safest thing to do even without worktrees, as a user could delete
their ".git/info" directory and expect Git to recover safely.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  4 ++++
 t/t1091-sparse-checkout-builtin.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b3bed891cb..3cee8ab46e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -199,6 +199,10 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	int result;
 
 	sparse_filename = get_sparse_checkout_filename();
+
+	if (safe_create_leading_directories(sparse_filename))
+		die(_("failed to create directory for sparse-checkout file"));
+
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e28e1c797f..43d1f7520c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -295,4 +295,14 @@ test_expect_success 'interaction with submodules' '
 	check_files super/modules/child a deep folder1 folder2
 '
 
+test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo worktree add --detach ../worktree &&
+	check_files worktree "a deep folder1 folder2" &&
+	git -C worktree sparse-checkout init --cone &&
+	git -C repo sparse-checkout set folder1 &&
+	git -C worktree sparse-checkout set deep/deeper1 &&
+	check_files repo a folder1 &&
+	check_files worktree a deep
+'
+
 test_done
-- 
gitgitgadget

