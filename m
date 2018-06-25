Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2AB1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934424AbeFYOew (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:34:52 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44854 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934420AbeFYOeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:50 -0400
Received: by mail-qt0-f196.google.com with SMTP id 92-v6so7651914qta.11
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJM+T7MNz5IuPSlUuCw23Ihaf2AtqsSIaHYWRjgoraY=;
        b=crxO0E6RcDrGikm4zbFhgH0pMSd9HCYOrF8hRGktau4bXXCjzWuMN2AlFSs/Qj4hj7
         kk2nGAR5L6ffaF+tBON46yNJeL2JzlNN3h0c/Kqqdp9KlaRl76PivZ3kAQgI2vNm0fNz
         9m7WmovAYzFetrhkbVhjc2ukt5Rw5BGjWsmJDUOaF235LuLiT9d29SkMqNOBm9Kgb91y
         0aCHIhuT7ffxYepWgSCbtEDPQuJquGA3IGXCKujPQs6LII2CGHJ71bLrJGx5YN0iiBP7
         5+WbN7rQzXqRgvAPBxbq8Dc0afPJRIwNC3xaGoYcVr31T4B02eC/MLA5sLSDGODDwWmP
         dKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJM+T7MNz5IuPSlUuCw23Ihaf2AtqsSIaHYWRjgoraY=;
        b=iZJgmZqcdG4Fi+1ktH1et69KbbqcYaNeKlWnxO7N/qvCQqnX43/hQAGCbwOP7Mjesb
         0UDUpPEIudjxDZMqMWIMPrG4Uh2r+aQwnQmhqXxc36cPRHHmyVix51ZfitsZMQ4Q0ZZb
         sf0d1b4AGr3JDaFQGgb7Spg69um+oE7kvXohX00SEocbWmfJvtL45gE8E+sfgru+t/0o
         96Ced3DpQ8/0hevdyvlDA4MHFLyj9BtOuYnnccPdB8dvpUyG85QvlDjtEhHb/06jFvx1
         EldMkKqab4Twu+WbyyYsKUw0uahfjDW8OmiFnNCf1z+8fEpl6SQKKjcXzcfhg6xuGbhJ
         fxKg==
X-Gm-Message-State: APt69E09JkpvRKp9WHk487iXuaVCmCBxZvDcLOxPl47gE6HWnVC0pr0I
        SovE2EVk3G4DNA2S17QdXH0IPiPd
X-Google-Smtp-Source: AAOMgpezvudmIiTn0bAcX3UqibkqIDdkd1H9mV6qzxn6Owwv2bwFc3+qkKxP6XVIUmiLVYDrqZjxsQ==
X-Received: by 2002:ac8:6750:: with SMTP id n16-v6mr10967845qtp.423.1529937289742;
        Mon, 25 Jun 2018 07:34:49 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:49 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 01/24] multi-pack-index: add design document
