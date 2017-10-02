Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF32E20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdJBTXu (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:23:50 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:33007 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJBTXs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:23:48 -0400
X-MHO-User: 2fe8d9ef-a7a7-11e7-a893-25625093991c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.3
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.3])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id 2fe8d9ef-a7a7-11e7-a893-25625093991c;
        Mon, 02 Oct 2017 19:23:37 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id DBA3680053;
        Mon,  2 Oct 2017 19:23:33 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io DBA3680053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1506972214;
        bh=EB6lwJDJld1fFFMmYxH9J6x4JIbWsToOwjDKlyMytDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=zFDVchN8NRaD6vaRVpTd1IOJUMtrGgTW7GZanijsFn2VocQ5aqKKfty6ONunVOYMx
         0l7+DCkDNshGJ0hJJhkZpuL/txaoPuBcnIFI148jQybawunLhK5H3tTye9c9K9IKv4
         Frv+tCUdn/Dd0npOcze82CEIWgZ6wJikgc6qCqlrMSBYAaEMUYDEQEo1f9H/KX7uJi
         GdB24vHt4fZrGNuQZKxekat+Kmqj3M88E9WHGiclAm8eMVNar/GwPNHPAu3I0Bw4uO
         6coHBHFCzUpGJhHWfF8EsvplNNuJ0Td8yd9p2CW3IAKdIGhl0oYIkbJmGvjHFj51El
         rMjjmuBrqF3tg==
Date:   Mon, 2 Oct 2017 19:23:33 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function
 transition
Message-ID: <20171002192333.GH31762@io.lakedaemon.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170928044320.GA84719@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928044320.GA84719@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, Sep 27, 2017 at 09:43:21PM -0700, Jonathan Nieder wrote:
> This document describes what a transition to a new hash function for
> Git would look like.  Add it to Documentation/technical/ as the plan
> of record so that future changes can be recorded as patches.
> 
> Also-by: Brandon Williams <bmwill@google.com>
> Also-by: Jonathan Tan <jonathantanmy@google.com>
> Also-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> On Thu, Mar 09, 2017 at 11:14 AM, Shawn Pearce wrote:
> > On Mon, Mar 6, 2017 at 4:17 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> Thanks for the kind words on what had quite a few flaws still.  Here's
> >> a new draft.  I think the next version will be a patch against
> >> Documentation/technical/.
> >
> > FWIW, I like this approach.
> 
> Okay, here goes.
> 
> Instead of sharding the loose object translation tables by first byte,
> we went for a single table.  It simplifies the design and we need to
> keep the number of loose objects under control anyway.
> 
> We also included a description of the transition plan and tried to
> include a summary of what has been agreed upon so far about the choice
> of hash function.
> 
> Thanks to Junio for reviving the discussion and in particular to Dscho
> for pushing this forward and making the missing pieces clearer.
> 
> Thoughts of all kinds welcome, as always.
> 
>  Documentation/Makefile                             |   1 +
>  .../technical/hash-function-transition.txt         | 797 +++++++++++++++++++++
>  2 files changed, 798 insertions(+)
>  create mode 100644 Documentation/technical/hash-function-transition.txt
> 
...
> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
> new file mode 100644
> index 0000000000..417ba491d0
> --- /dev/null
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -0,0 +1,797 @@
> +Git hash function transition
> +============================
> +
> +Objective
> +---------
> +Migrate Git from SHA-1 to a stronger hash function.
> +
...
> +Goals
> +-----
> +Where NewHash is a strong 256-bit hash function to replace SHA-1 (see
> +"Selection of a New Hash", below):

Could we clarify and say "a strong hash function with 256-bit output"?

...
> +Overview
> +--------
> +We introduce a new repository format extension. Repositories with this
> +extension enabled use NewHash instead of SHA-1 to name their objects.
> +This affects both object names and object content --- both the names
> +of objects and all references to other objects within an object are
> +switched to the new hash function.
> +
> +NewHash repositories cannot be read by older versions of Git.
> +
> +Alongside the packfile, a NewHash repository stores a bidirectional
> +mapping between NewHash and SHA-1 object names. The mapping is generated
> +locally and can be verified using "git fsck". Object lookups use this
> +mapping to allow naming objects using either their SHA-1 and NewHash names
> +interchangeably.

nit: Are we presuming that abbreviated hashes won't collide?  Or the
user needs to specify which hash type?

