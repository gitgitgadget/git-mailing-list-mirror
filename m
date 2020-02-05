Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28AC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9CB2072B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WbvamSJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBEXTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:19:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58117 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXTD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 18:19:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 816EEB09EA;
        Wed,  5 Feb 2020 18:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Ng4jWtikENOdThoEOv7m5frZ78=; b=WbvamS
        JgX5FVXPvj6SVepFzlY9Mo6r5mXefRTOjUxYdBphwYNK50IBayH7ej6xJIiTm8QO
        srwtgSwFzs4CuBF5MlzExaoyy8xfqdzr6w5jCiBJMYeopOp40ICNCqonvyB3jebu
        L0sy/23NwxRnX8xxrXEi/sETcJfDFa+GUnXxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L0vYMR/k5hkfEIdX3IawFofI0PLEtDsI
        SSgBQkFgQIqVUwPliKGYrEdTcHozjhDXIS+Qn4zDpi82TFMxaihVsetbvq1nBHim
        W0iz5c1giVembX8ZgxmSp/Xlft8ETgrVbkiytXGaRuvTDFKK5ESY1tE5L1wmSqts
        QqS+DwVKvOk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A7FDB09E9;
        Wed,  5 Feb 2020 18:19:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A4713B09E5;
        Wed,  5 Feb 2020 18:18:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] add: use advice API to display hints
References: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
        <pull.508.v3.git.1580346702203.gitgitgadget@gmail.com>
        <xmqqimksbo73.fsf@gitster-ct.c.googlers.com>
        <CACg5j27pTKuhZpZtgNUDNEkhG0+tGx5O=LJCr5E8+2q8v6Zu1w@mail.gmail.com>
        <xmqq7e10hgwn.fsf@gitster-ct.c.googlers.com>
        <CACg5j252=wKyh7Ar9vxTwxdYXgkjNvbMA=bJCKOc6UZRJfJmUg@mail.gmail.com>
        <xmqqy2tgfzk1.fsf@gitster-ct.c.googlers.com>
        <CACg5j25YpyRbxmYccZZiG9m5a0DKm0RMD3ypy2JzhA-bmgB_9w@mail.gmail.com>
Date:   Wed, 05 Feb 2020 15:18:56 -0800
In-Reply-To: <CACg5j25YpyRbxmYccZZiG9m5a0DKm0RMD3ypy2JzhA-bmgB_9w@mail.gmail.com>
        (Heba Waly's message of "Thu, 6 Feb 2020 12:05:03 +1300")
Message-ID: <xmqqtv44fwrj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E31865C0-486D-11EA-9A5C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> On Thu, Feb 6, 2020 at 11:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Heba Waly <heba.waly@gmail.com> writes:
>>
>> > No, I agreed with my mentors to wait on this update until that branch
>> > is merged in master.
>>
>> The users will first has to set advise.addnothing and then later has
>> to set something different if you do so, no?
>>
>
> You're right, I missed that point, will send an update based on the
> pickup branch shortly.

Thanks.  

I'll keep the topic in 'next' while letting some handful of other
topics graduate to 'master' in today's integration cycle.  Hopefully
it can join 'master' shortly.\

