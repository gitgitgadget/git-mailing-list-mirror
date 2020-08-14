Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE084C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3E320768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tgvzTJGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgHNTFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:05:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61063 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 15:05:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49B596B8A9;
        Fri, 14 Aug 2020 15:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jauWH8SEvKzapnJ2NrEZ8sR+CMU=; b=tgvzTJ
        Gu8IoRunAWwS4qOp4uV9b36ZjVLPZY3BBMXf433nMo8r6BjL7UEqGDDRxPNHHjb3
        P1JxaM7Dlhv0RAkJKp8m4PDD3Q69AhEaRdPfieh7aaq1irjJF+L118CZMxGnond0
        3h3Z5JkcxWUwya+VzCKN9/bMzxEPVIMcL0+VM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kkkLlq8+BpzPEqZct8Tif/0UmhAuAzGB
        BuhXIO6rSYeKLJA8lez0cGu/KHXzqlO6RLUW5/ak5VFwQyakwP5wtmXpCMmDegch
        syNdDFEVFsKHtSNLCD+XiaLWJVdh1KJEYivtMHD7JvVGPKtHBfX94N3CWS/GgOgK
        i25SyCmY9rU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40CF16B8A8;
        Fri, 14 Aug 2020 15:05:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70A086B8A7;
        Fri, 14 Aug 2020 15:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 12:05:09 -0700
In-Reply-To: <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 14 Aug 2020
        18:07:19 +0000")
Message-ID: <xmqqo8ndvyje.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1346AB7E-DE61-11EA-B507-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit-graph format reserved a byte among the header of the file to
> store a "hash version". During the SHA-256 work, this was not modified
> because file formats are not necessarily intended to work across hash
> versions. If a repository has SHA-256 as its hash algorithm, it
> automatically up-shifts the lengths of object names in all necessary
> formats.
>
> However, since we have this byte available for adjusting the version, we
> can make the file formats more obviously incompatible instead of relying
> on other context from the repository.

Very good idea.

> Update the oid_version() method in commit-graph.c to add a new value, 2,
> for sha-256. This automatically writes the new value in a SHA-256
> repository _and_ verifies the value is correct. This is a breaking
> change relative to the current 'master' branch since 092b677 (Merge
> branch 'bc/sha-256-cvs-svn-updates', 2020-08-13) but it is not breaking
> relative to any released version of Git.

That is perfectly fine.  I think any file and on-wire protocol that
uses anything but SHA-1 without identifying what it uses is a bug.

Will queue.  Thanks.

> +OID_VERSION=1
> +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> +then
> +	OID_VERSION=2
> +fi
> +
>  test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
>  	git init &&
>  	mkdir A A/B A/B/C &&
> @@ -35,7 +41,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
>  graph_read_expect () {
>  	NUM_CHUNKS=5
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 $NUM_CHUNKS 0
> +	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
>  	EOF
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 044cf8a3de..5b65017676 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -5,6 +5,12 @@ test_description='commit graph'
>  
>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>  
> +OID_VERSION=1
> +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> +then
> +	OID_VERSION=2
> +fi
> +
>  test_expect_success 'setup full repo' '
>  	mkdir full &&
>  	cd "$TRASH_DIRECTORY/full" &&
> @@ -77,7 +83,7 @@ graph_read_expect() {
>  		NUM_CHUNKS=$((3 + $(echo "$2" | wc -w)))
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 $NUM_CHUNKS 0
> +	header: 43475048 1 $OID_VERSION $NUM_CHUNKS 0
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata$OPTIONAL
>  	EOF
> @@ -412,6 +418,35 @@ test_expect_success 'replace-objects invalidates commit-graph' '
>  	)
>  '
>  
> +test_expect_success 'warn on improper hash version' '
> +	git init --object-format=sha1 sha1 &&
> +	(
> +		cd sha1 &&
> +		test_commit 1 &&
> +		git commit-graph write --reachable &&
> +		mv .git/objects/info/commit-graph ../cg-sha1
> +	) &&
> +	git init --object-format=sha256 sha256 &&
> +	(
> +		cd sha256 &&
> +		test_commit 1 &&
> +		git commit-graph write --reachable &&
> +		mv .git/objects/info/commit-graph ../cg-sha256
> +	) &&
> +	(
> +		cd sha1 &&
> +		mv ../cg-sha256 .git/objects/info/commit-graph &&
> +		git log -1 2>err &&
> +		test_i18ngrep "commit-graph hash version 2 does not match version 1" err
> +	) &&
> +	(
> +		cd sha256 &&
> +		mv ../cg-sha1 .git/objects/info/commit-graph &&
> +		git log -1 2>err &&
> +		test_i18ngrep "commit-graph hash version 1 does not match version 2" err
> +	)
> +'
> +
>  # the verify tests below expect the commit-graph to contain
>  # exactly the commits reachable from the commits/8 branch.
>  # If the file changes the set of commits in the list, then the
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index ea28d522b8..6f1a324f4f 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -6,6 +6,12 @@ test_description='split commit graph'
>  GIT_TEST_COMMIT_GRAPH=0
>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>  
> +OID_VERSION=1
> +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
> +then
> +	OID_VERSION=2
> +fi
> +
>  test_expect_success 'setup repo' '
>  	git init &&
>  	git config core.commitGraph true &&
> @@ -28,7 +34,7 @@ graph_read_expect() {
>  		NUM_BASE=$2
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 3 $NUM_BASE
> +	header: 43475048 1 $OID_VERSION 3 $NUM_BASE
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata
>  	EOF
