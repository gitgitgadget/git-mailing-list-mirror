Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A106BC433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CD322D58
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbhAZFAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbhAYPja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 10:39:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90298C061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 07:38:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id p15so6447436wrq.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4oJUGnvMwzYlMk2bIlkDr0NXpz+uOgBGqCT0MQoFvAc=;
        b=RgXhx1ajmfMURGZi7kktXnDdv3oiZDbDcQRXT4EWXCjGjrhH04IELtKWLARnEU3PNO
         HLKUvPW/T9PYg9TPuJXynvWKFPtKOEY+9L/wn23XWKzaES7A/o0uZOgt7CfMt5CVPuyD
         oR5rP7SMbCt99RLbktfFzJtSr3BsGmRTxToPZW1Irf6HkdyMHOAiuZnaS0KZDlASTdmA
         y5IeMO9rCr4CD/4Bff0oMxPRNf89Kxkmc57uDDAcyc/4sXTz+FWvOYOR8nZVuKLZdpln
         wrKHnHir9voQ+gFlej7y1BCrMLtNTXSyT72sspX2QlfP9nnaoIUAsZeY5Zwwhi4ln4E9
         kAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4oJUGnvMwzYlMk2bIlkDr0NXpz+uOgBGqCT0MQoFvAc=;
        b=Y0m9Q3SWs7k2C4NC0Fn23iYHa3BBW7TnD0WnIds7n3cG3uL/gUcZZehvVL4IWcmYot
         idqbjL6fWOkQpomIRUa++NZsowSkWTlIcSuxGjzpO3erlVi5AyeMeuCFGKLOcdfbtJav
         RF6jQhM/LWJH7bY9tGtmgN7oqg8q+Eeljh02Ky2jVUfd64FN6VR2jJPeAg2h7HPisB3C
         VNQ6uxOLO7FVcloEV3l5XLRbL6TzgUUvHf/DhqEaSLumB3G9N45hhKOqTNwbV/r+TFom
         jAiCtrf4RwqKPSYNkNNjVJaBEq0buBFNHpQjzWDuSue3yArLEcroBJAegz6wX8I7xC2l
         K29w==
X-Gm-Message-State: AOAM531WJco7r5mE9CZ9muJaz0K/8syXrpV3gU0yyrlN6nMBbvnBHeTl
        +IpBZoeWxAZBGggIrWxtGuWkJsmPZB8=
X-Google-Smtp-Source: ABdhPJxYzd+Jwa6wjH9CyyeGg9BTAfAiJmjWpm9PHEsPR4V5Ava9TII8/OrkV0s+m1slaUUXfNgQeQ==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr1658977wry.356.1611589127044;
        Mon, 25 Jan 2021 07:38:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z130sm21179823wmb.33.2021.01.25.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:38:46 -0800 (PST)
Message-Id: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jan 2021 15:38:45 +0000
Subject: [PATCH] doc/reftable: document how to handle windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

On Windows we can't delete or overwrite files opened by other processes. Here we
sketch how to handle this situation.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    doc/reftable: document how to handle windows
    
    On Windows we can't delete or overwrite files opened by other processes.
    Here we sketch how to handle this situation.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-951%2Fhanwen%2Fwindows-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-951/hanwen/windows-doc-v1
Pull-Request: https://github.com/git/git/pull/951

 Documentation/technical/reftable.txt | 38 +++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 8095ab2590c..d8be27d88c1 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -876,13 +876,13 @@ A collection of reftable files are stored in the `$GIT_DIR/reftable/`
 directory:
 
 ....
-00000001-00000001.log
-00000002-00000002.ref
-00000003-00000003.ref
+00000001-00000001-RANDOM1.log
+00000002-00000002-RANDOM2.ref
+00000003-00000003-RANDOM3.ref
 ....
 
 where reftable files are named by a unique name such as produced by the
-function `${min_update_index}-${max_update_index}.ref`.
+function `${min_update_index}-${max_update_index}-${random}.ref`.
 
 Log-only files use the `.log` extension, while ref-only and mixed ref
 and log files use `.ref`. extension.
@@ -893,9 +893,9 @@ current files, one per line, in order, from oldest (base) to newest
 
 ....
 $ cat .git/reftable/tables.list
-00000001-00000001.log
-00000002-00000002.ref
-00000003-00000003.ref
+00000001-00000001-RANDOM1.log
+00000002-00000002-RANDOM2.ref
+00000003-00000003-RANDOM3.ref
 ....
 
 Readers must read `$GIT_DIR/reftable/tables.list` to determine which
@@ -906,6 +906,10 @@ Reftable files not listed in `tables.list` may be new (and about to be
 added to the stack by the active writer), or ancient and ready to be
 pruned.
 
+The random suffix added to table filenames ensures that we never attempt to
+overwrite an existing table, which is necessary for this scheme to work on
+Windows
+
 Backward compatibility
 ^^^^^^^^^^^^^^^^^^^^^^
 
@@ -940,7 +944,7 @@ new reftable and atomically appending it to the stack:
 3.  Select `update_index` to be most recent file's
 `max_update_index + 1`.
 4.  Prepare temp reftable `tmp_XXXXXX`, including log entries.
-5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}.ref`.
+5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}-${random}.ref`.
 6.  Copy `tables.list` to `tables.list.lock`, appending file from (5).
 7.  Rename `tables.list.lock` to `tables.list`.
 
@@ -993,7 +997,7 @@ prevents other processes from trying to compact these files.
 should always be the case, assuming that other processes are adhering to
 the locking protocol.
 7.  Rename `${min_update_index}-${max_update_index}_XXXXXX` to
-`${min_update_index}-${max_update_index}.ref`.
+`${min_update_index}-${max_update_index}-${random}.ref`.
 8.  Write the new stack to `tables.list.lock`, replacing `B` and `C`
 with the file from (4).
 9.  Rename `tables.list.lock` to `tables.list`.
@@ -1005,6 +1009,22 @@ This strategy permits compactions to proceed independently of updates.
 Each reftable (compacted or not) is uniquely identified by its name, so
 open reftables can be cached by their name.
 
+Windows
+^^^^^^^
+
+On windows, and other systems that do not allow deleting or renaming to open
+files, compaction may succeed, but other readers may prevent obsolete tables
+from being deleted.
+
+On these platforms, the following strategy can be followed: on closing a
+reftable stack, reload `tables.list`, and delete any tables no longer mentioned
+in `tables.list`.
+
+Irregular program exit may still leave about unused files. In this case, a
+cleanup operation can read `tables.list`, note its modification timestamp, and
+delete any unreferenced `*.ref` files that are older.
+
+
 Alternatives considered
 ~~~~~~~~~~~~~~~~~~~~~~~
 

base-commit: 66e871b6647ffea61a77a0f82c7ef3415f1ee79c
-- 
gitgitgadget
