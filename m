Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308BC33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90562146E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAQ3DD4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgAGOq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:46:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43129 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGOq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 09:46:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so39055929lfq.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8gCiSbszJeEF0mHZxY0NnzMMM5Q6GmEQLL4ux9Ae0OM=;
        b=jAQ3DD4WHK8FoV3BbvYmnMeACteSvsgTa3WIfFDj6MtviDy2oBI4RS/RCE0k2ZWRr2
         9Dceub1yF/IiL5qUja7beGdYLgDtiwFhhZLq407+oOJ1aj1IsX9HC/xEVf7qeOT7djkG
         LRusOPsWdVbk7P93jdHuz9RFVzKRCceULLaJuuimpzsoItbfEvTI9owR++F8O4Gtyef1
         RN+tMfQngFV9V9uObEIog7nPwWUyIlaiYN7BlCBy81EgO0VbMfYghA0H1+qZDd5RkaWq
         Ewz0ifcL5c86h8EHHEm2Koy6kQSg0DwgC5hR6ayw/8fCywQ519un/qIpwFvRjPKoJQv7
         PD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=8gCiSbszJeEF0mHZxY0NnzMMM5Q6GmEQLL4ux9Ae0OM=;
        b=SqpIV6fAjZ79kOLRy9ZHe27Y7FA+KIsIsUH+ziA/F3NFqjO53SyzisGjNV/HmgVoXp
         Kl+yX7NT3Owq/ggJucphk/V4ezZhmzmCxAtb5pzznBX1d5ZkESSYX34d/yMK5yWGxJX4
         hLdNX7j5I6a++TxzyzEVvD4LDG2HArL5F9/t4XvNXmHWGFqFQH/aVe1Kp65NOGQkwKkQ
         YB3A4yQckrklOEbALLPUs3APRJr0HxEOANbNtpx1OZbpZz+akx0Z/XyiZ9gSECP6Fb6O
         REARyqsE+XCzQscnPjZ6AIJaWcdr17V9VzW+aZcEOVhbj/TdpfWsDVDIV0sVAaYBUUsV
         +8eQ==
X-Gm-Message-State: APjAAAVEb2x/oZGhJTyb5VA+/rhNjFyTwkdtvH1//3v6PYevmk8DRKN6
        GBIVeV3a0BeeOyW5UGrUkpw=
X-Google-Smtp-Source: APXvYqx3yFtx6KsjSSSbWeRKWqXaqS+fdEhZfzO02IyTW72SKS21d5Cgbg3jMnmfPUZ4lV+u54710w==
X-Received: by 2002:a19:784:: with SMTP id 126mr58715565lfh.191.1578408413545;
        Tue, 07 Jan 2020 06:46:53 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.110])
        by smtp.gmail.com with ESMTPSA id j204sm30453631lfj.38.2020.01.07.06.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 06:46:52 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 4/9] commit-graph: document bloom filter format
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <3182a11f7c07af834ba71dc7861742458754eb91.1576879520.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 15:46:49 +0100
In-Reply-To: <3182a11f7c07af834ba71dc7861742458754eb91.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:15
        +0000")
Message-ID: <86h817xr1i.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Update the technical documentation for commit-graph-format with BIDX
> and BDAT chunk information.
>
> RFC Notes:
> 1. [Call for advice] We specifically mention that we are using Bloom
>    filters in this technical document. Should this document also be
>    made open to other data structures in the future, with versioning
>    information?

I'm not sure.  In theory we might want to switch to another
probabilistic set inclusion query structure, like xor filters or cuckoo
hashing.

On one hand side we could use separate chunks (e.g. XIDX, XDAT for xor
filters), on the other hand we need only one such structure.  On the
gripping hand this can be left for the future, if needed.

