Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C0C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D5664EFE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhBEQoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBEQkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E98C061786
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b3so8722810wrj.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=73PanmKylEvqjb3EGhj/cA5vVvduH5Ze/XXY8XVnxuQ=;
        b=nsaWo0Acznz94RcuDVOkVHR7bwQq/9yxFQKHhZ1rrd4eIvg4AGTQklmSTdh6ehKQ4U
         DHEQoVF8YH56hubuTL/GFdzIXzAmUQc+BzZtvLCfTxHRytIuF82NkVSy99gYjeNBrm1Z
         +QXuMPgubIXUlNzzMyxDls3GPwrmyw990f0EYuw/MD5drCj0QNNh5kKftpO9ahXWIw/f
         4EbL8D0Aa9y5JsPFKgdTMjz8czGhVFCxoDvtYslccUAqZNXSVt82gQADXAyIERj5Ddy9
         rAbAtxgEfSR47crLj2QdAI1QRoXL2wb3kJDpTI/7vb6cdU+sF2YTgTqFsoFTE1kLsahC
         MWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=73PanmKylEvqjb3EGhj/cA5vVvduH5Ze/XXY8XVnxuQ=;
        b=trumabbJQVrrb2FgDQMurOftNs07+/wETMAcUnlLWeAKf5RSpo0PjXARrcYgyXxYjz
         1zwN0XXrLFD5VIt6QJlj501ejOFUQRp601MEHErGTvlQsZ+A7ecIiZmjBD+2fLQb7s01
         VkWS2SgF64nei0+X+XL+ZqDSAsirJJNfmJH+JMe3MFNY3MjQuJVBGyT7OIx6AkFKurld
         M5h5c3v6EYltdtO27S7b+9WRlQnNhGajMbB/0M9LccNsEnSG1IfZmWHzNQeE+MqWY/Zb
         1ZY+NZ0qnhN25zm4GAmM59nucfjhpcJLpr6l7XAA+2eC+1MbMUM7lcIUIGAAqGa13wvI
         1thw==
X-Gm-Message-State: AOAM533g1VJNmcN4wXUDuBJkgs2gi240L2oF6VeiUM+NWWqJ2qpFcfgc
        ws7fnSkxfXjsyrS7NQEm85cwFQAOr9w=
X-Google-Smtp-Source: ABdhPJx1DrnkaMcj1oof76n15eFFn2AO67dNVamv4vP8/r0VhXX61EouiBSEKBMzzBtnDGfktxyt1A==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr6343594wrz.86.1612549352368;
        Fri, 05 Feb 2021 10:22:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm13194619wru.70.2021.02.05.10.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:31 -0800 (PST)
Message-Id: <7c78d0c1c30add2a8937e0a6fb725509738a858c.1612549349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:24 +0000
Subject: [PATCH v3 1/6] doc hash-function-transition: fix asciidoc output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Asciidoc requires lists to start with an empty line and uses
different characters for indentation levels ("-", "*", "**", ...).
For special symbols like a dash "--" has to be used and there is
no double arrow "<->", so a left and right arrow "<-->" has to be
combined for that. Lastly for verbatim output a newline followed
by an indentation has to be used.

Fix asciidoc output for lists, special characters and verbatim
text while retaining the readabilty of the original text file.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 .../technical/hash-function-transition.txt    | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 6fd20ebbc254..b23d23151a57 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -94,7 +94,7 @@ Overview
 --------
 We introduce a new repository format extension. Repositories with this
 extension enabled use SHA-256 instead of SHA-1 to name their objects.
-This affects both object names and object content --- both the names
+This affects both object names and object content -- both the names
 of objects and all references to other objects within an object are
 switched to the new hash function.
 
@@ -191,21 +191,21 @@ hash functions. They have the following format (all integers are in
 network byte order):
 
 - A header appears at the beginning and consists of the following:
-  - The 4-byte pack index signature: '\377t0c'
-  - 4-byte version number: 3
-  - 4-byte length of the header section, including the signature and
+  * The 4-byte pack index signature: '\377t0c'
+  * 4-byte version number: 3
+  * 4-byte length of the header section, including the signature and
     version number
