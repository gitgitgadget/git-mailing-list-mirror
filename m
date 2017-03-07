Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372B320133
	for <e@80x24.org>; Tue,  7 Mar 2017 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbdCGA0a (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 19:26:30 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34350 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbdCGA0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 19:26:25 -0500
Received: by mail-pf0-f181.google.com with SMTP id v190so30100587pfb.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 16:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2ooFXT2pYMtI3eBVCSuEA314s05pymn+MiHtl8D40rI=;
        b=ASsM1PhDuhDy8+S33m3smX9XItT0dGljfX77FtPqRRdwrjCJyjlySRPA1gzcuDBP7U
         0LvLe2HJxLqNZA1JM8gO4ITmKXLgpHHRcWy7InJCHYxtxRibzMTSHlBWI/wIM7H30yhq
         6ldx4d5hl2y4YoeYA0vECbYDqPLMmdrh/IdTC588YL+6sI+eAR9RoHOWpJTcSMg4E0Yx
         o6MB60YH2unmciKN50GYSM4XH/aTrrLe6pW1bkGtFygDGzXi8z49NNSw98V8YpwZ2GOG
         oNPHPiVk+aF9xZByppMu3XjcPtiT+4MDiSo/sUAntUnmTFDdGuX9c/ImLtpKKnisFouU
         vVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2ooFXT2pYMtI3eBVCSuEA314s05pymn+MiHtl8D40rI=;
        b=LZ9XxoOpty9bNLOythW7zxZXQnX9dOs9D9OZWd1b6n4XrDFwPloOsKbcNi9orD+mY2
         6DIltZ56dyW061h/79XE+2mY+r7j051nIImCry4auiO5NN9kNGhTJrvnadsMjaEkUHQo
         15SNvjduoiZM+CyXTR7kYXS2iS9UaKh483XJOqjzxyLv0OJGAi4ndovUU7Mbfx3nCIaL
         jaXGGyJXBMarOA7V4SiilirpNMMnhHvq2vFpkk1ssbDrlc33bZ+rDQSaVauWmVLwIZIO
         SxuHz7ZFs+wN9tTi9Dn7hv94A2SvM9J9wsfX3PUzsB7cR70okmKXQILdkxUf4Pi7tyig
         xxPA==
X-Gm-Message-State: AMke39kKuBP1/o1J5x1mKAVUhFnKV7Rcn3GUig7lY0RHWb0Xj/UBCF7qAz0Qhnj2jRhu4Q==
X-Received: by 10.98.39.195 with SMTP id n186mr24094873pfn.17.1488845831989;
        Mon, 06 Mar 2017 16:17:11 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:39da:9b0c:a72:8776])
        by smtp.gmail.com with ESMTPSA id x21sm23833214pfa.71.2017.03.06.16.17.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 16:17:11 -0800 (PST)
Date:   Mon, 6 Mar 2017 16:17:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: RFC v3: Another proposed hash function transition plan
Message-ID: <20170307001709.GC26789@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> This document is still in flux but I thought it best to send it out
>> early to start getting feedback.
>
> This actually looks very reasonable if you can implement it cleanly
> enough.

Thanks for the kind words on what had quite a few flaws still.  Here's
a new draft.  I think the next version will be a patch against
Documentation/technical/.

As before, comments welcome, both here and inline at

  https://goo.gl/gh2Mzc

Changes since v2:

Use SHA3-256 instead of SHA2 (thanks, Linus and brian m.
carlson).[1][2]

Make sha3-based signatures a separate field, avoiding the need for
"hash" and "nohash" fields (thanks to peff[3]).

Add a sorting phase to fetch (thanks to Junio for noticing the need
for this).

Omit blobs from the topological sort during fetch (thanks to peff).

Discuss alternates, git notes, and git servers in the caveats section
(thanks to Junio Hamano, brian m. carlson[4], and Shawn Pearce).

Clarify language throughout (thanks to various commenters, especially
Junio).

Sincerely,
Jonathan

Git hash function transition
============================
Status: Draft
Last Updated: 2017-03-06

Objective
---------
Migrate Git from SHA-1 to a stronger hash function.

Background
----------
At its core, the Git version control system is a content addressable
filesystem. It uses the SHA-1 hash function to name content. For
example, files, directories, and revisions are referred to by hash
values unlike in other traditional version control systems where files
or versions are referred to via sequential numbers. The use of a hash
function to address its content delivers a few advantages:

* Integrity checking is easy. Bit flips, for example, are easily
  detected, as the hash of corrupted content does not match its name.
