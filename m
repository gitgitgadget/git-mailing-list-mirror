Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF46E1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfICTFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:05:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60133 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfICTFU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:05:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 517746E89C;
        Tue,  3 Sep 2019 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ApVZz/D0zb4mSQznv5f776x1pc0=; b=h7GBJ2
        z5P8uaqO6MYd4TEal28XdRFJejWSwLQpg3CeG05eQFUMbgKfv6yAJ8iTSCdMa22E
        5tJqxNuc+u/aqE/mpdeWBvJX1J/qG5oM7KtsbzPkjVzH9AUjIsOl6hVwSQF43KYS
        jvH/04Opru7kMdbSXBRItzC7k+pMwDQDVGF2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E5NxKBKO2tzmCgqy75WZxyva5DZ3VlwH
        in9avu/U+V7loz8EFc5lb4/aopsppd0kRCNTiKIcn97pVWmgh+LunpaEp+TVPXNg
        wXwwlIg61/C/Rt9EqFdBQq1wyT5snld4gbtqMVCRxnIYCEZx7z49TMYJ1xj8I2h1
        IcBrXqvCfVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A0D56E89B;
        Tue,  3 Sep 2019 15:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E1086E891;
        Tue,  3 Sep 2019 15:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
References: <pull.328.git.gitgitgadget@gmail.com>
        <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
Date:   Tue, 03 Sep 2019 12:05:14 -0700
In-Reply-To: <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 02 Sep 2019
        19:22:02 -0700 (PDT)")
Message-ID: <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3C2A18C-CE7D-11E9-AD9C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 53ce99d2bb..d36a403859 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -23,6 +23,7 @@
>  #include "packfile.h"
>  #include "list-objects-filter-options.h"
>  #include "commit-reach.h"
> +#include "commit-graph.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -1715,6 +1716,20 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	string_list_clear(&list, 0);
>  
> +	prepare_repo_settings(the_repository);
> +	if (the_repository->settings.fetch_write_commit_graph) {
> +		int commit_graph_flags = COMMIT_GRAPH_SPLIT;
> +		struct split_commit_graph_opts split_opts;
> +		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
> +
> +		if (progress)
> +			commit_graph_flags |= COMMIT_GRAPH_PROGRESS;
> +
> +		write_commit_graph_reachable(get_object_directory(),
> +					     commit_graph_flags,
> +					     &split_opts);
> +	}

As a low-impact change this is good.  

For longer term, it feels a bit unfortunate that this is still a
separate phase of the program, though.  We know what new refs we
added, we know what new objects we received, and we even scanned
each and every one of them while running the index-pack step to
store the .pack and compute the .idx file, i.e. it feels that we
have most of the information already in-core to extend the commit
graph for new parts of the history we just received.

Thanks.

