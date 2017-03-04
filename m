Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB3620133
	for <e@80x24.org>; Sat,  4 Mar 2017 01:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdCDBnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 20:43:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33428 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdCDBnS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 20:43:18 -0500
Received: by mail-pg0-f67.google.com with SMTP id 77so1450466pgc.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 17:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BhaUcSDZaTVno29GPO3Krpm0eY6ERh5HPtiKS/LT4lw=;
        b=HKlUOfDMAR0EcqPepEv0adv/hEBwyEetAwX6TrWwyWQCIP+lGfOQxseksakgsSCaCZ
         0uddabSPXfIgfb9OS0NEiZiVj43ULjy3BHJrpwizCvpvQ2lao/8trxz/tCWyPPoVVEAT
         FZ7zIuwBtjnSpd5w2f2ygPsGc1B3k7Uke/KrPCpyknUP5Kd8D2S83Y3+Rd5XDVFtmUYW
         /a+pAULGxng27waxOuiwKx5EEMT9yp5+JFUJZxni+eRKLPhvRFL+Pv1kSpJBT7S1nG7W
         UgpDD/nIhb0UUdNIyMiuRar6DqyKJmKsej6tu5fAad1nKQbyho7De5+xdc6S6RLHBCqm
         2+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BhaUcSDZaTVno29GPO3Krpm0eY6ERh5HPtiKS/LT4lw=;
        b=lS1kGp2pxf+n8Gz4icnM3Y6WNaDXZJH2MeryYhUFdPC0O3aBrX8dSRWHuk/iS2KoZs
         rZwTj2GUZnips2+2GBaHgz6fZk0kceddJmPsDas9xXweKLeF16LXWNwXvZF+sfH5lwpW
         /mkao9TBMER1gMMmAMFr87hBw6F5kWQrCoqmZtnxT4ayWFd/uutHDHYAqvvmWLs4G0fa
         oEd+FI7gDaBI4uvlL9TDP9yNzoW1STo+S1gcyPfyGMxDed3AevDKHOudKEh3IukNK8PC
         CxbMW3wRK54uWjFJaeQbVHmA454VF+gIsnaPuwjG6ChcnC92m+d4fu6Ckj6UjiCeQCSb
         BxUQ==
X-Gm-Message-State: AMke39mlDIKyI/k3WxALu56lDTyMYIrS07d+R0jLJ0a++99ur4/s+pjpIKfZxFE4rxOruQ==
X-Received: by 10.98.81.6 with SMTP id f6mr6855197pfb.180.1488590013404;
        Fri, 03 Mar 2017 17:13:33 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:31e6:2fed:ff25:b9a6])
        by smtp.gmail.com with ESMTPSA id c22sm25784912pgn.43.2017.03.03.17.13.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Mar 2017 17:13:32 -0800 (PST)
Date:   Fri, 3 Mar 2017 17:12:51 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, bmwill@google.com, jonathantanmy@google.com,
        peff@peff.net, Linus Torvalds <torvalds@linux-foundation.org>
Subject: RFC: Another proposed hash function transition plan
Message-ID: <20170304011251.GA26789@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This past week we came up with this idea for what a transition to a new
hash function for Git would look like.  I'd be interested in your
thoughts (especially if you can make them as comments on the document,
which makes it easier to address them and update the document).

This document is still in flux but I thought it best to send it out
early to start getting feedback.

We tried to incorporate some thoughts from the thread
http://public-inbox.org/git/20170223164306.spg2avxzukkggrpb@kitenet.net
but it is a little long so it is easy to imagine we've missed
some things already discussed there.

You can use the doc URL

 https://goo.gl/gh2Mzc

to view the latest version and comment.

Thoughts welcome, as always.

Git hash function transition
============================
Status: Draft
Last Updated: 2017-03-03

Objective
---------
Migrate Git from SHA-1 to a stronger hash function.

Background
----------
The Git version control system can be thought of as a content
addressable filesystem. It uses the SHA-1 hash function to name
content. For example, files, trees, commits are referred to by hash
values unlike in other traditional version control systems where files
or versions are referred to via sequential numbers. The use of a hash
function to address its content delivers a few advantages:

