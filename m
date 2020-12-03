Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3EEC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41833207CC
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 21:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgLCVnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:43:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61863 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgLCVnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 16:43:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 25E2D10E3B9;
        Thu,  3 Dec 2020 16:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pzkQGlz1mlrkcV7spJzXZoXJ2Zw=; b=DAWxc6
        UjoQJkYp46tTmx6e9gZff45iOehg646l1afmjzw2sn+BsnT1W92UMuFkIZHDzf2m
        MSkfijPVTFglBH9P741rCXYNmYL0wZ6t2DfIiL5XrH9zpnZ9aNxDcaTsEwo0XSsU
        q6inN6XH57uUf8H1N/czSQugSjFExO0H+ZwQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i2Hmx1r5CiP7lkTN+4GRN2EYVueMJ9Yx
        YHHmvCOEhWK9pQnuIFpJb1qcUJOmfvPPvYUyY0nHwprCskvs5irdXImywI0bSGKg
        BndTyiE2XFLDZEgo9ivKRSO9ZCdv37Xizy64aecyt0TcGo4lxIiO0PZZtARBf4tm
        y5obZxoIqkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DD1710E3B8;
        Thu,  3 Dec 2020 16:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5CEE510E3B5;
        Thu,  3 Dec 2020 16:42:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 05/15] midx: add entries to write_midx_context
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
        <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 13:42:16 -0800
In-Reply-To: <491667de2baef422e801df1e2c7d3173462a96ff.1607012215.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 03 Dec 2020
        16:16:44 +0000")
Message-ID: <xmqqim9ih8hz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A9A9664-35B0-11EB-9707-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static size_t write_midx_oid_lookup(struct hashfile *f, unsigned char hash_len,
> -				    struct pack_midx_entry *objects,
> -				    uint32_t nr_objects)
> +static size_t write_midx_oid_lookup(struct hashfile *f,
> +				    void *data)
>  {
> -	struct pack_midx_entry *list = objects;
> +	struct write_midx_context *ctx = (struct write_midx_context *)data;
> +	unsigned char hash_len = the_hash_algo->rawsz;
> +	struct pack_midx_entry *list = ctx->entries;

I know this is meant to be a faithful rewrite, but can we lose this
"length of the hash function output must be smaller than 256"
imposed by "unsigned char" at some point, perhaps after this series
settles?  .rawsz field is size_t IIRC.

