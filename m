Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C8FC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 09:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936EC2076A
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 09:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439472AbgLNJDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 04:03:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62649 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgLNJDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 04:03:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4E0EA591A;
        Mon, 14 Dec 2020 04:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         s=sasl; bh=GO3+wDqh3yf56uxI3Adb3McPE+I=; b=wVEsnTwtHwBOS7AjibWQ
        Ur9JuomjHDQ+AT9tLDDHbPAlciJMIgwgE+SlE+vn8yexA5n5utRooz+Vr/GZl81Z
        Qkz42aao+Jnk6RLYH+DBzbH9a/IHKxPDf37NPtyBXr2i//n4vbPnnNBQqAeElS98
        tEX6Uy5sI82pfz0YUHosDxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:references:message-id:mime-version:content-type;
         q=dns; s=sasl; b=iEhteXckkjJpKIxmd8IO8s8yN/+VrcBE+NCkGX11FrDOX1
        GGmKgvDIiML2Ob+p0UwzsLuLhtbLGee+K+fggGVuRvilbCHXut1jbYZZ2rkXa4/P
        cou2mtbLO6DaQBUQeMbeftgubYRy5ki18jJx6nYCCefu/u1rDIzRUxoadAN+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D832A5919;
        Mon, 14 Dec 2020 04:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BDC7A5918;
        Mon, 14 Dec 2020 04:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
Date:   Sun, 13 Dec 2020 12:58:41 -0800
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-3-felipe.contreras@gmail.com>
        <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
        <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
        <xmqq360bj3kt.fsf@gitster.c.googlers.com>
        <CAMP44s1v+ESk9y8WC8rKPb61KD_kUoM9F1gO-TZhEEgOzUAPTw@mail.gmail.com>
Message-ID: <xmqqpn3cep51.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24FAE242-3DEB-11EB-8598-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Dec 11, 2020 at 6:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> > Should actually be something like:
>> >
>> >         if (rebase_unspecified && !can_ff)
>> >                 die("Not a fast-forward; must either merge or rebase");
>>
>> The illustration I gave in the message you are responding to was
>> made in the context of patch 2/3; with patch 3/3 where can_ff
>> exists, it would not become like what you gave above.  It should
>> instead become
>>
>>         if (rebase_unspecified && !opt_ff && !can_ff) {
>>                 if (opt_verbosity >= 0 && advice_pull_non_ff)
>>                         show_advice_pull_non_ff();
>>                 die("not a fast-forward; must merge or rebase");
>>         }
>>
>> i.e. when we can fast-forward, we do not trigger the "you must
>> specify rebase/merge" message, and we do not trigger the "not a
>> fast-forward" error.
>
> It's not the !can_ff part I'm trying to highlight, it's the lack of
> advice *after* we have decided to flip the switch.
>
> As I said in another thread: I don't think we have any long
> condescending error in any other command.

Only the "not a fast-forward and you must choose between merge and
rebase" part (i.e. what I listed as the first part of three-part
message) is the error.

The rest, the message that teaches how to choose between merge and
rebase from command line and configuration (or how to choose
permanently not to make the choice between the two), is not an
error---it's called advice.

Even if we were to introduce the third choice (i.e. permanently not
to choose between rebase or merge and instead just error out without
getting advice), the advice must stay for those who didn't make any
choice among the three (i.e. merge, rebase or ff-only).

We have many of them.  An easy example to spot is a similar sized
onefor "git checkout HEAD^0".  Neither that one or the one under
discussion is particularly condescending.
