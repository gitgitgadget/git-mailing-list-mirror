Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C87F1F454
	for <e@80x24.org>; Sun, 10 Nov 2019 07:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfKJHSM (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 02:18:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64136 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfKJHSM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 02:18:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F18036780;
        Sun, 10 Nov 2019 02:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vPNuZmW2IATvs3g3gIrpR40cObU=; b=SQ8eyI
        ekK4UDXbmGv1W75jZYMnwQYpWE7Jtcp+H/MZRIgRNfXaHK5ZHPbI49uPSOJbrQk1
        utnv59y2E7fhdBOAUVSAc9TDwWN7vkz+pp7HupXKOTl5V82CKhIcILV2OxqRlCRS
        q2bidMiSbLdjr3TmYVObTVQtXrbrqClmLaR3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aKQvqRpmYwA8HI59+rJ75JmDJdDyUa2d
        YmW8WJwbIjZAMpNHan82sXBlFPCh+zsx3dRWB5o0nT/SATTKpMQ34w8lWkb1Qzlf
        We1pm+jBkesBUE8fw2hQr9iHiQ6LR39SwpekaXpQtoeT+qAnhz6CTJT/q1TpCYvT
        HClJAG2JKfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 372A53677F;
        Sun, 10 Nov 2019 02:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98E693677E;
        Sun, 10 Nov 2019 02:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
        <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet>
Date:   Sun, 10 Nov 2019 16:18:08 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 9 Nov 2019 12:06:07 +0100 (CET)")
Message-ID: <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FA64042-038A-11EA-8450-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I reworded the commit message:
>
>     Start to implement a built-in version of `git add --interactive`
>
>     To convert the interactive `add` to C, we start with a bare-bones
>     version of the built-in interactive add, guarded by the new
>     `add.interactive.useBuiltin` config variable, and then add more and more
>     functionality to it, until it is feature complete.
>
>     This is in contrast to previous conversions to C, where we started with
>     a built-in helper that spawns the script by default, but optionally
>     executes the C code instead. The sole reason for this deviation from
>     previous practice is that on Windows (where such a conversion has the
>     most benefits in terms of speed and robustness) we face the very
>     specific problem that a `system()` call in Perl seems to close `stdin`
>     in the parent process when the spawned process consumes even one
>     character from `stdin`. And that just does not work for us here, as it
>     would stop the main loop as soon as any interactive command was
>     performed by the helper. Which is almost all of the commands in `git add
>     -i`.
>
>     It is almost as if Perl told us once again that it does not want us to
>     use it on Windows.
>
>     At this point, the built-in version of `git add -i` only states that it
>     cannot do anything yet ;-)
>
> Hopefully you like this one better?

Not really.  I find the "we could do the other way but we don't, and
I hate Perl" totally irrelevant and misleading.

Unless it is in GSoC or something that wants to avoid a total
failure of nothing to show at the end of the period, in which case a
piecemeal "we did not finish, but at least we have a handful of
subcommands rewritten to show for the consolation prize" might be a
way to have "something" that resembles "working".  But if we value
the quality of the final product over having to have something to
show in a set term (like you as a paid programmer working as a
professional), building piece by piece in the final framework
(i.e. "in C as a builtin") and flipping the "useBuiltin" to turn on
the whole thing at the end would be the preferrable way to do this
kind of thing, I would think.  Also, it is less wasteful, not having
to worry about the inter-language glue code.  Even if the original
is in shell, not in Perl, we have quite a lot of glue code to throw
values back and forth across the language boundary to imitate what
used to be mere assignments to global shell variables between shell
functions and their callers, and always somebody screws up quoting
there ;-)

>> > +	if (use_builtin_add_i == 1 && !patch_mode)
>> > +		return !!run_add_i(the_repository, pathspec);
>> >
>>
>> Strictly speaking, we can bypass the probing of environment and
>> config when upon the entry of the function, where patch_mode is
>> already known.  I do not know offhand if rearranging the code to
>> take advantage of that fact would result in a flow that is also
>> easier to follow, but I suspect it would.
>
> Okay. I changed it to:
>
> 	if (!patch_mode) {
> 		if (use_builtin_add_i < 0)
> 			git_config_get_bool("add.interactive.usebuiltin",
> 					    &use_builtin_add_i);
> 		if (use_builtin_add_i == 1)
> 			return !!run_add_i(the_repository, pathspec);
> 	}

Doesn't look so bad as I feared.

Thanks.
