Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4861F461
	for <e@80x24.org>; Tue, 25 Jun 2019 22:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFYW22 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 18:28:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYW22 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 18:28:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5330016607B;
        Tue, 25 Jun 2019 18:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c04Y2/93bMDoRi/ITxrH7a8hD/Q=; b=oSzlw1
        ffrxMQsuG6rALvCDI7OwNzenK4VWNeFqa6XFuKLfUApBsOWefXWm4OS6c1JncSfd
        bSB6VzgrRCA7xw1CJXG43vkGo++AMmMHuycj1sIgjUpU9jo0trpBzksBwusLxLwI
        00IaNmHS00Q7t2kOa6hyLuxgritdVlPbvOkJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dTBChnPgBXOh3xrYgORvItIJnQeAOrgM
        aKIZTxPkMALBmiO6RDQgsNKEEMTe31nEtZi54fCuc6OngWI6y3wfEd9ScTXG3bzA
        0/KnJtu9LEE+rs5bjA5uerGV/PmmSKh9vAlOmeisUL6TiFTf6hYHUtFUCa5/RgNa
        0EmFQXEB5ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B64916607A;
        Tue, 25 Jun 2019 18:28:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B25FC166079;
        Tue, 25 Jun 2019 18:28:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
References: <20190624130226.17293-1-pclouds@gmail.com>
        <20190624130226.17293-2-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet>
Date:   Tue, 25 Jun 2019 15:28:24 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 25 Jun 2019 11:44:53 +0200 (CEST)")
Message-ID: <xmqqk1d9e1vb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C60D860-9798-11E9-A438-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
>
> This does not do what you think it does, in Ubuntu Xenial and on macOS:
>
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11408&view=ms.vss-test-web.build-test-results-tab&runId=27736&paneView=debug&resultId=105613
>
> The `\1` is expanded to the ASCII character 001. Therefore your test cases
> fail on almost all platforms.
>
> Funnily enough, they pass on Windows...

bash, dash and /bin/echo behave differently given 

    $ echo 'foo \1 bar'

some 'echo' suffer from the "\<n>" interpolation.  Some don't.

I think your spelled-out version downthread (except for stepping out
of BRE which would break your sed script, as you realized) would be
a much readable alternative.

Thanks.
