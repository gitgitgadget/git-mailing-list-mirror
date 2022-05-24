Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD299C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiEXT3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiEXT3S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:29:18 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A926CF61
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:29:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C07F2126873;
        Tue, 24 May 2022 15:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5NXdj9aD4JYd
        La6TIDAHweznNsq0N1JxW+shGf+ESo0=; b=sr08+lQCzb9Dg0iia0KlAr0jHdSh
        QFX24MeLAan7u3UpUBTz23NKoUWBYceTeKa9DrLqiBlXjudSKGlstmN0r3+mMUV/
        coTADgX6jWDgLxAZ0V0DZEaabMFUYGFGgsgLKxtvtztQwMQH3RMDkl8Mfvhz1UQ0
        zMxkGa2OGZGXuOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B71B5126872;
        Tue, 24 May 2022 15:29:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B6EA12686E;
        Tue, 24 May 2022 15:29:15 -0400 (EDT)
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
        <xmqqleuuazew.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241423260.352@tvgsbejvaqbjf.bet>
        <220524.86h75ex01s.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 12:29:13 -0700
In-Reply-To: <220524.86h75ex01s.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 20:11:57 +0200")
Message-ID: <xmqqsfoyhgqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC0909B0-DB97-11EC-BB64-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Both are built by our main build process, and thus should have
> corresponding adjustments in our main test code, just as is already the
> case for both "git" and "test-tool".
>
> But even if that wasn't the case I'd still be of the view that we shoul=
d
> add "scalar" to that list.
>
> It's just a matter of potential time sinks in the future. If we
> introduce a hidden segfault in the scalar code and don't notice for som=
e
> time because we're using that test pattern that's going to suck, and
> likely to waste a lot of time. We might even ship a broken command to
> users.
>
> Whereas having "scalar" on that list is going to be a relatively easy
> matter of grepping and doing some boilerplate changes if and when we
> ever "git rm" it entirely, or "promote it" from contrib or whatever.

In addition, it already is an actual time sink that causes us send a
lot more bytes back and forth than the number of bytes necessary to
send a reroll that adds one liner to the same step.

> I also think that just getting rid of that whitelist entirely is an
> acceptable solution. Perhaps it's just being overzealous in forbidding
> everything except "git", we should still not use it for the likes of
> "grep", but we could just leave that to the documentation.

It indeed is tempting entry into a slippery slope, and I'd see it as
a change bigger than we could comfortably make as a "while at it"
change.

We can stop arguing and instead send in a reroll that squashes in
something like this, which shouldn't be controversial, I would say.

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/t/test-lib-functions.sh w/t/test-lib-functions.sh
index 93c03380d4..8899eaabed 100644
--- i/t/test-lib-functions.sh
+++ w/t/test-lib-functions.sh
@@ -1106,7 +1106,7 @@ test_must_fail_acceptable () {
 	fi
=20
 	case "$1" in
-	git|__git*|test-tool|test_terminal)
+	git|__git*|scalar|test-tool|test_terminal)
 		return 0
 		;;
 	*)



