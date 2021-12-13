Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhLMWDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhLMWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:03:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1ECC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:03:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k4so12159800plx.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBrShAYrDyWiG6zueyDaVBiODxw+Assahd5lIC7YI2Q=;
        b=SCdiLtjqGHE4XR2HTNgH4tAUqbSYK9H+7W/lmUHOWJ7SiLTq/Kp2lJBZx5JIrwHDkU
         1VcWwFo0PZucFk0piKJkEUggKLfalT51lFvhhexvKQp391idmPzNItYDzGWcjSdyzPaH
         I4OPKq9tb/QIlOe1FW1RHKAjGhRiwFWkkBcmw6Y50fYjj8A8JGFHdc1k0dXYinrf2r8r
         cIiiPaPf/jg/cbPj3xKwD89WLSiw92iKZNMxq/LFSHZuVGbo8BWi5NF70uByXaPx084w
         uuC6oIz5VE3n3pE2j9xyKtWQJ787RjE6wSbAPzqttcjKmtG3c2XnEC+j7RbzuiNx2ZHK
         425Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBrShAYrDyWiG6zueyDaVBiODxw+Assahd5lIC7YI2Q=;
        b=Li9IeCexV0SbF9TrsjyR8xW4ygQV9+ffPyengK/WjhhgSWgwGDpDic7oqpBil//2OI
         wY79SqIkKk4pqBw9zt4HJnEdAzdNRNFU0wh3/kkok2y8CA5rpAGU0NU5y24lfzVr6wKy
         6bdsni5+cnCafKt2onESeOoc/sxhxaHAHPvu1JPmdzRJQRScQBV1U0b3xfee5eSrArWS
         AxYlWtb0DCK8/wrNyHmNM1mkA8HEl95oWpOZ2kT8S9I7EtSB99z5n7VJqozAb3wZW98I
         P9mopG5E6667DYBFvm2JCl325OEvyAzVdD7Vc+XiiBze1sX7JfV/dc+SIDBY4MW9MWJn
         jxIg==
X-Gm-Message-State: AOAM531KTZfwjEMTFXYn6GzKs1Bh4hSZKaSussFHVj3QCkB/UA4x5rso
        cU30gHXSFXmHjaJ4/ItGbpFQSOxFIxonog==
X-Google-Smtp-Source: ABdhPJyH2Sz6f1P0to9DARhNfksiF4irWtbs/M7IkBv9CAzbKw3Dv2T56b60M42wFsmO+MvDN3yAtw==
X-Received: by 2002:a17:902:7c8a:b0:143:bb4a:7bb3 with SMTP id y10-20020a1709027c8a00b00143bb4a7bb3mr1604855pll.46.1639433010450;
        Mon, 13 Dec 2021 14:03:30 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id e14sm14691905pfv.18.2021.12.13.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:03:30 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3 1/2] git-apply: add --quiet flag
Date:   Mon, 13 Dec 2021 14:03:26 -0800
Message-Id: <20211213220327.16042-1-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.186.g7a78fc126e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace OPT_VERBOSE with OPT_VERBOSITY.

This adds a --quiet flag to "git apply" so
the user can turn down the verbosity.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V2->V3 
- Reorganized into a patch series to capture
dependencies between 2 git apply changes.

 Documentation/git-apply.txt | 7 ++++++-
 apply.c                     | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index aa1ae56a25..a32ad64718 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,11 +14,11 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
 	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [--unsafe-paths] [<patch>...]
+	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
 
 DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to files.
 When running from a subdirectory in a repository, patched paths
@@ -226,10 +226,15 @@ behavior:
 --verbose::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
+-q::
+--quiet::
+	Suppress stderr output. Messages about patch status and progress
+	will not be printed.
+
 --recount::
 	Do not trust the line counts in the hunk headers, but infer them
 	by inspecting the patch (e.g. after editing the patch without
 	adjusting the hunk headers appropriately).
 
diff --git a/apply.c b/apply.c
index 64b226acd9..9f00f882a2 100644
--- a/apply.c
+++ b/apply.c
@@ -5071,11 +5071,11 @@ int apply_parse_options(int argc, const char **argv,
 			N_("don't expect at least one line of context")),
 		OPT_BOOL(0, "reject", &state->apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+		OPT__VERBOSITY(&state->apply_verbosity),
 		OPT_BIT(0, "inaccurate-eof", options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
 		OPT_BIT(0, "recount", options,
 			N_("do not trust the line counts in the hunk headers"),
-- 
2.32.0.1314.g6ed4fcc4cc

