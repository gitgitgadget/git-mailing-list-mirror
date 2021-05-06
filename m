Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139B3C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E600661168
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhEFLVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 07:21:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55329 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhEFLVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 07:21:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2F69C1443;
        Thu,  6 May 2021 07:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TxnhhZ5GoglDh+tUmKQvsRBIG1E12XQDYbNcfO
        kjv/0=; b=mEUdUVRfw8AaPyVioFfkM+tBBXDcsT8LXhCmvkcWnNUWi4ZFWBcCYb
        YqmQdPPle4ojxgKiFo8Gz0bKIZBYIXpAKNwDsQEwmrFx/INvP63GMZZfNTmX1ywu
        i4vxzJa5AcGiKlwzewWhh2rEDdRX+krQgY0nRd28jAlYQnPk76t3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AABE7C1442;
        Thu,  6 May 2021 07:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FC41C1441;
        Thu,  6 May 2021 07:20:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
        <xmqqfsz01vc2.fsf@gitster.g>
        <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
        <xmqqk0oczao3.fsf@gitster.g>
        <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
Date:   Thu, 06 May 2021 20:20:45 +0900
In-Reply-To: <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 6 May 2021 18:39:17 +0800")
Message-ID: <xmqqtungxg4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A4ED1AE-AE5D-11EB-A2C6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> So the fix was to see what atom it is by checking its name member?
>> Is starts_with() a reliable test?  A fictitious atom "pushe" will be
>> different from "push" or "push:<something>", but will still pass
>> that test, so from the point of view of future-proofing the tests,
>> shouldn't it do the same check as the one at the beginning of
>> remote_ref_atom_parser()?
>>
>
> I think it's not necesssary. Before we call `populate_value()`, ...

I do not care if it is not needed with the "current" set of atoms we
accept.  The example "pushe", which obviously will not be accepted
by today's code, was all about future-proofing.
