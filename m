Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1608C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiHCQZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHCQZS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:25:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B85F73
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:25:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 14529134DF5;
        Wed,  3 Aug 2022 12:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oYy34PC4dMOR
        UGud1InkW7a14cOvJbBebL0gG4gDbYE=; b=L2Bno/rEx8nfYQE6bH2DnDg6qclC
        OrnH7j3FgFVlqfmOP4rvQR0AZTJ7HZDpXKoYGtv4B9/kaskAYMY1prhkOgIAec59
        6CffvmaJHdGgfHK/tE847aWMLhcLJzW2bEFLOsc21IH/NKtbUtnmNSMiVcvv4+Jq
        beOH41lFBWfdrig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BA93134DF4;
        Wed,  3 Aug 2022 12:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 50B78134DF3;
        Wed,  3 Aug 2022 12:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 08/10] docs: move pack format docs to man section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-08.10-3505fa86039-20220802T125258Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 09:25:13 -0700
In-Reply-To: <patch-v7-08.10-3505fa86039-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:57
        +0200")
Message-ID: <xmqqv8r9b8gm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA8B1AEE-1348-11ED-B42C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -125,7 +139,7 @@ Git index format
>      entry is encoded as if the path name for the previous entry is an
>      empty string).  At the beginning of an entry, an integer N in the
>      variable width encoding (the same encoding as the offset is encode=
d
> -    for OFS_DELTA pack entries; see pack-format.txt) is stored, follow=
ed
> +    for OFS_DELTA pack entries; see linkgit:gitformat-pack[5]) is stor=
ed, followed

Possible #leftoverbits for cleaning up around here are:

 * Update the above description to use the term "offset encoding"
   from gitformat-patck[5] to give readers the term to look for;

 * Update <varint.h> and mention that the encode/decode pair
   declared there are to handle variable-length integers in the
   "offset encoding".

 * We might want to add an entry to the glossary, but the varint
   representation is not end-user facing, so it may not be necessary
   and the mention in <varint.h> would be enough.

> diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/gi=
tformat-pack-cruft.txt
> similarity index 96%
> rename from Documentation/technical/cruft-packs.txt
> rename to Documentation/gitformat-pack-cruft.txt
> index d81f3a8982f..908f752bd84 100644
> --- a/Documentation/technical/cruft-packs.txt
> +++ b/Documentation/gitformat-pack-cruft.txt
> @@ -1,4 +1,17 @@
> -=3D Cruft packs
> +gitformat-pack-cruft(5)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +gitformat-pack-cruft - The cruft pack file format
> +
> +SYNOPSIS
> +--------
> +[verse]
> +$GIT_DIR/objects/pack/pack-*.mtimes

I do not think this is quite right.

A reader who wants to learn about cruft packs, they need to know:

 * what a packfile is and what is in .pack/.idx pair, as a
   prerequisite information, that is described elsewhere

 * what it is, what it is used for, and how it is meant to be used,
   why the mtimes from the original loose objects need to be kept,
   all of which is not file-format per-se, but is part of the
   design, described in the original technical/cruft-packs.txt

 * how .mtimes file records the _additional_ pieces of per-object
   information only maintained for the "cruft pack" objects.

The original technical/cruft-packs.txt document was the design
document for the cruft packs feature as a whole, and it made sense
to write about both design and the implementation detail of the
mtimes format.

But that is not "cruft pack file format".  I think this can be fixed
either by having at least two documents (one for "cruft packs"
overall design, plus another one for "mtimes file format"), or by
having one document that is clearly more than "file format".  The
posted patch gives us a mixture of the two, that results in neither
of the two.

Stepping back a bit, unless we have separate .pack(5) and .idx(5)
manual pages, I suspect that having the format of .pack, .idx, .midx,
and .mtimes described in the same "file formats for packfiles" document
might make more sense.  After all, those who come to the packfile format
document from "pack protocol" document do not mind that the former talks
about .idx file, which they would find no use for.

I hope Taylor can help us with his input when he comes back from his
honeymoon.

> diff --git a/Documentation/technical/pack-format.txt b/Documentation/gi=
tformat-pack.txt
> similarity index 95%
> rename from Documentation/technical/pack-format.txt
> rename to Documentation/gitformat-pack.txt
> index b520aa9c45b..546c99f8871 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -1,5 +1,29 @@
> -Git pack format
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +gitformat-pack(5)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +gitformat-pack - Git pack format

OK.

> diff --git a/command-list.txt b/command-list.txt
> index ed859fdd798..4f30a6c30c8 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -210,7 +210,12 @@ gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>  gitformat-bundle                        developerinterfaces
> +gitformat-chunk                         developerinterfaces
>  gitformat-commit-graph                  developerinterfaces
> +gitformat-index                         developerinterfaces
> +gitformat-pack                          developerinterfaces
> +gitformat-pack-cruft                    developerinterfaces
> +gitformat-signature                     developerinterfaces
>  gitglossary                             guide
>  githooks                                userinterfaces
>  gitignore                               userinterfaces

OK.
