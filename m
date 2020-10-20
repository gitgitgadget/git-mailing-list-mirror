Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E9C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32C32224A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eGAVSEoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437978AbgJTTJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:09:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62301 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437957AbgJTTJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:09:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54497F9C46;
        Tue, 20 Oct 2020 15:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pD6bl2MA/AlD8iSwZ0p73nSYutw=; b=eGAVSE
        oTYcl66Z2eeuGgx1xb4GA7sdFIpojcIasI2w7nDHKp57wZ047KMRJDCDaTSeNNGD
        t2ewiXx0eBjiQYYAN5muZ149OVv3yqT1FE/kv55c0sZRxV7VPExDUyHIdkM7kBry
        51lcs4eeBGNQXgb/JzkN0P8HkqDF45/fg3dQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KfoLANIXhj+7Rl9erP9uKYFGxzYseSw8
        5SIGIcnRCrkouzBVtvP3Tt63MrImRBFsi8z8TjUrPK/NGDtS5KaGv6QKsPCIEJv+
        B2ig1LLqgRnUZ+WgAEtsc0h4A1RADNdd6SyD/sBR7qohXu9s8ZuWCsrmkDe+eBHu
        x3ODYDgqsyA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C36FF9C45;
        Tue, 20 Oct 2020 15:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7684FF9C42;
        Tue, 20 Oct 2020 15:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic operations
References: <cover.1600814153.git.matheus.bernardino@usp.br>
        <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
        <20201020013558.GA15198@google.com>
        <20201020025525.GG54484@nand.local>
        <CAHd-oW4A0S6Wb58HA7nRo37sU7YTEbnbsFmwLKN_Onc6ART=PA@mail.gmail.com>
Date:   Tue, 20 Oct 2020 12:09:00 -0700
In-Reply-To: <CAHd-oW4A0S6Wb58HA7nRo37sU7YTEbnbsFmwLKN_Onc6ART=PA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 20 Oct 2020 10:18:59
        -0300")
Message-ID: <xmqq4kmod8ab.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B73F62FE-1307-11EB-AF0C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> I noticed we also have some uses of + and ? in tests, with `grep -E`
> (or egrep). Are we OK with ERE or did these maybe just slip in by
> accident?

We are OK with 'grep -E' and 'egrep' and write '+' and '?' as valid
ERE elements.  What we are not OK with is to invoke ERE elements in
an expression that is supposed to be a BRE by prefixing a backslash,
e.g. '\+'.  Perhaps it is a GNU extension?

We need to remove '\+' in t/perf/bisect_regression used with sed.
What is sad is that this trick and "sed -E" are both GNUisms, and
there is no portable way to use ERE with sed X-<.

But we could resort to Perl in truly tricky cases ;-).



