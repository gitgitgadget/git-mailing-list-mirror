Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA1DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EF8610A8
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhJFS31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:29:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52860 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhJFS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 14:29:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D6B116AB7C;
        Wed,  6 Oct 2021 14:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D4/tlB8AveBD
        OC4EEaxsJa65sI1ZpHwe0qRGy3xWeC8=; b=x0ZRYhuvWXdiu3HEqDCNEc7Zvy+0
        uOFEsOkLOxiDqX4YnN3V24xfdTq+zXjSPIYvFfH52vGgAGwJxMujfY27+vMT9/JH
        OGJuM3NtCWDrLUeXbUxR+qgEVCrrxwGT8y9mOuACeXP14JcWvUxNeOmgK0p12fnC
        BthDixAZuPXbKpQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35F0D16AB7B;
        Wed,  6 Oct 2021 14:27:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9904816AB7A;
        Wed,  6 Oct 2021 14:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
        <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
        <xmqqk0iqrp4q.fsf@gitster.g>
Date:   Wed, 06 Oct 2021 11:27:28 -0700
In-Reply-To: <xmqqk0iqrp4q.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Oct 2021 11:20:53 -0700")
Message-ID: <xmqqfsterotr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1061628A-26D3-11EC-AF87-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>> I had the impression that I addressed all outstanding comments (but
>> not sure). Are you waiting for me to do something before this can go
>> into 'seen' ?
>>
>> There is a merge conflict against master, so I'll send a v4 shortly.
>
> Sorry.  I seem to have looked at and commented on the precursor RFC
> of this topic, but nobody other than =C3=86var seems to have commented =
on
> the second iteration and the topic was completely under my radar,
> and I do not remember what it was about.
>
> It would be good to have an update for others to see.
>
> Thanks.

Not really.  I think the comment on the RFC still stands, and I do
not recall seeing a response to the point.

    One potential harm this change will bring to us is what happens to
    people who disable core.logAllRefUpdates manually after using the
    repository for a while.  Their @{4} will point at the same commit no
    matter how many operations are done on the current branch after they
    do so.  I wouldn't mind if "git reflog disable" command is given to
    the users prominently and core.logAllRefUpdates becomes a mere
    implementation detail nobody has to care about---in such a world, we
    could set the configuration and drop the existing reflog records at
    the same time and nobody will be hurt.

    If we keep the current behaviour, what are we harming instead?
    Growth of diskspace usage is an obvious one, but disks are cheaper
    compared to human brainwave cycles cost.

As it is about the basic design of the "feature" (or misfeature), no
matter how improved the internal implementation details get, I am
skeptical how it is solved (other than "immediately when we notice
core.logAllRefUpdates is disabled, remove all the existing reflog
entries to avoid confusion, in addition to stop appending any more
reflog entries", that is).