* Integrity checking is easy. Bit flips, for example, are easily
  detected, as the hash of corrupted content does not match its name.
  Lookup of objects is fast.

Using a cryptographically secure hash function brings additional advantages:

* Object names can be signed and third parties can trust the hash to
  address the signed object and all objects it references.
* Communication using Git protocol and out of band communication
  methods have a short reliable string that can be used to reliably
  address stored content.

Over time some flaws in SHA-1 have been discovered by security
researchers. https://shattered.io demonstrated a practical SHA-1 hash
collision. As a result, SHA-1 cannot be considered cryptographically
secure any more. This impacts the communication of hash values because
we cannot trust that a given hash value represents the known good
version of content that the speaker intended.

SHA-1 still possesses the other properties such as fast object lookup
and safe error checking, but other hash functions are equally suitable
that are believed to be cryptographically secure.

Goals
-----
1. The transition to SHA256 can be done one local repository at a time.
   a. Requiring no action by any other party.
   b. A SHA256 repository can communicate with SHA-1 Git servers and
      clients (push/fetch).
   c. Users can use SHA-1 and SHA256 identifiers for objects
      interchangeably.
   d. New signed objects make use of a stronger hash function than
      SHA-1 for their security guarantees.
2. Allow a complete transition away from SHA-1.
   a. Local metadata for SHA-1 compatibility can be dropped in a
      repository if compatibility with SHA-1 is no longer needed.
3. Maintainability throughout the process.
   a. The object format is kept simple and consistent.
   b. Creation of a generalized repository conversion tool.

Non-Goals
---------
1. Add SHA256 support to Git protocol. This is valuable and the
   logical next step but it is out of scope for this initial design.
2. Transparently improving the security of existing SHA-1 signed
   objects.
3. Intermixing objects using multiple hash functions in a single
   repository.
4. Taking the opportunity to fix other bugs in git's formats and
   protocols.
5. Shallow clones and fetches into a SHA256 repository. (This will
   change when we add SHA256 support to Git protocol.)
6. Skip fetching some submodules of a project into a SHA256
   repository. (This also depends on SHA256 support in Git protocol.)

Overview
--------
We introduce a new repository format extension `sha256`. Repositories
with this extension enabled use SHA256 instead of SHA-1 to name their
objects. This affects both object names and object content --- both
the names of objects and all references to other objects within an
object are switched to the new hash function.

sha256 repositories cannot be read by older versions of Git.

Alongside the packfile, a sha256 stores a bidirectional mapping
between sha256 and sha1 object names. The mapping is generated locally
and can be verified using "git fsck". Object lookups use this mapping
to allow naming objects using either their sha1 and sha256 names
interchangeably.

"git cat-file" and "git hash-object" gain options to display a sha256
object in its sha1 form and write a sha256 object given its sha1 form.
This requires all objects referenced by that object to be present in
the object database so that they can be named using the appropriate
name (using the bidirectional hash mapping).

Fetches from a SHA-1 based server convert the fetched objects into
sha256 form and record the mapping in the bidirectional mapping table
(see below for details). Pushes to a SHA-1 based server convert the
objects being pushed into sha1 form so the server does not have to be
aware of the hash function the client is using.

Detailed Design
---------------
Object names
~~~~~~~~~~~~
Objects can be named by their 40 hexadecimal digit sha1-name or 64
hexadecimal digit sha256-name, plus names derived from those (see
gitrevisions(7)).

The sha1-name of an object is the SHA-1 of the concatenation of its
type, length, a nul byte, and the object's sha1-content. This is the
traditional <sha1> used in Git to name objects.

The sha256-name of an object is the SHA-256 of the concatenation of
its type, length, a nul byte, and the object's sha256-content.

Object format
~~~~~~~~~~~~~
Objects are stored using a compressed representation of their
sha256-content. The sha256-content of an object is the same as its
sha1-content, except that:
* objects referenced by the object are named using their sha256-names
  instead of sha1-names
* signed tags, commits, and merges of signed tags get some additional
  fields (see below)

