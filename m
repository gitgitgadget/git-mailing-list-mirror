Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158EDC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FF360F3A
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 16:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhHFQWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 12:22:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58228 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhHFQWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 12:22:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49C07141F78;
        Fri,  6 Aug 2021 12:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/PpUz2q1Jffy
        i9oWksQ9MZQ/4/HehxLyO8QpbZAVGD0=; b=BvZzWCzW9QDMu2dfy4EQsU7Xs6iN
        uRkCyAZTEIjtb7z02uErifw8it6bLuo16dkk6Dx87EPDweclWmar11ZYjQVmIZ64
        G2L7AILWJQTni6/rbT67Hog6fosuGHjVTXa+a9/Dq/nMYVnKsK+QyWIB96+D1UR2
        r+2CTk6S0z11mes=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41C8C141F76;
        Fri,  6 Aug 2021 12:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91E65141F75;
        Fri,  6 Aug 2021 12:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [GSoC] [PATCH 2/8] submodule--helper: remove repeated code in
 sync_submodule()
References: <20210805071917.29500-1-raykar.ath@gmail.com>
        <20210805071917.29500-3-raykar.ath@gmail.com>
        <YQyIJpq/r0O7zhb1@danh.dev>
        <CAP8UFD0hnkO+LMo2OTAiqPoi20V25806-zL97DA5qPz+3tgKnA@mail.gmail.com>
Date:   Fri, 06 Aug 2021 09:21:51 -0700
In-Reply-To: <CAP8UFD0hnkO+LMo2OTAiqPoi20V25806-zL97DA5qPz+3tgKnA@mail.gmail.com>
        (Christian Couder's message of "Fri, 6 Aug 2021 11:06:03 +0200")
Message-ID: <xmqq5ywik0gw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 695C4BD8-F6D2-11EB-93B8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Aug 6, 2021 at 2:54 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Da=
nh <congdanhqx@gmail.com> wrote:
>
>> While previous patch is definitely a refactoring, this patch add small
>> overhead to the system, the new code will query (then free())
>> git_config_get_string() and/or xgetcwd() one more time in the second
>> compute_submodule_clone_url()
>>
>> I think the abstraction overhead is not that big, though.
>
> Yeah, Junio made basically the same comment. So it would be nice if
> the commit message could mention we are adding a very small overhead
> in exchange for code simplification (10 lines removed).

If you guys want to, I wouldn't stop, but my comment was just a
thinking-aloud observation, not a suggestion to add to the proposed
log message.

Thanks.