Sidenote: using Bloom filters is somewhat encoded in the name of chunk
(B from Bloom filter).  I don't have a better poposal for 4-char name
(XIDX / XDAT for cXange?  CHDX / CHDT for CHange?  FIDX / FDAT for
changed Files?... I don't know).

>
> 2. [Call for advice] We are also not describing the explicit nature
>    of how we store the bloom filter binary data. Would it be useful
>    to document details about the hash algorithm, the number of hashes
>    and the specific seed values we are using in a separate document,
>    or perhaps in a separate section in this document?

I think it would be best to keep description of the commit graph format
concise.  The details about Bloom filter implementation would be better
put in Documentation/technical/commit-graph.txt in my opinion, together
with reasoning behind it (perhaps borrowing from Derrick Stolee blog
post).

This could be done as a separate patch.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Documentation/technical/commit-graph-format.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentat=
ion/technical/commit-graph-format.txt
> index a4f17441ae..6497f19f08 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -17,6 +17,9 @@ metadata, including:
>  - The parents of the commit, stored using positional references within
>    the graph file.
>=20=20
> +- The bloom filter of the commit carrying the paths that were changed be=
tween
> +  the commit and it's first parent.

s/bloom/Bloom/ and s/it's/its/

I am not sure about exact wording, but I could at this time think of a
better but concise way of stating it.

> +
>  These positional references are stored as unsigned 32-bit integers
>  corresponding to the array position within the list of commit OIDs. Due
>  to some special constants we use to track parents, we can store at most
> @@ -93,6 +96,20 @@ CHUNK DATA:
>        positions for the parents until reaching a value with the most-sig=
nificant
>        bit on. The other bits correspond to the position of the last pare=
nt.
>=20=20
> +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) [Optional]
> +      For each commit we store the offset of its bloom filter in the BDA=
T chunk
> +      as follows:
> +      BIDX[i] =3D number of 8-byte words in all the bloom filters from c=
ommit 0 to
> +		commit i (inclusive)

I think it would be better for consistency and ease of reading to follow
the example of OID Fanout (OIDF) chunk description:

 +  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
 +      The ith entry, BIDX[i], stores the number of 8-byte word blocks
 +      in all Bloom filters from commit 0 up to commit i (inclusive)
 +      in lexicographical order.

Maybe even add the following to make implementing it easier:

 +      Data for Bloom filter for i-th commit spans from BIDX[i-1] to
 +      BIDX[i] (plus header length), where we take BIDX[-1] to be 0.

Is it possible for (BIDX[i] - BIDX[i-1]) to be zero (no Bloom filter),
for example for commits with more than 512 changes?  Or is this case
handled by 1 8-byte word Bloom filter of all bits sets to '1', i.e.
0xffffffffffffffff?

How the case of too many changes is distingushed from the case of no
changes (`git commit --allow-empty`, or `git merge --ours`)?  Is the
case of no changes uninteresting, i.e. Bloom filter consisting of zero,
that is with all bits set to '0'?

> +
> +  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> +      * It starts with three 32 bit integers for the

I would say "It starts with the header consisting of three unsigned
32-bit integers:" (but current version is not bad).

I wonder if this metadata should perhaps be put in a separate chunk,
BMET... (Bloom filter METadata).

> +	    - version of the hash algorithm being used

This number not only encodes that the base hash algorithm being used is
32-bit Murmur3 hash, but that 'k' hashes used in the computation are
created out of Murmur3 hash using double hashing technique, and
specifies two specific seed values for this double hashing technique.

[Maybe we should store those two seed values here too?]

It might be important to say that the currently supported version is
'1', and if Git encounters unknown hashing algorithm version it should
not use Bloom filter data.

Unless we store encoded _name_ of the hash algorithm, e.g. bytes
'm','u','r','3' for MurmurHash3_32... though it is about more than
a base hash.

Do we need whole 4 bytes for hash version, or is it for ease of use and
alignment?

> +	    - the number of hashes used in the computation

All right.  Perhaps we should test in the future patches that the value
different from the default of 7 would also work.

Also 8-bits / 1 byte for number of hashes (hash functions) should be
enough: as I have written in prevous reply there is no need for k > 32.

> +	    - the number of bits per entry

This is important for construction of Bloom filter, but I think it is
not necessary to use it -- so it may not be necessary to store it.

Would also fit in a single byte: we don't need exceedingly low false
positive probability.

We could use it to estimate the false positive probability, and...

> +	  * The rest of the chunk is the concatenation of all the computed bloo=
m=20
> +	  filters for the commits in lexicographic order.

  +	 * The rest of the chunk is the concatenation of all the computed Bloom=
=20
  +	   filters for the commits in lexicographic order.

It would be, I think, a good idea to make it explicit that BDAT is
present iff BIDX is present (iff =3D=3D if and only if), i.e. that either
both or neither of those chunks should be present.

> +
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files =
that
>        form a commit-graph chain. The graph position for the ith commit i=
n this

Best,
--=20
Jakub Nar=C4=99bski
