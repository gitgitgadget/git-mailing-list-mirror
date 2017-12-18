Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60CD1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 16:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbdLRQzn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 11:55:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933076AbdLRQzi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 11:55:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94F5BC487A;
        Mon, 18 Dec 2017 11:55:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7vNM0M8IUXdt23yteM7h8p7yHGs=; b=d03Tkp
        hp09397qYV+THBs2ZY8naPo5A94iI7gDxg7JWcpc+wvPxa29HOM/CjxMFzxFKmdG
        pLddNonl9ACLuf/GACIrTzHV+djLeidz6CQtZ4eOzob87IRgM0CMyqdO1coh4/eX
        3iwxiYXjb/KHXdaefFTSzyFn+WnMv/64F9OrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FUL/x//BGFkxFRROmEKLIW+cWg6jcp4o
        6PZIw5N7lOfZj06O9agHY8z2Wm35VbDO7TzRfZzTjJpePJrzeUBFofKJw1xeF/xu
        65b8MoXHyOGvCuFbjTvMWeYV6dxe9kt04s8k6L/KUb9UbzJ7eVvhsfO9dhfpfzaN
        wrvbC8mpJ38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CFCBC4879;
        Mon, 18 Dec 2017 11:55:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F40C1C4877;
        Mon, 18 Dec 2017 11:55:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or just a bug?
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
        <20171211225615.GC214273@aiede.mtv.corp.google.com>
        <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
        <20171216220120.GB6217@genre.crustytoothpaste.net>
        <CA+P7+xpFyD0zuOz7XSCc6cV1T1zu6j-gZD=EMQs-t2WPxi1EMA@mail.gmail.com>
        <20171218064042.GA25733@sigill.intra.peff.net>
        <20171218142100.3mhshemnooc3sykv@hopa.kiewit.dartmouth.edu>
Date:   Mon, 18 Dec 2017 08:55:35 -0800
In-Reply-To: <20171218142100.3mhshemnooc3sykv@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Mon, 18 Dec 2017 09:21:00 -0500")
Message-ID: <xmqqvah4nfg8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4545A3B8-E414-11E7-920A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> On Mon, 18 Dec 2017, Jeff King wrote:
>
>> To complete that abstraction it seems like reading via "--global" should
>> read from both (in the same precedence order that normal config lookup
>> uses).
>
> FWIW +1 from me on that ;)

FWIW I do not have problem with that endgame.

I wonder if anybody wants to get their hands dirty.  It should be a
quite straight-forward to split a helper (or three) out of the
do_git_config_sequence() helper, but the interface from cmd_config()
to call into config.c to read a specific "class" of config file is
the same codepath as a single file, so a major part of this work
will be to design how to extend the interface to do the limited
"sequence" thing.
