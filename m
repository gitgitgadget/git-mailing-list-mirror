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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D59C43331
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DD64E9B
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbhBBQ1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhBBQWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23CC061225
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b3so2967894wrj.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2dao6OMT3vJpBhdQEs6QMZnm69uKurFMOI3bhJiNuvc=;
        b=el9/AyvzigukQkEcRQO5kOO0jvNACuWac4PfX5OU0gKIqCm2XEVKC14xZ3zZTDWkre
         u4YZWzQrDN8JAY7ZYpI1VbYuzbYpHXExbOzCpCgpwe3EzwtZ7bUMD6GceVdcPpkfIwXO
         yzJqReYpEziFPZPq3K/pe9gNDCnGbQsDMrTM476iyBGVy4Uc57eYxUVhKxsk3J2Jnd5t
         g/FR0sRbGNTSeqxMNM6n44kzwnPtbMJq7xum8BvuKRRtOibIqTfD/RImoIsos18qi3rY
         fHO4dfJCV+Cx+8iD6cGL0RRutUg7gxkqtT4kzD+BfV5jsJmXa3xjQjIGiqsTPk5bOB6D
         kV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2dao6OMT3vJpBhdQEs6QMZnm69uKurFMOI3bhJiNuvc=;
        b=TLyG1hJpnCmzJ3cVOOdTryb80JqsaLdlimpol8ENhN6nxMH3rupgNi2+zieOkKpe+6
         rjfITtyvV985b5qdvP+UrM6tWknla1TqPxaJ0gGtYwwCDB2EX/7rdaA+SEhv9TkHMQ5L
         mS5SROwtHi0pAG1iNDHDuF1nVLnQ0eIDgp1QeebZrWvwzBSYrLF9MGWM6TSNv5BMo3Wq
         bpAK1cvC+uf71Oj7NDsc92PcxVkm3piX+NSOqMDIBT0E652UBqonOBVS9iKHku+e6eXg
         4wWgNlqqDUFhrzd0PHqYhretBtk/OYQHznphAdbp3NwVcOCO7mMTM91HUPQCC5criehk
         xwlw==
X-Gm-Message-State: AOAM533M5UpVViWKn1LyPIcoZyavop9co/3o4FVdm7+VSq9FZOSBvFwl
        LlSZrBoLgoouISxNsyInvPgdtfIqWt8=
X-Google-Smtp-Source: ABdhPJwqxPBv2mvfofw4M2SrZaCs+9l0GBtY9EXYjo3p1H6J5HOilUss3DJ/zoGF18uzb5KnTT4z8g==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr24563022wrt.354.1612282754573;
        Tue, 02 Feb 2021 08:19:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm4389426wme.18.2021.02.02.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:13 -0800 (PST)
Message-Id: <681ce4129dc35b6a61aac0dbd1b9b9d638a2b78d.1612282749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:05 +0000
Subject: [PATCH v2 2/6] doc hash-function-transition: use SHA-1 and SHA-256
 consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Use SHA-1 and SHA-256 instead of sha1 and sha256  when referring
to the hash type.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 .../technical/hash-function-transition.txt    | 122 +++++++++---------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 4b04829d537..51acf2c10b7 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -107,7 +107,7 @@ mapping to allow naming objects using either their SHA-1 and SHA-256 names
 interchangeably.
 
 "git cat-file" and "git hash-object" gain options to display an object
-in its sha1 form and write an object given its sha1 form. This
+in its SHA-1 form and write an object given its SHA-1 form. This
 requires all objects referenced by that object to be present in the
 object database so that they can be named using the appropriate name
 (using the bidirectional hash mapping).
@@ -115,7 +115,7 @@ object database so that they can be named using the appropriate name
 Fetches from a SHA-1 based server convert the fetched objects into
 SHA-256 form and record the mapping in the bidirectional mapping table
 (see below for details). Pushes to a SHA-1 based server convert the
-objects being pushed into sha1 form so the server does not have to be
+objects being pushed into SHA-1 form so the server does not have to be
 aware of the hash function the client is using.
 
 Detailed Design
