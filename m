Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A47520989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbcJJWOG (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:14:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61382 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752138AbcJJWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:14:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1F6444285;
        Mon, 10 Oct 2016 18:14:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Z7rvcj1kGTawx0wc0AXSQ+gWFTU=; b=jWulZijjLlLTHBqL4NLJ
        +nSEo7/8Zsb04OzD/6YFCW/Q7HvAUQdvU2e/zkuNyl/qeNAsFL+FDXQEm9U9C7fn
        /WeS8ntZTPxnt6pBhAMmddHwGz13v9tPYrgTWBUIKY8+9FqTIk99pCBpYaKQgFEM
        O1+rfBTPD3eJcrVAZJbmsKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ICLgzXWAdaCqTDd0cqqHX43U5Y48PbzDsGnhdBoRFA5XxF
        gf92yVQ7MPKtpEoLO+WDaRxds7P3V9IhO4Q0zzJPitTO/LTKRhRSDzaKu31H28ls
        ST/WpE0OW88asw9qAzmNxXFj8k5CDpnbn0pDPfFKnSpRVrtDaIC4cgnF5y+Ls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAF8744284;
        Mon, 10 Oct 2016 18:14:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6035144283;
        Mon, 10 Oct 2016 18:14:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 01/25] sequencer: use static initializers for replay_opts
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <5c4c86f0ea7ee4a9bad15e48f72b8fe5baa72dfb.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 10 Oct 2016 15:14:02 -0700
Message-ID: <xmqqeg3ndf85.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAD96876-8F36-11E6-9DCA-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This change is not completely faithful: instead of initializing all fields
> to 0, we choose to initialize command and subcommand to -1 (instead of
> defaulting to REPLAY_REVERT and REPLAY_NONE, respectively). Practically,
> it makes no difference at all, but future-proofs the code to require
> explicit assignments for both fields.

The assignments to opts.action immediately following, I would say
this is quite faithful conversion that looks good.

>  int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
> -	struct replay_opts opts;
> +	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int res;
>  
> -	memset(&opts, 0, sizeof(opts));
>  	if (isatty(0))
>  		opts.edit = 1;
>  	opts.action = REPLAY_REVERT;
> @@ -195,10 +194,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
> -	struct replay_opts opts;
> +	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int res;
>  
> -	memset(&opts, 0, sizeof(opts));
>  	opts.action = REPLAY_PICK;
>  	git_config(git_default_config, NULL);
>  	parse_args(argc, argv, &opts);
> diff --git a/sequencer.h b/sequencer.h
> index 5ed5cb1..db425ad 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -47,6 +47,7 @@ struct replay_opts {
>  	/* Only used by REPLAY_NONE */
>  	struct rev_info *revs;
>  };
> +#define REPLAY_OPTS_INIT { -1, -1 }
>  
>  int sequencer_pick_revisions(struct replay_opts *opts);
