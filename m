Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D8C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E2020716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyLqBmQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgA1S0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:26:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46437 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1S0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so17177351wrl.13
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=FyLqBmQaP8DukXvPt0x5os6o/PdYnQ4LLeJVjOvrg0NtfzFlZmWGQEnJNEjHOXELG7
         kfLFy1ndsSjOtnQJwCmIH9zCLO3CVBn564Mqi8XZqeSGBqYu9yszfaM0zG9oAeHbCJKh
         l5iaW+/OxEeqBJIayiX6HIc7Cjm1xGt5J01qLX3yJO/s8gi8QEdq6FLScZIYg57e5QtS
         zvE2Jzvhgc+L4Ygte4H2rfFNFz+MA3HRLOBjsUsh5LwFyl3xxbL3iytY96feVUTYjHiM
         BCEClHfNOaixIHgQiVLBVmuRaU25gL6A1qTCapWo4e8c7Qypl+RDCxMWBVqZAAySRx7+
         dDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KDhiP/nTsJtYltovU0qLNJhnLe1wUUQjqGoJo1gXOog=;
        b=nm3YugBrjN9vLxO5quL6UM0+KqgPPHdd3o3ejnq1rrSEbhFJ+/lraEwPRpbgZAlFR9
         a6KnrLvzDMFxr7FFRzzh2hcaT3uW+WM93eiqDLtgePthyYgLSLwBdvmS1al+NwYtD/WQ
         gyD9Lr6h7kZHl2/FNwi3XH9Ah0MKgFiCglFCJh9Z6oYXtx/ye5pz06D3p2Mts/YWzVTa
         xiLRObtc4EIepJifoCa8hJy40CdV1Sn33UUa38xs+nVwW6t97KqppIT8eTSQM4Nwi+r2
         yqdUpbYdcxHDUkQtjxrqxIA7mEXPe769L/40uLkUudOzSXZrEwwf6j/9mJ9EJSNPml1R
         pekg==
X-Gm-Message-State: APjAAAXxDAAdHT7qtU/OwmxwUrVdurF2aCH4kza5G9YV9XHr4BFf0+Ye
        J1nscveA5a3pDgHGfypmalnIfpRQ
X-Google-Smtp-Source: APXvYqzrV8gr+E0y+emmzs0oKtTaGs7R8eZleQyFAn3D1TgUZpoi6cTTtH3FlIdKjpMeeAf8aybj0g==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr31258993wrw.313.1580236007908;
        Tue, 28 Jan 2020 10:26:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10sm27127510wrw.64.2020.01.28.10.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:47 -0800 (PST)
Message-Id: <4991a51f6d5d840eaa3bb830e68f1530c2ee08e4.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:35 +0000
Subject: [PATCH v3 04/12] clone: fix --sparse option with URLs
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

The --sparse option was added to the clone builtin in d89f09c (clone:
add --sparse mode, 2019-11-21) and was tested with a local path clone
in t1091-sparse-checkout-builtin.sh. However, due to a difference in
how local paths are handled versus URLs, this mechanism does not work
with URLs.

Modify the test to use a "file://" URL, which would output this error
before the code change:

  Cloning into 'clone'...
  fatal: cannot change to 'file://.../repo': No such file or directory
  error: failed to initialize sparse-checkout

These errors are due to using a "-C <path>" option to call 'git -C
<path> sparse-checkout init' but the URL is being given instead of
the target directory.

Update that target directory to evaluate this correctly. I have also
manually tested that https:// URLs are handled correctly as well.

Acked-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/clone.c                    | 2 +-
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4348d962c9..2caefc44fb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,7 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	if (option_sparse_checkout && git_sparse_checkout_init(repo))
+	if (option_sparse_checkout && git_sparse_checkout_init(dir))
 		return 1;
 
 	remote = remote_get(option_origin);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 43d1f7520c..cf4a595c86 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -90,7 +90,7 @@ test_expect_success 'init with existing sparse-checkout' '
 '
 
 test_expect_success 'clone --sparse' '
-	git clone --sparse repo clone &&
+	git clone --sparse "file://$(pwd)/repo" clone &&
 	git -C clone sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
 	/*
-- 
gitgitgadget

