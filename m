Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9FB1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 14:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKMOBe (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 09:01:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56932 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfKMOBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 09:01:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C778488915;
        Wed, 13 Nov 2019 09:01:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=svzJfbjN7X05pMQyiaMcTgO06c8=; b=wyyCPh
        SY9hYx9L5bM/KYty94yyImbkPEYUKVM2Lvei+W53/BkXKxN406aNEw7hxos1QpCr
        NaSQh0AYHvbjMbvp8Pqaa+Jqz6RP70YdFysiQ7kKhstQEAyh8xOkVU/4sMHdvCAL
        i/1zhkPzfjOen7JmacWF/MTsg2Hl6p4Hf5Iok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KETR4kQuJAK2ntvY4zGpjalWzsh6lAVQ
        PhS+THE5zB4DIsE4cN3KUnIumHBTwyQlF2iZJXVO+DmtF1+24nLIqI75+XG6pWJ8
        P9wxez9a0KVAf0wDe0EN/yyRkLZJ+0EWn3WBcU/KosHmDZ6P68q9cpdA6ATdyqfV
        4oHAqkZKxrQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A71AC88913;
        Wed, 13 Nov 2019 09:01:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C25668890F;
        Wed, 13 Nov 2019 09:01:28 -0500 (EST)
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
        <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet>
        <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911121459270.46@tvgsbejvaqbjf.bet>
        <xmqqd0dwbfd6.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911131326300.46@tvgsbejvaqbjf.bet>
Date:   Wed, 13 Nov 2019 23:01:26 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911131326300.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 13 Nov 2019 13:30:05 +0100 (CET)")
Message-ID: <xmqqzhgzan9l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16B74578-061E-11EA-9377-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As I do not see those past '--helper' ones necessarily successes, we
>> must agree to disagree here.
>
> Right. But if I recall, you never even saw the need for the conversions
> in the first place. Maybe you still don't?

You probably are forgetting the fact that I was very supportive for
the rewrite of checkout, commit and format-patch (the last one being
my favorite) in C from scripted Porcelain.  

None of these were '--helper' style conversion and I would consider
them much more successful than the recent ones, some of which still
suffer from impedance mismatch bugs (e.g. some parts of the C
implementation work on the in-core index, while other parts working
on the on the on-disk index, letting them become out of sync and
introducing bugs).
