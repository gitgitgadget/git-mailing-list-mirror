Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F220C1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 21:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfFGV5w (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 17:57:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55957 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfFGV5v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 17:57:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB3D614EE0A;
        Fri,  7 Jun 2019 17:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hXPFhxZqQfuabfTxy9UW25XjK40=; b=nzP3Gd
        emSebUOV5OA/mPbDhhGwlbkffBFR37YbGKNiI96uFTTLa9KJTJvTRhmEAKSmQmW2
        ylfQBQTRqyrUNWUTlT0G5OwRqis6LuBB53i3UVNWcgSSkHtEM+2DluYw0mfpkmVm
        ZvBeTNR8D0j+1RJ2MT59hrPZmZSgpoaF1VaYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KeLGK2g9bvoHBTnE8oueUXf9PIEzVYFi
        tTsxdywwpvUu2guAezGMmvbTo9ssmFvHeSXX6Tcj7lWsgqfKCW3drJ73mRdB4lwV
        d91NR5xiDLMHbnQlBXpiMo09YpWLpzydW+AMbBSiQw8ggdBX9Oo7CGfaxIAZTNpJ
        dMeOHfxvrwM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2C0D14EE08;
        Fri,  7 Jun 2019 17:57:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE1DE14EE07;
        Fri,  7 Jun 2019 17:57:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 08/14] commit-graph: add --split option to builtin
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
        <c42e683ef644e7d34614eb74156e5a2b31392758.1559830527.git.gitgitgadget@gmail.com>
Date:   Fri, 07 Jun 2019 14:57:45 -0700
In-Reply-To: <c42e683ef644e7d34614eb74156e5a2b31392758.1559830527.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 06 Jun 2019
        07:15:35 -0700 (PDT)")
Message-ID: <xmqqwohxnjmu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48F5A97A-896F-11E9-A25C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	N_("git commit-graph write [--object-dir <objdir>] [--append] [--reachable|--stdin-packs|--stdin-commits]"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits]"),

Not a comment on the essential part of this feature, but are append
and split meant to be mutually exclusive?

One thing that is somewhat curious is that this commit itself does
not do much that would affect the correctness of how GRAPH_SPLIT
works, as the actual machinery was introduced in the previous step
and this step merely makes it accessible from the outside.  So I had
to look at the previous step to see if the internal machinery had
some safety valve to catch the combination and flag it as an error
or something like that, but if I am not mistaken, there is nothing
that prevents both from being specified.

> @@ -156,6 +156,8 @@ static int graph_write(int argc, const char **argv)
>  			N_("start walk at commits listed by stdin")),
>  		OPT_BOOL(0, "append", &opts.append,
>  			N_("include all commits already in the commit-graph file")),
> +		OPT_BOOL(0, "split", &opts.split,
> +			N_("allow writing an incremental commit-graph file")),
>  		OPT_END(),
>  	};
>  
> @@ -169,6 +171,8 @@ static int graph_write(int argc, const char **argv)
>  		opts.obj_dir = get_object_directory();
>  	if (opts.append)
>  		flags |= COMMIT_GRAPH_APPEND;
> +	if (opts.split)
> +		flags |= COMMIT_GRAPH_SPLIT;