> +Object format
> +~~~~~~~~~~~~~
> +The content as a byte sequence of a tag, commit, or tree object named
> +by sha1 and newhash differ because an object named by newhash-name refers to
> +other objects by their newhash-names and an object named by sha1-name
> +refers to other objects by their sha1-names.
> +
> +The newhash-content of an object is the same as its sha1-content, except
> +that objects referenced by the object are named using their newhash-names
> +instead of sha1-names. Because a blob object does not refer to any
> +other object, its sha1-content and newhash-content are the same.
> +
> +The format allows round-trip conversion between newhash-content and
> +sha1-content.

It would be nice here to explicitly mention deterministic hashing.
Meaning that anyone who converts a commit from sha1 to newhash shall get
the same newhash.

> +
> +Object storage
> +~~~~~~~~~~~~~~
> +Loose objects use zlib compression and packed objects use the packed
> +format described in Documentation/technical/pack-format.txt, just like
> +today. The content that is compressed and stored uses newhash-content
> +instead of sha1-content.
> +
> +Pack index
> +~~~~~~~~~~
> +Pack index (.idx) files use a new v3 format that supports multiple
> +hash functions. They have the following format (all integers are in
> +network byte order):
> +
> +- A header appears at the beginning and consists of the following:
> +  - The 4-byte pack index signature: '\377t0c'
> +  - 4-byte version number: 3
> +  - 4-byte length of the header section, including the signature and
> +    version number
> +  - 4-byte number of objects contained in the pack
> +  - 4-byte number of object formats in this pack index: 2
> +  - For each object format:
> +    - 4-byte format identifier (e.g., 'sha1' for SHA-1)

This seems a little rough to me.  Maybe it would be better to have a 4
byte field where 0x01 = SHA-1, 0x02 = NEWHASH?

> +Reading an object's sha1-content
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The sha1-content of an object can be read by converting all newhash-names
> +its newhash-content references to sha1-names using the translation table.
> +
> +Fetch
> +~~~~~
> +Fetching from a SHA-1 based server requires translating between SHA-1
> +and NewHash based representations on the fly.
> +
> +SHA-1s named in the ref advertisement that are present on the client
> +can be translated to NewHash and looked up as local objects using the
> +translation table.
> +
> +Negotiation proceeds as today. Any "have"s generated locally are
> +converted to SHA-1 before being sent to the server, and SHA-1s
> +mentioned by the server are converted to NewHash when looking them up
> +locally.

By "converted", do you mean "looked up in the table" or "look up
newhash, re-calculate sha1, send" ?  I presume you mean the former, but
it would be good to clarify.

> +
> +After negotiation, the server sends a packfile containing the
> +requested objects. We convert the packfile to NewHash format using
> +the following steps:
> +
> +1. index-pack: inflate each object in the packfile and compute its
> +   SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
> +   objects the client has locally. These objects can be looked up
> +   using the translation table and their sha1-content read as
> +   described above to resolve the deltas.
> +2. topological sort: starting at the "want"s from the negotiation
> +   phase, walk through objects in the pack and emit a list of them,
> +   excluding blobs, in reverse topologically sorted order, with each
> +   object coming later in the list than all objects it references.
> +   (This list only contains objects reachable from the "wants". If the
> +   pack from the server contained additional extraneous objects, then
> +   they will be discarded.)
> +3. convert to newhash: open a new (newhash) packfile. Read the topologically
> +   sorted list just generated. For each object, inflate its
> +   sha1-content, convert to newhash-content, and write it to the newhash
> +   pack. Record the new sha1<->newhash mapping entry for use in the idx.
> +4. sort: reorder entries in the new pack to match the order of objects
> +   in the pack the server generated and include blobs. Write a newhash idx
> +   file
> +5. clean up: remove the SHA-1 based pack file, index, and
> +   topologically sorted list obtained from the server in steps 1
> +   and 2.

How are signed tags (against sha1 commits) to be handled?  See below for
further thoughts.

> +Signed Tags
> +~~~~~~~~~~~
> +We add a new field "gpgsig-newhash" to the tag object format to allow
> +signing tags without relying on SHA-1. Its signed payload is the
> +newhash-content of the tag with its gpgsig-newhash field and "-----BEGIN PGP
> +SIGNATURE-----" delimited in-body signature removed.
> +
> +This means tags can be signed
> +1. using SHA-1 only, as in existing signed tag objects
> +2. using both SHA-1 and NewHash, by using gpgsig-newhash and an in-body
> +   signature.
> +3. using only NewHash, by only using the gpgsig-newhash field.

