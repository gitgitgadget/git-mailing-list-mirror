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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65475C33C9E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A1A206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHUzAmhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKUWFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKUWFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so6321814wru.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l4KS8xjCkHfu4yECfI0p/qY1/ieLMG0/1p+g8ObGUGU=;
        b=YHUzAmhis/8tfFLB5zH4kWsqL+PIPvF2VkzScn5/DxqZ1Sox0ocVaSJickkP+YDb4p
         UClHnYqord4NDLvQ0fHuoVz80PImRumOx56Ryl6ZIJWRRQU7o9RLqg8lte2xOvd2jM+L
         2q4Jg6i7UMs7kcythwNWksyW6ZebJDdkS86D0Y0SX/sQFogfY3MG3PKeiP7n/RDdjD5h
         X1XCtmKSLkJB6DgkPusyuwknadmy3APoZuPtiOnUOUpbNqfxXFGOtad/MfPthF8NLedD
         V1J7E0zKBqW/aHfOlUyyUlI76ZJHVU4KqiKwrdzbgW8OMvj6DvF5m428/qUm3Qxwhmwg
         HUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l4KS8xjCkHfu4yECfI0p/qY1/ieLMG0/1p+g8ObGUGU=;
        b=HnniT18bEclSBqcL0CgVKHCEkdkYHhE6+p2ZwubCL+c7a/s9Cs0L4Na0wDiFqsYQ04
         yr+JuIFPzXHel0AVbwuG22AfckP6/oaerabG4ykis6Idb19KauYJPVWXymsGEIMxpHMK
         R34X7qx50eNk7QYCPDeH+3N+J8eaffYJNPtuZJnneZplzFWOpceG/xqAe7wV6dxR7wXY
         yWb3Hvo/JxQQPkAMcZ++VuANyfoWQVlfjMLb3W5DAQZc2DNXdPHKe9vXQgRa0fdtTu85
         uQxB/ltSb/hUZzSXr7v725nmPFcMxYMhxUyuZySChIMNqad02/b37vsHXBd54mQBCkIE
         Etmg==
X-Gm-Message-State: APjAAAWEeT9AqhlLkn1K8y9WbMlJi0KgpLogDHdPMu2Se3ZvcNSVHo7K
        hpS88mtXjcuFA8Pmdac615KmA2Na
X-Google-Smtp-Source: APXvYqx+OJxwrJHVGIlFmHlfCNv3LdTQ0eLnCP4lj4P8GU80RAOMbFJImxEy7yg3O0MwHleGzOgPPw==
X-Received: by 2002:a05:6000:1204:: with SMTP id e4mr6325957wrx.35.1574373900817;
        Thu, 21 Nov 2019 14:05:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm4814843wrs.48.2019.11.21.14.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:00 -0800 (PST)
Message-Id: <3b9e11d7f2a7ec7b9e0250e603e5de42f10efb92.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:40 +0000
Subject: [PATCH v6 08/19] sparse-checkout: add 'cone' mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

The sparse-checkout feature can have quadratic performance as
the number of patterns and number of entries in the index grow.
If there are 1,000 patterns and 1,000,000 entries, this time can
be very significant.

Create a new Boolean config option, core.sparseCheckoutCone, to
indicate that we expect the sparse-checkout file to contain a
more limited set of patterns. This is a separate config setting
from core.sparseCheckout to avoid breaking older clients by
introducing a tri-state option.

The config option does nothing right now, but will be expanded
upon in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt         | 10 ++++-
 Documentation/git-sparse-checkout.txt | 55 ++++++++++++++++++++++++++-
 cache.h                               |  4 +-
 config.c                              |  5 +++
 environment.c                         |  1 +
 t/t1091-sparse-checkout-builtin.sh    | 14 +++++++
 6 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 852d2ba37a..bdbbee58b9 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -593,8 +593,14 @@ core.multiPackIndex::
 	multi-pack-index design document].
 
 core.sparseCheckout::