Date:   Mon, 25 Jun 2018 10:34:11 -0400
Message-Id: <20180625143434.89044-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/multi-pack-index.txt | 109 +++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/technical/multi-pack-index.txt

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
new file mode 100644
index 0000000000..d7e57639f7
--- /dev/null
+++ b/Documentation/technical/multi-pack-index.txt
@@ -0,0 +1,109 @@
+Multi-Pack-Index (MIDX) Design Notes
+====================================
+
+The Git object directory contains a 'pack' directory containing
+packfiles (with suffix ".pack") and pack-indexes (with suffix
+".idx"). The pack-indexes provide a way to lookup objects and
+navigate to their offset within the pack, but these must come
+in pairs with the packfiles. This pairing depends on the file
+names, as the pack-index differs only in suffix with its pack-
+file. While the pack-indexes provide fast lookup per packfile,
+this performance degrades as the number of packfiles increases,
+because abbreviations need to inspect every packfile and we are
+more likely to have a miss on our most-recently-used packfile.
+For some large repositories, repacking into a single packfile
+is not feasible due to storage space or excessive repack times.
+
+The multi-pack-index (MIDX for short) stores a list of objects
+and their offsets into multiple packfiles. It contains:
+
+- A list of packfile names.
+- A sorted list of object IDs.
+- A list of metadata for the ith object ID including:
+  - A value j referring to the jth packfile.
+  - An offset within the jth packfile for the object.
+- If large offsets are required, we use another list of large
+  offsets similar to version 2 pack-indexes.
+
+Thus, we can provide O(log N) lookup time for any number
+of packfiles.
+
+Design Details
+--------------
+
+- The MIDX is stored in a file named 'multi-pack-index' in the
+  .git/objects/pack directory. This could be stored in the pack
+  directory of an alternate. It refers only to packfiles in that
+  same directory.
+
+- The pack.multiIndex config setting must be on to consume MIDX files.
+
+- The file format includes parameters for the object ID hash
+  function, so a future change of hash algorithm does not require
+  a change in format.
+
+- The MIDX keeps only one record per object ID. If an object appears
+  in multiple packfiles, then the MIDX selects the copy in the most-
+  recently modified packfile.
+
+- If there exist packfiles in the pack directory not registered in
+  the MIDX, then those packfiles are loaded into the `packed_git`
+  list and `packed_git_mru` cache.
+
+- The pack-indexes (.idx files) remain in the pack directory so we
+  can delete the MIDX file, set core.midx to false, or downgrade
+  without any loss of information.
+
+- The MIDX file format uses a chunk-based approach (similar to the
+  commit-graph file) that allows optional data to be added.
+
+Future Work
+-----------
+
+- Add a 'verify' subcommand to the 'git midx' builtin to verify the
+  contents of the multi-pack-index file match the offsets listed in
+  the corresponding pack-indexes.
+
+- The multi-pack-index allows many packfiles, especially in a context
+  where repacking is expensive (such as a very large repo), or
+  unexpected maintenance time is unacceptable (such as a high-demand
+  build machine). However, the multi-pack-index needs to be rewritten
+  in full every time. We can extend the format to be incremental, so
+  writes are fast. By storing a small "tip" multi-pack-index that
+  points to large "base" MIDX files, we can keep writes fast while
+  still reducing the number of binary searches required for object
+  lookups.
+
+- The reachability bitmap is currently paired directly with a single
+  packfile, using the pack-order as the object order to hopefully
+  compress the bitmaps well using run-length encoding. This could be
+  extended to pair a reachability bitmap with a multi-pack-index. If
+  the multi-pack-index is extended to store a "stable object order"
+  (a function Order(hash) = integer that is constant for a given hash,
+  even as the multi-pack-index is updated) then a reachability bitmap
+  could point to a multi-pack-index and be updated independently.
+
+- Packfiles can be marked as "special" using empty files that share
+  the initial name but replace ".pack" with ".keep" or ".promisor".
+  We can add an optional chunk of data to the multi-pack-index that
+  records flags of information about the packfiles. This allows new
+  states, such as 'repacked' or 'redeltified', that can help with
+  pack maintenance in a multi-pack environment. It may also be
+  helpful to organize packfiles by object type (commit, tree, blob,
+  etc.) and use this metadata to help that maintenance.
+
+- The partial clone feature records special "promisor" packs that
+  may point to objects that are not stored locally, but available
+  on request to a server. The multi-pack-index does not currently
+  track these promisor packs.
+
+Related Links
+-------------
+[0] https://bugs.chromium.org/p/git/issues/detail?id=6
+    Chromium work item for: Multi-Pack Index (MIDX)
+
+[1] https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/
+    An earlier RFC for the multi-pack-index feature
+
+[2] https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/
+    Git Merge 2018 Contributor's summit notes (includes discussion of MIDX)

base-commit: 53f9a3e157dbbc901a02ac2c73346d375e24978c
-- 
2.18.0.24.g1b579a2ee9

