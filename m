Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CAC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC3860C3D
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhBQS5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:57:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62466 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBQS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:57:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34141B0009;
        Wed, 17 Feb 2021 13:56:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wT3n3VMzyH4w
        m24Cx+T4wU6Qdz4=; b=tg8MwSlGLyV/kw4cwL7w/y13kkyBOdFp1o8QeEz0mUiK
        SCP/HUW+Z4f50RfEJeGqlwg4i/uBaKXzdxajI0n6L0hec1hWaYo9LXJvnjEHErHT
        kFx7pUkbDrH5n4CbCSX84iMSxaMuHcxayZVeH72secBKR3WF4RvzlB3a5rYahUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CVYTU6
        7ISt2dSedA1cZ9SMGuht5JNgChL829Irf/MlhD6Q05IpyH4PaMlXPV3TAYboxpGW
        +60FQqQw6cqVXH0+kwdHHZ/27s+z/aWu9egCdPMETrihwrzGcCutZ4Toi8jWs2nm
        djYp1JTGFS57jnpyMnazyFIZIKIgrg3Ozc8Z8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A2B4B0008;
        Wed, 17 Feb 2021 13:56:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A965B0006;
        Wed, 17 Feb 2021 13:56:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
        <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
        <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
        <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
        <YCz6oDZCAODPS8sY@generichostname>
        <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
Date:   Wed, 17 Feb 2021 10:56:29 -0800
In-Reply-To: <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 17 Feb 2021 19:40:23 +0800")
Message-ID: <xmqqo8gile02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D8AE244A-7151-11EB-BFE6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Denton Liu <liu.denton@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:14=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi ZheNing,
>>
>> On Wed, Feb 17, 2021 at 12:12:10PM +0800, ZheNing Hu wrote:
>> > Oh, I am sorry.
>> > Then I only need to squash the two commit, right?
>>
>> I've never used GGG before but I suspect that in your GitHub PR, you
>> need to set the PR base to 'master' instead of 'jc/diffcore-rotate'.
>>
>> CCing the creator of GGG, please correct me if I'm wrong.
>>
>> -Denton

> Hi Denton Liu,
> You mean I should cherry-pick Junio's patch to my topic branch, right?

Thanks, Denton, for helping.

ZheNing, the end result we want to see on the list is just a single
patch, your 2/2 alone, that says "this patch depends on the
diffcore-rotate topic" _under_ its "---" three-dash lines (where
"meta" comments on the patch to explain how it fits the rest of the
world, etc.).  As a single patch "topic", there won't be even 1/1
marking, i.e. something like:

    Subject: [PATCH v6] difftool.c: learn a new way start at specified fi=
le
    From: ZheNing Hu <adlternative@gmail.com>

    `git difftool` only allow us to ...
    ...
    Teach the command an option '--skip-to=3D<path>' to allow the
    user to say that diffs for earlier paths are not interesting
    (because they were already seen in an earlier session) and
    start this session with the named path.

    Signed-off-by: ZheNing Hu <adlternative@gmail.com>
    ---

     * An earlier round tried to implement the skipping all in the
       GIT_EXTERNAL_DIFF, but this round takes advantage of the new
       "diff --skip-to=3D<path>" feature implemented by gitster
       (therefore, the patch depends on that topic).

     Documentation/git-difftool.txt | 10 ++++++++++
     t/t7800-difftool.sh            | 30 ++++++++++++++++++++++++++++++
     2 files changed, 40 insertions(+)

    ... patch here ...


I do not know how to achieve that end result with GGG and I do not
know if GGG allows its users to do so easily, though.

Thanks.
