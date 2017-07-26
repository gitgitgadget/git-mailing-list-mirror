Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6254E2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 21:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdGZVKY (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 17:10:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751445AbdGZVKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 17:10:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3C8F95861;
        Wed, 26 Jul 2017 17:10:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u1VivkfpAFMgOMU4G9KmdXF9Ax4=; b=uP66Op
        muZWaT9wiWimBFPnh1okycRO6wEe22PT5pQsOrn/GCEnB0mVHzaXBNV8ajg9qi4J
        LpCMTFxMmfOcwir4ok4sYEb0Ax+TKfe1bGJs9EiHkQpIy+Z1xpuHCh56gcfzZw+u
        9fBVDQvxMJkr4JaaZHhhpAUdKKeejdOIMdmuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kwpcReCmiW9qYVTswrPZfHDBD7JV1QTs
        jVUhMekZCxLjNNI1GiBgoYqMyZZDVexIyuj2LdQYL+txgC+NfKNpJLZVJzRJ8EXI
        l6GCSzCb0VZHOZKh6P6+d5KZCHkKDID6dRdMooh83HlddC1geVLtcGSfd3Rqkq7P
        e/IK3v8J1bs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC12095860;
        Wed, 26 Jul 2017 17:10:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 584199585F;
        Wed, 26 Jul 2017 17:10:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule: correct error message for missing commits.
References: <20170726200832.28522-1-sbeller@google.com>
        <xmqqh8xzq6td.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaYQ5Lzz5i_+uLt3wWtid+YvDxXSyw=isaYj3+98X7Mbg@mail.gmail.com>
Date:   Wed, 26 Jul 2017 14:10:21 -0700
In-Reply-To: <CAGZ79kaYQ5Lzz5i_+uLt3wWtid+YvDxXSyw=isaYj3+98X7Mbg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Jul 2017 13:56:17 -0700")
Message-ID: <xmqqshhiq4zm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D61F9046-7246-11E7-9542-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We _do_ show the submodule as demonstrated by the code sample above
> if we possess the objects.
> ...
>> That sounds like a very sensible and user-centric behaviour to me,
>> and "not initialized" sounds like the right message to give in such
>> a case (as opposed to "commits not present"---even the user told us
>> they are not interesting, we may have them, so "not present" is not
>> just incorrect but irrelevant because that is not the reason why we
>> are not showing).
>
> So you are saying we should instead do:
>
>   if (not active)
>     message = "not initialized"
>   if (problems with object loading)
>     message = "commits not present"
>   ...

I think I am.

>> Or are you saying that even the user told us that the submodule is
>> not interesting, if we had "init" it earlier even once, we show the
>> difference and with a wrong label?  Showing the difference sounds
>> like a bug that is more severe than using a wrong label to me.
>
> I looked through the man pages and they never specify if submodule
> activeness affects the superproject diff, so we'd want to change that
> so that only active submodules are diffed.

I would think that would match my expectation more closely; if I
explicitly told Git to "deinit", and still see the diff to distrat
me (i.e. the current behaviour), I would probably feel that it is a
bug.  I do not know about others who are used to the current
beehaviour, though.  Do people actively "deinit" a submodule that
they once "init"ed, and if so for what purpose?  It's not like they
want to release the disk resource, so I'd imagine the only reason is
to reduce the distracting noise, but I'd prefer to hear from real
users rather than speculating.

Thanks.
