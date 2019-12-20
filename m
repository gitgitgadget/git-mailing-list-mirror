Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1133EC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABACD206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJjX8tmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfLTV3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:29:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfLTV3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:29:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70F5D9A6A4;
        Fri, 20 Dec 2019 16:29:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nbi5o6LIjfgNsqwXtLPaHBKgP0g=; b=AJjX8t
        mNDY24OBFYzeaYTNDWFUaFUJ/Y4nMRSoPj/a7mp49KO/hDfpx92B6oEBXAy9gpzB
        2LB+1aBlEsOSxn91xDsvsbwMrkML0sv1HwYmdrXuZYcTyvT1kfsNdeXxY/HNLMPm
        Ad3ygiFk+XgJ7r1GkxV2OWDlhP3W6Uxb4Cmds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ub7+8WixU0v439i6Q2YdLzhE6jcTkaeB
        3cvljPToAq66xPUJi3h0oO4VZH9PIOHibNYHA4XGbMIg/8W63+0MFgqKWFyKpdZj
        KwuCK4JXGvE6AtNHv+GrnS0oUQx31CmihLwlbC7CaKBerL3o6f1Ay5WQ5DCrljyM
        5qGaHWB7Da4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 695E29A6A3;
        Fri, 20 Dec 2019 16:29:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F5449A6A2;
        Fri, 20 Dec 2019 16:29:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        plroskin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 01/15] rebase: extend the options for handling of empty commits
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <13e2056e780b00baf86d4020c0974b6b05ce115b.1576861788.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 13:29:42 -0800
In-Reply-To: <13e2056e780b00baf86d4020c0974b6b05ce115b.1576861788.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Dec 2019
        17:09:34 +0000")
Message-ID: <xmqqimma8z3t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D719F590-236F-11EA-A1B2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Extend the interactive machinery with the ability to handle the full
> spread of options for how to handle commits that either start or become
> empty (by "become empty" I mean the changes in a commit are a subset of
> changes that exist upstream, so the net effect of applying the commit is
> no changes).  Introduce a new command line flag for selecting the
> desired behavior:
>     --empty={drop,keep,ask}
> with the definitions:
>     drop: drop empty commits
>     keep: keep empty commits
>     ask:  provide the user a chance to interact and pick what to do with
>           empty commits on a case-by-case basis

This looks like a logical and natural extension of the --keep-empty
option.

After seeing the stress on "empty from the beginning and ending up
to be empty" in the description, I somehow expected that we may be
able to specify what happens to the empty commit separately, but
that does not seem to be what the patch is about, which was somewhat
disappointing.

> +static long parse_empty_value(const char *value)
> +{
> +	if (!value)
> +		return EMPTY_UNSPECIFIED;
> +	else if (!strcasecmp(value, "drop"))
> +		return EMPTY_DROP;
> +	else if (!strcasecmp(value, "keep"))
> +		return EMPTY_KEEP;
> +	else if (!strcasecmp(value, "ask"))
> +		return EMPTY_ASK;

Not an error but just silently ignored?

> +	return EMPTY_UNSPECIFIED;
> +}
> +

> +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
> +{
> +	struct rebase_options *options = opt->value;
> +	long value = parse_empty_value(arg);

Ahh, OK.

Wouldn't it be better to make the variable and the parsing helper
function of type "enum empty_type", not "long", just like the field
in the rebase_options struct?

> +	BUG_ON_OPT_NEG(unset);
> +	if (value < 0)
> +		return error(_("option empty accepts \"drop\", "
> +			       "\"keep\", and \"ask\""));
> +
> +	options->empty = value;
> +	return 0;
> +}
