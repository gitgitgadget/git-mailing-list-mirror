Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC1AC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3891B64E2E
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 16:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhBWQ6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 11:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhBWQ6H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 11:58:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B5C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 08:57:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v21so3088375wml.4
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKkrXF4yaz37QyNB3FCv6EdYV3X3mvQ/nWuLY3/kyEs=;
        b=tD30fbm+AeXZnJP9vhjsjqQgoYpbS7SgelCSr0A1UasrBINFcxhkOdTdbuUffocELp
         mYISbFdxnN/dmZ9B8cTLZ/euTPHHqe87YftdYWryjCmtRJBJCsSJSjEePG/0FXpcotg0
         EBEfOK1HKzHDPeYEfdXG9RpLONTNcCorobGbcahu7A1/VXf13EBXPK3U1KQ/H2UZV3Fr
         /9bHHGSDVjXUSnV38h/q1CwHcZbA68ZcH3j+yGWReMRszZhWi7TpQnv2wBjU6iABXxll
         8C9GjVgTWIjxlFN7iwvg29GMrBL0LUgfq6+NIyZkFftDiySM3qfXTz9PzmO9NDqsGS76
         INNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uKkrXF4yaz37QyNB3FCv6EdYV3X3mvQ/nWuLY3/kyEs=;
        b=F7r0VQjsIPcm+NchaBkOojla7ftHrhv31bqQm35Sd/Q8xV2nbU251XuISHPd9wr9L1
         CYvGog6Y44qdJSA0cTEyx7TMOZCkGH9mMU4ecCi7QkQ37D6v9YSDvYCvLXKOHOiMJRB0
         USoq+9S55aqxM2Ifp3rJKCIQt9dl/lJcdZlsR+ADFSordKEMN5EWz34h8+JNpR0/0MNS
         yWb3bEa8G0OyYwXWFF+83Lb686/xMufE2WF8unuuxbvd5ahifM1DEa/U7hPDriydqDHo
         cXz0q4lPpo1fKUMVgfEKd5NmqxMQ9d6tNVUqE2W+HaME3o/ZBW1836UA/FGNKEAnw9FK
         gSFg==
X-Gm-Message-State: AOAM532yoQrX8A0YULHqkpPDH2eImf+uQxH+iYKDAtN2GtsMJWK3j7Jf
        yOYtcXM/fE164VIK4ZvoQIcjRMuvhAA=
X-Google-Smtp-Source: ABdhPJwprOpAMxhu8NH+dkCItB1dYms2VAud///G6wLo/8WjwcHr0jLrkgXSU8/zInJTI6Ma7IVbKA==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr26062060wmp.8.1614099444979;
        Tue, 23 Feb 2021 08:57:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm32684743wrr.41.2021.02.23.08.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:57:24 -0800 (PST)
Message-Id: <pull.951.v2.git.git.1614099444126.gitgitgadget@gmail.com>
In-Reply-To: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
References: <pull.951.git.git.1611589125365.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 16:57:23 +0000
Subject: [PATCH v2] doc/reftable: document how to handle windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

On Windows we can't delete or overwrite files opened by other processes. Here we
sketch how to handle this situation.

We propose to use a random element in the filename. It's possible to design an
alternate solution based on counters, but that would assign semantics to the
filenames that complicates implementation.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    doc/reftable: document how to handle windows
    
    On Windows we can't delete or overwrite files opened by other processes.
    Here we sketch how to handle this situation.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-951%2Fhanwen%2Fwindows-doc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-951/hanwen/windows-doc-v2
Pull-Request: https://github.com/git/git/pull/951

