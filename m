Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F0D1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbcHBR0a (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 13:26:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932529AbcHBRZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 13:25:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E93932C94;
	Tue,  2 Aug 2016 13:25:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DofzZdgheeCadyMfpUIbAJ1d98A=; b=yRtUO8
	uLqSl7lhObIekQ5AXLukWghzMC7zBdHlJu+vjOoFfWLe1mziQ2keWJpM5vxwrrUb
	a91xGg+i0y9hzSSmDgROwKY3fPvlBqQ+wxNnmPVVxZgkb5opF2LYxVwS9JxrgpL1
	DrOv2DmsnlGA8/f6CQ8DG31MrvR53C7aRxt8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6kz5pkr63ZMwmMqNNodZ9LQqhsCsxAX
	H7GnnbKGz6TKghsC6C6sKErYmiaWcRQQYAdM4pT/lqj8H/Iv7ZpcH8dIVQPuSKmg
	2Es0pqHIetULeO9LMgdYZpEtiXlo1VMwy1vxINOMQsWgBuqA5IvLslKxtBYeph21
	hvplViY9wR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 174F132C93;
	Tue,  2 Aug 2016 13:25:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94ED832C91;
	Tue,  2 Aug 2016 13:25:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 01/13] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
	<0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 10:25:48 -0700
In-Reply-To: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:37 +0000")
Message-ID: <xmqqbn1bf5gj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28725E72-58D6-11E6-9679-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> `--next-all` is meant to be used as a subcommand to support multiple
> "operation mode" though the current implementation does not contain any
> other subcommand along side with `--next-all` but further commits will
> include some more subcommands.

Sounds sensible.

As long as the dispatch happens inside cmd_bisect__helper() itself,
limiting the enum definition local to the function also looks like a
good thing to do (and I do not see a reason why we need the world
outside this function to know about the enum in the future).



> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---


>  builtin/bisect--helper.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3324229..8111c91 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
>  
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> -	int next_all = 0;
> +	enum { NEXT_ALL = 1 } cmdmode = 0;
>  	int no_checkout = 0;
>  	struct option options[] = {
> -		OPT_BOOL(0, "next-all", &next_all,
> -			 N_("perform 'git bisect next'")),
> +		OPT_CMDMODE(0, "next-all", &cmdmode,
> +			 N_("perform 'git bisect next'"), NEXT_ALL),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")),
>  		OPT_END()
> @@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_bisect_helper_usage, 0);
>  
> -	if (!next_all)
> +	if (!cmdmode)
>  		usage_with_options(git_bisect_helper_usage, options);
>  
> -	/* next-all */
> -	return bisect_next_all(prefix, no_checkout);
> +	switch (cmdmode) {
> +	case NEXT_ALL:
> +		return bisect_next_all(prefix, no_checkout);
> +	default:
> +		die("BUG: unknown subcommand '%d'", cmdmode);
> +	}
> +	return 0;
>  }
>
> --
> https://github.com/git/git/pull/281
