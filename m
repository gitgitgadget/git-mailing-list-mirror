Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5BC433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148D520936
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 21:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VOLRNt9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgINVox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 17:44:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52037 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgINVot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 17:44:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F006AACE;
        Mon, 14 Sep 2020 17:44:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J2slb6RDEDyhSUMhkmwT9/tRtA8=; b=VOLRNt
        9tav9XvD3RGl5oUv6DhHh+76oBOGMDTKvEneIfGE/wiNcVJWFlvdMKfA10733SIT
        +2q0ZBltjQgIIT36l07hwtXy/CcnBtYCeT6FvEpBKnYY9VHpov4DADiufTRoC6qu
        uyAMIfblzUJwdd0lknEqk90nDvDKvsFkzgK14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QU0uncBxo96J7Cwy6Q7/Xg7tIWNJV7Hq
        AL3cvPdLlHk7cbJVpKw8Vv4tRjNeftweHtYoFFCGl53rTmRT2uLKgp2jGciCzwA9
        Usk/DGj0+6Pp6wEzC6Wu7nMVSosYT+tr1+vVGRPd6VQyJH17sQgNXmT6arvZLMIO
        rGWaYavc0DA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE08B6AACD;
        Mon, 14 Sep 2020 17:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E2756AACC;
        Mon, 14 Sep 2020 17:44:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH] builtin/clone: avoid failure with GIT_DEFAULT_HASH
References: <20200911151717.43475-1-matheus.bernardino@usp.br>
        <20200911233815.2808426-1-sandals@crustytoothpaste.net>
        <20200912032448.GB1988@nand.local>
        <20200912195256.GN241078@camp.crustytoothpaste.net>
        <xmqqo8m811mf.fsf@gitster.c.googlers.com>
Date:   Mon, 14 Sep 2020 14:44:45 -0700
In-Reply-To: <xmqqo8m811mf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 14 Sep 2020 14:37:12 -0700")
Message-ID: <xmqqk0ww119u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81D05650-F6D3-11EA-85CD-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>>> Alternatively, I certainly wouldn't complain if you did introduce a new
>>> function and updated the call-site that passes reinit as 1.
>>
>> I thought about introducing a new function, but since it would share
>> almost all of the code, it seemed a bit wasteful, even if the function
>> is small.  We do have only two callers, I believe, since I recall
>> making this function non-static and calling it from clone, so I think
>> it's okay.
>
> Perhaps.
>
> FWIW, this seems to have strange interaction with something in
> 'seen' when merged; I suspect it is the topic that mucks with the
> set-up sequence for "git clone", but didn't check.

Actually I have to take it back.  I have this directly on top of
v2.28.0 and it already breaks tests big time.  For example, here is
how "cd t && sh t0021-conversion.sh -i -v" breaks:

    ...
    Cloning into 'repo-cloned'...
    fatal: could not unset 'extensions.objectformat'
    fatal: the remote end hung up unexpectedly
    not ok 25 - delayed checkout in process filter

The story is the same if it is applied on top of 'master' (which is
expected, as we haven't done anything to affect this area since
v2.28.0).
