Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5189BC43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184D860241
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhDSTyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbhDSTyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:54:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45194C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c6so27062449qtc.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HdsnG9RAtQM047kS+hKns6Q95YlyVNkqy2vxOBuVbk4=;
        b=OFj9fVBi8wKaLqofhecoPCg0bm9pFrUnOIzB4C6yb0+eOg7RoxOja925Q1rnXPfB2n
         4JYj0Y2gVDXYalo4SM/aV/hT6tOLMM0OK8lQj3Pk5YWT3DzWvgrw04ROQD8MGbN0lE/R
         1qQMuTU3cUO2ty2qO/md450Bn3Aot6QtZW5fmeOLQBXacmyDsxE/vlIBG6qODKSxc/a4
         9ukVtuYO4I5hvFmhFhnb7FVMM82d/ehIEahW2DiPHOMcWoeXR2qXpHvBxM/iiM9dCCBE
         9/o5jYbuvh4Hozm7bVShjKOBdaXQKsORvHLX58uyImqU+E9+2f/rRPu2lLYZwjGrCbw7
         URrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HdsnG9RAtQM047kS+hKns6Q95YlyVNkqy2vxOBuVbk4=;
        b=ketqjYu0YxJjqCW3bn8aOd0IwCqVThVZlku1ZSoNiUsWERWGnLmz2OMXIyZ0c6O6uy
         bx/HkLyCV+1lb1yvIjJWMy5y97Cs3ltju4MgkpZGOSeoXAJhxTzZHK3JV4uhZO9vwDE0
         OS9xTHMSYGmkZQ1XHI/9zJGEiOtj/YuzEbb8rHvO1Ydm++zchnxtuNMoJi4eYvzVfRVZ
         ekr58lvqkncbOkCyF75kWo/LH5ujOAozeLdsFEwncxCjT6BlSgbs3hla2YM8re6tFvn5
         f07bfv2rBph8iRPzqMpmM+mXmggdMa56brNp6kcfPW8nWbI0pnDdmjKaPzITarj4oRTM
         VGAg==
X-Gm-Message-State: AOAM531fDu2/WBJJEugl2FSlbUqCCoWrYgDgWCjZByTN/wkD9vh8ErEu
        86xZV8Gb3BYU4xRQ7O2jL3VKjg==
X-Google-Smtp-Source: ABdhPJzjik/zcYLbB/thXSDac/xG1k94DayDes7fEbrkuhU3glxsOdJvSP4EgenJbjUOWqsKBYZ1kQ==
X-Received: by 2002:aed:3001:: with SMTP id 1mr13395743qte.344.1618862033321;
        Mon, 19 Apr 2021 12:53:53 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h3sm4479987qka.122.2021.04.19.12.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:53:52 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com
Subject: [PATCH v4 5/5] parallel-checkout: add design documentation
Date:   Mon, 19 Apr 2021 16:53:35 -0300
Message-Id: <fd929f072c040f738212ec769df7cb632356f8d1.1618861380.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1618861380.git.matheus.bernardino@usp.br>
References: <cover.1618861380.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/Makefile                        |   1 +
 Documentation/technical/parallel-checkout.txt | 270 ++++++++++++++++++
 2 files changed, 271 insertions(+)
 create mode 100644 Documentation/technical/parallel-checkout.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 81d1bf7a04..af236927c9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -90,6 +90,7 @@ TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/pack-protocol
+TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
 TECH_DOCS += technical/protocol-capabilities
 TECH_DOCS += technical/protocol-common
