Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B651F97E
	for <e@80x24.org>; Tue, 13 Nov 2018 06:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeKMQEL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 11:04:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56280 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbeKMQEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 11:04:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 894BF10EB7A;
        Tue, 13 Nov 2018 01:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=77ezHA/kNH9//VNY4Vp1ZyRmu5g=; b=F2GQCS
        1paLsSCXgwkVVopOWe5BA3K9LVshaPAvSMQ+kUP22mSx++kehzcNURx3QhfMdmI4
        3H/nCuR4mKxyCtVqcoYVNsGmpBcfg4JGpuqqBoX+Mmb+xO9NWeGgEkX0sLWObbUy
        pAzGLd+kwQZwpBD1LShH6rE6s9hzcKBzWzE+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XghvFOmB5556w0vfqqMwo2cU2gaIERzN
        FkDOG6kxnvbN7L+JJJTzeevD5JBDVKWuNDJEp2xh2Rz27xkPEtwHHI+6HlidTJv1
        8wljCKi+ziwz45vxLUKMHR+VUXw4QSFp+qa/5cPrdtk9lxo2yw5447fRkBqEzuRk
        jdrC8pzIjzA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F0210EB79;
        Tue, 13 Nov 2018 01:07:39 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F105610EB78;
        Tue, 13 Nov 2018 01:07:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior where appropriate
References: <pull.72.git.gitgitgadget@gmail.com>
        <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
        <20181109101148.GB7410@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
        <xmqq1s7r3pqy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811121235120.39@tvgsbejvaqbjf.bet>
        <xmqq1s7pzqzl.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 13 Nov 2018 15:07:37 +0900
In-Reply-To: <xmqq1s7pzqzl.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 13 Nov 2018 10:49:18 +0900")
Message-ID: <xmqq8t1xwlw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C739A40-E70A-11E8-A4FC-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> On the other hand, for a file-scope static that is likely to stay as a
>>> non-API function but a local helper, it may not be worth it.
>>
>> Oh, do you think that `reset_head()` is likely to stay as non-API
>> function? I found myself in the need of repeating this tedious
>> unpack_trees() dance quite a few times over the past two years, and it is
>> *always* daunting because the API is *that* unintuitive.
>>
>> So I *do* hope that `reset_head()` will actually be moved to reset.[ch]
>> eventually, and callsites e.g. in `sequencer.c` will be converted from
>> calling `unpack_trees()` to calling `reset_head()` instead.
>
> As long as the public API function is well thought out, of course it
> is OK.  Ideally, builtin/reset.c can detect when it is making a hard
> reset to HEAD and call that same function.  Which may or may not
> mean you would also want to tell it to record ORIG_HEAD and remove
> MERGE_HEAD and others), perhaps with another bit in that flag word.

Nah, forget about that one.  It sometimes does branch switching and
sometimes does hard reset, which looks like a strange chimera.  We
shouldn't burden it further by adding "while at it remove cruft, as
'reset --hard' needs to do that" to it.