The format allows round-trip conversion between sha256-content and
sha1-content.

Loose objects use zlib compression and packed objects use the packed
format described in Documentation/technical/pack-format.txt, just like
today.

Translation table
~~~~~~~~~~~~~~~~~
A fast bidirectional mapping between sha1-names and sha256-names of
all local objects in the repository is kept on disk. The exact format
of that mapping is to be determined.

All operations that make new objects (e.g., "git commit") add the new
objects to the translation table.

Reading an object's sha1-content
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The sha1-content of an object can be read by converting all
sha256-names its sha256-content references to sha1-names using the
translation table. There is an additional minor transformation needed
for signed tags, commits, and merges (see below).

Fetch
~~~~~
Fetching from a SHA-1 based server requires translating between SHA-1
and SHA-256 based representations on the fly.

SHA-1s named in the ref advertisement can be translated to SHA-256 and
looked up as local objects using the translation table.

Negotiation proceeds as today. Any "have"s or "want"s generated
locally are converted to SHA-1 before being sent to the server, and
SHA-1s mentioned by the server are converted to SHA-256 when looking
them up locally.

After negotiation, the server sends a packfile containing the
requested objects. We convert the packfile to SHA-256 format using the
following steps:

1. index-pack: inflate each object in the packfile and compute its
   SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
   objects the client has locally. These objects can be looked up using
   the translation table and their sha1-content read as described above
   to resolve the deltas.
2. topological sort: starting at the "want"s from the negotiation
   phase, walk through objects in the pack and emit a list of them in
   topologically sorted order. (This list only contains objects
   reachable from the "wants". If the pack from the server contained
   additional extraneous objects, then they will be discarded.)
3. convert to sha256: open a new (sha256) packfile. Read the
   topologically sorted list just generated in reverse order. For each
   object, inflate its sha1-content, convert to sha256-content, and
   write it to the sha256 pack. Write an idx file for this pack and
   include the new sha1<->sha256 mapping entry in the translation
   table.
4. clean up: remove the SHA-1 based pack file, index, and
   topologically sorted list obtained from the server and steps 1 and 2.

Step 3 requires every object referenced by the new object to be in the
translation table. This is why the topological sort step is necessary.

As an optimization, step 1 can write a file describing what objects
each object it has inflated from the packfile references. This makes
the topological sort in step 2 possible without inflating the objects
in the packfile for a second time. The objects need to be inflated
again in step 3, for a total of two inflations.

Push
~~~~
Push is simpler than fetch because the objects referenced by the
pushed objects are already in the translation table. The sha1-content
of each object being pushed can be read as described in the "Reading
an object's sha1-content" section to generate the pack written by git
send-pack.

Signed Objects
~~~~~~~~~~~~~~
Commits
^^^^^^^
Commits currently have the following sequence of header lines:

	"tree" SP object-name
	("parent" SP object-name)*
	"author" SP ident
	"committer" SP ident
	("mergetag" SP object-content)?
	("gpgsig" SP pgp-signature)?

We introduce new header lines "hash" and "nohash" that come after the
"gpgsig" field. No "hash" lines may appear unless the "gpgsig" field
is present.

Hash lines have the form

	"hash" SP hash-function SP field SP alternate-object-name

Nohash lines have the form

	"nohash" SP hash-function

There are only two recognized values of hash-function: "sha1" and
"sha256". "git fsck" will tolerate values of hash-function it does not
recognize, as long as they do not come before either of those two. All
"nohash" lines come before all "hash" lines. Any "hash sha1" lines
must come before all "hash sha256" lines, and likewise for nohash. The
Git project determines any future supported hash-functions that can
come after those two and their order.

There can be at most one "nohash <hash-function>" for one hash
function, indicating that this hash function should not be used when
checking the commit's signature.

There is one "hash <hash-function>" line for each tree or parent field
in the commit object header. The hash lines record object names for
those trees and parents using the indicated hash function, to be used
when checking the commit's signature.

TODO: simplify signature rules, handle the mergetag field better.

sha256-content of signed commits
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The sha256-content of a commit with a "gpgsig" header can include no
hash and nohash lines, a "nohash sha256" line and "hash sha1", or just
a "hash sha1" line.

