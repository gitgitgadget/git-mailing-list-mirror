Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85006208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753173AbdHJStY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:49:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752827AbdHJStX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:49:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F068198E80;
        Thu, 10 Aug 2017 14:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZM2wzrbkleymXFYfevvh165IKiI=; b=pD2wrM
        vMAuOQw5e7yqJatopK6v+O83EkcszGa1Ob23nayGGw8SUXQsL9eKluA5K0wZVmGx
        YIRvMiGYW7tziYEh2w3OXTOntmrRSTU/RmN43kAp2apFw4i9+//e/8gXhLB4PvhP
        OV6AZSph8a6dIYRQt7mSOaM6wt0ToWOfYadVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tDUePDwNPVfUeTzYG0+i+wLz6FNycd7G
        NWt+kBmp/H0/cYJlwSauBsZP15pgiJbEP6WGDjvcsMPhhWDd7bWglH4/Oe82qlI9
        IUW/JZOpuH4F6L4a3EizBNohdxzZt3L17i7QtcLApDh4dzTrwCOIgNQNts52pzdw
        Dh+Mgykqwk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E890E98E7F;
        Thu, 10 Aug 2017 14:49:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6010E98E7D;
        Thu, 10 Aug 2017 14:49:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] interpret-trailers: add an option to show only the trailers
References: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
        <20170810180404.yg3jdzhquregh4ta@sigill.intra.peff.net>
        <CAGZ79kZY1ifks_TAniR+diHOKWVQpRVFeS=XEBGW+7LT=Js5RQ@mail.gmail.com>
        <20170810183107.fykw6w3ypxnxzcy4@sigill.intra.peff.net>
Date:   Thu, 10 Aug 2017 11:49:15 -0700
In-Reply-To: <20170810183107.fykw6w3ypxnxzcy4@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Aug 2017 14:31:07 -0400")
Message-ID: <xmqq4ltf45sk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C35C76C-7DFC-11E7-95ED-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 10, 2017 at 11:28:52AM -0700, Stefan Beller wrote:
>
>> > +test_expect_success 'only trailers' '
>> > +       git config trailer.sign.command "echo config-value" &&
>> 
>> You may want to use 'test_config' here, which keeps the config
>> only for one test. The subsequent tests seem to overwrite the
>> config, so this is not wrong, just not the best style.
>
> Yeah, I actually considered that but decided to keep style with the rest
> of the script. I agree the whole thing could possibly switch to
> test_config, but I suspect there may be some fallouts (the style of the
> rest of the script seems to assume some continuity between the tests).

I agree with your judgment here.  As you said in the "use tool to
enforce consistent style" thread, sometimes humans need to apply
better taste than mechanical tooling could, and I view this one of a
good example.  

Even though this is not a C coding-style thing, but the essense of
the problem is the same.  That is one of the reasons why I earlier
said that we may see more style-only critique to patches if we
introduce a new tool without setting the expectation of what we want
to get out of such a tool straight.