-  - 4-byte number of objects contained in the pack
-  - 4-byte number of object formats in this pack index: 2
-  - For each object format:
-    - 4-byte format identifier (e.g., 'sha1' for SHA-1)
-    - 4-byte length in bytes of shortened object names. This is the
+  * 4-byte number of objects contained in the pack
+  * 4-byte number of object formats in this pack index: 2
+  * For each object format:
+    ** 4-byte format identifier (e.g., 'sha1' for SHA-1)
+    ** 4-byte length in bytes of shortened object names. This is the
       shortest possible length needed to make names in the shortened
       object name table unambiguous.
-    - 4-byte integer, recording where tables relating to this format
+    ** 4-byte integer, recording where tables relating to this format
       are stored in this index file, as an offset from the beginning.
-  - 4-byte offset to the trailer from the beginning of this file.
-  - Zero or more additional key/value pairs (4-byte key, 4-byte
+  * 4-byte offset to the trailer from the beginning of this file.
+  * Zero or more additional key/value pairs (4-byte key, 4-byte
     value). Only one key is supported: 'PSRC'. See the "Loose objects
     and unreachable objects" section for supported values and how this
     is used.  All other keys are reserved. Readers must ignore
@@ -213,37 +213,36 @@ network byte order):
 - Zero or more NUL bytes. This can optionally be used to improve the
   alignment of the full object name table below.
 - Tables for the first object format:
-  - A sorted table of shortened object names.  These are prefixes of
+  * A sorted table of shortened object names.  These are prefixes of
     the names of all objects in this pack file, packed together
     without offset values to reduce the cache footprint of the binary
     search for a specific object name.
 
-  - A table of full object names in pack order. This allows resolving
+  * A table of full object names in pack order. This allows resolving
     a reference to "the nth object in the pack file" (from a
     reachability bitmap or from the next table of another object
     format) to its object name.
 
-  - A table of 4-byte values mapping object name order to pack order.
+  * A table of 4-byte values mapping object name order to pack order.
     For an object in the table of sorted shortened object names, the
     value at the corresponding index in this table is the index in the
     previous table for that same object.
-
     This can be used to look up the object in reachability bitmaps or
     to look up its name in another object format.
 
-  - A table of 4-byte CRC32 values of the packed object data, in the
+  * A table of 4-byte CRC32 values of the packed object data, in the
     order that the objects appear in the pack file. This is to allow
     compressed data to be copied directly from pack to pack during
     repacking without undetected data corruption.
 
-  - A table of 4-byte offset values. For an object in the table of
+  * A table of 4-byte offset values. For an object in the table of
     sorted shortened object names, the value at the corresponding
     index in this table indicates where that object can be found in
     the pack file. These are usually 31-bit pack file offsets, but
     large offsets are encoded as an index into the next table with the
     most significant bit set.
 
-  - A table of 8-byte offset entries (empty for pack files less than
+  * A table of 8-byte offset entries (empty for pack files less than
     2 GiB). Pack files are organized with heavily used objects toward
     the front, so most object references should not need to refer to
     this table.
@@ -252,10 +251,10 @@ network byte order):
   up to and not including the table of CRC32 values.
 - Zero or more NUL bytes.
 - The trailer consists of the following:
-  - A copy of the 20-byte SHA-256 checksum at the end of the
+  * A copy of the 20-byte SHA-256 checksum at the end of the
     corresponding packfile.
 
-  - 20-byte SHA-256 checksum of all of the above.
+  * 20-byte SHA-256 checksum of all of the above.
 
 Loose object index
 ~~~~~~~~~~~~~~~~~~
@@ -351,7 +350,7 @@ the following steps:
 3. convert to sha256: open a new (sha256) packfile. Read the topologically
    sorted list just generated. For each object, inflate its
    sha1-content, convert to sha256-content, and write it to the sha256
-   pack. Record the new sha1<->sha256 mapping entry for use in the idx.
+   pack. Record the new sha1<-->sha256 mapping entry for use in the idx.
 4. sort: reorder entries in the new pack to match the order of objects
    in the pack the server generated and include blobs. Write a sha256 idx
    file
@@ -391,6 +390,7 @@ existing "gpgsig" field. Its signed payload is the sha256-content of the
 commit object with any "gpgsig" and "gpgsig-sha256" fields removed.
 
 This means commits can be signed
+
 1. using SHA-1 only, as in existing signed commit objects
 2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
    fields.
@@ -408,6 +408,7 @@ sha256-content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
 SIGNATURE-----" delimited in-body signature removed.
 
 This means tags can be signed