* Lookup of objects is fast.

Using a cryptographically secure hash function brings additional
advantages:

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
1. The transition to SHA3-256 can be done one local repository at a time.
   a. Requiring no action by any other party.
   b. A SHA3-256 repository can communicate with SHA-1 Git servers
      (push/fetch).
   c. Users can use SHA-1 and SHA3-256 identifiers for objects
      interchangeably.
   d. New signed objects make use of a stronger hash function than
      SHA-1 for their security guarantees.
2. Allow a complete transition away from SHA-1.
   a. Local metadata for SHA-1 compatibility can be removed from a
      repository if compatibility with SHA-1 is no longer needed.
3. Maintainability throughout the process.
   a. The object format is kept simple and consistent.
   b. Creation of a generalized repository conversion tool.

Non-Goals
---------
1. Add SHA3-256 support to Git protocol. This is valuable and the
   logical next step but it is out of scope for this initial design.
2. Transparently improving the security of existing SHA-1 signed
   objects.
3. Intermixing objects using multiple hash functions in a single
   repository.
4. Taking the opportunity to fix other bugs in git's formats and
   protocols.
5. Shallow clones and fetches into a SHA3-256 repository. (This will
   change when we add SHA3-256 support to Git protocol.)
6. Skip fetching some submodules of a project into a SHA3-256
   repository. (This also depends on SHA3-256 support in Git
   protocol.)

Overview
--------
We introduce a new repository format extension `sha3`. Repositories
with this extension enabled use SHA3-256 instead of SHA-1 to name
their objects. This affects both object names and object content ---
both the names of objects and all references to other objects within
an object are switched to the new hash function.

sha3 repositories cannot be read by older versions of Git.

Alongside the packfile, a sha3 repository stores a bidirectional
mapping between sha3 and sha1 object names. The mapping is generated
locally and can be verified using "git fsck". Object lookups use this
mapping to allow naming objects using either their sha1 and sha3 names
interchangeably.

"git cat-file" and "git hash-object" gain options to display an object
in its sha1 form and write an object given its sha1 form. This
requires all objects referenced by that object to be present in the
object database so that they can be named using the appropriate name
(using the bidirectional hash mapping).

Fetches from a SHA-1 based server convert the fetched objects into
sha3 form and record the mapping in the bidirectional mapping table
(see below for details). Pushes to a SHA-1 based server convert the
objects being pushed into sha1 form so the server does not have to be
aware of the hash function the client is using.

Detailed Design
---------------
Object names
~~~~~~~~~~~~
Objects can be named by their 40 hexadecimal digit sha1-name or 64
hexadecimal digit sha3-name, plus names derived from those (see
gitrevisions(7)).

The sha1-name of an object is the SHA-1 of the concatenation of its
type, length, a nul byte, and the object's sha1-content. This is the
traditional <sha1> used in Git to name objects.

The sha3-name of an object is the SHA3-256 of the concatenation of its
type, length, a nul byte, and the object's sha3-content.

Object format
~~~~~~~~~~~~~
The content as a byte sequence of a tag, commit, or tree object named
by sha1 and sha3 differ because an object named by sha3-name refers to
other objects by their sha3-names and an object named by sha1-name
refers to other objects by their sha1-names.

The sha3-content of an object is the same as its sha1-content, except
that objects referenced by the object are named using their sha3-names
instead of sha1-names. Because a blob object does not refer to any
other object, its sha1-content and sha3-content are the same.

The format allows round-trip conversion between sha3-content and
sha1-content.

Object storage
~~~~~~~~~~~~~~
Loose objects use zlib compression and packed objects use the packed
format described in Documentation/technical/pack-format.txt, just like
today. The content that is compressed and stored uses sha3-content
instead of sha1-content.

Translation table
~~~~~~~~~~~~~~~~~
A fast bidirectional mapping between sha1-names and sha3-names of all
local objects in the repository is kept on disk. The exact format of
that mapping is to be determined.

All operations that make new objects (e.g., "git commit") add the new
objects to the translation table.

(This work could have been deferred to push time, but that would
significantly complicate and slow down pushes. Calculating the
sha1-name at object creation time at the same time it is being
streamed to disk and having its sha3-name calculated should be an
acceptable cost.)

Reading an object's sha1-content
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The sha1-content of an object can be read by converting all sha3-names
its sha3-content references to sha1-names using the translation table.

Fetch
~~~~~
Fetching from a SHA-1 based server requires translating between SHA-1
and SHA3-256 based representations on the fly.

