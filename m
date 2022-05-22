Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E28DC433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 05:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiEVFvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 01:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbiEVFu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 01:50:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CE8281
        for <git@vger.kernel.org>; Sat, 21 May 2022 22:50:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A82CA1A63D6;
        Sun, 22 May 2022 01:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nHEjlFcYexqz
        N6Ilqe42wcUuFG0kDOMUXMW2hPddY80=; b=aJV36iD/sHO8V/i+K62MiFd7+Zrp
        Bv7JG7TSN0bcY1eQlqqAN4pYV+UfhsRoFfk8gx1+A2Rr0gkX/u4XO3jIAskc0tVw
        44VRwe943EBygHCl5gvE1ewjxLh+geM5KMHwoBDzIIJFRbNCBiSfnCbSrDzrkBi0
        DPFnih/TV+lnjTo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A09201A63D5;
        Sun, 22 May 2022 01:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5103C1A63D4;
        Sun, 22 May 2022 01:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 3/7] scalar: validate the optional enlistment argument
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <da9f52a82406ffc909e9c5f2b6b5e77818d972c0.1652210824.git.gitgitgadget@gmail.com>
        <220517.867d6k6wjr.gmgdl@evledraar.gmail.com>
        <xmqqbkvuwxps.fsf@gitster.g>
        <220520.86fsl43bkf.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2205201753300.352@tvgsbejvaqbjf.bet>
        <220521.86leuv199g.gmgdl@evledraar.gmail.com>
Date:   Sat, 21 May 2022 22:50:47 -0700
In-Reply-To: <220521.86leuv199g.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 21 May 2022 11:54:42 +0200")
Message-ID: <xmqqleuuazew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21490670-D993-11EC-AEE6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Scalar is not (yet?) a Git command.
>
> "test-tool" isn't "git" either, so I think this argument is a
> non-starter.
>
> As the documentation for "test_must_fail" notes the distinction is
> whether something is "system-supplied". I.e. we're not going to test
> whether "grep" segfaults, but we should test our own code to see if it
> segfaults.
>
> The scalar code is code we ship and test, so we should use the helper
> that doesn't hide a segfault.
>
> I don't understand why you wouldn't think that's the obvious fix here,
> adding "scalar" to that whitelist is a one-line fix, and clearly yields
> a more useful end result than a test silently hiding segfaults.

FWIW, I don't, either.

