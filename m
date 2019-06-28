Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD5C1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfF1WJI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:09:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61022 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfF1WJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 18:09:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B915272945;
        Fri, 28 Jun 2019 18:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xy60zlsXQKipgwOkIHIhhGGiHI8=; b=jMHMkC
        bp5i+3Q6nCUyM71gnRI3rjdPT004Y529/SbWqzOG84VJHpscfOhKzjnOdlk07d9w
        Acyd+S+lFw6Soc6ybGgqf8QBO+VFCzv1GObXgI5jF5KZYoRaWhMz1Xw5loe/ZYIu
        hphatCQteEkIl8w9QR6Gqj+mPZ1harT9ox794=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R9Aqf6wtk+6SX0y27pMGPiAFDozF6CZa
        rHzx0+gMxMQ7LD6H5DFDgxSgUjMitJDhcW+ZMAxJCy9aszsQ/uzEgGUiacGstSzg
        t/cFZgUZBaScMw7qlbDNLCdJE0kE1QKF8uvEbi3RlvDNzWxKhEMaDKViKquoi1nJ
        zlgMkSNdp3Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B026772944;
        Fri, 28 Jun 2019 18:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DA52C72941;
        Fri, 28 Jun 2019 18:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive rebases
References: <pull.253.git.gitgitgadget@gmail.com>
        <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
        <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
        <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
Date:   Fri, 28 Jun 2019 15:08:57 -0700
In-Reply-To: <e332eb5f-0818-763c-9de0-889644446a35@gmail.com> (Phillip Wood's
        message of "Fri, 28 Jun 2019 14:44:07 +0100")
Message-ID: <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54B92EE8-99F1-11E9-B7C8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> I wonder if users understand that '-x' is "an interctive rebase".
>>> The documentation can read both ways, and one of these may want to
>>> be clarified.
>>>
>>> 	-x <cmd>, --exec <cmd>
>>> 	...
>>> 	This uses the --interactive machinery internally, but it can
>>> 	be run without an explicit --interactive.
>>>
>>> Is it saying that use of interactive machinery is an impelementation
>>> detail the users should not concern themselves (in which case, the
>>> message given to "die()" above is misleading---not a new problem
>>> with this patch, though)?  Is it saying "-x" makes it plenty clear
>>> that the user wants interactive behaviour, so the users do not need
>>> to spell out --interactive in order to ask for it (in which case,
>>> "die()" message is fine, but "... internally, but ..." is
>>> misleading)?
>>
>> Hmm. What would you think about:
>>
>>    		die(_("--reschedule-failed-exec requires --exec or --interactive"));

I was leaning towards admitting that the use of the interactive
machinery in "-x" is not merely an implementation detail and fixing
the documentation, leaving the die() message in the patch as-is.

But ...

> I was wondering about requiring --exec with --reschedule-failed-exec
> rather than checking is_interactive() as that would be easier to
> understand.

... I find this a reasonable way to think about the issue.  The
option only matters when we are doing "--exec".  And the usual
convenience measure we'd use, i.e. with --reschedule-failed-exec we
consider that we are implicitly in --exec mode, would not work
because there is no default "command" to be executed.

> One potential problem is if someone has an alias that
> always sets --reschedule-failed-exec but does not always add --exec to
> the command line.

Such a use case would be hitting this die() already without this
topic, wouldn't it?  In which case we can say there is no "someone"
with such an alias.
