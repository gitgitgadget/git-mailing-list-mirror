Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6DC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKHSE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiKHSEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:04:24 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61C1F2E0
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:04:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id kt23so40657337ejc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u0H2yRx0dMe/gjQykNZkCITG/nCsAhhlN0rAj+1oEA4=;
        b=lKpTZIOe58eeL74WvnLQWepX/T8nW1k2JgjxyTfvIEqH/bTLSprVcZ3lYAAs6IoimL
         0I3HHRe+jeqZiecbS0kDV3rCA/CZ+kKioerDmFyizpvg2zRvg7ugHN7mdX2x/uVJFYOt
         X0csRHCt0pZq6aIU72ShP/LKjizMf8mTGMY4BtVtH8EkYMMupAuoAw041B6fsue+JSbW
         eDecUf8z8Rj5MVoydwy9LdybkJE2GL3UNIpHfen8txxeGOPTpUornN3POq2Xiw59/0zo
         EJMuac0qPL7P+b0jcCGTP+6gzgQ1aS8MYZFk/9KDCLy395oYLf+Vwqu/X/8zD1iiO/cW
         kQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0H2yRx0dMe/gjQykNZkCITG/nCsAhhlN0rAj+1oEA4=;
        b=8SQbTzVF5blNhTrCsiN7Wbnnrftu4dUx8NJaDANbM3u0RIvzMrFxWIWLfZXWiEFpE5
         SYio8mMhoF3DfceafDBltJWnbscQTqoOHiCxNSBTVh/FSyEb4jYR5AOLAbZrA0foizUN
         sk5WDhvHYE15j2HMQm8U39PUja0y7ZotgjJ6NKhG9MkWOU92sSqcGOSPvRurkPe3+CgY
         nfy5iaKXbaufWyJ2OVxbd4Geqs8jVA/xWLI2fIcI6Dk+Y2BVOBNAteT9loLJAwsglZrW
         DuDQ6A5gASgVRwiOYTYD68mzGf8Ufrcke57Bpn4+aARQtKLLP1ESN3yx+L+w/ThDoStO
         /NPg==
X-Gm-Message-State: ACrzQf1xPD6z5E4nw/CRsE2bfAKpPa/X3uJTLMdbbGe2k4TpyLmHRSUc
        hE4KLV6jBh4oBsigq/WhrHuAL5j3YHI=
X-Google-Smtp-Source: AMsMyM7zDbPq+m4LXAnncR4g27HJi44qdJdsSbzkeIGKyoYVAne+AXSZtW9cXpInHTnJwFFCa92S8Q==
X-Received: by 2002:a17:907:3181:b0:787:d81c:a6ad with SMTP id xe1-20020a170907318100b00787d81ca6admr52990165ejb.769.1667930660632;
        Tue, 08 Nov 2022 10:04:20 -0800 (PST)
Received: from localhost (78-131-17-60.pool.digikabel.hu. [78.131.17.60])
        by smtp.gmail.com with ESMTPSA id ca21-20020aa7cd75000000b004580862ffdbsm5862828edb.59.2022.11.08.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:04:19 -0800 (PST)
Date:   Tue, 8 Nov 2022 19:04:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 06/12] docs: move commit-graph format docs to man
 section 5
Message-ID: <20221108180417.GB1731@szeder.dev>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
 <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
 <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v8-06.12-df3ef265d45-20220804T162138Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 04, 2022 at 06:28:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space.
> 
> By moving the documentation for the commit-graph format into man
> section 5 and the new "developerinterfaces" category. This change is
> split from subsequent commits due to the relatively large amount of
> ASCIIDOC formatting changes that are required.

