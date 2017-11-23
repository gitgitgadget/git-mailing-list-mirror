Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB7420954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdKWCle (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:41:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53250 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751742AbdKWCld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:41:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6E8DC0FFA;
        Wed, 22 Nov 2017 21:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rzIkLV2m2KAQb83wCz5huMnCfa4=; b=I5sVMV
        xcN3JhJzOWXcK2hSeX/84Qh7yCgS+n5VDralDaNGI0oWH2ou8h9vPFJEQMzLl7U0
        ES5GVGMP4mj992Ph9Q28PZ4nzQHUXiQ/DGwIbf4EbcGcNSi5qIEHPf/l3arL32xQ
        iUBhgQXjZ7YLjIp+NfxGUs/uTbHBeY6YF3ZEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NrOsn6nSsY2Wv3/AqAUSWEuSzF5h8QIa
        6I0C3k/12XRMyhgl0uBteHy3HaOz9k6a3IcNvvq2/wcHqdWrRzHRxB9qUIQ6RovT
        DP93rXu6niB8kVZWbQP4/XxLuG8royx8znvvkYOlRd4/f8y5B+M1ociZdB1UQu12
        ZmNio1tmjYk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEE93C0FF9;
        Wed, 22 Nov 2017 21:41:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30CB3C0FF8;
        Wed, 22 Nov 2017 21:41:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] p5550: factor our nonsense-pack creation
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
        <CAPig+cRDNmjmM2Ed+mwqf7JZ76CxA3Eh7-UV6k=LFngZ3YE_sQ@mail.gmail.com>
        <20171121155815.46ih4ld4cp7n544l@sigill.intra.peff.net>
        <CAGZ79kbNQCzmkQDFY+gxEuZDPziehZdhgReCzpk3oxn=fpv=UQ@mail.gmail.com>
        <20171122223817.GB1405@sigill>
Date:   Thu, 23 Nov 2017 11:41:25 +0900
In-Reply-To: <20171122223817.GB1405@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 17:38:17 -0500")
Message-ID: <xmqqlgixra22.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDA5FB1C-CFF7-11E7-8997-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, I came to the same conclusion (we may even have discussed this on
> the list, I don't remember). The current "todo" format says that only
> the command and sha1 matter, and we'd be changing that. Maybe that's not
> so bad if the user has to enable the feature themselves (and clearly it
> would be incompatible with a custom format option).

If you are in the habit of always writing 4 or more lines, the
chance that you would make a typo on the line you can correct in the
"todo" list with such a feature is at most 25% ;-).

I think one downside is that a mere presence of such an option hints
that we somehow encourage people to commit with a title-only message.