To be clear here, "gpgsig" = SHA-1, "gpgsig-SHA-256" = SHA-256?

> +Caveats
> +-------
> +Invalid objects
> +~~~~~~~~~~~~~~~
> +The conversion from sha1-content to newhash-content retains any
> +brokenness in the original object (e.g., tree entry modes encoded with
> +leading 0, tree objects whose paths are not sorted correctly, and
> +commit objects without an author or committer). This is a deliberate
> +feature of the design to allow the conversion to round-trip.

Ah, so this is part of the deterministic hashing.

> +Object names on the command line
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +To support the transition (see Transition plan below), this design
> +supports four different modes of operation:
> +
> + 1. ("dark launch") Treat object names input by the user as SHA-1 and
> +    convert any object names written to output to SHA-1, but store
> +    objects using NewHash.  This allows users to test the code with no
> +    visible behavior change except for performance.  This allows
> +    allows running even tests that assume the SHA-1 hash function, to

nit:  s/allows allows/allows/

> +    sanity-check the behavior of the new mode.
> +
> + 2. ("early transition") Allow both SHA-1 and NewHash object names in
> +    input. Any object names written to output use SHA-1. This allows
> +    users to continue to make use of SHA-1 to communicate with peers
> +    (e.g. by email) that have not migrated yet and prepares for mode 3.
> +
> + 3. ("late transition") Allow both SHA-1 and NewHash object names in
> +    input. Any object names written to output use NewHash. In this
> +    mode, users are using a more secure object naming method by
> +    default.  The disruption is minimal as long as most of their peers
> +    are in mode 2 or mode 3.
> +
> + 4. ("post-transition") Treat object names input by the user as
> +    NewHash and write output using NewHash. This is safer than mode 3
> +    because there is less risk that input is incorrectly interpreted
> +    using the wrong hash function.

Surely we can error-out if the provided object name is ambiguous?

> +Selection of a New Hash
> +-----------------------
> +In early 2005, around the time that Git was written,  Xiaoyun Wang,
> +Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
> +collisions in 2^69 operations. In August they published details.
> +Luckily, no practical demonstrations of a collision in full SHA-1 were
> +published until 10 years later, in 2017.
> +
> +The hash function NewHash to replace SHA-1 should be stronger than
> +SHA-1 was: we would like it to be trustworthy and useful in practice
> +for at least 10 years.
> +
> +Some other relevant properties:
> +
> +1. A 256-bit hash (long enough to match common security practice; not
> +   excessively long to hurt performance and disk usage).
> +
> +2. High quality implementations should be widely available (e.g. in
> +   OpenSSL).
> +
> +3. The hash function's properties should match Git's needs (e.g. Git
> +   requires collision and 2nd preimage resistance and does not require
> +   length extension resistance).

Based on recent discussion, I would add here, that the candidate hash
has had sufficient review.  Such that the likelihood of overnight
catastrophic failure is greatly reduced.  This gives git and git users
time to migrate away from the now weakening hash function.

> +
> +4. As a tiebreaker, the hash should be fast to compute (fortunately
> +   many contenders are faster than SHA-1).
> +
> +Some hashes under consideration are SHA-256, SHA-512/256, SHA-256x16,
> +K12, and BLAKE2bp-256.

If anyone is counting votes, I prefer either SHA-512/256 or
BLAKE2bp-256.  But as I've mentioned elsewhere, it's only a preference.

> +
> +Transition plan
> +---------------
...
> +Once a critical mass of users have upgraded to a version of Git that
> +can verify NewHash signatures and have converted their existing
> +repositories to support verifying them, we can add support for a
> +setting to generate only NewHash signatures. This is expected to be at
> +least a year later.
> +
> +That is also a good moment to advertise the ability to convert
> +repositories to use NewHash only, stripping out all SHA-1 related
> +metadata. This improves performance by eliminating translation
> +overhead and security by avoiding the possibility of accidentally
> +relying on the safety of SHA-1.

There is a caveat here regarding old signatures.  Those have value and
shouldn't be lost.  repos needing to prove the validity of the old
sha1-only signatures should counter-hash all objects, and then
counter-sign the corresponding newhash version of the original sha1-only
tags.

Reviewed-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
