Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAB11F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfG3Urf (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:47:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfG3Urf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:47:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21C50151109;
        Tue, 30 Jul 2019 16:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GEEefOYfpjhOuBk3+vgye7vCCYM=; b=lHtgD0
        J3+4rEJzuV97danbpMTl0xX9AiknTdek5XVMxJ+aRltLv5am4tuNnFhwxxF3Hu3K
        RcTHaDx0WaKXIwSMLTTvLjhSToxrBjnHRtidfwtGKbPjumU3nL0oLLWbAiIoT+9m
        NnCxFHGaq7Wn04YRodTzbTHOUnSb6LXWFAZv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UlXTE/vvirO94oHnY0pufn31W52t7fK9
        kqzKuBZ5HnhGVx2aZ2kl3QmT5w/Ym+2hUrbe2RdHi/grQPSBcgkihdHZsq121ggD
        c4tekbZ/XBuYM44jaf7WDx3L92mqNEf990B6zO6Hy9oNuee3Heo5TZBqzYy2m6Sb
        RdLqZFm7m/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18492151107;
        Tue, 30 Jul 2019 16:47:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DFB8151105;
        Tue, 30 Jul 2019 16:47:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/5] repo-settings: consolidate some config settings
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
        <4d0db57ecb4d241b61ba1f9c6f23aedc6b9bb4d9.1564515324.git.gitgitgadget@gmail.com>
Date:   Tue, 30 Jul 2019 13:47:31 -0700
In-Reply-To: <4d0db57ecb4d241b61ba1f9c6f23aedc6b9bb4d9.1564515324.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 30 Jul 2019
        12:35:26 -0700 (PDT)")
Message-ID: <xmqqlfwfs10c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40D6C1BE-B30B-11E9-8B2F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/repository.h b/repository.h
> index 4fb6a5885f..2bb2bc3eea 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  #include "path.h"
>  
>  struct config_set;
> +struct repo_settings;

Given that the next hunk you introduce the real thing, and nobody
refers to it until then, I do not see why we want to have a forward
declaration.

>  struct git_hash_algo;
>  struct index_state;
>  struct lock_file;
> @@ -11,6 +12,17 @@ struct pathspec;
>  struct raw_object_store;
>  struct submodule_cache;
>  
> +struct repo_settings {
> +	int initialized;
> +
> +	int core_commit_graph;
> +	int gc_write_commit_graph;
> +
> +	int index_version;
> +
> +	int pack_use_sparse;
> +};
> +
>  struct repository {
>  	/* Environment */
>  	/*
> @@ -72,6 +84,8 @@ struct repository {
>  	 */
>  	char *submodule_prefix;
>  
> +	struct repo_settings settings;
> +
>  	/* Subsystems */
>  	/*
>  	 * Repository's config which contains key-value pairs from the usual
> @@ -157,5 +171,6 @@ int repo_read_index_unmerged(struct repository *);
>   */
>  void repo_update_index_if_able(struct repository *, struct lock_file *);
>  
> +void prepare_repo_settings(struct repository *r);
>  
>  #endif /* REPOSITORY_H */