-	Enable "sparse checkout" feature. See section "Sparse checkout" in
-	linkgit:git-read-tree[1] for more information.
+	Enable "sparse checkout" feature. See linkgit:git-sparse-checkout[1]
+	for more information.
+
+core.sparseCheckoutCone::
+	Enables the "cone mode" of the sparse checkout feature. When the
+	sparse-checkout file contains a limited set of patterns, then this
+	mode provides significant performance advantages. See
+	linkgit:git-sparse-checkout[1] for more information.
 
 core.abbrev::
 	Set the length object names are abbreviated to.  If
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index c2cb19f80d..8535f0cf40 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -80,7 +80,9 @@ the sparse-checkout file.
 To repopulate the working directory with all files, use the
 `git sparse-checkout disable` command.
 
-## FULL PATTERN SET
+
+FULL PATTERN SET
+----------------
 
 By default, the sparse-checkout file uses the same syntax as `.gitignore`
 files.
@@ -95,6 +97,57 @@ using negative patterns. For example, to remove the file `unwanted`:
 ----------------
 
 
+CONE PATTERN SET
+----------------
+
+The full pattern set allows for arbitrary pattern matches and complicated
+inclusion/exclusion rules. These can result in O(N*M) pattern matches when
+updating the index, where N is the number of patterns and M is the number
+of paths in the index. To combat this performance issue, a more restricted
+pattern set is allowed when `core.spareCheckoutCone` is enabled.
+
+The accepted patterns in the cone pattern set are:
+
+1. *Recursive:* All paths inside a directory are included.
+
+2. *Parent:* All files immediately inside a directory are included.
+
+In addition to the above two patterns, we also expect that all files in the
+root directory are included. If a recursive pattern is added, then all
+leading directories are added as parent patterns.
+
+By default, when running `git sparse-checkout init`, the root directory is
+added as a parent pattern. At this point, the sparse-checkout file contains
+the following patterns:
+
+----------------
+/*
+!/*/
+----------------
+
+This says "include everything in root, but nothing two levels below root."
+If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
+`A/B` are added as parent patterns. The resulting sparse-checkout file is
+now
+
+----------------
+/*
+!/*/
+/A/
+!/A/*/
+/A/B/
+!/A/B/*/
+/A/B/C/
+----------------
+
+Here, order matters, so the negative patterns are overridden by the positive
+patterns that appear lower in the file.
+
+If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
+expecting patterns of these types. Git will warn if the patterns do not match.
+If the patterns do match the expected format, then Git will use faster hash-
+based algorithms to compute inclusion in the sparse-checkout.
+
 SEE ALSO
 --------
 
diff --git a/cache.h b/cache.h
index 04cabaac11..4980ee198e 100644
--- a/cache.h
+++ b/cache.h
@@ -918,12 +918,14 @@ extern char *git_replace_ref_base;
 
 extern int fsync_object_files;
 extern int core_preload_index;
-extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
 
+int core_apply_sparse_checkout;
+int core_sparse_checkout_cone;
+
 /*
  * Include broken refs in all ref iterations, which will
  * generally choke dangerous operations rather than letting
diff --git a/config.c b/config.c
index e7052b3977..d75f88ca0c 100644
--- a/config.c
+++ b/config.c
@@ -1364,6 +1364,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.sparsecheckoutcone")) {
+		core_sparse_checkout_cone = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index efa072680a..2a1a866659 100644
--- a/environment.c
+++ b/environment.c
@@ -67,6 +67,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
+int core_sparse_checkout_cone;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c385c62c92..0b2715db52 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -148,6 +148,20 @@ test_expect_success 'set sparse-checkout using --stdin' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: match patterns' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	rm -rf repo/a repo/folder1 repo/folder2 &&
+	git -C repo read-tree -mu HEAD &&
+	git -C repo reset --hard &&
+	ls repo >dir  &&
+	cat >expect <<-EOF &&
+		a
+		folder1
+		folder2
+	EOF
+	test_cmp expect dir
+'
+
 test_expect_success 'sparse-checkout disable' '
 	git -C repo sparse-checkout disable &&
 	test_path_is_missing repo/.git/info/sparse-checkout &&
-- 
gitgitgadget

