Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B68D1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 22:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfGOWIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 18:08:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62876 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGOWIg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 18:08:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1279D168A20;
        Mon, 15 Jul 2019 18:08:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+QAMEkZTN4yd2/HBdICJZhegMOc=; b=EnoU1e
        g3pecvG5IPvtJEeoeKg3wxxIUovCNxmP21Clvl7aC3G8zTO/xu20CzAyB5hJMVyF
        Yk6nKJ29kgpUt3bVhlufF27Nx05lHczGhQFkA6FM0sEkzAGx0lMWjjxmS7Muxb3u
        MvuY0MCDaYlqkz1mVtvF3pSeNB8sIeBYwsFIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wgEpM8NTgToeRXDJS5zqhZi6ThhDZLiI
        dlGt1QNh5bZDJHly3J3tZ3Li2epyTbNNYVv8Xklq2DQEHSWZoDi4ZLViE8r+CR/S
        dGHTS21XM0ZLpqeirS45G++/3MomAiStckgXutY5KMetPgVGr1UEsCpc9zAkYyvs
        O6lBjM4W3s0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E0F168A1F;
        Mon, 15 Jul 2019 18:08:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FEC3168A1E;
        Mon, 15 Jul 2019 18:08:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, phillip.wood123@gmail.com
Subject: Re: [GSoC][PATCH 1/1] rebase -i: add --ignore-whitespace flag
References: <xmqqlfwz41vl.fsf@gitster-ct.c.googlers.com>
        <20190715220010.8146-1-rohit.ashiwal265@gmail.com>
Date:   Mon, 15 Jul 2019 15:08:30 -0700
In-Reply-To: <20190715220010.8146-1-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 16 Jul 2019 03:30:10 +0530")
Message-ID: <xmqqd0ib3q8x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14CC5E72-A74D-11E9-A658-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Hi Junio
>
> On Mon, 15 Jul 2019 10:57:18 -0700 Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
>> 
>> > +	if (opts->ignore_whitespace) {
>> > +		struct strbuf buf = STRBUF_INIT;
>> > +
>> > +		if (opts->strategy_opts)
>> > +			strbuf_addstr(&buf, opts->strategy_opts);
>> > +
>> > +		strbuf_addstr(&buf, " --ignore-space-change");
>> > +		free(opts->strategy_opts);
>> 
>> Is this call to free() safe?
>
> Yes, as far as I can tell. Since up till now, `strategy_opts` is
> either "NULL" or xstrdup()'d string. There is no double free involved.

Doesn't it also come from handling OPT_STRING() via parse_options(),
which gives a pointer from argv[], freeing something that is not
allocated in the first place?

