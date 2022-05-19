Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE3C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 21:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiESVlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 17:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiESVlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 17:41:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CE3FDBE
        for <git@vger.kernel.org>; Thu, 19 May 2022 14:41:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AEA611CBD0;
        Thu, 19 May 2022 17:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jUCBJbTN20TE
        piX2uEo8EnwdhdaVV6+sgBWbYrGPszg=; b=DZRTapDpGBI9zt0YUS1SuUoBF/7j
        eEaONqBYsfojJWgmZG0BTmaIOdHUMkGhgOZDVznPUGeOE9eLrMfsCozwUVW2pItz
        DDA+6gubMv49oxGbfjg9fuCexA0ik5aDgjKYX5VQ1m5IoOuPyJgEPmjWyZp7TNXZ
        Lmd5L3G5H/unWpk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32D1111CBCF;
        Thu, 19 May 2022 17:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 938CE11CBCE;
        Thu, 19 May 2022 17:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ab/env-array
References: <xmqq5ym4zpmn.fsf@gitster.g>
        <220519.86sfp52u91.gmgdl@evledraar.gmail.com>
Date:   Thu, 19 May 2022 14:41:12 -0700
In-Reply-To: <220519.86sfp52u91.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 19 May 2022 21:28:58 +0200")
Message-ID: <xmqqzgjdkxon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67C1ECEE-D7BC-11EC-A2A6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, May 16 2022, Junio C Hamano wrote:
>
>> * ab/env-array (2022-04-06) 3 commits
>>  - run-command API users: use "env" not "env_array" in comments & name=
s
>>  - run-command API: rename "env_array" to "env"
>>  - cocci: add a rename of "struct child_process"'s "env_array" to "env=
"
>>
>>  Rename .env_array member to .env in the child_process structure.
>>
>>  On hold.
>>  source: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
>
> I'm not sure if the "on hold" status is wanted here, or a holdover from
> around the release time (per
> https://lore.kernel.org/git/?q=3Dab%2Fenv-array); but in this case I th=
ink
> it would be very nice if we could advance this sooner than later.
>
> I'm aware of a couple of topics that would semantically conflict with i=
t
> if re-submitted (IIRC the rest of submodule-in-C is one). So if we're
> going to do the s/env_array/env/g at all it seems better to do it soone=
r
> than later.

I do not think the run_command.cocci should remain in the tree at
the end of this topic, as anybody who uses .env_array will be broken
at compile time, so the only effect it adds is to make it take more
time run "make coccicheck" for no good reason.  Anything it would
catch we can find with "make" a lot faster.  It may serve as a
dormant mine to surprise future developer who may want to add
.env_array member for other reasons, too ;-)

Instead of renaming .pending.cocci to .cocci I think the file should
be removed, no?

Other than that, I think this can go in any time, before or after
the topics that add more mention of the .env_array member that are
in-flight.  The rename done in this topic felt somewhat irritating
while merging them, but the conflicts have been manageable.

