Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C38D20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 02:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdINCKI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 22:10:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56040 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbdINCKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 22:10:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F07CA2843;
        Wed, 13 Sep 2017 22:10:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/p2EZkTD9kcfa4iSriA9xhLerOE=; b=CmExv0
        mExjlq3ajgd2EQqejP02IVJC9nvJ346wRPgcc5ebJYwxuSG+JBWHNlQ0LfCmbk22
        nvmHTDbB86nj7805H+Iv/YisfbcpL8ffo29zGSZyHzKwXMaagxnlfOpkcZjUhrCy
        HAMPio2Yg7Q6HtOJI82ncIaso6kKNB+k+dBx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hghc4HZ404ZKJopromp9rq8vBNRwxqjZ
        o9xkBRNAJjmu5lMtSsZn2BGZVLbi0EfK27TOVg3wo3CllLlDTn71xNIQ48ndSp5g
        RXMa4xI4ezzcuZAZpVGYAma0UwZC8tU6qk8l8gft/yyhot0fVH5Fj8p+URAK50bL
        wH0BnthuKE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 733FBA2842;
        Wed, 13 Sep 2017 22:10:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F364A283F;
        Wed, 13 Sep 2017 22:10:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
        <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
        <20170911185913.GA5869@google.com>
        <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
        <20170913163052.GA27425@aiede.mtv.corp.google.com>
        <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com>
        <xmqq377q1c0g.fsf@gitster.mtv.corp.google.com>
        <20170913222731.GQ27425@aiede.mtv.corp.google.com>
Date:   Thu, 14 Sep 2017 11:10:01 +0900
In-Reply-To: <20170913222731.GQ27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 13 Sep 2017 15:27:31 -0700")
Message-ID: <xmqqtw06yqrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D33642FE-98F1-11E7-95F0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The NewHash-based signature is included in the SHA-1 content as well,
> for the sake of round-tripping.  It is not stripped out.

Ah, OK, that allays my worries.  We rely on the fact that unknown
object headers from the future are ignored.  We use something other
than "gpgsig" header (say, "gpgsigN") to store NewHash based
signature on a commit object created in the NewHash world, so that
SHA-1 clients will ignore it but still include in the signature
computation---is that the idea?

Existing versions of Git that live in the SHA-1 world may still need
to learn to ignore/drop "gpgsigN" while amending a commit that
originally was created in the NewHash world.  Or to force upgrade we
may freeze the SHA-1 only versions of Git and stop updating them
altogether.  I dunno.

We also need to use something other than "mergetag" when carrying
over the contents of a tag being merged in the NewHash world, but
I'd imagine that you've thought about this already.

Thanks.


