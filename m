Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C941FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 01:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbdJYBsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 21:48:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57160 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751623AbdJYBsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 21:48:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51BCBAA444;
        Tue, 24 Oct 2017 21:48:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gfMU/PueDsEnT65jJKwynVStsAk=; b=dNnQTm
        PAmPJiC2xzRldwap+DU0rFBthulocV/VMUsauEQqRyUGrGu9f33sRXZwXHKkRh1F
        xRuwxLr1iySenH4sZ1hA43TqZzNUm2q+2+ogFEYve5w0HBA18D3OMmgBlTGHIy68
        o1xPmUTROr4gOf7FQyDjzhb4kWfLwNWrcDQq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s7zS3rfu7BsKJHsCqYC5yieTjDJm3eVN
        0OKfLP+bFVn1gIPUGUkx+NKT56HSECQT9wW4jl7t6GhsRmxbwVTrIAezANTbSLj4
        GP3mAj53zkFRPhgLiYG7T4YXpJIA3TD0u5hBn1ImdHkdNa25cDttetoQMnRfJBea
        Jou/ZVBq8MM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49AA6AA442;
        Tue, 24 Oct 2017 21:48:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7E9DAA441;
        Tue, 24 Oct 2017 21:48:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Andrey Okoshkin <a.okoshkin@samsung.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
Date:   Wed, 25 Oct 2017 10:48:08 +0900
In-Reply-To: <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 24 Oct 2017 12:52:21 -0700")
Message-ID: <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DD731AA-B926-11E7-8C6A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I definitely agree with the sentiment that as few things as possible
> should happen between calling getenv() and using its result. I've seen
> real bugs there from unexpected invalidation of the static buffer.

Sure.  I do not think we mind xstrdup()ing the result and freeing
after we are done, though ;-)
