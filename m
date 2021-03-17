Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96409C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A4264F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhCQTRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:17:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55262 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCQTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:17:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A7ACA8FC7;
        Wed, 17 Mar 2021 15:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E5tVriGAagch
        ihv3eMQAj0s8I/M=; b=f8+Q6NYiWSH9m577ME+1DLioxOZJrq97kxvKeFvGsR2v
        yiScvEPy10P1O+EnPlCg4wKRrbSlc6aKWs9xhkRSu388cFRSFm4njBw500nRk/W0
        4B5A7FDC180J0DPyS7GjVbyhvcg+vpNPezpgFiM6jwjORNQuFqhv3Y9yfegipxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=l0CHge
        EgBtN2n/mF/LGBh+WBbLiPCQGhuJ2QgDH0hbqS5edizhzwIM8bZ9xiCIExckGSNg
        dbZWUyiSg1b9Ey1vXfNLG//8vHh+gX+onsl7wktYEksedRtfTpb4od+71B5Gvu6x
        aLiWxMStQfhysMOi5iwo9cmXHMYB5ef2ZgTaM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3080CA8FC5;
        Wed, 17 Mar 2021 15:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99C4AA8FC4;
        Wed, 17 Mar 2021 15:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] format-patch: allow a non-integral version numbers
References: <pull.885.git.1614269753194.gitgitgadget@gmail.com>
        <xmqqzgzsuibf.fsf@gitster.g> <YFHsHg/R9la3IwEv@danh.dev>
Date:   Wed, 17 Mar 2021 12:17:28 -0700
In-Reply-To: <YFHsHg/R9la3IwEv@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Wed, 17 Mar 2021 18:46:38 +0700")
Message-ID: <xmqq1rcdvbcn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AAB25D2-8755-11EB-AA07-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> If we were to do this, I would probably suggest a preliminary patch
>> that refactors the hardcoded "reroll_count - 1" out of diff_title()
>> so that the helper takes two "reroll count strings", i.e. reroll
>> count for this round, and the previous round, as two separate
>> parameters.  Teach the caller to pass "reroll_count - 1" for the new
>> parameter in this preliminary step.
>
> However, if it's only a minor correction to the major version,
> I _think_ it makes better sense to compare with the major version
> instead of comparing with another minor version.

I wanted to have no opinion on this, as what is expected out of the
fractional iteration count by people would be different depending on
whom you ask.  The "-1" suggestion was a fallback to allow those who
supply integral reroll count not to explicitly say what the previous
round was from the command line.  I do not particularly care how the
previous round for fractional iteration count were computed by default
when the user did not give one explicitly from the command line.

> When a reviewer reviews v3.5, they can just compare to v3.
> In a hypothetical world, when another reviewer jump in and a major
> change required, v4 reroll also compare with v3.
>
> In other words, we will have something likes:
>
>  - v3   vs v2
>  - v3.1 vs v3
>  - v3.2 vs v3
>  ....
>  - v4   vs v3
>
> The good side of this approach is: the logic to choose previous
> version is simple.
>
> The downside of this approach is: reviewers need to re-read the
> changes in v3.1 v3.2, etc... However, we can reasonably expect those
> changes are small enough, they're minor changes after all.
>
> And they will need to re-read all the change if the major verison was
> increased.
