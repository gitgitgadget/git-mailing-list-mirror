Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B5C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiBOIc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:32:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiBOIcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:32:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A86FC3313
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q7so30644922wrc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZH+9Cxv/6UJbd1oWmz8Bh/o11mstupjqCb9ozi3qAfo=;
        b=hj/PKsHTvb+Bq6sJWH4Iz6evIXl84smJdAwhng02PORXXMgyoeYVljCD4QcILZUbdO
         AbLxB+zd5n0zF9B+nL+hUg2EnuZaaHMDl5pGe8aWOKypUKZyOJ4VVAVdFJzrwsvJaT1y
         Kk6NF6DVUZhL1EMFaCu89hrEZomQRccwYUkqiJ4P4wfVPPUlhxVVKyfvjUbqKEwHvsu9
         MJ0IdbfVg/X0/pbJm7FHOqOBd912A2/ALHIrbyoVcwwNpWopjPIUpxiFxOb3s3rJufR5
         BGsjE1DHL+d5S1uRO7gLRs5ym4GWCzf/h4HxCl4FXM+oSZFnF1fNsUQsG73vHoPvRQt8
         VT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZH+9Cxv/6UJbd1oWmz8Bh/o11mstupjqCb9ozi3qAfo=;
        b=L6HURZUw3oQkq5WnLM7Aeutw8pP/lHF5GnRfDhVt5N+HiCC4kH5oBUU7Zo3qq5JQ+U
         tKPqswZAePwsKH1MIKueyz/wsPvlIRV1uIHgeqp5QIS+uSiOu3f7FqaKrTv6G6EZjzBO
         aIfO9pSuYrWh+v0Vr2119TaUJ8VccU3mWlgZqGl0LPW30Yjpnmgsxr/m2AP/xl48U6vJ
         HcgCEVEr+3S18E/BUtyJUgw51oeh8aRjFUYp1lnfe7duVKlF/hOg2E8Z3c8vv8bcvwyz
         RGx9ru4u4dL4UqdLyoKqa8lGBjKiGig7h9FRetlDDK2PxwsGf1I7XKlyecTIuU7Exz43
         R3Gg==
X-Gm-Message-State: AOAM532MWbKS9FchCXxrxKT1zvAhVOwtvcyrms2sGNHVPZCl/Es3IPHU
        u+GxYzcrSTMX/t7le0nn0DcjPi17pdk=
X-Google-Smtp-Source: ABdhPJzeOtvco1Dt3on0THjMLXNLJzrVRWWzm3HrhGWYRqBDkRhjq4YQOPeh2epywrEKesPML764rQ==
X-Received: by 2002:adf:cd0f:: with SMTP id w15mr2164868wrm.335.1644913950481;
        Tue, 15 Feb 2022 00:32:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm17128780wmj.32.2022.02.15.00.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:32:30 -0800 (PST)
Message-Id: <286c22e5ecdd1e19cc4ca53126b2616085de6133.1644913943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:23 +0000
Subject: [PATCH v2 6/6] sparse-checkout: reject arguments in cone-mode that
 look like patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In sparse-checkout add/set under cone mode, the arguments passed are
supposed to be directories rather than gitignore-style patterns.
However, given the amount of effort spent in the manual discussing
patterns, it is easy for users to assume they need to pass patterns such
as
   /foo/*
or
   !/bar/*/
or perhaps they really do ignore the directory rule and specify a
random gitignore-style pattern like
   *.c

To help catch such mistakes, throw an error if any of the positional
arguments:
  * starts with any of '/!'
  * contains any of '*\?[]'

Inform users they can pass --skip-checks if they have a directory that
really does have such special characters in its name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 16 ++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 74d64ada9f9..a30c77e7a1a 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -710,10 +710,22 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
-	if (!core_sparse_checkout_cone)
-		for (i = 0; i < argc; i++)
+	for (i = 0; i < argc; i++) {
+		if (core_sparse_checkout_cone) {
+			if (argv[i][0] == '/')
+				die(_("specify directories rather than patterns (no leading slash)"));
+			if (argv[i][0] == '!')
+				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
+			if (strchr(argv[i], '*') ||
+			    strchr(argv[i], '?') ||
+			    strchr(argv[i], '[') ||
+			    strchr(argv[i], ']'))
+				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
+		} else {
 			if (argv[i][0] == '#')
 				die(_("paths beginning with a '#' must be preceeded by a backslash"));
+		}
+	}
 
 	for (i = 0; i < argc; i++) {
 		struct cache_entry *ce;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3c811724d5d..72157fc6f1f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -673,7 +673,7 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
 	git -C escaped sparse-checkout init --cone &&
-	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
+	git -C escaped sparse-checkout set --skip-checks zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
-- 
gitgitgadget
