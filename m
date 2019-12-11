Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9700C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9DB206C3
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZH7WN4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfLKReG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:34:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57504 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLKReF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:34:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEAB3935F7;
        Wed, 11 Dec 2019 12:34:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iWO3gAZz/PYC
        ZXXcEd8Y3Po5lcE=; b=kZH7WN4lITPqP6vkF7VdLqwoEV2VQagFb1MNmAqY1K1X
        MIQHY7DBJHyZte2wdnjsRSCn9Kfvndh5p1bzqgxurR1a5jnbel8Pi8fAJuPko1UB
        dqocAOtD17djgXWWTLW1QxtwuCv0kcktDPUXs9UMKBeC/4OhCZbqbD+ZLIG8C3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=m+Oa/a
        e8XAXhrwl0M4GuQTOXjySUaRDSA3iBWYcE1l/Kn3sM+MobuDs+XAISawtuk57FNA
        bkZM1ISHxnhGZECN4MBvkHo0FhAhLQnn9ylh74DamBJm6ECWHA7aXlqwvV7e1zxv
        BC/Yh5S79m3kYAgzj69cgrjyVIzioV+cxEFEo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7081935F6;
        Wed, 11 Dec 2019 12:34:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D35D9935EE;
        Wed, 11 Dec 2019 12:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 00/14] name-rev: eliminate recursion
References: <20191112103821.30265-1-szeder.dev@gmail.com>
        <20191209115258.9281-1-szeder.dev@gmail.com>
        <a589cd6d-f074-e31b-3b22-ee856090b02a@gmail.com>
Date:   Wed, 11 Dec 2019 09:33:58 -0800
In-Reply-To: <a589cd6d-f074-e31b-3b22-ee856090b02a@gmail.com> (Derrick
        Stolee's message of "Mon, 9 Dec 2019 10:08:53 -0500")
Message-ID: <xmqqd0cupy0p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B1E48A8-1C3C-11EA-A73D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/9/2019 6:52 AM, SZEDER G=C3=A1bor wrote:
>> 'git name-rev' is implemented using a recursive algorithm, and,
>> consequently, it can segfault in deep histories (e.g. WebKit), and
>> thanks to a test case demonstrating this limitation every test run
>> results in a dmesg entry logging the segfaulting git process.
>>=20
>> This patch series eliminates the recursion.
>>=20
>> Changes since v2:
>>=20
>>   - Add the new patch 12 to use 'name->tip_name' instead of
>>     'tip_name', to make the patch eliminating the recursion a bit even
>>     easier to follow (only with '--ignore-all-space', though, without
>>     that option that patch's diff is still mostly gibberish).
>>     The end result is the still same, see the empty interdiff.
>
> This new commit makes sense, and I see how it adjusts the context lines
> in the patch that follows. This series looks good to me.

I've finished eyeballing the patches myself, and they seem to be in
a good shape, too.

Thanks.
