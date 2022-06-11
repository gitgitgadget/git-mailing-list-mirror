Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1603FC433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 19:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiFKTWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 15:22:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28307369FD
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 12:22:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4658124346;
        Sat, 11 Jun 2022 15:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6gskgh8AjiFX
        wM+aDurArUBMJ1pfKAcG9Ok6+ezVyFo=; b=Ousf5ylKCJnpYZXFCZeC0EiJzxom
        +dlLec3adlP5pelXkiqdTrs1BT2L5fL4KMYsoCI6XDT//qUZDk0w9I2EJwHGrwji
        Qh/vo1k5VKPuLoKcg81e7jJhBnjwDRaAk8+qFiGaZJ50qgT085wGf0nueSUq6Wq2
        4bvjWy3Kbkkfyds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB584124344;
        Sat, 11 Jun 2022 15:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D24A124343;
        Sat, 11 Jun 2022 15:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 3/4] rebase: note `preserve` merges may be a pull
 config option
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
        <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
        <xmqq1qw18yk2.fsf@gitster.g>
        <4cac8a13-a075-544e-8c10-e58bbf0dd73d@iee.email>
        <3800fa9c-50b4-2967-2f00-036c1edf5e52@iee.email>
Date:   Sat, 11 Jun 2022 12:22:37 -0700
In-Reply-To: <3800fa9c-50b4-2967-2f00-036c1edf5e52@iee.email> (Philip Oakley's
        message of "Sat, 11 Jun 2022 16:38:20 +0100")
Message-ID: <xmqqh74rattu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DAF679B2-E9BB-11EC-B670-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> small clarification,
>
> On 11/06/2022 15:03, Philip Oakley wrote:
>>> When pull.rebase is parsed, rebase.c::rebase_parse_value() is called
>>> from builtin/pull.c::parse_config_rebase() and would trigger an
>>> error, whether it comes from the pull.rebase or the branch.*.rebase
>>> configuration variable.  An error() message already said that
>>> 'preserve' was removed and 'merges' would be a replacement when it
>>> happened.
>>>
>>> If the user has *not* reached this die() due to a configuration
>>> variable, then there is not much point giving this new message,
>>> either.
>> From my perspective, users should then
>
> That is, when users hit any of the `preserve-merges` error message, ...=
=C2=A0

Yes, but configuration parsing happens way earlier than the actual
use of the option (which is decided after configuration and then
command line is read), so the users would probably have hit the
error message and corrected their configuration before they can even
see this error message, no?

I guess I am repeating myself, so there may be some case where a
stale variable can still be in the user's configuration file and the
user can hit this error message without seeing the other error
message about the stale configuration variable that I am not seeing?

>>  be purging _all_ their `preserve`
>> configurations once they hit such errors. As the v2.34.0 change
>> propagates through the Git ecosystem, hopefully it'll be a sufficient
>> prompt for those who haven't realised that the option can be 'hidden' =
in
>> their configuration options.
