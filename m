Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810BDC4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJSQdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiJSQdW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:33:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84418B01
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:33:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C17C21485D2;
        Wed, 19 Oct 2022 12:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hx+QoVJP5uNz
        WvMB4m+h4sFzA8+EXpN4bvltwgG+FTk=; b=b3mBWQ1J8YTNm/2RDPB18zr/nt0N
        qaQv1FgaSw7fQz5IaRmOBNb9PU1Ybt9yu+uLuay98AHf92iVgpqOeQxoF6njCq0r
        nh0TY2jTeWanM9+KpwIyExmx2b5EJZUyp6f5FeOtqLGTEK8Y6VVghTa3YwqR/YWD
        90vQVsHkKPD8qbc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9E081485CF;
        Wed, 19 Oct 2022 12:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C7391485CE;
        Wed, 19 Oct 2022 12:33:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <kl6l7d0yyu6r.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqo7u9wyt7.fsf@gitster.g>
        <221019.86fsfkhb14.gmgdl@evledraar.gmail.com>
Date:   Wed, 19 Oct 2022 09:33:19 -0700
In-Reply-To: <221019.86fsfkhb14.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Oct 2022 03:04:41 +0200")
Message-ID: <xmqqk04vsrhs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BDF0D828-4FCB-11ED-A125-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Oct 17 2022, Junio C Hamano wrote:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> At $DAYJOB, we observed that this topic breaks MacOS builds with sha1=
dc:
>>
>> Thanks for a report.
>>
>> How dissapointing.  The thing is that the topic has been in 'next'
>> since the 11th (i.e. early last week), and I know that you guys rely
>> on the tip of 'next' in working order to cut your internal releases,
>> but we did not hear about this until now.  What makes it taste even
>> worse is that nobody else caught this, even though we seem to have a
>> couple of macOS jobs at GitHub Actions CI, there we didn't see any
>> breakage related to this.
>
> FWIW I see you caught it on the 9th in
> https://lore.kernel.org/git/xmqqh70c62w0.fsf@gitster.g/, but then the
> base topic was merged down on the 17th.

Heh, I already forgot I made that comment myself ;-) Thanks for
reminding, and thanks for picking the single step to fast-track the
fix.
