Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E5A20281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967947AbdIZW0T (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:26:19 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:56864 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967343AbdIZW0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:26:15 -0400
Received: by mail-pf0-f175.google.com with SMTP id g65so6219122pfe.13
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hvG1pyNhZRcTV3puJhL/HLajSJ09H8CqQNMcUe9OxzI=;
        b=Bt9WC0/657yFv6mYLAG/FzYgpbE3Ux5+gHOhRO9/5R1mA7lfPBqefC7HXcyHnsKFvm
         bocu9m9a4ouJ8Jxn9CIoecVc/wefmnr1Z/jfM51l4b9tbgN5oaDy09E+6PKtQHxKrq+8
         PJcS6o5pP6N6ovLK5FhQtL/yrFEHoGi6gUh8CeBeudUOxTuKOCC3WGm6e7z1cEbjG0ot
         w+AdPLRHFSCzyGqTZhgLnwGzeS7IId4G66tIbwF93IaYgUNKFEq8dSJLiqZYt9nsZuzi
         QTWCrc2piVZYwJ7t8tmHyRuNX1qNbpGKgkTcyHPlCKQbSm3PiaZH01MHKb6fquGDJvk9
         Ok2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hvG1pyNhZRcTV3puJhL/HLajSJ09H8CqQNMcUe9OxzI=;
        b=X+YK0m7a1Er93sNylXvTh1MIzQI5PRpz50bD7YRHD7nEwU0ggpSd6UA1O0j03261N1
         t39nYnsmD6d0ByCePofpBdn6QmZ+65m5nN9P2ocXNOs0lxNh9XDh/TDnBb9jfurZO0Bn
         WrLrmV6R0pHhpam6k2eQDrH3EMiuewinhcrIKYPttmIaq60a+AF1qPT132aTQ2hRDISy
         6YSSYCNuUyKV7nEqBi7t+ZleNDmbbHdsulgkrka3ekL9qFs+mGEOYwRkMBIuZwC/d6yE
         TElL/TjthjvDfiZ1mbSxxxGGFki71lI6bBXpEymTz09yC5DzeXoDPxIWWKqiAtyyuJzk
         5Ujg==
X-Gm-Message-State: AHPjjUj1NLgNIXs488/NPebhrPKI/8nyGrw2upmRV6Mj/2rAzNFiKIrY
        8LQtIoI+N31C3sUhJskzpohOjg==
X-Google-Smtp-Source: AOwi7QBRbeKNoh0ZvdB3Vy1BOOdCc3cXGS9nKnylmrGZKX96pT+2fpVcUBpfiqZgjXKaO1WLY75xlA==
X-Received: by 10.84.140.35 with SMTP id 32mr11913410pls.378.1506464774558;
        Tue, 26 Sep 2017 15:26:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7981:413b:8357:cbf7])
        by smtp.gmail.com with ESMTPSA id e76sm18286448pfd.149.2017.09.26.15.26.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 15:26:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     bmwill@google.com, david@lang.hm, demerphq@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, jason@lakedaemon.net,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, sbeller@google.com,
        torvalds@linux-foundation.org, Jonathan Nieder <jrn@google.com>
Subject: [PATCH] technical doc: add a design doc for hash function transition
Date:   Tue, 26 Sep 2017 15:25:58 -0700
Message-Id: <20170926222558.22418-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
References: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrn@google.com>

This is "RFC v3: Another proposed hash function transition plan" from
the git mailing list.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This takes the original Google Doc[1] and adds it to our history,
 such that the discussion can be on on list and in the commit messages.
 
 * replaced SHA3-256 with NEWHASH, sha3 with newhash
 * added section 'Implementation plan'
 * added section 'Future work'
 * added section 'Agreed-upon criteria for selecting NewHash'
 
 As the discussion restarts again, here is our attempt
 to add value to the discussion, we planned to polish it more, but as the
 discussion is restarting, we might just post it as-is.
  
 Thanks.

