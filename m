Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BA3C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiCJSDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiCJSDc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:03:32 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AB044774
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:02:24 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B0F9D181955;
        Thu, 10 Mar 2022 13:02:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+DRgIwco7gjj
        F+37c6nwsKU51ENaUhTTPDzw4gUvx4U=; b=iieeV+mLWHvMYKbpBkLBHKipScb/
        RR7lCbbOP70q39Ac/a33gol3U8kyGuYVRAxuE7+UsAuGpdj46WtckzzlJddgyoRW
        y13RagcQxgGxfHVj4tyseqyOcBrdfBhZwMddqbwQdU/FN6LQf0Ww2U70IzRKrh47
        zkAVFNuplX3fBVE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A8EFD181954;
        Thu, 10 Mar 2022 13:02:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D76E0181950;
        Thu, 10 Mar 2022 13:02:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 3/4] terminal: work around macos poll() bug
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220309110325.36917-1-phillip.wood123@gmail.com>
        <20220309110325.36917-4-phillip.wood123@gmail.com>
        <220310.86v8wmj5c8.gmgdl@evledraar.gmail.com>
        <45b98ac0-4d33-ee9a-e7f2-3e8137fa8a1a@gmail.com>
Date:   Thu, 10 Mar 2022 10:02:19 -0800
In-Reply-To: <45b98ac0-4d33-ee9a-e7f2-3e8137fa8a1a@gmail.com> (Phillip Wood's
        message of "Thu, 10 Mar 2022 16:02:43 +0000")
Message-ID: <xmqqh785fzys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B20AF06-A09C-11EC-931F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi =C3=86var
>
> On 10/03/2022 13:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]
>>>   +/*
>>> + * On macos it is not possible to use poll() with a terminal so use =
select
>>> + * instead.
>>> + */
>>> +#include <sys/select.h>
>> I don't think this breaks anything in practice due to the platforms
>> we
>> define HAVE_DEV_TTY and NO_SYS_SELECT_H on, but it does look redundant=
 &
>> confusing, and will break if the current users of HAVE_DEV_TTY and
>> NO_SYS_SELECT_H change.
>> I.e. isn't sys/select.h already pulled in by the relevant include in
>> git-compat-util.h? Why is it needed again here?
>
> I didn't realize that git-compat-util.h already included that header,
> I'll remove it.

Thanks, both.  The removal of that line is very much appreciated.