+
 1. using SHA-1 only, as in existing signed tag objects
 2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
    signature.
@@ -598,7 +599,7 @@ The user can also explicitly specify which format to use for a
 particular revision specifier and for output, overriding the mode. For
 example:
 
-git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
+    git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
 
 Choice of Hash
 --------------
@@ -636,6 +637,7 @@ We choose SHA-256.
 Transition plan
 ---------------
 Some initial steps can be implemented independently of one another:
+
 - adding a hash function API (vtable)
 - teaching fsck to tolerate the gpgsig-sha256 field
 - excluding gpgsig-* from the fields copied by "git commit --amend"
@@ -647,9 +649,9 @@ Some initial steps can be implemented independently of one another:
 - introducing index v3
 - adding support for the PSRC field and safer object pruning
 
-
 The first user-visible change is the introduction of the objectFormat
 extension (without compatObjectFormat). This requires:
+
 - teaching fsck about this mode of operation
 - using the hash function API (vtable) when computing object names
 - signing objects and verifying signatures
@@ -657,6 +659,7 @@ extension (without compatObjectFormat). This requires:
   repository
 
 Next comes introduction of compatObjectFormat:
+
 - implementing the loose-object-idx
 - translating object names between object formats
 - translating object content between object formats
@@ -669,6 +672,7 @@ Next comes introduction of compatObjectFormat:
   "Object names on the command line" above)
 
 The next step is supporting fetches and pushes to SHA-1 repositories:
+
 - allow pushes to a repository using the compat format
 - generate a topologically sorted list of the SHA-1 names of fetched
   objects
@@ -734,6 +738,7 @@ Using hash functions in parallel
 Objects newly created would be addressed by the new hash, but inside
 such an object (e.g. commit) it is still possible to address objects
 using the old hash function.
+
 * You cannot trust its history (needed for bisectability) in the
   future without further work
 * Maintenance burden as the number of supported hash functions grows
@@ -749,6 +754,7 @@ sha1-content based signatures.
 
 In other words, a single signature was used to attest to the object
 content using both hash functions. This had some advantages:
+
 * Using one signature instead of two speeds up the signing process.
 * Having one signed payload with both hashes allows the signer to
   attest to the sha1-name and sha256-name referring to the same object.
@@ -756,6 +762,7 @@ content using both hash functions. This had some advantages:
   to be detected quickly using current versions of git.
 
 However, it also came with disadvantages:
+
 * Verifying a signed object requires access to the sha1-names of all
   objects it references, even after the transition is complete and
   translation table is no longer needed for anything else. To support
@@ -782,16 +789,17 @@ Document History
 bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
 sbeller@google.com
 
-Initial version sent to
-http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
+* Initial version sent to http://lore.kernel.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
 
 2017-03-03 jrnieder@gmail.com
 Incorporated suggestions from jonathantanmy and sbeller:
+
 * describe purpose of signed objects with each hash type
 * redefine signed object verification using object content under the
   first hash function
 
 2017-03-06 jrnieder@gmail.com
+
 * Use SHA3-256 instead of SHA2 (thanks, Linus and brian m. carlson).[1][2]
 * Make sha3-based signatures a separate field, avoiding the need for
   "hash" and "nohash" fields (thanks to peff[3]).
@@ -805,6 +813,7 @@ Incorporated suggestions from jonathantanmy and sbeller:
   especially Junio).
 
 2017-09-27 jrnieder@gmail.com, sbeller@google.com
+
 * use placeholder NewHash instead of SHA3-256
 * describe criteria for picking a hash function.
 * include a transition plan (thanks especially to Brandon Williams
@@ -816,12 +825,14 @@ Incorporated suggestions from jonathantanmy and sbeller:
 
 Later history:
 
- See the history of this file in git.git for the history of subsequent
- edits. This document history is no longer being maintained as it
- would now be superfluous to the commit log
+* See the history of this file in git.git for the history of subsequent
+  edits. This document history is no longer being maintained as it
+  would now be superfluous to the commit log
+
+References:
 
-[1] http://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
-[2] http://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
-[3] http://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
-[4] http://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
-[5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
+ [1] http://lore.kernel.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
+ [2] http://lore.kernel.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
+ [3] http://lore.kernel.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
+ [4] http://lore.kernel.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
+ [5] https://lore.kernel.org/git/CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com/
-- 
gitgitgadget

