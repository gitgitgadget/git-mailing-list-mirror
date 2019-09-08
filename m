Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367791F461
	for <e@80x24.org>; Sun,  8 Sep 2019 15:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfIHPkL (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 11:40:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50681 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfIHPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 11:40:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F2FD885C7;
        Sun,  8 Sep 2019 11:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/SJnUaubiL0nzyexnsiqBxFmn7E=; b=Wd0Aq6
        /YGbJxpVjm4NAD/XsDOpB3TGd3Eo89kjy6AJMVbyYPJ+Ef3EDqNHYAfewb1Xm0tI
        /iX3hphOxrFg7c/nYXj/IZAR10QXipKJX3PJgasV5L/2QgU2tccPVjc/+c0jfo3c
        j9YWN/BKCVZER9tVIc4ILVqzg3blvGVsnLJvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KzsSd72tbJW0IlJJbAY8tQfQpWkIcZj/
        RyU8g1FZs1fUEN379Hr/n0y64BYBBcuKJLBL/kfio/BZ1iFgyl65iV4g53O6aavY
        CUckhnfyYr7Usi8gkJ+1bDWCrxes3J/jVWBK0rzgEODLvWginyAHCCp+nZQQLveH
        XIg2PN5MrLY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07DE8885C4;
        Sun,  8 Sep 2019 11:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0EA3C885C3;
        Sun,  8 Sep 2019 11:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Freese <ericdfreese@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
References: <20190907213646.21231-1-ericdfreese@gmail.com>
        <20190907213646.21231-2-ericdfreese@gmail.com>
        <20190908100543.GB15641@sigill.intra.peff.net>
Date:   Sun, 08 Sep 2019 08:40:03 -0700
In-Reply-To: <20190908100543.GB15641@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 8 Sep 2019 06:05:44 -0400")
Message-ID: <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE6A9FFA-D24E-11E9-ABA9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So in my mind there's an endgame we'd like to eventually reach where
> the option added by your patch isn't needed anymore. But we're a long
> way from that. And it's not entirely clear where we'd draw the line
> anyway.

All true and very good "thinking out loud".

> So in the meantime, this seems like a useful thing, and it
> wouldn't be a burden to carry it even if we eventually added
> "--omit=%(symref)" or something.

I would draw the line above this particular change, though.

>> +--no-symbolic::
>> +	Only list refs that are not symbolic.
>> +
>
> I wonder if "symbolic" might be too vague here. Would "--no-symref" be a
> better name?

Definitely.  Another disturbing thing is the design mistake that
made this a bool.  If it is useful to filter out symrefs, it would
equally be useful to only show symrefs.  --[no-]symbolic-refs does
not capture the tristate-ness, and that is why I do not think this
is good enough in the meantime, without causing us trouble carrying
forward.

THanks.
