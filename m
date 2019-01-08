Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C980D1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfAHVws (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43217 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfAHVwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so5587361wrs.10
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jajW7V9cUxutbQJjoXzTjR6DncCYMr/f3oQ7PbSVFo=;
        b=TLkCePlywC3OG+N9fMwmmgBxkyW1tECyMTZox0IHeVqUEXkVm8udDTJjvyzF+E1irm
         bEMruuGfcJK/HABIKHMI4/T49TvURB6568cic1F5gL2pI6bk4SNQlGpVfjMENGfDY258
         +AFtYaInWzMbe0FD2CTuspYCZrPmSWBv8hlJgx4v/hMOuefLLOriZJdadv4XWCytulxE
         nFGU2/t3x4twZ0Wic3pcKsdTlYMRKdf/C0OQu1+AArfNIxrG5LhbfaE8mTiyUX1DWF/R
         5v1ssVgJJrGZFA5q0TCaYngOvIhL5Lv4zaN8NeMMXUYd0PRmMc8UAfJYDmSn/ShhHWe2
         pR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jajW7V9cUxutbQJjoXzTjR6DncCYMr/f3oQ7PbSVFo=;
        b=Sjve/qoBbjyGHd2u2e5AiPHMotx6YaV/+Pct4p2WnVbzHfJG+kq3/TzoLqMSKRhQnN
         c0WjvMMyBDgbAL0HuF0QICeSC7bOHkYFG+cMKlfmRVyPRXMaMJfsUOB47N7qEqQskKP6
         Zu5Z++8R+q3ELhe65YQd1zYMfZqvX5a6Y23RFWnNDmSSGOH0tymJ8HPsuo0S08XRxK6L
         2w7kRRxw9jTwoishhF9hd41B6TuhvB+lqNAfwugu9G6V/a1ZgFda+XNhQx4hjY/zrT/i
         HjfpZ+1nX2D2NivPRMjYEawsdaWup2dR1jD+RCGK2lYNYJm8VY6EAUNPRuY0+ZGzowof
         BtJw==
X-Gm-Message-State: AJcUukdJ8PNGZZIwBDp9WsfllzEmg+mibrVNoeezHTEF0AUItlVafBQw
        MjtMOou2rhnbnJkjejYUTIesQNc6
X-Google-Smtp-Source: ALg8bN7fq61ncvugSa9N6PAtA9VEQj6ozAPGycqBm9Y5MHVnH4GKEPfiUB6cvnkj/Euu1m/7ngs47g==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr2982729wrr.285.1546984364848;
        Tue, 08 Jan 2019 13:52:44 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id w18sm9547056wmi.12.2019.01.08.13.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:44 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 8/8] checkout: introduce checkout.overlayMode config
Date:   Tue,  8 Jan 2019 21:52:25 +0000
Message-Id: <20190108215225.3077-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190108215225.3077-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patch we introduced a new no-overlay mode for git
checkout.  Some users (such as the author of this commit) may want to
have this mode turned on by default as it matches their mental model
more closely.  Make that possible by introducing a new config option
to that extend.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config/checkout.txt |  7 +++++++
 builtin/checkout.c                |  8 +++++++-
 t/t2025-checkout-no-overlay.sh    | 10 ++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index c4118fa196..73380a8d86 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -21,3 +21,10 @@ checkout.optimizeNewBranch::
 	will not update the skip-worktree bit in the index nor add/remove
 	files in the working directory to reflect the current sparse checkout
 	settings nor will it show the local changes.
+
+checkout.overlayMode::
+	In the default overlay mode, `git checkout` never
+	removes files from the index or the working tree.  When
+	setting `checkout.overlayMode` to false, files that appear in
+	the index and working tree, but not in <tree-ish> are removed,
+	to make them match <tree-ish> exactly.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0c5fe948ef..b5dfc45736 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1019,13 +1019,19 @@ static int switch_branches(const struct checkout_opts *opts,
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
+	struct checkout_opts *opts = cb;
+
 	if (!strcmp(var, "checkout.optimizenewbranch")) {
 		checkout_optimize_new_branch = git_config_bool(var, value);
 		return 0;
 	}
 
+	if (!strcmp(var, "checkout.overlaymode")) {
+		opts->overlay_mode = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "diff.ignoresubmodules")) {
-		struct checkout_opts *opts = cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index 76330cb5ab..a4912e35cb 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -44,4 +44,14 @@ test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
 	test_path_is_missing file1
 '
 
+test_expect_success 'checkout with checkout.overlayMode=false deletes files not in <tree-ish>' '
+	>file &&
+	mkdir dir &&
+	>dir/file1 &&
+	git add file dir/file1 &&
+	git -c checkout.overlayMode=false checkout HEAD -- file &&
+	test_path_is_missing file &&
+	test_path_is_file dir/file1
+'
+
 test_done
-- 
2.20.1.153.gd81d796ee0