[1] https://docs.google.com/document/d/18hYAQCTsDgaFUo-VJGhT0UqyetL2LbAzkWNK1fYS8R0/edit

 Documentation/Makefile                             |   1 +
 .../technical/hash-function-transition.txt         | 571 +++++++++++++++++++++
 2 files changed, 572 insertions(+)
 create mode 100644 Documentation/technical/hash-function-transition.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2415e0d657..471bb29725 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,7 @@ SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
 TECH_DOCS += technical/pack-format
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
new file mode 100644
index 0000000000..0ac751d600
--- /dev/null
+++ b/Documentation/technical/hash-function-transition.txt
@@ -0,0 +1,571 @@
+Git hash function transition
+============================
+
+Objective
+---------
+Migrate Git from SHA-1 to a stronger hash function.
+
+Background
+----------
+At its core, the Git version control system is a content addressable
+filesystem. It uses the SHA-1 hash function to name content. For
+example, files, directories, and revisions are referred to by hash
+values unlike in other traditional version control systems where files
+or versions are referred to via sequential numbers. The use of a hash
+function to address its content delivers a few advantages:
+
+* Integrity checking is easy. Bit flips, for example, are easily
+  detected, as the hash of corrupted content does not match its name.
+* Lookup of objects is fast.
+
+Using a cryptographically secure hash function brings additional
+advantages:
+
+* Object names can be signed and third parties can trust the hash to
+  address the signed object and all objects it references.
+* Communication using Git protocol and out of band communication
+  methods have a short reliable string that can be used to reliably
+  address stored content.
+
+Over time some flaws in SHA-1 have been discovered by security
+researchers. https://shattered.io demonstrated a practical SHA-1 hash
+collision. As a result, SHA-1 cannot be considered cryptographically
+secure any more. This impacts the communication of hash values because
+we cannot trust that a given hash value represents the known good
+version of content that the speaker intended.
+
+SHA-1 still possesses the other properties such as fast object lookup
+and safe error checking, but other hash functions are equally suitable
+that are believed to be cryptographically secure.
+
+Goals
+-----
+1. The transition to NEWHASH can be done one local repository at a time.
+   a. Requiring no action by any other party.
+   b. A NEWHASH repository can communicate with SHA-1 Git servers
+      (push/fetch).
+   c. Users can use SHA-1 and NEWHASH identifiers for objects
+      interchangeably.
+   d. New signed objects make use of a stronger hash function than
+      SHA-1 for their security guarantees.
+2. Allow a complete transition away from SHA-1.
+   a. Local metadata for SHA-1 compatibility can be removed from a
+      repository if compatibility with SHA-1 is no longer needed.
+3. Maintainability throughout the process.
+   a. The object format is kept simple and consistent.
+   b. Creation of a generalized repository conversion tool.
+
+Non-Goals
+---------
+1. Add NEWHASH support to Git protocol. This is valuable and the
+   logical next step but it is out of scope for this initial design.
+2. Transparently improving the security of existing SHA-1 signed
+   objects.
+3. Intermixing objects using multiple hash functions in a single
+   repository.
+4. Taking the opportunity to fix other bugs in git's formats and
+   protocols.
+5. Shallow clones and fetches into a NEWHASH repository. (This will
+   change when we add NEWHASH support to Git protocol.)
+6. Skip fetching some submodules of a project into a NEWHASH
+   repository. (This also depends on NEWHASH support in Git
+   protocol.)
+
+Overview
+--------
+We introduce a new repository format extension `newhash`. Repositories
+with this extension enabled use NEWHASH instead of SHA-1 to name
+their objects. This affects both object names and object content ---
+both the names of objects and all references to other objects within
+an object are switched to the new hash function.
+
+newhash repositories cannot be read by older versions of Git.
+
+Alongside the packfile, a newhash repository stores a bidirectional
+mapping between newhash and sha1 object names in a new format of .idx files.
+The mapping is generated locally and can be verified using "git fsck".
+Object lookups use this mapping to allow naming objects using either
+their sha1 and newhash names interchangeably.
+
+"git cat-file" and "git hash-object" gain options to display an object
+in its sha1 form and write an object given its sha1 form. This
+requires all objects referenced by that object to be present in the
+object database so that they can be named using the appropriate name
+(using the bidirectional hash mapping).
+
+Fetches from a SHA-1 based server convert the fetched objects into
+newhash form and record the mapping in the bidirectional mapping table
+(see below for details). Pushes to a SHA-1 based server convert the
+objects being pushed into sha1 form so the server does not have to be
+aware of the hash function the client is using.
+
+Detailed Design
+---------------
+Object names
+~~~~~~~~~~~~
+Objects can be named by their 40 hexadecimal digit sha1-name or <n>
+hexadecimal digit newhash-name, plus names derived from those (see
+gitrevisions(7)).
+
+The sha1-name of an object is the SHA-1 of the concatenation of its
+type, length, a nul byte, and the object's sha1-content. This is the
+traditional <sha1> used in Git to name objects.
+
+The newhash-name of an object is the NEWHASH of the concatenation of its
+type, length, a nul byte, and the object's newhash-content.
+
+Object format
+~~~~~~~~~~~~~
+The content as a byte sequence of a tag, commit, or tree object named
+by sha1 and newhash differ because an object named by newhash-name refers to
+other objects by their newhash-names and an object named by sha1-name
+refers to other objects by their sha1-names.
+
+The newhash-content of an object is the same as its sha1-content, except
+that objects referenced by the object are named using their newhash-names
+instead of sha1-names. Because a blob object does not refer to any
+other object, its sha1-content and newhash-content are the same.
+
+The format allows round-trip conversion between newhash-content and
+sha1-content.
+
+Object storage
+~~~~~~~~~~~~~~
+Loose objects use zlib compression and packed objects use the packed
+format described in Documentation/technical/pack-format.txt, just like
+today. The content that is compressed and stored uses newhash-content
+instead of sha1-content.
+
+Translation table
+~~~~~~~~~~~~~~~~~
+A fast bidirectional mapping between sha1-names and newhash-names of all
+local objects in the repository is kept on disk.
+
+For pack files, upgrade the .idx file to be as follows:
+
+  4 magic bytes
+  header, containing pointers to the 3 lists below
+
+  list of
+  abbrev sha1 -> ordinal, sorted by sha1
+
+  list of
+  abbrev newhash -> ordinal, sorted by newhash
+
+  list of
+  ordinal, complete sha1, complete new hash,
+  sorted by ordinal, such that a lookup can be computed after looking into
+  one of the first lists.
+
+For unpacked objects, keep a simple list
+  sha1 -> newhash
+around at $OBJECT_DIR/loose-lookup
+
+All operations that make new objects (e.g., "git commit") add the new
+objects to the translation table.
+
+(This work could have been deferred to push time, but that would
+significantly complicate and slow down pushes. Calculating the
+sha1-name at object creation time at the same time it is being
+streamed to disk and having its newhash-name calculated should be an
+acceptable cost.)
+
+Reading an object's sha1-content
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The sha1-content of an object can be read by converting all newhash-names
+its newhash-content references to sha1-names using the translation table.
+
+Fetch
+~~~~~
+Fetching from a SHA-1 based server requires translating between SHA-1
+and NEWHASH based representations on the fly.
+
+SHA-1s named in the ref advertisement that are present on the client
+can be translated to NEWHASH and looked up as local objects using the
+translation table.
+
+Negotiation proceeds as today. Any "have"s generated locally are
+converted to SHA-1 before being sent to the server, and SHA-1s
+mentioned by the server are converted to NEWHASH when looking them up
+locally.
+
+After negotiation, the server sends a packfile containing the
+requested objects. We convert the packfile to NEWHASH format using
+the following steps:
+
+1. index-pack: inflate each object in the packfile and compute its
+   SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
+   objects the client has locally. These objects can be looked up
+   using the translation table and their sha1-content read as
+   described above to resolve the deltas.
+2. topological sort: starting at the "want"s from the negotiation
+   phase, walk through objects in the pack and emit a list of them,
+   excluding blobs, in reverse topologically sorted order, with each
+   object coming later in the list than all objects it references.
+   (This list only contains objects reachable from the "wants". If the
+   pack from the server contained additional extraneous objects, then
+   they will be discarded.)
+3. convert to newhash: open a new (newhash) packfile. Read the topologically
+   sorted list just generated. For each object, inflate its
+   sha1-content, convert to newhash-content, and write it to the newhash
+   pack. Include the new sha1<->newhash mapping entry in the translation
+   table.
+4. sort: reorder entries in the new pack to match the order of objects
+   in the pack the server generated and include blobs. Write a newhash idx
+   file.
+5. clean up: remove the SHA-1 based pack file, index, and
+   topologically sorted list obtained from the server and steps 1
+   and 2.
+
+Step 3 requires every object referenced by the new object to be in the
+translation table. This is why the topological sort step is necessary.
+
+As an optimization, step 1 could write a file describing what non-blob
+objects each object it has inflated from the packfile references. This
+makes the topological sort in step 2 possible without inflating the
+objects in the packfile for a second time. The objects need to be
+inflated again in step 3, for a total of two inflations.
+
+Step 4 is probably necessary for good read-time performance. "git
+pack-objects" on the server optimizes the pack file for good data
+locality (see Documentation/technical/pack-heuristics.txt).
+
+Details of this process are likely to change. It will take some
+experimenting to get this to perform well.
+
+Push
+~~~~
+Push is simpler than fetch because the objects referenced by the
+pushed objects are already in the translation table. The sha1-content
+of each object being pushed can be read as described in the "Reading
+an object's sha1-content" section to generate the pack written by git
+send-pack.
+
+Signed Commits
+~~~~~~~~~~~~~~
+We add a new field "gpgsig-newhash" to the commit object format to allow
+signing commits without relying on SHA-1. It is similar to the
+existing "gpgsig" field. Its signed payload is the newhash-content of the
+commit object with any "gpgsig" and "gpgsig-newhash" fields removed.
+
+This means commits can be signed
+1. using SHA-1 only, as in existing signed commit objects
+2. using both SHA-1 and NEWHASH, by using both gpgsig-newhash and gpgsig
+   fields.
+3. using only NEWHASH, by only using the gpgsig-newhash field.
+
+Old versions of "git verify-commit" can verify the gpgsig signature in
+cases (1) and (2) without modifications and view case (3) as an
+ordinary unsigned commit.
+
+Signed Tags
+~~~~~~~~~~~
+We add a new field "gpgsig-newhash" to the tag object format to allow
+signing tags without relying on SHA-1. Its signed payload is the
+newhash-content of the tag with its gpgsig-newhash field and "-----BEGIN PGP
+SIGNATURE-----" delimited in-body signature removed.
+
+This means tags can be signed
+1. using SHA-1 only, as in existing signed tag objects
+2. using both SHA-1 and NEWHASH, by using gpgsig-newhash and an in-body
+   signature.
+3. using only NEWHASH, by only using the gpgsig-newhash field.
+
+Mergetag embedding
+~~~~~~~~~~~~~~~~~~
+The mergetag field in the sha1-content of a commit contains the
+sha1-content of a tag that was merged by that commit.
+
+The mergetag field in the newhash-content of the same commit contains the
+newhash-content of the same tag.
+
+Submodules
+~~~~~~~~~~
+To convert recorded submodule pointers, you need to have the converted
+submodule repository in place. The translation table of the submodule
+can be used to look up the new hash.
+
+Caveats
+-------
+Invalid objects
+~~~~~~~~~~~~~~~
+The conversion from sha1-content to newhash-content retains any
+brokenness in the original object (e.g., tree entry modes encoded with
+leading 0, tree objects whose paths are not sorted correctly, and
+commit objects without an author or committer). This is a deliberate
+feature of the design to allow the conversion to round-trip.
+
+More profoundly broken objects (e.g., a commit with a truncated "tree"
+header line) cannot be converted but were not usable by current Git
+anyway.
+
+Shallow clone and submodules
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Because it requires all referenced objects to be available in the
+locally generated translation table, this design does not support
+shallow clone or unfetched submodules. Protocol improvements might
+allow lifting this restriction.
+
+Alternates
+~~~~~~~~~~
+For the same reason, a newhash repository cannot borrow objects from a
+sha1 repository using objects/info/alternates or
+$GIT_ALTERNATE_OBJECT_REPOSITORIES.
+
+git notes
+~~~~~~~~~
+The "git notes" tool annotates objects using their sha1-name as key.
+This design does not describe a way to migrate notes trees to use
+newhash-names. That migration is expected to happen separately (for
+example using a file at the root of the notes tree to describe which
+hash it uses).
+
+Server-side cost
+~~~~~~~~~~~~~~~~
+Until Git protocol gains NEWHASH support, using newhash based storage on
+public-facing Git servers is strongly discouraged. Once Git protocol
+gains NEWHASH support, newhash based servers are likely not to support
+sha1 compatibility, to avoid what may be a very expensive hash
+reencode during clone and to encourage peers to modernize.
+
+The design described here allows fetches by SHA-1 clients of a
+personal NEWHASH repository because it's not much more difficult than
+allowing pushes from that repository. This support needs to be guarded
+by a configuration option --- servers like git.kernel.org that serve a
+large number of clients would not be expected to bear that cost.
+
+Meaning of signatures
+~~~~~~~~~~~~~~~~~~~~~
+The signed payload for signed commits and tags does not explicitly
+name the hash used to identify objects. If some day Git adopts a new
+hash function with the same length as the current SHA-1 (40
+hexadecimal digit) or NEWHASH (64 hexadecimal digit) objects then the
+intent behind the PGP signed payload in an object signature is
+unclear:
+
+	object e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
+	type commit
+	tag v2.12.0
+	tagger Junio C Hamano <gitster@pobox.com> 1487962205 -0800
+
+	Git 2.12
+
+Does this mean Git v2.12.0 is the commit with sha1-name
+e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
+new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?
+
+Fortunately NEWHASH and SHA-1 have different lengths. If Git starts
+using another hash with the same length to name objects, then it will
+need to change the format of signed payloads using that hash to
+address this issue.
+
+Alternatives considered
+-----------------------
+Upgrading everyone working on a particular project on a flag day
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Projects like the Linux kernel are large and complex enough that
+flipping the switch for all projects based on the repository at once
+is infeasible.
+
+Not only would all developers and server operators supporting
+developers have to switch on the same flag day, but supporting tooling
+(continuous integration, code review, bug trackers, etc) would have to
+be adapted as well. This also makes it difficult to get early feedback
+from some project participants testing before it is time for mass
+adoption.
+
+Using hash functions in parallel
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+(e.g. https://public-inbox.org/git/22708.8913.864049.452252@chiark.greenend.org.uk/ )
+Objects newly created would be addressed by the new hash, but inside
+such an object (e.g. commit) it is still possible to address objects
+using the old hash function.
+* You cannot trust its history (needed for bisectability) in the
+  future without further work
+* Maintenance burden as the number of supported hash functions grows
+  (they will never go away, so they accumulate). In this proposal, by
+  comparison, converted objects lose all references to SHA-1.
+
+Signed objects with multiple hashes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Instead of introducing the gpgsig-newhash field in commit and tag objects
+for newhash-content based signatures, an earlier version of this design
+added "hash newhash <newhash-name>" fields to strengthen the existing
+sha1-content based signatures.
+
+In other words, a single signature was used to attest to the object
+content using both hash functions. This had some advantages:
+* Using one signature instead of two speeds up the signing process.
+* Having one signed payload with both hashes allows the signer to
+  attest to the sha1-name and newhash-name referring to the same object.
+* All users consume the same signature. Broken signatures are likely
+  to be detected quickly using current versions of git.
+
+However, it also came with disadvantages:
+* Verifying a signed object requires access to the sha1-names of all
+  objects it references, even after the transition is complete and
+  translation table is no longer needed for anything else. To support
+  this, the design added fields such as "hash sha1 tree <sha1-name>"
+  and "hash sha1 parent <sha1-name>" to the newhash-content of a signed
+  commit, complicating the conversion process.
+* Allowing signed objects without a sha1 (for after the transition is
+  complete) complicated the design further, requiring a "nohash sha1"
+  field to suppress including "hash sha1" fields in the newhash-content
+  and signed payload.
+
+
+Implementation plan
+-------------------
+
+Here's a rough list of some useful tasks, in no particular order:
+
+1. bc/object-id: This patch series continues, eliminating assumptions
+   about the size of object ids by encapsulating them in a struct.
+   One straightforward way to find code that still needs to be
+   converted is to grep for "sha" --- often the conversion patches
+   change function and variable names to refer to oid_ where they used
+   to use sha1_, making the stragglers easier to spot.
+
+2. Hard-coded object ids in tests: Many tests beyond t00* make assumptions
+   about the exact values of object ids.  That's bad for maintainability
+   for other reasons beyond the hash function transition, too.
+
+   It should be possible to suss them out by patching git's sha1
+   routine to use the ones-complement of sha1 (~sha1) instead and
+   seeing which tests fail.
+
+3. Repository format extension to use a different hash function: we
+   want git to be able to work with two hash functions: sha1 and
+   something else.  For interoperability and simplity, it is useful
+   for a single git binary to support both hash functions.
+
+   That means a repository needs to be able to specify what hash
+   function is used for the objects in that repository.  This can be
+   configured by setting '[core] repositoryformatversion=1' (to avoid
+   confusing old versions of git) and
+   '[extensions] experimentalNewHashFunction = true'.
+   Documentation/technical/repository-version.txt has more details.
+
+   We can start experimenting with this using e.g. the ~sha1 function
+   described at (2), or the 160-bit hash of the patch author's choice
+   (e.g. truncated blake2bp-256).
+
+4. When choosing a hash function, people may argue about performance.
+   It would be useful for run some benchmarks for git (running
+   the test suite, t/perf tests, etc) using a variety of hash
+   functions as input to such a discussion.
+
+5. Longer hash: Even once all object id references in git use struct
+   object_id (see (1)), we need to tackle other assumptions about
+   object id size in git and its tests.
+
+   It should be possible to suss them out by replacing git's sha1
+   routine with a 40-byte hash: sha1 with each byte repeated (sha1+sha1)
+   and seeing what fails.
+
+6. Repository format extension for longer hash: As in (3), we could
+   add a repository format extension to experiment with using the
+   sha1+sha1 function.
+
+7. Avoiding wasted memory from unused hash functions: struct object_id
+   has definition 'unsigned char hash[GIT_MAX_RAWSZ]', where
+   GIT_MAX_RAWSZ is the size of the largest supported hash function.
+   When operating on a repository that only uses sha1, this wastes
+   memory.
+
+   Avoid that by making object identifiers variable-sized.  That is,
+   something like
+
+     struct object_id {
+        union {
+           unsigned char hash20[20];
+           unsigned char hash32[32];
+        } *hash;
+     }
+
+   or
+
+     struct object_id {
+       unsigned char *hash;
+     }
+
+   The hard part is that allocation and destruction have to be
+   explicit instead of happening automatically when an object_id is an
+   automatic variable.
+
+8. Implementation of this plan (roughly in order):
+   - abstract the hash computation to be able to plug in another hash
+   - make the choice of hash dependant on repository extension
+   - implement the new .idx format
+   - implement cat-file's flag to show things in old/new hash
+   - convert fetch, push
+
+9. We can use help from security experts in all of this.  Fuzzing,
+   analysis of how we use cryptography, security review of other parts
+   of the design, and information to help choose a hash function are
+   all appreciated.
+
+Agreed-upon criteria for selecting NewHash
+------------------------------------------
+
+The discussion which hash function to use is going in circles, so let's
+first argree on criteria on how to select the new hash function. These
+could include:
+* cryptografic strength
+* performance
+* other cryptografic aspects(?)
+* portability / availability of properly licensed implementations
+
+Future work
+-----------
+
+* other compression instead of zlib (this is a stated non goal, though!)
+* rehash discussion whether to include generation numbers natively
+  (this is a stated non goal, though!)
+* describing (1) the possibility of caching translated objects
+* and (2) protocol changes.
+* other format changes
+
+Document History
+----------------
+
+2017-03-03
+bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
+sbeller@google.com
+
+Initial version sent to
+http://public-inbox.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com
+
+2017-03-03 jrnieder@gmail.com
+Incorporated suggestions from jonathantanmy and sbeller:
+* describe purpose of signed objects with each hash type
+* redefine signed object verification using object content under the
+  first hash function
+
+2017-03-06 jrnieder@gmail.com
+* Use SHA3-256 instead of SHA2 (thanks, Linus and brian m. carlson).[1][2]
+* Make sha3-based signatures a separate field, avoiding the need for
+  "hash" and "nohash" fields (thanks to peff[3]).
+* Add a sorting phase to fetch (thanks to Junio for noticing the need
+  for this).
+* Omit blobs from the topological sort during fetch (thanks to peff).
+* Discuss alternates, git notes, and git servers in the caveats
+  section (thanks to Junio Hamano, brian m. carlson[4], and Shawn
+  Pearce).
+* Clarify language throughout (thanks to various commenters,
+  especially Junio).
+
+[1] http://public-inbox.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
+[2] http://public-inbox.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
+[3] http://public-inbox.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
+[4] http://public-inbox.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
+
+2017-09-25
+* replaced SHA3-256 with NEWHASH, sha3 with newhash
+* added section 'Implementation plan'
+* added section 'Future work'
+
+* This version is sent to the list; to be incorporated into git.git, such
+  that further document history is found using git-log.
+
+
-- 
2.14.0.rc0.3.g6c2e499285

