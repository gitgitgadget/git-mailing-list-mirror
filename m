Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29251F461
	for <e@80x24.org>; Mon, 24 Jun 2019 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfFXSmA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 14:42:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56186 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfFXSmA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 14:42:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5ECEB65E79;
        Mon, 24 Jun 2019 14:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yR/B4AgGjGCGd/QjINAw918U8IE=; b=yKK88W
        90Ct6uLNzlxaf3zARvYTCF1TgAXjgGONYBwHR6MXIfXaXtrdKpxLuF7d+M792goM
        YcNYA1br+bHaGH/E0FcffccNcyjw/OytszBcfNVArlPtieIS4ri3v1gQcioZvVzV
        4GhTTNSGf0PPsGwtFM/UybuySC8p+xXhH2n20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRA1D62eRVMzfyGcgKR8+LKlL8NGB24C
        EXKTMMa2luFlP81THV6kNdfoC69EOSbO5Amnkl+ZGwdTiVKVpoc6L78XOZQdQLBW
        3bbW3XlO6JsyHlzudwPNZBBKEQOBPMISEEM6XZoesZx9HVCC4hnWql7QOg3u19ss
        MJK9WutoJkQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57C2665E78;
        Mon, 24 Jun 2019 14:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B62C65E77;
        Mon, 24 Jun 2019 14:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Pedro Larroy <pedro.larroy.lists@gmail.com>, git@vger.kernel.org
Subject: Re: git bisect should return 1 when the first bad commit is found
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
        <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
        <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
        <20190623224935.GD1100@sigill.intra.peff.net>
Date:   Mon, 24 Jun 2019 11:41:53 -0700
In-Reply-To: <20190623224935.GD1100@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 23 Jun 2019 18:49:35 -0400")
Message-ID: <xmqqo92mhlla.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD8EF10E-96AF-11E9-A584-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 23, 2019 at 01:32:16PM -0700, Pedro Larroy wrote:
>
>> Thanks for your answer.
>> 
>> I was expecting the HEAD to point to the first bad commit.
>> 
>> In mercurial, the exit status tells you information about the
>> bisection process:  https://www.mercurial-scm.org/repo/hg/help/bisect
>> 
>> Sure one can parse stdout, it's just more tedious than just checking
>> the return code and having the HEAD left to the original bad commit.
>
> I think it might be nice for Git to write a well-known refname (like
> BISECT_RESULT or similar) so that you can refer to that instead of
> having to read stdout (whether by machine or by a user
> cutting-and-pasting). And I cannot offhand think of a particular reason
> why that could not just be HEAD (instead of something bisect-specific)
> after the bisect finishes.

As Christian downthread reminds us, that is what the bisect/bad ref
is (which I totally forgot when I gave the earlier response).  I do
not think we need a new ref, but I do not think it is so bad to add
an option "git bisect --exit-code ( --good | --bad ) [<commit-ish>]"
that makes the command usually exit with non-zero status.  Unless we
have found the final answer successfully, that is, and in that case
the command would exit with 0 status to signall "all done".

But that should be an option.
