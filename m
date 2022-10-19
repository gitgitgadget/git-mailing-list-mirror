Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29AC43219
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJSSAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiJSSA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 14:00:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24618C42F
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 11:00:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78E9B1AC8B8;
        Wed, 19 Oct 2022 14:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gcj43MOJ48CGCa5ICyLkeo66/Z4ott+L/RBbCi
        8Jjc0=; b=krXvxcrRwiBcLASUfuzqrQAZkGva1HoYD9u/ZfFvIN46rsiB1TJZp5
        QyO550IujGL56QVIEF91fBluna7Y4axSdZvw55rDKCBjxWYE5TmrFBTE0Kbhjqtk
        qByASDkGB3FKS3MpGv5WNglE+LfJqcV2srdkEa1BkUyTDoQdhJfSQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 719EC1AC8B7;
        Wed, 19 Oct 2022 14:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3DA01AC8B2;
        Wed, 19 Oct 2022 14:00:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
        <xmqq4jw1wl6z.fsf@gitster.g>
        <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
        <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
        <xmqq7d0vu8cw.fsf@gitster.g>
        <Y1AujKKPUJFepph5@coredump.intra.peff.net>
Date:   Wed, 19 Oct 2022 11:00:22 -0700
In-Reply-To: <Y1AujKKPUJFepph5@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 19 Oct 2022 13:06:20 -0400")
Message-ID: <xmqq7d0vsngp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E761F802-4FD7-11ED-ACD0-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> True. run_command() needs the RUN_* flags twiddling, too, so it is
>> not a point against _l_opt() variant.
>
> Did you mean run_command_v() here? If so, then yes, it requires the
> flags. But if we are going to drop it in favor of just run_command(),
> then those flags go away (and moving to the _l() variant is a step in
> the opposite direction).

Ah, but we'd still need to prepare individual bits in the child
structure (e.g. RUN_GIT_CMD vs .git_cmd) anyway.  Even though we may
not have to work with the flags, somehow we need to set it up.  So
it is not all that strong argument against the _l_opt().

The above assessment is primarily because I do not have too much
against RUN_GIT_CMD and friends, compared to setting the individual
members in the child_process struct.  Setting individual members in
the struct is more direct and it may be an improvement use
run_command() directly over using _v_opt() and _l_opt() variants.

