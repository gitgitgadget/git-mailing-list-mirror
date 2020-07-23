Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB69C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912A620768
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 22:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BN3jR9ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGWWPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:15:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61051 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgGWWPa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 18:15:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E5FA3D52E7;
        Thu, 23 Jul 2020 18:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1fop3rszs/IUCDyWgJUYnhCtKg=; b=BN3jR9
        kyGMkCf+1krWTUYdYf4K9J3eo79Gs5Hb2Xgb0dX8yDLFhNwBe0YTowgnWdIAcf4r
        uGw1fYIbn0vftLLU7X4AovBonKSerAs2Wsdkfp2LySuq6FWYIEngVVfb6r5cfZEg
        dHfLP9V1yp71ENuPHrozvvhu2bUiaM6KGFxpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FLOlOfCZ+w5S+Bknd3rrS9zBwevzeYYm
        Be3xDTIQZ1MMZk1eaJ7p4vLDAdy+hOLkFVN1DXaJWtZYKkzq24Kb1t4gRFVNzPBw
        /pUXLQ8DdME0pmwIu2TgF3SnBHHOgEEjogD9gYJgC2alSg2MpO+kglu/7lqXVFSQ
        x/OufCjTcPc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCD68D52E6;
        Thu, 23 Jul 2020 18:15:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD380D52E5;
        Thu, 23 Jul 2020 18:15:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 15:15:18 -0700
In-Reply-To: <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:33 +0000")
Message-ID: <xmqqa6zpq3nt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEAB0768-CD31-11EA-AE1A-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When repacking during the 'incremental-repack' task, we use the
> --batch-size option in 'git multi-pack-index repack'. The initial setting
> used --batch-size=0 to repack everything into a single pack-file. This is
> not sustaintable for a large repository. The amount of work required is

sustainable.

> also likely to use too many system resources for a background job.
>
> Update the 'incremental-repack' task by dynamically computing a
> --batch-size option based on the current pack-file structure.

OK.

> The dynamic default size is computed with this idea in mind for a client
> repository that was cloned from a very large remote: there is likely one
> "big" pack-file that was created at clone time. Thus, do not try
> repacking it as it is likely packed efficiently by the server.
>
> Instead, we select the second-largest pack-file, and create a batch size
> that is one larger than that pack-file. If there are three or more
> pack-files, then this guarantees that at least two will be combined into
> a new pack-file.
>
> Of course, this means that the second-largest pack-file size is likely
> to grow over time and may eventually surpass the initially-cloned
> pack-file. Recall that the pack-file batch is selected in a greedy
> manner: the packs are considered from oldest to newest and are selected
> if they have size smaller than the batch size until the total selected
> size is larger than the batch size. Thus, that oldest "clone" pack will
> be first to repack after the new data creates a pack larger than that.
>
> We also want to place some limits on how large these pack-files become,
> in order to bound the amount of time spent repacking. A maximum
> batch-size of two gigabytes means that large repositories will never be
> packed into a single pack-file using this job, but also that repack is
> rather expensive. This is a trade-off that is valuable to have if the
> maintenance is being run automatically or in the background. Users who
> truly want to optimize for space and performance (and are willing to pay
> the upfront cost of a full repack) can use the 'gc' task to do so.

It might be too late to ask this now, but how does the quality of
the resulting combined pack ensured, wrt locality and deltification?

> +#define TWO_GIGABYTES (2147483647)
> +#define UNSET_BATCH_SIZE ((unsigned long)-1)
> +
> +static off_t get_auto_pack_size(void)
> +{
> +	/*
> +	 * The "auto" value is special: we optimize for
> +	 * one large pack-file (i.e. from a clone) and
> +	 * expect the rest to be small and they can be
> +	 * repacked quickly.
> +	 *
> +	 * The strategy we select here is to select a
> +	 * size that is one more than the second largest
> +	 * pack-file. This ensures that we will repack
> +	 * at least two packs if there are three or more
> +	 * packs.
> +	 */
> +	off_t max_size = 0;
> +	off_t second_largest_size = 0;
> +	off_t result_size;
> +	struct packed_git *p;
> +	struct repository *r = the_repository;
> +
> +	reprepare_packed_git(r);
> +	for (p = get_all_packs(r); p; p = p->next) {
> +		if (p->pack_size > max_size) {
> +			second_largest_size = max_size;
> +			max_size = p->pack_size;
> +		} else if (p->pack_size > second_largest_size)
> +			second_largest_size = p->pack_size;
> +	}
> +
> +	result_size = second_largest_size + 1;

We won't worry about this addition wrapping around; I guess we
cannot do anything intelligent when it happens.

> +	/* But limit ourselves to a batch size of 2g */
> +	if (result_size > TWO_GIGABYTES)
> +		result_size = TWO_GIGABYTES;

Well, when it happens, we'd cap to 2G, which must be a reasonable
fallback value, so it would be OK.

> +	return result_size;
> +}
> +
>  static int multi_pack_index_repack(void)
>  {
>  	int result;
>  	struct argv_array cmd = ARGV_ARRAY_INIT;
> +	struct strbuf batch_arg = STRBUF_INIT;
> +
>  	argv_array_pushl(&cmd, "multi-pack-index", "repack", NULL);
>  
>  	if (opts.quiet)
>  		argv_array_push(&cmd, "--no-progress");
>  
> -	argv_array_push(&cmd, "--batch-size=0");
> +	strbuf_addf(&batch_arg, "--batch-size=%"PRIuMAX,
> +		    (uintmax_t)get_auto_pack_size());
> +	argv_array_push(&cmd, batch_arg.buf);
>  
>  	close_object_store(the_repository->objects);
>  	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
> +	strbuf_release(&batch_arg);

I think I saw a suggestion to use xstrfmt() with free()  instead of
the sequence of strbuf_init(), strbuf_addf(), and strbuf_release()
in a similar but different context.  Perhaps we should follow suit
here, too?


Thanks.  That's it for today from me.

