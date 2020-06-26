Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1DC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF82A20706
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mxhHihtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgFZPn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:43:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65204 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgFZPn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5158C8F20;
        Fri, 26 Jun 2020 11:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V7MpBEHZF/oYOKQjj2bpYliamM0=; b=mxhHih
        tuy3u2Sc00CCilsM5O8Cvd6iGl0f9a2Nvfg99YrGjX8OwN3VDu5XhDn44NgawxGo
        s0n9DjSn1JBTRVh/YYRwDqSfrkXdWLGjLyIbcA2YD95a98BLAosDJ2w0Ecyz+23V
        tSU0kVFzMFfhte6T0OZNnjfMbnpX3oiO4CDaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MJnh0/k8iS00mQ3Uy/GVfjWHVk0yqnvl
        HEWUHUCR8WEGjWRLe3BfUNGwS+JTWVGNFzB/ndZcHRRZVCi7x6a33NQ6YKK8vvhl
        iyRM0F6EHDWXN3V4cibmiplz0/+i8CNFc/KE64BCEbo7rHOxw1g/PudITeOKAf8Q
        HyJSEFRdd30=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC4F7C8F1F;
        Fri, 26 Jun 2020 11:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE111C8F19;
        Fri, 26 Jun 2020 11:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 1/5] rebase -i: add --ignore-whitespace flag
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200626095528.117524-1-phillip.wood123@gmail.com>
        <20200626095528.117524-2-phillip.wood123@gmail.com>
Date:   Fri, 26 Jun 2020 08:43:17 -0700
In-Reply-To: <20200626095528.117524-2-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 26 Jun 2020 10:55:24 +0100")
Message-ID: <xmqqo8p5hlyi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C29F040A-B7C3-11EA-A78D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... This option treats
> lines with only whitespace changes as unchanged and is implemented in
> the merge backend by translating it to -Xignore-space-change.

OK.  Hiding the subtle difference is good.

> @@ -598,6 +612,7 @@ In addition, the following pairs of options are incompatible:
>   * --preserve-merges and --signoff
>   * --preserve-merges and --rebase-merges
>   * --preserve-merges and --empty=
> + * --preserve-merges and --ignore-whitespace
>   * --keep-base and --onto
>   * --keep-base and --root

Hmph...

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 27a07d4e78..810c9b7779 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -126,6 +126,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>  	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>  	replay.strategy = opts->strategy;
> +
>  	if (opts->strategy_opts)
>  		parse_strategy_opts(&replay, opts->strategy_opts);

Usually I would complain about whitespace-only changes to places
where there is no real change, but I am OK with this one.  It does
make sense to have a blank here.

> @@ -1850,6 +1851,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		imply_merge(&options, "--rebase-merges");
>  	}
>  
> +	if (options.type == REBASE_APPLY) {
> +		if (ignore_whitespace)
> +			argv_array_push (&options.git_am_opts,
> +					 "--ignore-whitespace");
> +	} else if (ignore_whitespace) {
> +			string_list_append (&strategy_options,
> +					    "ignore-space-change");
> +	}

I agree with the other reviewer that "when --ignore-whitespace is
given, do these different things depending on the .type" is easier
to follow.  Also pay attention to the style.  There is no SP between
the name of the function and the opening '(' for its parameter list.

	if (ignore_whitespace) {
        	if (options.type == REBASE_APPLY)
			argv_array_push(&options.git_am_opts, "--ignore-whitespace");
		else
			string_list_append(&strategy_options, "ignore-space-change");
	}


> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index 50e7960702..55ca46786d 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>  }
>  
>  test_rebase_am_only --whitespace=fix
> -test_rebase_am_only --ignore-whitespace
>  test_rebase_am_only --committer-date-is-author-date
>  test_rebase_am_only -C4

OK.

Thanks.
