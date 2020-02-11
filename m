Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FABC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA7D246B3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p/kfrG4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgBKRF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:05:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60069 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBKRF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:05:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F7B44BD5C;
        Tue, 11 Feb 2020 12:05:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WNe5uh7F9lkdBy3DMs7hjOtItBw=; b=p/kfrG
        4RMjecTogPPKjq89w49ocTyp97oAAOwPQ/KXBG/W0tn1kXdYYPrOdpffKtkzrHQO
        vzn78XGfF7iVgs64OQ6ZZrfVsjv3fBqJxIKN/QMcxvxf9hkfENOMIGB8RldKPDzl
        X6ywR3K2CHwzrLDm8BNl+2SqwOcwknu5IwYoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OeGa6krLvHwWDXISuz5KZAEahB9Xp540
        sb24M1lxRfB1MLzgOJePrSacfLDM4mYwI6v5xCkMAiJ+CsQV1C8a0Jp6IBUllfAu
        bjar/7NfyZtkcYAv+OoKNVdjY1a0N7dFiTy0POgMDgI1+4JoJTpmb7xBzKVkd/JQ
        hOQFqVmx8eM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85E204BD5B;
        Tue, 11 Feb 2020 12:05:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 036A44BD5A;
        Tue, 11 Feb 2020 12:05:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] sparse-checkout: create 'add' subcommand
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
        <663c40a6909ffac6650a3ee6883b3299f6b2bd90.1581433344.git.gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 09:05:54 -0800
In-Reply-To: <663c40a6909ffac6650a3ee6883b3299f6b2bd90.1581433344.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 11 Feb 2020
        15:02:23 +0000")
Message-ID: <xmqqk14tvytp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C478B656-4CF0-11EA-96AD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	switch (m) {
> +	case ADD:
> +		if (core_sparse_checkout_cone)
> +			add_patterns_cone_mode(argc, argv, &pl);
> +		else
> +			add_patterns_literal(argc, argv, &pl);
> +		break;
> +
> +	case REPLACE:
> +		add_patterns_from_input(&pl, argc, argv);
> +		break;
> +	}

Is it just me or do readers find it irritating to see the order of
the arguments seem a bit random?  Those who like Pseudo-OO-in-C
probably would want to consistently see &pl as the first parameter,
which lets them pretend various flavours of add_patterns_*() are
all "methods" to the pattern list object.

> +static void add_patterns_literal(int argc, const char **argv,
> +				 struct pattern_list *pl)
> +{
> +	char *sparse_filename = get_sparse_checkout_filename();
> +	if (add_patterns_from_file_to_list(sparse_filename, "", 0,
> +					   pl, NULL))
> +		die(_("unable to load existing sparse-checkout patterns"));
> +	free(sparse_filename);
> +	add_patterns_from_input(pl, argc, argv);
> +}

It may make it easier to read the caller if this helper were
replaced with one that does not add anything but just read from the
existing file, i.e.

		if (core_sparse_checkout_cone)
			add_patterns_cone_mode(argc, argv, &pl);
		else {
			read_existing_patterns(&pl);
			add_patterns_from_input(&pl, argc, argv);
		}

