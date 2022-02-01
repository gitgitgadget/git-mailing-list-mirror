Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB49C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 05:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiBAFdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 00:33:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51304 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiBAFds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 00:33:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E8AD124BE2;
        Tue,  1 Feb 2022 00:33:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HP3LhiFhiji04cnkh/TMf2z5Udza1FBWeFz3tv
        xyGtI=; b=oaKrNsPukPeaymT4V77PDQqSETPVoswuA4PfLM2xANTtJ+OpB8M76F
        y6r4vJoawWY2k7hXP816+KrRT5wmE9C3w31CGd901DSJfBRGNsmzq3DbZZOkpKF9
        fyo+lVI8Dido/yqRF/WhE/ut68HCExc89YVXgVG5lslh/yLeEzcvI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51FA3124BE1;
        Tue,  1 Feb 2022 00:33:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4929124BDE;
        Tue,  1 Feb 2022 00:33:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>, christian.couder@gmail.com
Subject: Re: [GSoC] Add =?utf-8?Q?=E2=80=93no-sort?= option for
 git-for-each-ref
References: <CAJyCBOQDBMcowKZgMp2iCbWpaMJGxNH9EtbQ8e0zB67k1g9uYg@mail.gmail.com>
        <CAJyCBOTpmKCHaYEvNc1-r_Rs2OWMsyCO7P6iSeM78QcjjcPuHQ@mail.gmail.com>
Date:   Mon, 31 Jan 2022 21:33:45 -0800
In-Reply-To: <CAJyCBOTpmKCHaYEvNc1-r_Rs2OWMsyCO7P6iSeM78QcjjcPuHQ@mail.gmail.com>
        (Shaoxuan Yuan's message of "Tue, 1 Feb 2022 11:23:17 +0800")
Message-ID: <xmqqzgnbf8w6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86E44036-8320-11EC-A0AA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> On Tue, Jan 25, 2022 at 5:59 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>>
>> Hi git community,
>>
>> I'm considering if this microproject
>> [https://git.github.io/Outreachy-23-Microprojects/#add-no-sort-option-for-git-for-each-ref]
>>  is a good option for now. I want to spend some time on it and see if
>> I can come up with something.

I am fairly negative on that entry in the micro-project list (no, it
is not your fault), because

 (1) the one that is described there is fairly useless and I do not
     think we want to take in my tree at all.

 (2) a variant that is any useful would be a bit too large for a
     micro-project

As the explanatory text there says, the code should be able to
figure out when it does not need to make an extra ref_array_sort()
call, without being told by the user.

A smaller and more appropriate "add --no-sort and when it is given,
skip the call to ref_array_sort()" is much easier to do, but it is
very much useless.

If we were to spend any project resources (both developer's time and
reviewers' time), I'd rather not to see such an option added---once
we add a feature, we'd have to maintain it.  Rather, it would be
much better use of our time to do "automatically figure out when we
do not have to sort", and with that feature, nobody needs to use the
"--no-sort" option at all.

Such an "automatically skip the call to ref_array_sort()" would be
doable by a developer who may be relatively unfamiliar with our
codebase, but is still a bit too large for a micro-project, which I
expect anybody to be able to code during a lunch break and spend
more time on review exchanges on the list.