@@ -151,38 +151,38 @@ repository extensions.
 
 Object names
 ~~~~~~~~~~~~
-Objects can be named by their 40 hexadecimal digit sha1-name or 64
-hexadecimal digit sha256-name, plus names derived from those (see
+Objects can be named by their 40 hexadecimal digit SHA-1 name or 64
+hexadecimal digit SHA-256 name, plus names derived from those (see
 gitrevisions(7)).
 
-The sha1-name of an object is the SHA-1 of the concatenation of its
-type, length, a nul byte, and the object's sha1-content. This is the
+The SHA-1 name of an object is the SHA-1 of the concatenation of its
+type, length, a nul byte, and the object's SHA-1 content. This is the
 traditional <sha1> used in Git to name objects.
 
-The sha256-name of an object is the SHA-256 of the concatenation of its
-type, length, a nul byte, and the object's sha256-content.
+The SHA-256 name of an object is the SHA-256 of the concatenation of its
+type, length, a nul byte, and the object's SHA-256 content.
 
 Object format
 ~~~~~~~~~~~~~
 The content as a byte sequence of a tag, commit, or tree object named
-by sha1 and sha256 differ because an object named by sha256-name refers to
-other objects by their sha256-names and an object named by sha1-name
-refers to other objects by their sha1-names.
+by SHA-1 and SHA-256 differ because an object named by SHA-256 name refers to
+other objects by their SHA-256 names and an object named by SHA-1 name
+refers to other objects by their SHA-1 names.
 
-The sha256-content of an object is the same as its sha1-content, except
-that objects referenced by the object are named using their sha256-names
-instead of sha1-names. Because a blob object does not refer to any
-other object, its sha1-content and sha256-content are the same.
+The SHA-256-content of an object is the same as its SHA-1 content, except
+that objects referenced by the object are named using their SHA-256 names
+instead of SHA-1 names. Because a blob object does not refer to any
+other object, its SHA-1 content and SHA-256 content are the same.
 
-The format allows round-trip conversion between sha256-content and
-sha1-content.
+The format allows round-trip conversion between SHA-256 content and
+SHA-1 content.
 
 Object storage
 ~~~~~~~~~~~~~~
 Loose objects use zlib compression and packed objects use the packed
 format described in Documentation/technical/pack-format.txt, just like
-today. The content that is compressed and stored uses sha256-content
-instead of sha1-content.
+today. The content that is compressed and stored uses SHA-256 content
+instead of SHA-1 content.
 
 Pack index
 ~~~~~~~~~~
@@ -287,18 +287,18 @@ To remove entries (e.g. in "git pack-refs" or "git-prune"):
 
 Translation table
 ~~~~~~~~~~~~~~~~~
-The index files support a bidirectional mapping between sha1-names
-and sha256-names. The lookup proceeds similarly to ordinary object
-lookups. For example, to convert a sha1-name to a sha256-name:
+The index files support a bidirectional mapping between SHA-1 names
+and SHA-256 names. The lookup proceeds similarly to ordinary object
+lookups. For example, to convert a SHA-1 name to a SHA-256 name:
 
  1. Look for the object in idx files. If a match is present in the
-    idx's sorted list of truncated sha1-names, then:
-    a. Read the corresponding entry in the sha1-name order to pack
+    idx's sorted list of truncated SHA-1 names, then:
+    a. Read the corresponding entry in the SHA-1 name order to pack
        name order mapping.
-    b. Read the corresponding entry in the full sha1-name table to
+    b. Read the corresponding entry in the full SHA-1 name table to
        verify we found the right object. If it is, then
-    c. Read the corresponding entry in the full sha256-name table.
-       That is the object's sha256-name.
+    c. Read the corresponding entry in the full SHA-256 name table.
+       That is the object's SHA-256 name.
  2. Check for a loose object. Read lines from loose-object-idx until
     we find a match.
 
@@ -312,10 +312,10 @@ Since all operations that make new objects (e.g., "git commit") add
 the new objects to the corresponding index, this mapping is possible
 for all objects in the object store.
 
-Reading an object's sha1-content
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-The sha1-content of an object can be read by converting all sha256-names
-its sha256-content references to sha1-names using the translation table.
+Reading an object's SHA-1 content
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The SHA-1 content of an object can be read by converting all SHA-256 names
+its SHA-256 content references to SHA-1 names using the translation table.
 
 Fetch
 ~~~~~
@@ -338,7 +338,7 @@ the following steps:
 1. index-pack: inflate each object in the packfile and compute its
    SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
    objects the client has locally. These objects can be looked up
-   using the translation table and their sha1-content read as
+   using the translation table and their SHA-1 content read as
    described above to resolve the deltas.
 2. topological sort: starting at the "want"s from the negotiation
    phase, walk through objects in the pack and emit a list of them,
@@ -347,12 +347,12 @@ the following steps:
    (This list only contains objects reachable from the "wants". If the
    pack from the server contained additional extraneous objects, then
    they will be discarded.)
-3. convert to sha256: open a new (sha256) packfile. Read the topologically
+3. convert to SHA-256: open a new SHA-256 packfile. Read the topologically
    sorted list just generated. For each object, inflate its
    SHA-1 content, convert to SHA-256 content, and write it to the SHA-256
    pack. Record the new SHA-1<-->SHA-256 mapping entry for use in the idx.
 4. sort: reorder entries in the new pack to match the order of objects
-   in the pack the server generated and include blobs. Write a sha256 idx
+   in the pack the server generated and include blobs. Write a SHA-256 idx
    file
 5. clean up: remove the SHA-1 based pack file, index, and
    topologically sorted list obtained from the server in steps 1
@@ -377,16 +377,16 @@ experimenting to get this to perform well.
 Push
 ~~~~
 Push is simpler than fetch because the objects referenced by the
-pushed objects are already in the translation table. The sha1-content
+pushed objects are already in the translation table. The SHA-1 content
 of each object being pushed can be read as described in the "Reading
-an object's sha1-content" section to generate the pack written by git
+an object's SHA-1 content" section to generate the pack written by git
 send-pack.
 
 Signed Commits
 ~~~~~~~~~~~~~~
 We add a new field "gpgsig-sha256" to the commit object format to allow
 signing commits without relying on SHA-1. It is similar to the
-existing "gpgsig" field. Its signed payload is the sha256-content of the
+existing "gpgsig" field. Its signed payload is the SHA-256 content of the
 commit object with any "gpgsig" and "gpgsig-sha256" fields removed.
 
 This means commits can be signed
@@ -404,7 +404,7 @@ Signed Tags
 ~~~~~~~~~~~
 We add a new field "gpgsig-sha256" to the tag object format to allow
 signing tags without relying on SHA-1. Its signed payload is the
-sha256-content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
+SHA-256 content of the tag with its gpgsig-sha256 field and "-----BEGIN PGP
 SIGNATURE-----" delimited in-body signature removed.
 
 This means tags can be signed
@@ -416,11 +416,11 @@ This means tags can be signed
 
 Mergetag embedding
 ~~~~~~~~~~~~~~~~~~
-The mergetag field in the sha1-content of a commit contains the
-sha1-content of a tag that was merged by that commit.
+The mergetag field in the SHA-1 content of a commit contains the
+SHA-1 content of a tag that was merged by that commit.
 
-The mergetag field in the sha256-content of the same commit contains the
-sha256-content of the same tag.
+The mergetag field in the SHA-256 content of the same commit contains the
+SHA-256 content of the same tag.
 
 Submodules
 ~~~~~~~~~~
@@ -495,7 +495,7 @@ Caveats
 -------
 Invalid objects
 ~~~~~~~~~~~~~~~
-The conversion from sha1-content to sha256-content retains any
+The conversion from SHA-1 content to SHA-256 content retains any
 brokenness in the original object (e.g., tree entry modes encoded with
 leading 0, tree objects whose paths are not sorted correctly, and
 commit objects without an author or committer). This is a deliberate
@@ -514,15 +514,15 @@ allow lifting this restriction.
 
 Alternates
 ~~~~~~~~~~
-For the same reason, a sha256 repository cannot borrow objects from a
-sha1 repository using objects/info/alternates or
+For the same reason, a SHA-256 repository cannot borrow objects from a
+SHA-1 repository using objects/info/alternates or
 $GIT_ALTERNATE_OBJECT_REPOSITORIES.
 
 git notes
 ~~~~~~~~~
-The "git notes" tool annotates objects using their sha1-name as key.
+The "git notes" tool annotates objects using their SHA-1 name as key.
 This design does not describe a way to migrate notes trees to use
-sha256-names. That migration is expected to happen separately (for
+SHA-256 names. That migration is expected to happen separately (for
 example using a file at the root of the notes tree to describe which
 hash it uses).
 
@@ -556,7 +556,7 @@ unclear:
 
 	Git 2.12
 
-Does this mean Git v2.12.0 is the commit with sha1-name
+Does this mean Git v2.12.0 is the commit with SHA-1 name
 e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
 new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?
 
@@ -676,7 +676,7 @@ The next step is supporting fetches and pushes to SHA-1 repositories:
 - allow pushes to a repository using the compat format
 - generate a topologically sorted list of the SHA-1 names of fetched
   objects
-- convert the fetched packfile to sha256 format and generate an idx
+- convert the fetched packfile to SHA-256 format and generate an idx
   file
 - re-sort to match the order of objects in the fetched packfile
 
@@ -748,38 +748,38 @@ using the old hash function.
 Signed objects with multiple hashes
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Instead of introducing the gpgsig-sha256 field in commit and tag objects
-for sha256-content based signatures, an earlier version of this design
-added "hash sha256 <sha256-name>" fields to strengthen the existing
-sha1-content based signatures.
+for SHA-256 content based signatures, an earlier version of this design
+added "hash sha256 <SHA-256 name>" fields to strengthen the existing
+SHA-1 content based signatures.
 
 In other words, a single signature was used to attest to the object
 content using both hash functions. This had some advantages:
 
 * Using one signature instead of two speeds up the signing process.
 * Having one signed payload with both hashes allows the signer to
-  attest to the sha1-name and sha256-name referring to the same object.
+  attest to the SHA-1 name and SHA-256 name referring to the same object.
 * All users consume the same signature. Broken signatures are likely
   to be detected quickly using current versions of git.
 
 However, it also came with disadvantages:
 
-* Verifying a signed object requires access to the sha1-names of all
+* Verifying a signed object requires access to the SHA-1 names of all
   objects it references, even after the transition is complete and
   translation table is no longer needed for anything else. To support
-  this, the design added fields such as "hash sha1 tree <sha1-name>"
-  and "hash sha1 parent <sha1-name>" to the sha256-content of a signed
+  this, the design added fields such as "hash sha1 tree <SHA-1 name>"
+  and "hash sha1 parent <SHA-1 name>" to the SHA-256 content of a signed
   commit, complicating the conversion process.
-* Allowing signed objects without a sha1 (for after the transition is
+* Allowing signed objects without a SHA-1 (for after the transition is
   complete) complicated the design further, requiring a "nohash sha1"
-  field to suppress including "hash sha1" fields in the sha256-content
+  field to suppress including "hash sha1" fields in the SHA-256 content
   and signed payload.
 
 Lazily populated translation table
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Some of the work of building the translation table could be deferred to
 push time, but that would significantly complicate and slow down pushes.
-Calculating the sha1-name at object creation time at the same time it is
-being streamed to disk and having its sha256-name calculated should be
+Calculating the SHA-1 name at object creation time at the same time it is
+being streamed to disk and having its SHA-256 name calculated should be
 an acceptable cost.
 
 Document History
@@ -801,7 +801,7 @@ Incorporated suggestions from jonathantanmy and sbeller:
 2017-03-06 jrnieder@gmail.com
 
 * Use SHA3-256 instead of SHA2 (thanks, Linus and brian m. carlson).[1][2]
-* Make sha3-based signatures a separate field, avoiding the need for
+* Make SHA3-based signatures a separate field, avoiding the need for
   "hash" and "nohash" fields (thanks to peff[3]).
 * Add a sorting phase to fetch (thanks to Junio for noticing the need
   for this).
-- 
gitgitgadget