SHA-1s named in the ref advertisement that are present on the client
can be translated to SHA3-256 and looked up as local objects using the
translation table.

Negotiation proceeds as today. Any "have"s generated locally are
converted to SHA-1 before being sent to the server, and SHA-1s
mentioned by the server are converted to SHA3-256 when looking them up
locally.

After negotiation, the server sends a packfile containing the
requested objects. We convert the packfile to SHA3-256 format using
the following steps:

1. index-pack: inflate each object in the packfile and compute its
   SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
   objects the client has locally. These objects can be looked up
   using the translation table and their sha1-content read as
   described above to resolve the deltas.
2. topological sort: starting at the "want"s from the negotiation
   phase, walk through objects in the pack and emit a list of them,
   excluding blobs, in reverse topologically sorted order, with each
   object coming later in the list than all objects it references.
   (This list only contains objects reachable from the "wants". If the
   pack from the server contained additional extraneous objects, then
   they will be discarded.)
3. convert to sha3: open a new (sha3) packfile. Read the topologically
   sorted list just generated. For each object, inflate its
   sha1-content, convert to sha3-content, and write it to the sha3
   pack. Include the new sha1<->sha3 mapping entry in the translation
   table.
4. sort: reorder entries in the new pack to match the order of objects
   in the pack the server generated and include blobs. Write a sha3 idx
   file.
5. clean up: remove the SHA-1 based pack file, index, and
   topologically sorted list obtained from the server and steps 1
   and 2.

Step 3 requires every object referenced by the new object to be in the
translation table. This is why the topological sort step is necessary.

As an optimization, step 1 could write a file describing what non-blob
objects each object it has inflated from the packfile references. This
makes the topological sort in step 2 possible without inflating the
objects in the packfile for a second time. The objects need to be
inflated again in step 3, for a total of two inflations.

Step 4 is probably necessary for good read-time performance. "git
pack-objects" on the server optimizes the pack file for good data
locality (see Documentation/technical/pack-heuristics.txt).

Details of this process are likely to change. It will take some
experimenting to get this to perform well.

Push
~~~~
Push is simpler than fetch because the objects referenced by the
pushed objects are already in the translation table. The sha1-content
of each object being pushed can be read as described in the "Reading
an object's sha1-content" section to generate the pack written by git
send-pack.

Signed Commits
~~~~~~~~~~~~~~
We add a new field "gpgsig-sha3" to the commit object format to allow
signing commits without relying on SHA-1. It is similar to the
existing "gpgsig" field. Its signed payload is the sha3-content of the
commit object with any "gpgsig" and "gpgsig-sha3" fields removed.

This means commits can be signed
1. using SHA-1 only, as in existing signed commit objects
2. using both SHA-1 and SHA3-256, by using both gpgsig-sha3 and gpgsig
   fields.
3. using only SHA3-256, by only using the gpgsig-sha3 field.

Old versions of "git verify-commit" can verify the gpgsig signature in
cases (1) and (2) without modifications and view case (3) as an
ordinary unsigned commit.

Signed Tags
~~~~~~~~~~~
We add a new field "gpgsig-sha3" to the tag object format to allow
signing tags without relying on SHA-1. Its signed payload is the
sha3-content of the tag with its gpgsig-sha3 field and "-----BEGIN PGP
SIGNATURE-----" delimited in-body signature removed.

This means tags can be signed
1. using SHA-1 only, as in existing signed tag objects
2. using both SHA-1 and SHA3-256, by using gpgsig-sha3 and an in-body
   signature.
3. using only SHA3-256, by only using the gpgsig-sha3 field.

Mergetag embedding
~~~~~~~~~~~~~~~~~~
The mergetag field in the sha1-content of a commit contains the
sha1-content of a tag that was merged by that commit.

The mergetag field in the sha3-content of the same commit contains the
sha3-content of the same tag.

Submodules
~~~~~~~~~~
To convert recorded submodule pointers, you need to have the converted
submodule repository in place. The translation table of the submodule
can be used to look up the new hash.

Caveats
-------
Invalid objects
~~~~~~~~~~~~~~~
The conversion from sha1-content to sha3-content retains any
brokenness in the original object (e.g., tree entry modes encoded with
leading 0, tree objects whose paths are not sorted correctly, and
commit objects without an author or committer). This is a deliberate
feature of the design to allow the conversion to round-trip.

More profoundly broken objects (e.g., a commit with a truncated "tree"
header line) cannot be converted but were not usable by current Git
anyway.

