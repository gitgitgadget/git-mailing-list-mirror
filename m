Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400DD1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 20:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfHGUW1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 16:22:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54989 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbfHGUW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 16:22:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C142F1637F2;
        Wed,  7 Aug 2019 16:22:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uItR6IWBvLPYbWAc2B+tyiJA9VA=; b=W5XtkJ
        UaztAkv2lkiGoJtIqZ72N0020M83bdaiSCtCt/udR2axGWx21GuJcE+HBeIVCbF7
        L2tJPK03zionETAv/aU4YKCPPKzcBzANPPehAMicaxKEUbdj7LQAc/hD7NO+NKM0
        77eL7R+RvLxCSeU0bv/K7JxmJzILfftHPCQb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VLR6z0fXgRKZAsr0PVEzIi3bgVSInyTl
        YQWEryJLuuYN5Y4Hqr1wcfLz58oFKRLg81ehouzaoWcSqGiOBKeYUo36Eahk+xep
        4LDdZrLnaSw7rq/E6tG2+me/lXOOzWZhup1mPNl+cNvO2dQiaoehUu3tfdRHxl7t
        03smKZOJNwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B918E1637F0;
        Wed,  7 Aug 2019 16:22:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C6AF1637EF;
        Wed,  7 Aug 2019 16:22:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Phillip <phillip.wood123@gmail.com>,
        Martin <martin.agren@gmail.com>
Subject: Re: [GSoC][PATCHl 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190806173638.17510-6-rohit.ashiwal265@gmail.com>
        <nycvar.QRO.7.76.6.1908072139190.46@tvgsbejvaqbjf.bet>
Date:   Wed, 07 Aug 2019 13:22:22 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1908072139190.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 7 Aug 2019 21:41:31 +0200 (CEST)")
Message-ID: <xmqqimr8hgjl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11112522-B951-11E9-A528-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 6 Aug 2019, Rohit Ashiwal wrote:
>
>> @@ -1046,6 +1066,8 @@ static int run_git_commit(struct repository *r,
>>  		argv_array_push(&cmd.args, "--amend");
>>  	if (opts->gpg_sign)
>>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>> +	if (opts->ignore_date)
>> +		argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
>>  	if (defmsg)
>>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>>  	else if (!(flags & EDIT_MSG))
>
> I need this patch to make the code _at least_ compile on Windows again
> (I don't know whether it breaks the test suite yet):
>
> -- snipsnap --
> Subject: [PATCH] fixup! rebase -i: support --ignore-date
>
> It is a mistake to believe that the return value of `time()` is always
> an `unsigned long`.

Good catch.  We can at least expect it to be some integral type ;-)

With or without this fix-up, I think the patch is still not quite
right.  Output from time() formatted as an integer is a string of
digits, and the side that reads that string and interprets it as a
timestamp does so by calling parse_date(); it is up to that function
to decide what datestring format it is in, and it does not
necessarily take it as seconds since epoch.  It is safer to force
the "seconds since epoch" interpretation by writing the timestamp
string like so:

	argv_array_pushf(&args, "--date=@%ld", time(NULL));

See 14ac2864 ("commit: accept more date formats for "--date"",
2014-05-01), which gives a good hint on how to do this right, and
2c733fb2 ("parse_date(): '@' prefix forces git-timestamp",
2012-02-02) for a backstory.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 539c0ef601b..a4c932d3407 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1070,7 +1070,8 @@ static int run_git_commit(struct repository *r,
>  	if (opts->gpg_sign)
>  		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
>  	if (opts->ignore_date)
> -		argv_array_pushf(&cmd.args, "--date=%ld", time(NULL));
> +		argv_array_pushf(&cmd.args, "--date=%"PRIuMAX,
> +				 (uintmax_t)time(NULL));
>  	if (defmsg)
>  		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
>  	else if (!(flags & EDIT_MSG))
> @@ -3642,7 +3643,8 @@ static int do_merge(struct repository *r,
>  			argv_array_push(&cmd.args, opts->gpg_sign);
>  		if (opts->ignore_date)
>  			argv_array_pushf(&cmd.args,
> -					 "GIT_AUTHOR_DATE=%ld", time(NULL));
> +					 "GIT_AUTHOR_DATE=%"PRIuMAX,
> +					 (uintmax_t)time(NULL));
>
>  		/* Add the tips to be merged */
>  		for (j = to_merge; j; j = j->next)
> --
> 2.22.0.windows.1.6.g271c090e89
