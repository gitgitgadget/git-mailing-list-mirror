Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2248C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E4E21775
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qzyLOeOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfLQTho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:37:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60532 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTho (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:37:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 192DD9F64A;
        Tue, 17 Dec 2019 14:37:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RSUkeoBO3cnBiVBQuIesux2zc14=; b=qzyLOe
        Ov0k6lwej1+KP2aFGz4gH3VPlW3nogRygRqhH3CaVwXGgsu4alU/gB5/eNn0gZ+t
        ryu/Enhf9OObdLR2t11I+dMAgVvMwTp4Hnsexrr3PD3TmWcP9X1jx1JeDt9FpJDW
        a2+nm/yE+bizVw+dYZJ8y6Wce1qk7WX6LdmZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FEY0ClIPLd2+tSMcU4tYM2Bkg2A6r03X
        pwk+22C8DbrJn7oqkw/DcUvFcAI+a+O9n/WsHdrbw9CiPOCEQ/JhUkesiZaNhrfY
        bPHJGNk1w8rphDkcE0bb1ggOZ97NhDi2OcTI2o4Sh2QXg7Pd+QW8NDQ2T6KWlAHi
        J0jy9SsCkTc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 112CE9F649;
        Tue, 17 Dec 2019 14:37:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 38E419F648;
        Tue, 17 Dec 2019 14:37:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/7] built-in add -p: prepare for patch modes other than "stage"
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
        <8f6139f94debb9b3bfb9c9e8b8e18e3c2fb46a06.1576579264.git.gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 11:37:36 -0800
In-Reply-To: <8f6139f94debb9b3bfb9c9e8b8e18e3c2fb46a06.1576579264.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 17 Dec 2019
        10:40:58 +0000")
Message-ID: <xmqq36dihhfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF474378-2104-11EA-ABDC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +
> +enum add_p_mode {
> +	ADD_P_STAGE,
> +};

Nice to see a trailing comma here ;-)

> +int run_add_p(struct repository *r, enum add_p_mode mode,
> +	      const char *revision, const struct pathspec *ps);

This makes readers wonder if "const struct object_id *" is more
appropriate; "const char *revision" that holds human-readable name
is better when the internal machinery uses it for reporting, so that
may be what is going on here (so is the new field in add_p_state
structure).

>  #endif
> diff --git a/add-patch.c b/add-patch.c
> index 2c46fe5b33..8a691f07da 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -11,10 +11,33 @@ enum prompt_mode_type {
>  	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
>  };
>  
> -static const char *prompt_mode[] = {
> -	N_("Stage mode change [y,n,a,q,d%s,?]? "),
> -	N_("Stage deletion [y,n,a,q,d%s,?]? "),
> -	N_("Stage this hunk [y,n,a,q,d%s,?]? ")
> +struct patch_mode {
> +	const char *diff[4], *apply[4], *apply_check[4];

Hardcoded "4" and not-quite descriptive names puzzle readers at the
first glance.  Let's read on to see if they need any further
improvement.

> +	unsigned is_reverse:1, apply_for_checkout:1;
> +	const char *prompt_mode[PROMPT_HUNK + 1];

This relies on the enum value assignment (or listing) order to
ensure that PROMPT_HUNK always comes at the end.  Perhaps that
deserves a comment before "enum prompt_mode_type", e.g.

	+/* Keep PROMPT_HUNK at the end */
	 enum prompt_mode_type {
	 	PROMPT_MODE_CHANGE = 0, ...
	 };

> +	const char *edit_hunk_hint, *help_patch_text;
> +};
> +
> +static struct patch_mode patch_mode_stage = {
> +	.diff = { "diff-files", NULL },

Nice to see designated initializers used ;-)

Mental note: the "diff" field is (probably) for "the command line
to be used to generate the patch"

> +	.apply = { "--cached", NULL },
> +	.apply_check = { "--cached", NULL },

Mental note: these "apply" and "apply_check" fields are (probably)
not for the command line; unlike the "diff" field, these only have
arguments.

Mental note: if the three field names become confusing, perhaps we
can clarify them by either (1) calling diff as diff_cmd[], or (2)
calling the other as apply_args[] and apply_check_args[], or (3)
rename both.

> +	.is_reverse = 0,

Wouldn't it be sufficient to apply the default initialization, just
like it is done for apply_for_checkout bitfield?

> @@ -1310,6 +1345,9 @@ int run_add_p(struct repository *r, const struct pathspec *ps)
>  
>  	init_add_i_state(&s.s, r);
>  
> +	s.mode = &patch_mode_stage;
> +	s.revision = revision;

The phrase "mode_stage" may become problematic, as other modes that
will be introduced, like "reset", "checkout" all will stage
different contents to the index.  The only mode the machinery knows
at this point in the series is how "add" stages contents to the
index, so "patch_mode_add" might turn out to be a better choice of
the phrase as we read the series along.  We'll see.

> +		if (!strcmp(patch_mode, "--patch"))
> +			mode = ADD_P_STAGE;

The same comment applies to this enum token.

Thanks.
