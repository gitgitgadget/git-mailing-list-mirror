Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F6C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528CA61953
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhC3Rhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:37:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62284 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3Rhi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:37:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C0F9BF681;
        Tue, 30 Mar 2021 13:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNoTdYO9wzCopTm3KA7Mz/DU+oM=; b=JtwyXE
        MEj8joapBdZajtzcQJkTCfihjW325buX9VeRGhIigo3K/N+7ClbSkfuCE2KJ4TDV
        lo47RHdKaiwdw6UIrnaTHevp9a0NprI3q11w+3++VFPPIlGao8fjRgb4AJbIpppX
        O8G749cxPb+E13pJTt5u5bPkFImA903dtvMB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j0ZDvBaxTqIN6pZrsCzeeDkKitVZYtq/
        x7+x05gWJaVCI5+C+6Re1fTy07afqfFb+p5RukVfWFCTpO0+YEYpCr28OAOAzPrt
        8gOfzsL1QrLWxAeL3Z8hTLkJK2ZX4G1E+HE8ZJ6s/PFRkNxxqrVYCdAYgejojDEm
        RtpsmQ1LjZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43428BF680;
        Tue, 30 Mar 2021 13:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C7A6BF67E;
        Tue, 30 Mar 2021 13:37:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stavros Ntentos <stdedos@gmail.com>
Cc:     git@vger.kernel.org, stdedos+git@gmail.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2] pathspec: advice: long and short forms are incompatible
References: <xmqqft1iquka.fsf@gitster.g>
        <20210328154532.23803-1-133706+stdedos@users.noreply.github.com>
        <xmqqmtunks8q.fsf@gitster.g>
Date:   Tue, 30 Mar 2021 10:37:35 -0700
In-Reply-To: <xmqqmtunks8q.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        28 Mar 2021 12:12:05 -0700")
Message-ID: <xmqqo8f0ee5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DDBAFAC-917E-11EB-B5FA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static const char mixed_pathspec_magic[] = N_(
>> +	"'%.*s...': cannot mix shortform magic with longform [e.g. like :(glob)].\n"
>
> OK.  Just a bit of bikeshedding.
>
> cannot mix short and long form magic
> cannot mix shortform magic with longform
> 	
> The former is a bit shorter.  Also, if we show (with %.*s) the
> actual beginning of their attempt, e.g.  when they gave us [*]
>
> 	git show -- ':!(global,icase)foo'
>
> if we show
> ...
> 	':!(...': cannot mix short and long form pathspec magic
>
> it may be sufficiently clear where the problem is.

I meant "clear where the problem is, without adding [e.g. like :(glob)]".

Thanks.