So after this series I got a couple of gitformat-* manpages, but,
alas, most of them render improperly: a lot of paragraphs are for some
reason fixed width even in a fullscreen terminal window, and their
width is more than 80 chars, so they are rather awkward in a
standard-width terminal.  This also affects the html version, where
those paragraphs are rendered with a fixed-width font.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/Makefile                        |  1 +
>  Documentation/git-commit-graph.txt            |  5 ++
>  ...-format.txt => gitformat-commit-graph.txt} | 47 +++++++++++++------
>  Documentation/technical/chunk-format.txt      |  4 +-
>  command-list.txt                              |  1 +
>  5 files changed, 41 insertions(+), 17 deletions(-)
>  rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (88%)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 1a4a545f44a..e7bd72bb84e 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -25,6 +25,7 @@ MAN1_TXT += gitweb.txt
>  # man5 / man7 guides (note: new guides should also be added to command-list.txt)
>  MAN5_TXT += gitattributes.txt
>  MAN5_TXT += gitformat-bundle.txt
> +MAN5_TXT += gitformat-commit-graph.txt
>  MAN5_TXT += githooks.txt
>  MAN5_TXT += gitignore.txt
>  MAN5_TXT += gitmailmap.txt
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index e1f48c95b3c..047decdb65b 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -143,6 +143,11 @@ $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
>  ------------------------------------------------
>  
>  
> +FILE FORMAT
> +-----------
> +
> +see linkgit:gitformat-commit-graph[5].
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/gitformat-commit-graph.txt
> similarity index 88%
> rename from Documentation/technical/commit-graph-format.txt
> rename to Documentation/gitformat-commit-graph.txt
> index 484b185ba98..108dc2295c0 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -1,5 +1,18 @@
> -Git commit graph format
> -=======================
> +gitformat-commit-graph(5)
> +=========================
> +
> +NAME
> +----
> +gitformat-commit-graph - Git commit graph format
> +
> +SYNOPSIS
> +--------
> +[verse]
> +$GIT_DIR/objects/info/commit-graph
> +$GIT_DIR/objects/info/commit-graphs/*
> +
> +DESCRIPTION
> +-----------
>  
>  The Git commit graph stores a list of commit OIDs and some associated
>  metadata, including:
> @@ -30,7 +43,7 @@ and hash type.
>  
>  All multi-byte numbers are in network byte order.
>  
> -HEADER:
> +=== HEADER:
>  
>    4-byte signature:
>        The signature is: {'C', 'G', 'P', 'H'}
> @@ -52,7 +65,7 @@ HEADER:
>        We infer the length (H*B) of the Base Graphs chunk
>        from this value.
>  
> -CHUNK LOOKUP:
> +=== CHUNK LOOKUP:
>  
>    (C + 1) * 12 bytes listing the table of contents for the chunks:
>        First 4 bytes describe the chunk id. Value 0 is a terminating label.
> @@ -68,17 +81,17 @@ CHUNK LOOKUP:
>    these chunks may be given in any order. Chunks are required unless
>    otherwise specified.
>  
> -CHUNK DATA:
> +=== CHUNK DATA:
>  
> -  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +==== OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>        The ith entry, F[i], stores the number of OIDs with first
>        byte at most i. Thus F[255] stores the total
>        number of commits (N).
>  
> -  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +====  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>        The OIDs for all commits in the graph, sorted in ascending order.
>  
> -  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
> +====  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
>      * The first H bytes are for the OID of the root tree.
>      * The next 8 bytes are for the positions of the first two parents
>        of the ith commit. Stores value 0x70000000 if no parent in that
> @@ -93,7 +106,7 @@ CHUNK DATA:
>        2 bits of the lowest byte, storing the 33rd and 34th bit of the
>        commit time.
>  
> -  Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
> +==== Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
>      * This list of 4-byte values store corrected commit date offsets for the
>        commits, arranged in the same order as commit data chunk.
>      * If the corrected commit date offset cannot be stored within 31 bits,
> @@ -104,7 +117,7 @@ CHUNK DATA:
>        by compatible versions of Git and in case of split commit-graph chains,
>        the topmost layer also has Generation Data chunk.
>  
> -  Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
> +==== Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
>      * This list of 8-byte values stores the corrected commit date offsets
>        for commits with corrected commit date offsets that cannot be
>        stored within 31 bits.
> @@ -112,7 +125,7 @@ CHUNK DATA:
>        chunk is present and atleast one corrected commit date offset cannot
>        be stored within 31 bits.
>  
> -  Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> +==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>        This list of 4-byte values store the second through nth parents for
>        all octopus merges. The second parent value in the commit data stores
>        an array position within this list along with the most-significant bit
> @@ -120,14 +133,14 @@ CHUNK DATA:
>        positions for the parents until reaching a value with the most-significant
>        bit on. The other bits correspond to the position of the last parent.
>  
> -  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
> +==== Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
>      * The ith entry, BIDX[i], stores the number of bytes in all Bloom filters
>        from commit 0 to commit i (inclusive) in lexicographic order. The Bloom
>        filter for the i-th commit spans from BIDX[i-1] to BIDX[i] (plus header
>        length), where BIDX[-1] is 0.
>      * The BIDX chunk is ignored if the BDAT chunk is not present.
>  
> -  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
> +==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>      * It starts with header consisting of three unsigned 32-bit integers:
>        - Version of the hash algorithm being used. We currently only support
>  	value 1 which corresponds to the 32-bit version of the murmur3 hash
> @@ -147,13 +160,13 @@ CHUNK DATA:
>        of length one, with either all bits set to zero or one respectively.
>      * The BDAT chunk is present if and only if BIDX is present.
>  
> -  Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
> +==== Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files that
>        form a commit-graph chain. The graph position for the ith commit in this
>        file's OID Lookup chunk is equal to i plus the number of commits in all
>        base graphs.  If B is non-zero, this chunk must exist.
>  
> -TRAILER:
> +=== TRAILER:
>  
>  	H-byte HASH-checksum of all of the above.
>  
> @@ -164,3 +177,7 @@ the number '2' in their chunk IDs because a previous version of Git wrote
>  possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". By
>  changing the IDs, newer versions of Git will silently ignore those older
>  chunks and write the new information without trusting the incorrect data.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/technical/chunk-format.txt b/Documentation/technical/chunk-format.txt
> index 593614fceda..f36ce42f37c 100644
> --- a/Documentation/technical/chunk-format.txt
> +++ b/Documentation/technical/chunk-format.txt
> @@ -6,7 +6,7 @@ sections of the file. This allows structured access to a large file by
>  scanning a small "table of contents" for the remaining data. This common
>  format is used by the `commit-graph` and `multi-pack-index` files. See
>  link:technical/pack-format.html[the `multi-pack-index` format] and
> -link:technical/commit-graph-format.html[the `commit-graph` format] for
> +the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
>  how they use the chunks to describe structured data.
>  
>  A chunk-based file format begins with some header information custom to
> @@ -108,7 +108,7 @@ for future formats:
>  * *commit-graph:* see `write_commit_graph_file()` and `parse_commit_graph()`
>    in `commit-graph.c` for how the chunk-format API is used to write and
>    parse the commit-graph file format documented in
> -  link:technical/commit-graph-format.html[the commit-graph file format].
> +  the commit-graph file format in linkgit:gitformat-commit-graph[5].
>  
>  * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
>    in `midx.c` for how the chunk-format API is used to write and
> diff --git a/command-list.txt b/command-list.txt
> index 1950c4ccd9c..3afcfcd35f0 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -210,6 +210,7 @@ gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>  gitformat-bundle                        developerinterfaces
> +gitformat-commit-graph                  developerinterfaces
>  gitglossary                             guide
>  githooks                                userinterfaces
>  gitignore                               userinterfaces
> -- 
> 2.37.1.1233.g61622908797
> 