Examples:
1. tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
2. tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
   nohash sha256
   hash sha1 tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   hash sha1 parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   hash sha1 parent 04b871796dc0420f8e7561a895b52484b701d51a
3. tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
   hash sha1 tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   hash sha1 parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   hash sha1 parent 04b871796dc0420f8e7561a895b52484b701d51a

sha1-content of signed commits
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The sha1-content of a commit with a "gpgsig" header can contain a
"nohash sha1" and "hash sha256" line, no hash or nohash lines, or just
a "hash sha256" line.

Examples:
1. tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   parent 04b871796dc0420f8e7561a895b52484b701d51a
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
   nohash sha1
   hash sha256 tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   hash sha256 parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   hash sha256 parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
2. tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   parent 04b871796dc0420f8e7561a895b52484b701d51a
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
3. tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   parent 04b871796dc0420f8e7561a895b52484b701d51a
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   gpgsig ...
   hash sha256 tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   hash sha256 parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   hash sha256 parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315

Converting signed commits
^^^^^^^^^^^^^^^^^^^^^^^^^
To convert the sha1-content of a signed commit to its sha256-content:

1. Change "tree" and "parent" lines to use the sha256-names of
   referenced objects, as with unsigned commits.
2. If there is a "mergetag" field, convert it from sha1-content to
   sha256-content, as with unsigned commits with a mergetag (see the
   "Mergetag" section below).
3. Unless there is a "nohash sha1" line, add a full set of "hash sha1
   <field> <sha1>" lines indicating the sha1-names of the tree and
   parents.
4. Remove any "hash sha256 <field> <sha256>" lines. If no such lines
   were present, add a "nohash sha256" line.

Converting the sha256-content of a signed commit to sha1-content uses
the same process with sha1 and sha256 switched.

Verifying signed commit signatures
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If the commit has a "hash sha1" line (or is sha1-content without a
"nohash sha1" line): check that the signature matches the sha1-content
with gpgsig field stripped out.

Otherwise: check that the signature matches the sha1-content with
gpgsig, nohash, tree, and parents fields stripped out.

With the examples above, the signed payloads are
1. author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   hash sha256 tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   hash sha256 parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   hash sha256 parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
2. tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   parent 04b871796dc0420f8e7561a895b52484b701d51a
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
3. tree c7b1cff039a93f3600a1d18b82d26688668c7dea
   parent c33429be94b5f2d3ee9b0adad223f877f174b05d
   parent 04b871796dc0420f8e7561a895b52484b701d51a
   author A U Thor <author@example.com> 1465982009 +0000
   committer C O Mitter <committer@example.com> 1465982009 +0000
   hash sha1
   hash sha256 tree 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   hash sha256 parent e094bc809626f0a401a40d75c56df478e546902ff812772c4594265203b23980
   hash sha256 parent 1059dab4748aa33b86dad5ca97357bd322abaa558921255623fbddd066bb3315
   
Current versions of "git verify-commit" can verify examples (2) and (3)
(but not (1)).

Tags
~~~~
Tags currently have the following sequence of header lines:
   
   	"object" SP object-name
	"type" SP type
	"tag" SP identifier
	"tagger" SP ident

A tag's signature, if it exists, is in the message body.

We introduce new header lines "nohash" and "hash" that come after the
"tagger" field. No "nohash" or "hash" lines may appear unless the
message body contains a PGP signature.

As with commits, "nohash" lines have the form "nohash
<hash-function>", indicating that this hash function should not be
used when checking the tag's signature.

"hash" lines have the form

	"hash" SP hash-function SP alternate-object-name

This records the pointed-to object name using the indicated hash
function, to be used when checking the tag's signature.

As with commits, "sha1" and "sha256" are the only permitted values of
hash-function and can only appear in that order for a field when they
appear. There can be at most one "nohash" line, and it comes before
any "hash" lines. There can be only one "hash" line for a given hash
function.

sha256-content of signed tags
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The sha256-content of a signed tag can include no "hash" or "nohash"
lines, a "nohash sha256" and "hash sha1 <sha1>" line, or just a "hash
sha1 <sha1>" line.

