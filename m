Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F39211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 10:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbfALK6D (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 05:58:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33175 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALK6D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 05:58:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so17893640wrr.0
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 02:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuyVIBbR9D7IgyrSDSMKW3hOFEZdQo5hdBShevvzkbU=;
        b=NEM7gpeY1gt/YtMRoPi/D7wnhx105omuchuH4cGlpNQ/s2ntRjzyjUUMndCQjCyJQq
         1zOvYqXfdzkPjPP/DJ7LmpDpyWama8H42S17dHusOyAQc2o7ttyZbWHulgsB27eM/KWE
         sjW3XS1drVnCWoEbhSGfd16KcT2j7+iCupQAcloPSJYiNcY+Nmqydm9nrIf21VenN0Z5
         cxRqMjLsh5ynbI0bk/dBk2Gs4F5u0HqMnA7m0DcoBtytb+jSZArQbU/ynm9Zws22I3Ho
         gSAXvjrNBQc1pCl7jQ8b43cQzWuHMr/96WnzjP/W7yxV0o7NigVnaVXC/wYUJ/v6o+m/
         wgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuyVIBbR9D7IgyrSDSMKW3hOFEZdQo5hdBShevvzkbU=;
        b=KWNEBYIWZ1UMWqjPqIB7zwsoo+7hp/rGTi4Lyveo6SpMlAcVaU+XYrZkyq77bQ4bo5
         nfFXQfaQ6ghDln1JK9taD7/Y+52atD6GJdwzei8VkA5xj0WhmrCE/5Do5Rh1k0kAp7ZH
         rxlBO+vxy6DE97kYFVwgoBkILaSIASJTqiUZFX/LNZVJEkfQxPoMUTbJ4l7jFHDMzSp5
         NHNE1cD0Sk9wiknT2wLsn/f39exw7P1JIC9isQKEfK91E7jbmz5i1jrT6F5FbbbgdWvR
         wUzu/IkS/YL6W9PjIsF83fJRF6w7zcsI00pfVWqbbZZOj+VVEmCX6X9FcNvp7+YEpMO+
         EJMg==
X-Gm-Message-State: AJcUukc2EqJV5MYT+TUCEKOU4NZlKSbnUvULdY1gyHo+Ep2hLWXYV52V
        kR7M9LNlBDtZGPauyxaNnmI=
X-Google-Smtp-Source: ALg8bN4dkoVQ01J7VazovgD6a6P8W61dINE2Jc4murodDonchRsDManqaelp9967DeRNKC8MROLcFQ==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr17954287wrx.221.1547290681017;
        Sat, 12 Jan 2019 02:58:01 -0800 (PST)
Received: from szeder.dev (x4dbe795f.dyn.telefonica.de. [77.190.121.95])
        by smtp.gmail.com with ESMTPSA id v6sm6624987wrd.88.2019.01.12.02.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 02:58:00 -0800 (PST)
Date:   Sat, 12 Jan 2019 11:57:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v4 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20190112105757.GE840@szeder.dev>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
 <80b5662f30cb87210385a6bd26e037ce39e46b6d.1544729841.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80b5662f30cb87210385a6bd26e037ce39e46b6d.1544729841.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 11:43:57AM -0800, Josh Steadmon wrote:
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 5fe21db99f..a1b5a75882 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -366,21 +366,26 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
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
>  	pos=$1
>  	data="${2:-\0}"
>  	grepstr=$3
> +	orig_size=$(wc -c < $objdir/info/commit-graph) &&

A minor nit: this test script is unusually prudent about which
directory/repository each test is executed in, as the first thing each
test does is to 'cd' into the right directory.  (I think this is a
Good Thing, and other test scripts should follow suit if they use a
repo other than $TRASH_DIRECTORY.)  Though it doesn't cause any
immediate issues (the previous test happens to use the same
repository), the above line violates this, as it accesses the
'.git/.../commit-graph' file ...

> +	zero_pos=${4:-${orig_size}} &&
>  	cd "$TRASH_DIRECTORY/full" &&

... before this line could ensure that it's in the right repository.

>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> +	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> +	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
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
>  test_expect_success 'git fsck (checks commit-graph)' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git fsck &&
> -- 
> 2.20.0.rc2.10.g21101b961a
> 
