Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8121F454
	for <e@80x24.org>; Sat,  9 Nov 2019 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIHO6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 02:14:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52569 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfKIHO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 02:14:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 808BC25EB9;
        Sat,  9 Nov 2019 02:14:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ZqDDKhoE330QbiO0aM7CD7kwpQ=; b=ghX2v4
        0oCQ/YXcR64r8wUwIatIvIRpN4OBy57iBlO3REE50cDzpBNuH94RILfgJzdc9Tfl
        KatMPhWv9ptgKOJPC0Tlj5AdWBIc2CAKa7BQDMKLNgPAl5OPj/sEyiOf/a9P3igD
        hrIrbgur5TzBt5m3ol8o2WgkxIQB9dQzFYP0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KwsOcrX8mvqnVvCDZ8K36fR8OHzCjYvO
        zMeEYVAJjiMb0iFP0ir64pE01D85+e2Vtd7ycbz8m1eAbzclDkz3RLPkj1rGMC/w
        q0bWRjYe9AgMoBU62O1xHXTpwQS+GN+pY9w16P18bTMLd4U8GQn38vKn9HmiFVXO
        pCd3RL+fSCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 776C625EB8;
        Sat,  9 Nov 2019 02:14:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AEBC25EB7;
        Sat,  9 Nov 2019 02:14:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Change behavior of git add --patch on newly added file?
References: <20191108225035.GA60198@google.com>
        <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 09 Nov 2019 16:14:53 +0900
In-Reply-To: <xmqq5zjtn07v.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 09 Nov 2019 13:27:16 +0900")
Message-ID: <xmqqpni1ldw2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A19B4E7A-02C0-11EA-B4E7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> Should 'git add -p <newly-added-file>' do the same thing as 'git add -N
>> <newly-added-file && git add -p <newly-added-file>'?
> ...
> Patches welcome, but you may want to check with Dscho as there is an
> effort going on to reimplement the entire "add -i" machinery in C.

Oh, having said all that, for a newly added file, all you have is a
hunk that is full of added lines and nothing else, so even 's'plit
interactive subcommand of "add -p" interface would not do anything.

So I am not sure if performing an implicit "add -N" upfront would
help your use case that much.  For that, you'd need to extend hunk
splitting UI a bit more, so that the user can split a hunk that only
adds lines into two at a desired point in the hunk.
