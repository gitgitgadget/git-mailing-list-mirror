Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C00C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B460EE9
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 17:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhHDRbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 13:31:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65511 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhHDRbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 13:31:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A42E16A8;
        Wed,  4 Aug 2021 13:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lEfWE9fDo5DNa89DqbbFc8c2of5RTpBD+dssqM
        Mc+v0=; b=R8qVpHMCFIDHjChaGKvQ35yQpChKx+cXwzeaewCGUxS7ar/EQJCnFT
        JTHQugyb99WkT1qyiUnP3OA/odfUUJndW+M5JrDGRGyR//OsBFBpMiku46gmvRTi
        MzY2W76rG4ifNK6v8U572wRvgx3XUhocAtlMZolVjx0k7b50ZAI/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50378E16A7;
        Wed,  4 Aug 2021 13:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CBA54E16A6;
        Wed,  4 Aug 2021 13:31:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
        <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
        <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
        <xmqqa6lytat9.fsf@gitster.g>
        <CAOLTT8SkbNMcVocU9Lg3PfqTGHVEX8y27BMcP55HytfWH60w6g@mail.gmail.com>
        <2e3e8379-99e3-521b-1666-30fcf0e7909b@gmail.com>
Date:   Wed, 04 Aug 2021 10:31:20 -0700
In-Reply-To: <2e3e8379-99e3-521b-1666-30fcf0e7909b@gmail.com> (Phillip Wood's
        message of "Wed, 4 Aug 2021 11:10:11 +0100")
Message-ID: <xmqqsfzpp15j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8667F02-F549-11EB-B4C8-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> You mean that cherry_pick with GIT_CHERRY_PICK_HELP suppresses
>> CHERRY_PICK_HEAD is not even a bug?

I think that it is what the existing test is telling us.  Of course,
with a good reason, an earlier design can be updated as long as we
make sure we won't hurt existing users who may rely on the current
design, but ...

> Looking at the history I think it is fair to conclude that
> GIT_CHERRY_PICK_HELP was introduced as a way to help people writing 
> scripts built on top of 'git cherry-pick' like 'git rebase' that want
> to have a custom message and do not want to leave CHERRY_PICK_HEAD
> around if there are conflicts. I don't think it was intended as a way
> for users to change the help when cherry-picking and has never been
> documented as such. I think we'd be better to focus on improving the
> default help that cherry-pick prints as the second patch in this
> series does.

... I think that is a reasonable stance to take [*1*].  If the
default help message can be improved, that is a good thing to do
regardless.

Thanks.

[Footnote]

*1* Tying the "here is a custom HELP text" environment variable to
"having a customization means whoever is driving the cherry-pick
machinery is ALSO responsible for sequencing and we will remove
CHERRY_PICK_HEAD" is a rather unfortunate design, but as long as
that is documented, it is a workable design.
