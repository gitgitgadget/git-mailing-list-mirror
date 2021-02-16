Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6CBC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F16B64DBA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBPBiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 20:38:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59846 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBPBiA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 20:38:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42C2E9F6B0;
        Mon, 15 Feb 2021 20:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8wfq+1/buAFa
        CdlWYfZfRs4hl0A=; b=CxS3uUJubUYb8wHhAUHA9Ypsv2NL0HuojVv7jvHR+AmF
        BwzPY4x4zyEQspb2o1EFO7neH6/MUnFfPIeBu26wIlviV7snTMsMCEQRo+vUftyg
        H2QDgIAQVgHNij8nYxnrQ6HWNHCGC4W49UUX7rUoSk4Ic4K+VbSw/wQBnhKZDJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KMgnTi
        HIUFuAOinAonqbX+y2fkmCg8WWgbzXCr3Z2pCMg8d71ioOP/zx6tvSeOLKO29cNP
        5XpJPwik04sujI14/61F/B1c333V6ODZ68Ems2Mihq7wVjZoE0KXONxFbLFb4CYr
        PTafN90WDt1VCEWc7+MnZKMOzVyaOCtcEUXfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39A469F6AF;
        Mon, 15 Feb 2021 20:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9A529F6AE;
        Mon, 15 Feb 2021 20:37:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210215155020.2804-2-avarab@gmail.com>
        <xmqq7dn8u7dz.fsf@gitster.c.googlers.com>
Date:   Mon, 15 Feb 2021 17:37:15 -0800
In-Reply-To: <xmqq7dn8u7dz.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 15 Feb 2021 17:30:00 -0800")
Message-ID: <xmqq35xwu71w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FDE22C6-6FF7-11EB-9670-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> But if we viewed it with the -W option we'd show "is_empty_rec()",
>> because we'd first find the "xdl_emit_diff()" context line, extend the
>> diff to that, and then would go look for context to show again.
>
> Makes sense.

Ehh, I did not mean "the current behaviour with -W that shows
is_empty_rec makes sense".  The observation you made (which lead to
the conclusion in your next paragraph that it is not a good idea
to show is_empty_rec on the hunk header line) made sense to me.

But I do not think any change from the current behaviour should be
made if -U<n> wins -W (i.e. the first precontext line shown in the
hunk header is not due to -W).  We should hunt for the name of the
function whose latter half we are seeing at the beginning of the
hunk in that case.

Thanks.
