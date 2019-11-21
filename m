Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8841AC43141
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5212068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7+TbP/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKUWFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfKUWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so6313023wro.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=WrXdb3eI+X2vlTbxqFu8O3zgpIiouKGMmlNb0VYchmk=;
        b=J7+TbP/H8XKhr6lr0Fcdorq87OsGMKunA0Zei0i0QHGx1C9v7uIWOywrCGYxW9AoiQ
         lQs5HjNitaT9J6gHcOH3x0ys9+MKyT5LOpo06aCCa8ES0ZeWN7jJSoQZt3uyxUllRF2q
         D1AEOlE6cy1/CPa7yQ8W8Id/UMGTdZx0FgjT3jUK2iXSX141iACyqiwxm+hYJ+p8YCkQ
         pzxiweHQK3akJ3faZFhbDCIJHpFKlDNaLgx27hp+T7FiFqu1iX2gJPhz+1z8XLcxtS0c
         3r86/hmYhmOwqtEXQos/ABDypXLXVGy74z44EYANVkpF9dGpR9WY1R8irXp0HAd4KNGQ
         Kg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=WrXdb3eI+X2vlTbxqFu8O3zgpIiouKGMmlNb0VYchmk=;
        b=NYpJQKajX6Kz2CO1esU4N4nWsMaYBsft1eI7DEHgVdTuEqt1GFyjXs4yne9f0Sfvkn
         5ywanYS8vwGyJc7rcL6MXdzD6YpEDQ0ybg89nbb0y+kpfh9LCbGb9bM8BER2kx3kwXq2
         LBI7HlG/st9IYoCb/EqQBTCIM+fgsd837dd0FOlbcPt2k++wjKZw0CTAKCrLwMDXobYB
         BFhFPoXIvkXZOqzHg5onr9ZhmGCcUbZebYUNBTv7fxnS4Rf5z5Apj8cEEKNYf+oC2H49
         Uu/D/KjA1uWbumO/8QlLR1nS7j6U6nD2EPTQts/mkgsb4BA6znXMbcC2rt6qI8tW/9o3
         WDSg==
X-Gm-Message-State: APjAAAVMD5aFgiD8WKXdkL67V0mpZlcY/zb94oyoZCLA+Zixea3Q8ztR
        i+zIQV/Cfvl1O+diezy+wwYYoFZf
X-Google-Smtp-Source: APXvYqyxMxAMw8ZJ109fmbIHEg/w7oMOhOy0pD82W0cYITsdbNbCwv5cgS+GIjGMdkmUOJ5+cOgHOg==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr13845545wru.54.1574373913817;
        Thu, 21 Nov 2019 14:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm1056006wmk.23.2019.11.21.14.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:13 -0800 (PST)
Message-Id: <cc6773e49b70681a9efbaa42d5a78011a0cafb38.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:47 +0000
Subject: [PATCH v6 15/19] sparse-checkout: use in-process update for disable
 subcommand
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git sparse-checkout disable' subcommand returns a user to a
full working directory. The old process for doing this required
updating the sparse-checkout file with the "/*" pattern and then
updating the working directory with core.sparseCheckout enabled.
Finally, the sparse-checkout file could be removed and the config
setting disabled.

However, it is valuable to keep a user's sparse-checkout file
intact so they can re-enable the sparse-checkout they previously
used with 'git sparse-checkout init'. This is now possible with
the in-process mechanism for updating the working directory.

Reported-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt |  6 ++++--
 builtin/sparse-checkout.c             | 25 ++++++++++++-------------
 t/t1091-sparse-checkout-builtin.sh    |  3 ++-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 8535f0cf40..b975285673 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -52,8 +52,10 @@ When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
 
 'disable'::
-	Remove the sparse-checkout file, set `core.sparseCheckout` to
-	`false`, and restore the working directory to include all files.
+	Disable the `core.sparseCheckout` config setting, and restore the
+	working directory to include all files. Leaves the sparse-checkout
+	file intact so a later 'git sparse-checkout init' command may
+	return the working directory to the same state.
 
 SPARSE CHECKOUT
 ---------------
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a5d32e4702..a11ea65599 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -412,24 +412,23 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 
 static int sparse_checkout_disable(int argc, const char **argv)
 {
-	char *sparse_filename;
-	FILE *fp;
+	static const char *empty_base = "";
+	struct pattern_list pl;
+	struct strbuf match_all = STRBUF_INIT;
 
-	if (set_config(MODE_ALL_PATTERNS))
-		die(_("failed to change config"));
+	memset(&pl, 0, sizeof(pl));
+	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
+	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
+	pl.use_cone_patterns = 0;
+	core_apply_sparse_checkout = 1;
 
-	sparse_filename = get_sparse_checkout_filename();
-	fp = xfopen(sparse_filename, "w");
-	fprintf(fp, "/*\n");
-	fclose(fp);
+	strbuf_addstr(&match_all, "/*");
+	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
 
-	core_apply_sparse_checkout = 1;
-	if (update_working_directory(NULL))
+	if (update_working_directory(&pl))
 		die(_("error while refreshing working directory"));
 
-	unlink(sparse_filename);
-	free(sparse_filename);
-
+	clear_pattern_list(&pl);
 	return set_config(MODE_NO_PATTERNS);
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 53aeb5980f..b8f18e2a09 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -172,8 +172,9 @@ test_expect_success 'cone mode: warn on bad pattern' '
 '
 
 test_expect_success 'sparse-checkout disable' '
+	test_when_finished rm -rf repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout disable &&
-	test_path_is_missing repo/.git/info/sparse-checkout &&
+	test_path_is_file repo/.git/info/sparse-checkout &&
 	git -C repo config --list >config &&
 	test_must_fail git config core.sparseCheckout &&
 	ls repo >dir &&
-- 
gitgitgadget