diff --git a/Documentation/technical/parallel-checkout.txt b/Documentation/technical/parallel-checkout.txt
new file mode 100644
index 0000000000..e790258a1a
--- /dev/null
+++ b/Documentation/technical/parallel-checkout.txt
@@ -0,0 +1,270 @@
+Parallel Checkout Design Notes
+==============================
+
+The "Parallel Checkout" feature attempts to use multiple processes to
+parallelize the work of uncompressing the blobs, applying in-core
+filters, and writing the resulting contents to the working tree during a
+checkout operation. It can be used by all checkout-related commands,
+such as `clone`, `checkout`, `reset`, `sparse-checkout`, and others.
+
+These commands share the following basic structure:
+
+* Step 1: Read the current index file into memory.
+
+* Step 2: Modify the in-memory index based upon the command, and
+  temporarily mark all cache entries that need to be updated.
+
+* Step 3: Populate the working tree to match the new candidate index.
+  This includes iterating over all of the to-be-updated cache entries
+  and delete, create, or overwrite the associated files in the working
+  tree.
+
+* Step 4: Write the new index to disk.
+
+Step 3 is the focus of the "parallel checkout" effort described here.
+
+Sequential Implementation
+-------------------------
+
+For the purposes of discussion here, the current sequential
+implementation of Step 3 is divided in 3 parts, each one implemented in
+its own function:
+
+* Step 3a: `unpack-trees.c:check_updates()` contains a series of
+  sequential loops iterating over the `cache_entry`'s array. The main
+  loop in this function calls the Step 3b function for each of the
+  to-be-updated entries.
+
+* Step 3b: `entry.c:checkout_entry()` examines the existing working tree
+  for file conflicts, collisions, and unsaved changes. It removes files
+  and creates leading directories as necessary. It calls the Step 3c
+  function for each entry to be written.
+
+* Step 3c: `entry.c:write_entry()` loads the blob into memory, smudges
+  it if necessary, creates the file in the working tree, writes the
+  smudged contents, calls `fstat()` or `lstat()`, and updates the
+  associated `cache_entry` struct with the stat information gathered.
+
+It wouldn't be safe to perform Step 3b in parallel, as there could be
+race conditions between file creations and removals. Instead, the
+parallel checkout framework lets the sequential code handle Step 3b,
+and uses parallel workers to replace the sequential
+`entry.c:write_entry()` calls from Step 3c.
+
+Rejected Multi-Threaded Solution
+--------------------------------
+
+The most "straightforward" implementation would be to spread the set of
+to-be-updated cache entries across multiple threads. But due to the
+thread-unsafe functions in the ODB code, we would have to use locks to
+coordinate the parallel operation. An early prototype of this solution
+showed that the multi-threaded checkout would bring performance
+improvements over the sequential code, but there was still too much lock
+contention. A `perf` profiling indicated that around 20% of the runtime
+during a local Linux clone (on an SSD) was spent in locking functions.
+For this reason this approach was rejected in favor of using multiple
+child processes, which led to a better performance.
+
+Multi-Process Solution
+----------------------
+
+Parallel checkout alters the aforementioned Step 3 to use multiple
+`checkout--worker` background processes to distribute the work. The
+long-running worker processes are controlled by the foreground Git
+command using the existing run-command API.
+
+Overview
+~~~~~~~~
+
+Step 3b is only slightly altered; for each entry to be checked out, the
+main process performs the following steps:
+
+* M1: Check whether there is any untracked or unclean file in the
+  working tree which would be overwritten by this entry, and decide
+  whether to proceed (removing the file(s)) or not.
+
+* M2: Create the leading directories.
+
+* M3: Load the conversion attributes for the entry's path.
+
+* M4: Check, based on the entry's type and conversion attributes,
+  whether the entry is eligible for parallel checkout (more on this
+  later). If it is eligible, enqueue the entry and the loaded
+  attributes to later write the entry in parallel. If not, write the
+  entry right away, using the default sequential code.
+
+Note: we save the conversion attributes associated with each entry
+because the workers don't have access to the main process' index state,
+so they can't load the attributes by themselves (and the attributes are
+needed to properly smudge the entry). Additionally, this has a positive
+impact on performance as (1) we don't need to load the attributes twice
+and (2) the attributes machinery is optimized to handle paths in
+sequential order.
+
+After all entries have passed through the above steps, the main process
+checks if the number of enqueued entries is sufficient to spread among
+the workers. If not, it just writes them sequentially. Otherwise, it
+spawns the workers and distributes the queued entries uniformly in
+continuous chunks. This aims to minimize the chances of two workers
+writing to the same directory simultaneously, which could increase lock
+contention in the kernel.
+
+Then, for each assigned item, each worker:
+
+* W1: Checks if there is any non-directory file in the leading part of
+  the entry's path or if there already exists a file at the entry' path.
+  If so, mark the entry with `PC_ITEM_COLLIDED` and skip it (more on
+  this later).
+
+* W2: Creates the file (with O_CREAT and O_EXCL).
+
+* W3: Loads the blob into memory (inflating and delta reconstructing
+  it).
+
+* W4: Applies any required in-process filter, like end-of-line
+  conversion and re-encoding.
+
+* W5: Writes the result to the file descriptor opened at W2.
+
+* W6: Calls `fstat()` or lstat()` on the just-written path, and sends
+  the result back to the main process, together with the end status of
+  the operation and the item's identification number.
+
+Note that, when possible, steps W3 to W5 are delegated to the streaming
+machinery, removing the need to keep the entire blob in memory.
+
+If the worker fails to read the blob or to write it to the working tree,
+it removes the created file to avoid leaving empty files behind. This is
+the *only* time a worker is allowed to remove a file.
+
+As mentioned earlier, it is the responsibility of the main process to
+remove any file that blocks the checkout operation (or abort if the
+removal(s) would cause data loss and the user didn't ask to `--force`).
+This is crucial to avoid race conditions and also to properly detect
+path collisions at Step W1.
+
+After the workers finish writing the items and sending back the required
+information, the main process handles the results in two steps:
+
+- First, it updates the in-memory index with the `lstat()` information
+  sent by the workers. (This must be done first as this information
+  might me required in the following step.)
+
+- Then it writes the items which collided on disk (i.e. items marked
+  with `PC_ITEM_COLLIDED`). More on this below.
+
+Path Collisions
+---------------
+
+Path collisions happen when two different paths correspond to the same
+entry in the file system. E.g. the paths 'a' and 'A' would collide in a
+case-insensitive file system.
+
+The sequential checkout deals with collisions in the same way that it
+deals with files that were already present in the working tree before
+checkout. Basically, it checks if the path that it wants to write
+already exists on disk, makes sure the existing file doesn't have
+unsaved data, and then overwrites it. (To be more pedantic: it deletes
+the existing file and creates the new one.) So, if there are multiple
+colliding files to be checked out, the sequential code will write each
+one of them but only the last will actually survive on disk.
+
+Parallel checkout aims to reproduce the same behavior. However, we
+cannot let the workers racily write to the same file on disk. Instead,
+the workers detect when the entry that they want to check out would
+collide with an existing file, and mark it with `PC_ITEM_COLLIDED`.
+Later, the main process can sequentially feed these entries back to
+`checkout_entry()` without the risk of race conditions. On clone, this
+also has the effect of marking the colliding entries to later emit a
+warning for the user, like the classic sequential checkout does.
+
+The workers are able to detect both collisions among the entries being
+concurrently written and collisions between a parallel-eligible entry
+and an ineligible entry. The general idea for collision detection is
+quite straightforward: for each parallel-eligible entry, the main
+process must remove all files that prevent this entry from being written
+(before enqueueing it). This includes any non-directory file in the
+leading path of the entry. Later, when a worker gets assigned the entry,
+it looks again for the non-directories files and for an already existing
+file at the entry's path. If any of these checks finds something, the
+worker knows that there was a path collision.
+
+Because parallel checkout can distinguish path collisions from the case
+where the file was already present in the working tree before checkout,
+we could alternatively choose to skip the checkout of colliding entries.
+However, each entry that doesn't get written would have NULL `lstat()`
+fields on the index. This could cause performance penalties for
+subsequent commands that need to refresh the index, as they would have
+to go to the file system to see if the entry is dirty. Thus, if we have
+N entries in a colliding group and we decide to write and `lstat()` only
+one of them, every subsequent `git-status` will have to read, convert,
+and hash the written file N - 1 times. By checking out all colliding
+entries (like the sequential code does), we only pay the overhead once,
+during checkout.
+
+Eligible Entries for Parallel Checkout
+--------------------------------------
+
+As previously mentioned, not all entries passed to `checkout_entry()`
+will be considered eligible for parallel checkout. More specifically, we
+exclude:
+
+- Symbolic links; to avoid race conditions that, in combination with
+  path collisions, could cause workers to write files at the wrong
+  place. For example, if we were to concurrently check out a symlink
+  'a' -> 'b' and a regular file 'A/f' in a case-insensitive file system,
+  we could potentially end up writing the file 'A/f' at 'a/f', due to a
+  race condition.
+
+- Regular files that require external filters (either "one shot" filters
+  or long-running process filters). These filters are black-boxes to Git
+  and may have their own internal locking or non-concurrent assumptions.
+  So it might not be safe to run multiple instances in parallel.
++
+Besides, long-running filters may use the delayed checkout feature to
+postpone the return of some filtered blobs. The delayed checkout queue
+and the parallel checkout queue are not compatible and should remain
+separate.
++
+Note: regular files that only require internal filters, like end-of-line
+conversion and re-encoding, are eligible for parallel checkout.
+
+Ineligible entries are checked out by the classic sequential codepath
+*before* spawning workers.
+
+Note: submodules's files are also eligible for parallel checkout (as
+long as they don't fall into any of the excluding categories mentioned
+above). But since each submodule is checked out in its own child
+process, we don't mix the superproject's and the submodules' files in
+the same parallel checkout process or queue.
+
+The API
+-------
+
+The parallel checkout API was designed with the goal of minimizing
+changes to the current users of the checkout machinery. This means that
+they don't have to call a different function for sequential or parallel
+checkout. As already mentioned, `checkout_entry()` will automatically
+insert the given entry in the parallel checkout queue when this feature
+is enabled and the entry is eligible; otherwise, it will just write the
+entry right away, using the sequential code. In general, callers of the
+parallel checkout API should look similar to this:
+
+----------------------------------------------
+int pc_workers, pc_threshold, err = 0;
+struct checkout state;
+
+get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+
+/*
+ * This check is not strictly required, but it
+ * should save some time in sequential mode.
+ */
+if (pc_workers > 1)
+	init_parallel_checkout();
+
+for (each cache_entry ce to-be-updated)
+	err |= checkout_entry(ce, &state, NULL, NULL);
+
+err |= run_parallel_checkout(&state, pc_workers, pc_threshold, NULL, NULL);
+----------------------------------------------
-- 
2.30.1

