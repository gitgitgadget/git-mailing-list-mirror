Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB1C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 18:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiDFSCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbiDFSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 14:01:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33944CEE22
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:14:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3673A1741D4;
        Wed,  6 Apr 2022 12:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WqHja1rvWeyvXQK2SN5f1uNIKyVTqw4y3HEjJd
        SuxTY=; b=VPAy+SFjsefN+FTxhqY1TfiniqzqWAel32DLljQBBOJfW/KGJXtlF5
        3FVlTdztohCP/M+30oeSwti52WywPPlpOUxbiT32funfOI1RIuXbnvk6y3Z5H5aH
        c55T1mfxjYZ0vCxQ1Yd0Yqf8Sw15wPAJfFX6XKK25EMJC9RM1n0TY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F46C1741D3;
        Wed,  6 Apr 2022 12:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CA8D1741D1;
        Wed,  6 Apr 2022 12:14:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
        <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
        <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
Date:   Wed, 06 Apr 2022 09:14:14 -0700
In-Reply-To: <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Mon, 4 Apr 2022 18:40:35 -0400")
Message-ID: <xmqqv8vmyysp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9ABC843E-B5C4-11EC-8F6C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On April 4, 2022 6:33 PM, Junio C Hamano wrote:
>>To: Randall S. Becker <rsbecker@nexbridge.com>
>>Cc: Git Mailing List <git@vger.kernel.org>; git-packagers@googlegroups.com
>>Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
>>
>>CSPRNG_METHOD?
>
> We already have
>
>         CSPRNG_METHOD = openssl
>
> In the config for NonStop. Should that not have worked?

In your original report, you said

>> I thought we did not have a direct reference to OpenSSL. What do
>> I need here to resolve this?

I misread it as "I did not directly ask to use OpenSSL---why am I
seeing breakage from RAND_bytes() that is an OpenSSL thing?", and
where my suggestion to look for CSPRNG_METHOD came from.

Downthread, folks seem to have figured out that OpenSSL support
failed to include a necessary header and link with libraries, while
I was offline yesterday, so hopefully all is well?

Since d073bdc6 (Merge branch 'bc/csprng-mktemps', 2022-02-11) the
CSPRNG code has been in 'master/main' and the topic was merged to
'next' much earlier, at 2e32375c (Merge branch 'bc/csprng-mktemps'
into next, 2022-02-04).  I was puzzled why it took this long for
your report to come, as I somehow thought you've been quite good at
reporting portability issues to your platform quickly, and was
wondering if we broke something between the time we merged it to
'next' and -rc0, but it seems that it was not working from the
beginning X-<.

Thanks.
