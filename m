Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3377D1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754353AbeAGSPI (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 13:15:08 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39592 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeAGSPG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 13:15:06 -0500
Received: by mail-qk0-f195.google.com with SMTP id r8so7422913qke.6
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 10:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5BaJrW84J4hELVJe7MF13jQPYvlLKjp8ucS6gABAms=;
        b=YGT6gDhRnzYOapd0HaZ/5FR5bS0+207jEcZ9iUz9lypded0QkMNOG8VMG6qexUPL8Z
         GEus4xFLYKOjowMwQc7RVjQyfTalVBLgEYVYEGjjT0vvhkK2S2GgiDgrdRuxzTXmeY75
         Rs4JHdD+EGLSMxowJ5U3x4j6A2Yj3SBj6uIXV/3F1WGgieD4PGJR6P/dflL34Zt7zMcp
         hwKwgG4zgRK4g/bg/RER5nJKHuK27l6h7omM/KCnXRyP0yKn79zCRof6zEOPfzOpQy6A
         o5bESDRgl5vs4c5u/dSd8QoJ6MpvbZ8ybHBea/cmKxvf/ZlRu07yL5qHmpdDiR1F+XsU
         V88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5BaJrW84J4hELVJe7MF13jQPYvlLKjp8ucS6gABAms=;
        b=IMRYWum1q3aagTfrLMzB+MX3KbqKBGaRssWrssa4rij2wvo1I3B1WjQRnuAFCzTxij
         YaiRMZDeqzW7sRNINWJ2IhvQbZ8UFErDLBullNkDGwuFQ1fxKMhhW89+Z5u6jYkj3peB
         TB2cJ8S+QGYj7y82GdmQX2EdTyis/IOopfxt7BLqB06s+vpuJ9O0Tr1lMFuLauE5LO04
         k17k5pVzh55hx9a8ZD0EbacRGYUXbclsxgB9GvOyVIgazTNyri5STFpCxqXqTXnEufv+
         t0mE915SPZvUIGuAszPfjl6uCViT1oc239z4DYrg5H9WuRRMhdG6xPkK1N/eS1LBAZks
         u5QQ==
X-Gm-Message-State: AKwxytccH3rnbUgZDpm+GsubFP3xuRvpB09brgVSmrFRKpykyagyYdmX
        h1iLFcJCFq/lnAeaIlrXRIoH6L76vIo=
X-Google-Smtp-Source: ACJfBotLQqhPBb5IunZKA5Uy+M3s4vY4wUamoo78+lOBwVo1JOMJe/eeuUA8fjPcevBUM+c4tAslmA==
X-Received: by 10.55.162.140 with SMTP id l134mr13245212qke.124.1515348905193;
        Sun, 07 Jan 2018 10:15:05 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id f38sm6599763qtc.73.2018.01.07.10.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 10:15:04 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, stolee@gmail.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
Subject: [RFC PATCH 01/18] docs: Multi-Pack Index (MIDX) Design Notes
Date:   Sun,  7 Jan 2018 13:14:42 -0500
Message-Id: <20180107181459.222909-2-dstolee@microsoft.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180107181459.222909-1-dstolee@microsoft.com>
References: <20180107181459.222909-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commentary: This file format uses the large offsets from the pack-index
version 2 format, but drops the CRC32 hashes from that format.

Also: I included the HASH footer at the end only because it is already in
the pack and pack-index formats, but not because it is particularly useful
here. If possible, I'd like to remove it and speed up MIDX writes.

-- >8 --

Add a technical documentation file describing the design
for the multi-pack index (MIDX). Includes current limitations
and future work.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/multi-pack-index.txt | 149 +++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/technical/multi-pack-index.txt

diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
new file mode 100644
index 0000000000..d31b03dec5
--- /dev/null
+++ b/Documentation/technical/multi-pack-index.txt
@@ -0,0 +1,149 @@
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
+The multi-pack-index (MIDX for short, with suffix ".midx")
+stores a list of objects and their offsets into multiple pack-
+files. It contains:
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
+A new config setting 'core.midx' must be enabled before writing
+or reading MIDX files.
+
+The MIDX files are updated by the 'midx' builtin with the
+following common parameter combinations:
+
+- 'git midx' gives the hash of the current MIDX head.
+- 'git midx --write --update-head --delete-expired' writes a new
+  MIDX file, points the MIDX head to that file, and deletes the
+  existing MIDX file if out-of-date.
+- 'git midx --read' lists some basic information about the current
+  MIDX head. Used for basic tests.
+- 'git midx --clear' deletes the current MIDX head.
+
+Design Details
+--------------
+
+- The MIDX file refers only to packfiles in the same directory
+  as the MIDX file.
+
+- A special file, 'midx-head', stores the hash of the latest
+  MIDX file so we can load the file without performing a dirstat.
+  This file is especially important with incremental MIDX files,
+  pointing to the newest file.
+
+- If a packfile exists in the pack directory but is not referenced
+  by the MIDX file, then the packfile is loaded into the packed_git
+  list and Git can access the objects as usual. This behavior is
+  necessary since other tools could add packfiles to the pack
+  directory without notifying Git.
+
+- The MIDX file should be only a supplemental structure. If a
+  user downgrades or disables the `core.midx` config setting,
+  then the existing .idx and .pack files should be sufficient
+  to operate correctly.
+
+- The file format includes parameters for the object id length
+  and hash algorithm, so a future change of hash algorithm does
+  not require a change in format.
+
+- If an object appears in multiple packfiles, then only one copy
+  is stored in the MIDX. This has a possible performance issue:
+  If an object appears as the delta-base of multiple objects from
+  multiple packs, then cross-pack delta calculations may slow down.
+  This is currently only theoretical and has not been demonstrated
+  to be a measurable issue.
+
+Current Limitations
+-------------------
+
+- MIDX files are managed only by the midx builtin and is not
+  automatically updated on clone or fetch.
+
+- There is no '--verify' option for the midx builtin to verify
+  the contents of the MIDX file against the pack contents.
+
+- Constructing a MIDX file currently requires the single-pack
+  index for every pack being added to the MIDX.
+
+- The fsck builtin does not check MIDX files, but should.
+
+- The repack builtin is not aware of the MIDX files, and may
+  invalidate the MIDX files by deleting existing packfiles. The
+  MIDX may also be extended in the future to store metadata about
+  a packfile that can be used for faster repack commands.
+
+- The naive Git HTTP server advertises lists of packfiles using
+  the file system directly.
+
+Future Work
+-----------
+
+- The current file-format requires between 28 and 36 bytes per
+  object. As the repository grows, the MIDX file can become
+  very large and become a bottleneck when updating the file. To
+  fix this "big write" problem, we can make the MIDX file
+  incremental. Instead of just one MIDX file, we will have a
+  sequence of MIDX files that can be unioned together. Then
+  on write we take the new objects to add and consider how many
+  existing files should be merged into a new file containing
+  the latest objects.
+
+  This list of "base indexes" will be presented as an optional
+  chunk in the MIDX format and contains the OIDs for the base
+  files. Thus, the `midx_head` file only stores the OID for the
+  "tip" MIDX file and then the rest are loaded based on those
+  pointers, such as the following figure:
+
+  [     BIG     ] <- [ MEDIUM ] <- [tiny] <- midx_head
+	 ^___________________________|
+
+  The plan being that every write replaces the "tiny" index,
+  and when that index becomes large enough it merges with the
+  "medium" index and a new tiny index is created in the next
+  write. Very rarely, the "big" index would be updated, causing
+  a slow write.
+
+- After the MIDX feature is sufficiently hardened and widely used,
+  consider making Git more fully depend on the MIDX file. If MIDX
+  is the default, then we can delete the single-pack-indexes from
+  the pack directory. We could also allow thin packs in the pack
+  directory.
+
+- The MIDX could be extended to store a "stable object order" such
+  that adding objects to the order does not change the existing
+  objects. This would enable re-using the reachability bitmaps after
+  repacking and updating the MIDX file.
+
+Related Links
+-------------
+
+[0] https://bugs.chromium.org/p/git/issues/detail?id=6
+    Chromium work item for: Multi-Pack Index (MIDX)
+
+[1] https://public-inbox.org/git/CB5074CF.3AD7A%25joshua.redstone@fb.com/T/#u
+    Subject: Git performance results on a large repository
+    Date: 3 Feb 2012
+
-- 
2.15.0

