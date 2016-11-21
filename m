Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFD41FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbcKUSYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 13:24:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52880 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753620AbcKUSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 13:24:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8B7751ECD;
        Mon, 21 Nov 2016 13:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fNvgAY/lhj5YCDZ0U6CqY+++dFM=; b=CVdAJe
        AyVRRrqy98AAD7VwSn9gOkEUP5PZAA5djP3u6KrI2E+7y44F2YyYOsqy28/M8+4V
        itgy5YZ48tPfBtOzUzgComqlp8QNDTJdc8SpCDzyT29G7NL3zBtF4HMRckFv2263
        v1AVqVVc/pPDjwWzH8qWthe+swjywOUh80FGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=udRrGaG3nsBvNQr549vUIgDBhOCc63OP
        ATkMZsuOtF82AVX0ealTZbBaPBUMqSBVm22Z8f7IEhwReYI4qBrMy6pp3wFleZF6
        vhwRgAZih8FWqGwmJ3rfLQbX0250PhldBv1HAyvzamhS6Y6Rc6VXT6nUUxZDGXZA
        c9pB6AtMWxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0F7A51ECC;
        Mon, 21 Nov 2016 13:24:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F10451ECB;
        Mon, 21 Nov 2016 13:24:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: identify problems with core.commentchar
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
        <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
        <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 21 Nov 2016 10:24:34 -0800
In-Reply-To: <xmqqbmx8k8c0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 21 Nov 2016 10:15:43 -0800")
Message-ID: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C13BBD7C-B017-11E6-B8F0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_failure '-c with comment char defined in .git/config' '
>> +	test_config core.commentchar = &&
>> +	printf "= foo\n" >expect &&
>> +	printf "foo" | git stripspace -c >actual &&
>
> We'd want "\n" on this printf to match the one before as well, as
> this test is not about "does stripspace complete an incomplete
> line?", I think.  
>
> I could amend it while queuing, but I need to know if I am missing a
> reason why this must be an incomplete line before doing so.
>
>> +	test_cmp expect actual
>> +'
>> +
>
> Is this a recent regression?  When applied on top of 'maint' or
> older, it seems to pass just fine.

I think we can force failure by running this test somewhere other
than the top level of the working tree.  A set of proposed amends
incoming ...