Range-diff vs v1:

 1:  a952bc478f86 ! 1:  e3854f2cc106 doc/reftable: document how to handle windows
     @@ Commit message
          On Windows we can't delete or overwrite files opened by other processes. Here we
          sketch how to handle this situation.
      
     +    We propose to use a random element in the filename. It's possible to design an
     +    alternate solution based on counters, but that would assign semantics to the
     +    filenames that complicates implementation.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Documentation/technical/reftable.txt ##
     -@@ Documentation/technical/reftable.txt: A collection of reftable files are stored in the `$GIT_DIR/reftable/`
     - directory:
     +@@ Documentation/technical/reftable.txt: A repository must set its `$GIT_DIR/config` to configure reftable:
     + Layout
     + ^^^^^^
       
     - ....
     +-A collection of reftable files are stored in the `$GIT_DIR/reftable/`
     +-directory:
     +-
     +-....
      -00000001-00000001.log
      -00000002-00000002.ref
      -00000003-00000003.ref
     -+00000001-00000001-RANDOM1.log
     -+00000002-00000002-RANDOM2.ref
     -+00000003-00000003-RANDOM3.ref
     - ....
     - 
     - where reftable files are named by a unique name such as produced by the
     +-....
     +-
     +-where reftable files are named by a unique name such as produced by the
      -function `${min_update_index}-${max_update_index}.ref`.
     -+function `${min_update_index}-${max_update_index}-${random}.ref`.
     ++A collection of reftable files are stored in the `$GIT_DIR/reftable/` directory.
     ++Their names should have a random element, such that each filename is globally
     ++unique; this helps avoid spurious failures on Windows, where open files cannot
     ++be removed or overwritten. It suggested to use
     ++`${min_update_index}-${max_update_index}-${random}.ref` as a naming convention.
       
       Log-only files use the `.log` extension, while ref-only and mixed ref
       and log files use `.ref`. extension.
     @@ Documentation/technical/reftable.txt: current files, one per line, in order, fro
       ....
       
       Readers must read `$GIT_DIR/reftable/tables.list` to determine which
     -@@ Documentation/technical/reftable.txt: Reftable files not listed in `tables.list` may be new (and about to be
     - added to the stack by the active writer), or ancient and ready to be
     - pruned.
     - 
     -+The random suffix added to table filenames ensures that we never attempt to
     -+overwrite an existing table, which is necessary for this scheme to work on
     -+Windows
     -+
     - Backward compatibility
     - ^^^^^^^^^^^^^^^^^^^^^^
     - 
      @@ Documentation/technical/reftable.txt: new reftable and atomically appending it to the stack:
       3.  Select `update_index` to be most recent file's
       `max_update_index + 1`.


 Documentation/technical/reftable.txt | 42 +++++++++++++++++-----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 8095ab2590c8..3ef169af27d8 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -872,17 +872,11 @@ A repository must set its `$GIT_DIR/config` to configure reftable:
 Layout
 ^^^^^^
 
-A collection of reftable files are stored in the `$GIT_DIR/reftable/`
-directory:
-
-....
-00000001-00000001.log
-00000002-00000002.ref
-00000003-00000003.ref
-....
-
-where reftable files are named by a unique name such as produced by the
-function `${min_update_index}-${max_update_index}.ref`.
+A collection of reftable files are stored in the `$GIT_DIR/reftable/` directory.
+Their names should have a random element, such that each filename is globally
+unique; this helps avoid spurious failures on Windows, where open files cannot
+be removed or overwritten. It suggested to use
+`${min_update_index}-${max_update_index}-${random}.ref` as a naming convention.
 
 Log-only files use the `.log` extension, while ref-only and mixed ref
 and log files use `.ref`. extension.
@@ -893,9 +887,9 @@ current files, one per line, in order, from oldest (base) to newest
 
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
@@ -940,7 +934,7 @@ new reftable and atomically appending it to the stack:
 3.  Select `update_index` to be most recent file's
 `max_update_index + 1`.
 4.  Prepare temp reftable `tmp_XXXXXX`, including log entries.
-5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}.ref`.
+5.  Rename `tmp_XXXXXX` to `${update_index}-${update_index}-${random}.ref`.
 6.  Copy `tables.list` to `tables.list.lock`, appending file from (5).
 7.  Rename `tables.list.lock` to `tables.list`.
 
@@ -993,7 +987,7 @@ prevents other processes from trying to compact these files.
 should always be the case, assuming that other processes are adhering to
 the locking protocol.
 7.  Rename `${min_update_index}-${max_update_index}_XXXXXX` to
-`${min_update_index}-${max_update_index}.ref`.
+`${min_update_index}-${max_update_index}-${random}.ref`.
 8.  Write the new stack to `tables.list.lock`, replacing `B` and `C`
 with the file from (4).
 9.  Rename `tables.list.lock` to `tables.list`.
@@ -1005,6 +999,22 @@ This strategy permits compactions to proceed independently of updates.
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
