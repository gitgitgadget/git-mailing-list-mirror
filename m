Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E9CECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIUSHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIUSHB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 14:07:01 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967867172
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 11:06:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 597F315203F;
        Wed, 21 Sep 2022 14:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6QbqpdByac+u
        P2KWPeuz9Yu/qfjicLzjjYceOLCGjv8=; b=SWP+tHMHSI3eAjmLg3gOQwZhAoBl
        0Beifo6zYYFLntan+i3KVyAq6ypEc7W9ZKdbv2bHR/V1ydB5K2F5FwyHF3kJKDak
        Tzu6dWsDpGCnxvoDZXl3SJc8oziW8S17svO/11cbK121o10ia6bKCc2LsaBJOT5V
        jBHljVwp7iqLmSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB4815203E;
        Wed, 21 Sep 2022 14:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADB9F15203D;
        Wed, 21 Sep 2022 14:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/4] t: remove \{m,n\} from BRE grep usage
References: <cover.1663765176.git.congdanhqx@gmail.com>
        <ebaf6cec07e3a07c969c456e93aa9d4464f75548.1663765176.git.congdanhqx@gmail.com>
Date:   Wed, 21 Sep 2022 11:06:56 -0700
In-Reply-To: <ebaf6cec07e3a07c969c456e93aa9d4464f75548.1663765176.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 21 Sep
 2022 20:02:30 +0700")
Message-ID: <xmqqpmfo38lb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EAF33C0-39D8-11ED-A4E1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> The CodingGuidelines says we should avoid \{m,n\} in BRE usage.
> And their usages in our code base is limited, and subjectively
> hard to read.
>
> Replace them with ERE.

OK.  I do not personally mind allowing \{0,1\} in BRE (which would
give us a portable way to express '?'), but we are not forbidding
ERE in any way, so I am OK with the direction.

> Except for "0\{40\}" which would be changed to "$ZERO_OID",
> which is a better value for testing with:
> GIT_TEST_DEFAULT_HASH=3Dsha256

Absolutely.  This alone is a change worth doing regardless of the
portability issues.

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>
>  Phillip Wood said:
>  > \{m,n\} is valid in a posix BRE[1]. If we're already using it withou=
t
>  > anyone
>  > complaining I think it would be better to update CodingGuidlines to =
allow
>  > it.
>
>  Yes, I agree. However, I think our usage of \{m,n\} is limited.
>  Let's skip the lifting for now.

OK.
