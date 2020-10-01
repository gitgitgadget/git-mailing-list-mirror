Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE7C4741F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB3C20872
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dm/OYG2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbgJAPuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:50:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62128 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAPuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 11:50:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 643FA979C3;
        Thu,  1 Oct 2020 11:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L5jm1sMqBFjCQhH8vnIxTMIAkA0=; b=dm/OYG
        2mu5gine1WqnFjErybwQGz3g5CpCblPQgA82jSDkI3skgYrYRbgyLSlTZ7/Ofvg1
        h4w5Wr9CsFXfrxx/lZRkADJSkFK3rylxh+PGFRV5j0zKLmnV2LckTPDao2+qzOJB
        CNeeo2O3OY7n/vfux522622z9+fFOp+G9IJzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bqxS1LudnFhYyvi2eh1eDmaySH6O1kVc
        DMaxSzIdzIA5R4JyT2hIL9F7t4dx9BoYrlt6kdsdBiLMaDWK/L4P/3tTq7G5+KQl
        be9hW9FNW4AHrdrxnjoIUGZEEgeNFl1aSFbXsFGpdahII3DttqvERhebbhwEvcJF
        oYDHqB8Gwco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D6D9979C1;
        Thu,  1 Oct 2020 11:50:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDDF6979C0;
        Thu,  1 Oct 2020 11:49:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Theodore Dubois <tbodt@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] Propagate --quiet on submodule update to merge/rebase
References: <20200930195052.118199-1-tbodt@google.com>
        <xmqqzh57f0dh.fsf@gitster.c.googlers.com>
        <20201001053803.GC2930867@google.com>
Date:   Thu, 01 Oct 2020 08:49:59 -0700
In-Reply-To: <20201001053803.GC2930867@google.com> (Jonathan Nieder's message
        of "Wed, 30 Sep 2020 22:38:03 -0700")
Message-ID: <xmqqd022c5eg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2FE0D7A-03FD-11EB-B3F0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Theodore Dubois <tbodt@google.com> writes:
>
>>> Without this, commands such as
>>> git pull --rebase --recurse-submodules --quiet
>>> might produce non-quiet output from the merge or rebase.
>>>
>>> Also fix the parsing of git submodule update -v. Setting GIT_QUIET to 0
>>> has the same effect as setting GIT_QUIET to 1, because
>>> ${GIT_QUIET:+--quiet} only checks whether GIT_QUIET is set or unset.
>>
>> Thanks.
>>
>> Will queue with the following log message.
>>
>>     submodule update: silence underlying merge/rebase "--quiet" is given
>
> Missing 'when' before '"--quiet"', as Eric noticed.
>
> Aside from that,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks, all.

I just noticed that our names were on the original change that
introduced the broken GIT_QUIET=0; hopefully this time around we did
a better job at reviewing the change? ;-)

Thanks.
