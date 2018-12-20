Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362CC1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbeLTNsz (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35021 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733309AbeLTNsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so1841078wrb.2
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF2/23HtdHDIPq8B9BHlPJcIY6KTtXVFkrsxLTxSbI0=;
        b=WKTAg3t92g6mSSOGsZGT53uV0/Qs5CmdRXAwQcshEttSRrJENlQV8+bw0OAZkMroVN
         JzGtes7r2ttEF4WPb4KsfXnjaxRmAv0XUc49dD4FsY4186GXDOwqi/1NlCtDteC+p58z
         lf++DAA/66vi90S9Tpfmhtz91LHNYGtKeaBAjaBSFa4To7xUTtlHbWS2yQdw68BunX+M
         brENU60RdYNviDvOoqm53mWkjF780xK1vHY/roZySHytn9CpLIbZQAw9ls3yPPR/Ox+O
         drCtq81sIL4ZD9ux0zwMPBJMnNYn/wiMQPbfulhxoCSMeq2zPeLtuhY+Ac5KaI9s+re6
         Z9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF2/23HtdHDIPq8B9BHlPJcIY6KTtXVFkrsxLTxSbI0=;
        b=Qhop5PjJ+MqTD+nJD/cBZ/o5sxKvYFf4/4dcnfoslX7rNK6JqMcqbHXJ3FcSH/elgj
         fc0Xuwxp4PbGBFwfMqANcdkpjynVypTepwECkLQc2iJe73z2GbE/GFUGDWvupcONx03U
         TRFb0l8abQZHGo8K2SL1tBIHCmLO/L17ex33UD835oKQ5feInHRLRZvJWomjkZtWRBCD
         F0vC5hd4VD5Vni8mJmq4vd2v0zuqo00LAKXGdJrOlyUtEtfa3TuIhUfmNeG4rg9IfjdQ
         PxSN9zPCnSvQejkwh3p9PPVA0T5CIXv+8Y/IOQmwsnr8NVEYRnUO8LVk5tlGlBMEpB51
         Dhmw==
X-Gm-Message-State: AA+aEWZ6DxBRQ1EZvHYpUvNWZK1uafjeIGtcNKuipNGs/Np7CTl3NdhH
        kKT/UdKfDPnK6vsHV6SnjqPbn3Pljyo=
X-Google-Smtp-Source: AFSGD/Wrd0qBBGrGZ/4VDdgqGq/Ng/L48cr8Z1Iuha5MNWJrlvQfaXx5XuCL1egyE/Aydy3KYISXrg==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr22475096wrs.319.1545313730040;
        Thu, 20 Dec 2018 05:48:50 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id r77sm11954684wmd.22.2018.12.20.05.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:49 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 8/8] checkout: introduce checkout.overlayMode config
Date:   Thu, 20 Dec 2018 13:48:20 +0000
Message-Id: <20181220134820.21810-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
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
index c4118fa196..53f917e15e 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -21,3 +21,10 @@ checkout.optimizeNewBranch::
 	will not update the skip-worktree bit in the index nor add/remove
 	files in the working directory to reflect the current sparse checkout
 	settings nor will it show the local changes.
+
+checkout.overlayMode::
+	In the default overlay mode files `git checkout` never
+	removes files from the index or the working tree.  When
+	setting checkout.overlayMode to false, files that appear in
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
2.20.1.415.g653613c723

