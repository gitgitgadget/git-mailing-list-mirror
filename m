Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7B31F453
	for <e@80x24.org>; Wed, 20 Feb 2019 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBTO4D (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 09:56:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41370 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTO4D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 09:56:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so14146815wrw.8
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 06:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5aYWQn8lZY9MyqkZPGh0TTY2BpAz9XhMpDrgA+LuiZw=;
        b=Vq6M5mS07wIwo2F7qt9YSxZLSW/+MyyAox/qwR5Z85agp9B1NVzUF2Y6x0Dau4Lhvp
         gb8kZRhvF7EVKIppjX77/lCVkZ1S9ZkloQuD6lgEruXmpYptnXXVM3F0XTdL8cTIsPGp
         IANfRhkitJIxBCoB2KXT8ioTQL58VCu8lmGd1lUi1WOn0kqFnj8avnzgouSbY6dTpq+6
         nigfp31WC2E1o6c6WMJgcLHUjQL5N52iz67RpbzILMY/9Yt6Dybu51KPmyH8EB8A6uOp
         yuEH4xlGPnS8qQY/ijWomphmQ4qH+MhKSJ3q2iztCqFhEczUgroRomRKz1Jm+FmU9DMx
         ZgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5aYWQn8lZY9MyqkZPGh0TTY2BpAz9XhMpDrgA+LuiZw=;
        b=pOfKvBaRADH5R0iiqJS1ke1RtfEYyKJ/aJhzFv2lGsC7ZrBtdSGYlAV25TIr/If7dc
         2JXOfpUmO0vivJW6V7HPiK09LVBVR49xAncIla6A6QhJMpG8Eg0FNSUn3QqzfIuqkaJm
         O/9ej0uZNQS8Yfddwwr0/ShmosymBg7a3TWQCf2BPq7+c7wYdkGhwIgPIQfyCo+Q94at
         /tRFyZZU2nKn1ufnvMZa8WjetMQavWL5GmJwryPtsus67wULNZPMeP8dmbhlQCasKLBE
         Q/ikEPLbMnnY1cgG3mMK1ojTxlTvDTdIeA5xum2rXUFwVMhv47w/7VqMKcPU1X3d14Fs
         UKlg==
X-Gm-Message-State: AHQUAuYC7ZE9LR4HBB76zUFGQZhylzyQG7yoKl7ucq1yM0YtuMXOAYac
        /Zx2O7FIvrcWj56Jk9v5jAY=
X-Google-Smtp-Source: AHgI3Ia2xCEVOFvMnaa+c1CIF8vQ970ihzepownwi3CCkEKQr2BBg2uamVOVQriB7hvNM7WmL/G4FQ==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr23965038wru.135.1550674560953;
        Wed, 20 Feb 2019 06:56:00 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u15sm6993107wmu.17.2019.02.20.06.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 06:55:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v6 2/3] commit-graph: fix buffer read-overflow
References: <cover.1544048946.git.steadmon@google.com> <cover.1547590928.git.steadmon@google.com> <d7b137650f9203148c1fb998a3dd4af7a2105e62.1547590928.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <d7b137650f9203148c1fb998a3dd4af7a2105e62.1547590928.git.steadmon@google.com>
Date:   Wed, 20 Feb 2019 15:55:58 +0100
Message-ID: <87d0nm5x1d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 15 2019, Josh Steadmon wrote:

> fuzz-commit-graph identified a case where Git will read past the end of
> a buffer containing a commit graph if the graph's header has an
> incorrect chunk count. A simple bounds check in parse_commit_graph()
> prevents this.

This has a 2.21 regression where the test fails on NetBSD:
https://gitlab.com/git-vcs/git-ci/-/jobs/164224275

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  commit-graph.c          | 14 ++++++++++++--
>  t/t5318-commit-graph.sh | 16 +++++++++++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 07dd410f3c..836d65a1d3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -165,10 +165,20 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>  	last_chunk_offset = 8;
>  	chunk_lookup = data + 8;
>  	for (i = 0; i < graph->num_chunks; i++) {
> -		uint32_t chunk_id = get_be32(chunk_lookup + 0);
> -		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
> +		uint32_t chunk_id;
> +		uint64_t chunk_offset;
>  		int chunk_repeated = 0;
>
> +		if (data + graph_size - chunk_lookup <
> +		    GRAPH_CHUNKLOOKUP_WIDTH) {
> +			error(_("chunk lookup table entry missing; graph file may be incomplete"));
> +			free(graph);
> +			return NULL;
> +		}
> +
> +		chunk_id = get_be32(chunk_lookup + 0);
> +		chunk_offset = get_be64(chunk_lookup + 4);
> +
>  		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
>
>  		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 5fe21db99f..694f26079f 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -366,9 +366,10 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
>  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
>  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
>
> -# usage: corrupt_graph_and_verify <position> <data> <string>
> +# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
>  # Manipulates the commit-graph file at the position
> -# by inserting the data, then runs 'git commit-graph verify'
> +# by inserting the data, optionally zeroing the file
> +# starting at <zero_pos>, then runs 'git commit-graph verify'
>  # and places the output in the file 'err'. Test 'err' for
>  # the given string.
>  corrupt_graph_and_verify() {
> @@ -376,11 +377,15 @@ corrupt_graph_and_verify() {
>  	data="${2:-\0}"
>  	grepstr=$3
>  	cd "$TRASH_DIRECTORY/full" &&
> +	orig_size=$(wc -c < $objdir/info/commit-graph) &&
> +	zero_pos=${4:-${orig_size}} &&
>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> +	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> +	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&

In the limited time I had to dig it starts failing at test 46, when
count=0 is given. dd on NetBSD exits with 127 when given count=0 it
seems.

>  	test_must_fail git commit-graph verify 2>test_err &&
> -	grep -v "^+" test_err >err
> +	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err
>  }
>
> @@ -484,6 +489,11 @@ test_expect_success 'detect invalid checksum hash' '
>  		"incorrect checksum"
>  '
>
> +test_expect_success 'detect incorrect chunk count' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\377" \
> +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
> +'
> +

Hacking around the above (e.g. "dd ... || :") makes all the failing
tests pass except this new one, which I didn't dig into.