Examples:
1. object 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   type tree
   tag v1.0
   tagger C O Mitter <committer@example.com> 1465981006 +0000

   Tag Demo v1.0
   -----BEGIN PGP SIGNATURE-----
   Version: GnuPG v1

   iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
   ...
2. object 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   type tree
   tag v1.0
   tagger C O Mitter <committer@example.com> 1465981006 +0000
   nohash sha256
   hash sha1 c7b1cff039a93f3600a1d18b82d26688668c7dea

   Tag Demo v1.0
   -----BEGIN PGP SIGNATURE-----
   ...
3. object 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
   type tree
   tag v1.0
   tagger C O Mitter <committer@example.com> 1465981006 +0000
   hash sha1 c7b1cff039a93f3600a1d18b82d26688668c7dea

   Tag Demo v1.0
   ...

sha1-content of signed tags
^^^^^^^^^^^^^^^^^^^^^^^^^^^
The sha1-content of a signed tag can include a "nohash sha1" and "hash
sha256" line, no "nohash" or "hash" lines, or just a "hash sha256
<sha256>" line.
   
Examples:
1. object c7b1cff039a93f3600a1d18b82d26688668c7dea
   ...
   tagger C O Mitter <committer@example.com> 1465981006 +0000
   nohash sha1
   hash sha256 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4

   Tag Demo v1.0
   -----BEGIN PGP SIGNATURE-----
   ...
2. object c7b1cff039a93f3600a1d18b82d26688668c7dea
   ...
   tagger C O Mitter <committer@example.com> 1465981006 +0000

   Tag Demo v1.0
   -----BEGIN PGP SIGNATURE-----
   ...
3. object c7b1cff039a93f3600a1d18b82d26688668c7dea
   ...
   tagger C O Mitter <committer@example.com> 1465981006 +0000
   hash sha256 98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4

   Tag Demo v1.0
   -----BEGIN PGP SIGNATURE-----
   ...

Signed tags can be converted between sha1-content and sha256-content
using the same process as signed commits.

Verifying signed tags
^^^^^^^^^^^^^^^^^^^^^
As with commits, if the tag has a "hash sha1" (or is sha1-content
without a "nohash sha1" line): check that the signature matches the
sha1-content with PGP signature stripped out.
   
Otherwise: check that the signature matches the sha1-content with
nohash and object fields and PGP signature stripped out.

Mergetag signatures
~~~~~~~~~~~~~~~~~~~
The mergetag field in the sha1-content of a commit contains the
sha1-content of a tag that was merged by that commit.

The mergetag field in the sha256-content of the same commit contains
the sha256-content of the same tag.

Submodules
~~~~~~~~~~
To convert recorded submodule pointers, you need to have the converted
submodule repository in place. The bidirectional mapping of the
submodule can be used to look up the new hash.

Caveats
-------
Shallow clone and submodules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Because this requires all referenced objects to be available in the
locally generated translation table, this design does not support
shallow clone or unfetched submodules.

Protocol improvements might allow lifting this restriction.

Alternatives considered
-----------------------
Upgrading everyone working on a particular project on a flag day
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Projects like the Linux kernel are large and complex enough that
flipping the switch for all projects based on the repository at once
is infeasible.

Not only would all developers and server operators supporting
developers have to switch on the same flag day, but supporting tooling
(continuous integration, code review, bug trackers, etc) would have to
be adapted as well. This also makes it difficult to get early feedback
from some project participants testing before it is time for mass
adoption.

Using hash functions in parallel 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(e.g. https://public-inbox.org/git/22708.8913.864049.452252@chiark.greenend.org.uk/ )
Objects newly created would be addressed by the new hash, but inside
such an object (e.g. commit) it is still possible to address objects
using the old hash function.

* You cannot trust its history (needed for bisectability) in the
  future without further work 
* Maintenance burden as the number of supported hash functions grows
  (they will never go away, so they accumulate). In this proposal, by
  comparison, converted objects lose all references to SHA-1 except
  where needed to verify signatures.
