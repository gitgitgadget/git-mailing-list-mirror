Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4DC1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 03:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKPDw2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 22:52:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65285 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKPDw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 22:52:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7AEFA434F;
        Fri, 15 Nov 2019 22:52:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IHS28X5RIvCE2Ilx1XX22YyNFE0=; b=ej4qi5
        Hng94Uf1AMgC9zNXD9wtTF6YPUaNowavt4tnvRcK5GSrYizdh2imJsXmD/zSXeeI
        +mr4TmSoCctVr1bpKO0Hbce6o/3X8Jq19fBHbMWpHD+Uk5/6OG77dWo1St0i0W1q
        0s1oUrwFPz0axOcYK+mSJfvdwKOx2OWrLYvi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hAXn7J1TLxfih4nrpmz420kr7dFCzerb
        c9OFy5rs9vzw9Qr+F2FpK+llGdtxtpYTkOYd4/006pmL82hOKk6PM/XQ4ieKK3RT
        k4Wt3tSJYlTo+8G4YpFX96PGguAv4YRFeJCeG6Xqgun4nXlEik14c11+D1gr5+ls
        i/TaNPED7Qo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5436A434E;
        Fri, 15 Nov 2019 22:52:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00649A434D;
        Fri, 15 Nov 2019 22:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Ben Keene <bkeene@partswatch.com>
Subject: Re: [PATCH v2 1/3] Cast byte strings to unicode strings in python3
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
        <0bca930ff82623bbef172b4cb6c36ef8e5c46098.1573828978.git.gitgitgadget@gmail.com>
        <xmqqeey85yt6.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 16 Nov 2019 12:52:20 +0900
In-Reply-To: <xmqqeey85yt6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 16 Nov 2019 11:40:05 +0900")
Message-ID: <xmqqimnk4gwb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EF6F482-0824-11EA-AAF7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>          cmd += [ key ]
>>          s = read_pipe(cmd, ignore_error=True)
>>          _gitConfig[key] = s.strip()
>> -    return _gitConfig[key]
>> +    return ustring(_gitConfig[key])
>
> Likewise.  I'd expect, if we were to declare that our internal
> strings are all unicode in Python 3, we'd be using a thin wrapper of
> read_pipe() that yields a unicode string, so 's' would not be a
> bytestring, and s.strip() would not be either.

Oops, I did not even realize read_pipe() is already our own.  So
there is no need to any wrapper around it, if we were to declare
that all strings we use are unicode under Python 3---we just need
to have the ustring() call (after giviing the helper a better name)
directly inside read_pipe() function.
