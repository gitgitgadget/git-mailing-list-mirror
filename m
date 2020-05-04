Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E0AC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77682206D9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dXLtlSZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEDP7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:59:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56581 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgEDP7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:59:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 703FC49D5C;
        Mon,  4 May 2020 11:59:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LO57IH4wxNOG/rVLlFncTcHobj0=; b=dXLtlS
        Zboq8EWwfNB7jTryONmI6jKVzxj9E14NxoZ6b70SyuqWFETF2EPmIMCkrtQGTh6A
        FLAmGDhecwqnRKIboBjX7zAfT/uXWxsxa5VpK9827oh8dpJiYKfEe3XBTiYYVI2e
        PYMZ5f5h+NbbeDhH0fK5hXb/DLA9579aM68lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oMplI2aIMGRIfhg/K07pVgBm36xBxZuF
        TrsP7WNxuQzCvK725gHhu3lLUpuaLEXaPtinHJYQHM3aGjavka/AoErq8Pzdt8bs
        P5Ttv1pTcUjQKaXquElejfmOmvN0MGLHUVHPYF9j0xkyV6xbLrDknW36mzYSNy4v
        iHGUL/JoO5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6719F49D5B;
        Mon,  4 May 2020 11:59:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE0EA49D5A;
        Mon,  4 May 2020 11:59:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #04; Thu, 30)
References: <xmqqmu6spocm.fsf@gitster.c.googlers.com>
        <20200501202411.GA41612@syl.local> <20200501224004.GA45288@syl.local>
Date:   Mon, 04 May 2020 08:59:46 -0700
In-Reply-To: <20200501224004.GA45288@syl.local> (Taylor Blau's message of
        "Fri, 1 May 2020 16:40:04 -0600")
Message-ID: <xmqq4ksvitcd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46FC1FEE-8E20-11EA-9AA1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, May 01, 2020 at 02:24:11PM -0600, Taylor Blau wrote:
>> One thing that may have been passed over is my series to teach the
>> bitmap machinery how to quickly interpret '--filter=tree:0' by
>> discarding non-named trees from the result set. That is here:
>>
>>   https://lore.kernel.org/git/cover.1587597151.git.me@ttaylorr.com/
>>
>> This didn't get much review outside of from Peff, who wrote some of the
>> patches, so I'd be happy to re-send it or wait longer for others to have
>> a look, too. For what it's worth, these changes are fairly
>> straightforward and we have been running them at GitHub (and allowing
>> partial clones with `--filter=tree:0`!) for some time now.
>
> At the risk of nagging, would you like this one to be re-sent, or are
> you feeling OK about picking it up?

Ah, I completely missed this message.  I have no strong opinions on
the topic itself myself and I do not remember seeing anything
objectionable in the implementation, but a resend may give it the
last chance for exposure.

Thanks.