Shallow clone and submodules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Because it requires all referenced objects to be available in the
locally generated translation table, this design does not support
shallow clone or unfetched submodules. Protocol improvements might
allow lifting this restriction.

Alternates
~~~~~~~~~~
For the same reason, a sha3 repository cannot borrow objects from a
sha1 repository using objects/info/alternates or
$GIT_ALTERNATE_OBJECT_REPOSITORIES.

git notes
~~~~~~~~~
The "git notes" tool annotates objects using their sha1-name as key.
This design does not describe a way to migrate notes trees to use
sha3-names. That migration is expected to happen separately (for
example using a file at the root of the notes tree to describe which
hash it uses).

Server-side cost
~~~~~~~~~~~~~~~~
Until Git protocol gains SHA3-256 support, using sha3 based storage on
public-facing Git servers is strongly discouraged. Once Git protocol
gains SHA3-256 support, sha3 based servers are likely not to support
sha1 compatibility, to avoid what may be a very expensive hash
reencode during clone and to encourage peers to modernize.

The design described here allows fetches by SHA-1 clients of a
personal SHA256 repository because it's not much more difficult than
allowing pushes from that repository. This support needs to be guarded
by a configuration option --- servers like git.kernel.org that serve a
large number of clients would not be expected to bear that cost.

Meaning of signatures
~~~~~~~~~~~~~~~~~~~~~
The signed payload for signed commits and tags does not explicitly
name the hash used to identify objects. If some day Git adopts a new
hash function with the same length as the current SHA-1 (40
hexadecimal digit) or SHA2-256 (64 hexadecimal digit) objects then the
intent behind the PGP signed payload in an object signature is
unclear:

	object e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
	type commit
	tag v2.12.0
	tagger Junio C Hamano <gitster@pobox.com> 1487962205 -0800

	Git 2.12

Does this mean Git v2.12.0 is the commit with sha1-name
e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?

Fortunately SHA3-256 and SHA-1 have different lengths. If Git starts
using another hash with the same length to name objects, then it will
need to change the format of signed payloads using that hash to
address this issue.

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
  comparison, converted objects lose all references to SHA-1.

Signed objects with multiple hashes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Instead of introducing the gpgsig-sha3 field in commit and tag objects
for sha3-content based signatures, an earlier version of this design
added "hash sha3 <sha3-name>" fields to strengthen the existing
sha1-content based signatures.

In other words, a single signature was used to attest to the object
content using both hash functions. This had some advantages:
* Using one signature instead of two speeds up the signing process.
* Having one signed payload with both hashes allows the signer to
  attest to the sha1-name and sha3-name referring to the same object.
* All users consume the same signature. Broken signatures are likely
  to be detected quickly using current versions of git.

However, it also came with disadvantages:
* Verifying a signed object requires access to the sha1-names of all
  objects it references, even after the transition is complete and
  translation table is no longer needed for anything else. To support
  this, the design added fields such as "hash sha1 tree <sha1-name>"
  and "hash sha1 parent <sha1-name>" to the sha3-content of a signed
  commit, complicating the conversion process.
* Allowing signed objects without a sha1 (for after the transition is
  complete) complicated the design further, requiring a "nohash sha1"
  field to suppress including "hash sha1" fields in the sha3-content
  and signed payload.

Document History
----------------

2017-03-03
bmwill@google.com, jonathantanmy@google.com, jrnieder@gmail.com,
sbeller@google.com

Initial version sent to
http://public-inbox.org/git/20170304011251.GA26789@aiede.mtv.corp.google.com

2017-03-03 jrnieder@gmail.com
Incorporated suggestions from jonathantanmy and sbeller:
* describe purpose of signed objects with each hash type
* redefine signed object verification using object content under the
  first hash function

2017-03-06 jrnieder@gmail.com
* Use SHA3-256 instead of SHA2 (thanks, Linus and brian m. carlson).[1][2]
* Make sha3-based signatures a separate field, avoiding the need for
  "hash" and "nohash" fields (thanks to peff[3]).
* Add a sorting phase to fetch (thanks to Junio for noticing the need
  for this).
* Omit blobs from the topological sort during fetch (thanks to peff).
* Discuss alternates, git notes, and git servers in the caveats
  section (thanks to Junio Hamano, brian m. carlson[4], and Shawn
  Pearce).
* Clarify language throughout (thanks to various commenters,
  especially Junio).

[1] http://public-inbox.org/git/CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com/
[2] http://public-inbox.org/git/CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com/
[3] http://public-inbox.org/git/20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net/
[4] http://public-inbox.org/git/20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net
