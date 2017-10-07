Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189DA20372
	for <e@80x24.org>; Sat,  7 Oct 2017 02:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbdJGCMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 22:12:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63349 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752982AbdJGCMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 22:12:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F154494B2E;
        Fri,  6 Oct 2017 22:12:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qmxj8uLlvOntWhJv4e8o4rjNE84=; b=nG0xRR
        6cGcSPbZisp3f5DuCaCoLMfm4YPjDITuHAXQciPh5MmzFH5SxXbgxS0w5qWHQZ2n
        EsQzYZUpBIJ6U+hm/QtQbJ2CcfjN+9TKg4XiXZon9N16EGyN6pCG1//UXVU3nQHW
        PQx4nNtO1gNUkjA7w/CQ8KfGcKksxYkm/xMuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dwlAWyW87Q/8wQ9rP2Li8enaTb6osMY6
        HMSE6uF1AF/zIk/z1U3Xa+Qexnok3e+VgyHHO/LZ+hDklpPpDdfbzdXC+2DkaYcE
        gP0yQ/7Z9ltnmAJQwuu+X8M8G5bt2gV3iUrJOSus3AUhJsuEEaT4Vx4TJFKlIzdm
        ILIQ5mjCx6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA07F94B2C;
        Fri,  6 Oct 2017 22:12:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A1D594B2B;
        Fri,  6 Oct 2017 22:12:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: use shell negation instead of test_must_fail for test_cmp
References: <20171006190006.19623-1-sbeller@google.com>
        <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net>
Date:   Sat, 07 Oct 2017 11:12:19 +0900
In-Reply-To: <20171006192252.3a27enzim5yurhe5@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 6 Oct 2017 15:22:52 -0400")
Message-ID: <xmqq1smfvh8c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3AD1506-AB04-11E7-9DD5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmph. "test_must_fail test_cmp" is a weird thing for somebody to write.
> And your patch is obviously an improvement, but I have to wonder if some
> of these make any sense.
>
> If we're expecting some outcome, then it's reasonable to say:
>
>   1. The output should look exactly like this. (test_cmp)
>
>   2. The output should look something like this. (grep)
>
>   3. The output should _not_ mention this (! grep)
>
> But "the output should not look exactly like this" doesn't seem very
> robust. It's likely to give a false success due to small changes (or
> translations), or even bugs in the script.

Yeah, thanks for stepping back and looking at it from higher level.

$ git grep -e 'test_must_fail test_cmp' -e '! test_cmp' t/

gives 21 hits, in addition to the 5 Stefan identified, and it would
be a promising hunt to go through each one of them to see if they
make sense.

