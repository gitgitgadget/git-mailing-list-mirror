Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05014C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbiASBJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:09:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54511 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiASBJN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:09:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D34A317FC9B;
        Tue, 18 Jan 2022 20:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WVaY2DpPTcB3
        dnfl0U4VrxdZ6HcJIzgx7Dxw3Pvwo30=; b=vomH+ibNTTi3W9AAkQaZDfz1zRIM
        oFrOqkgaBfnrRaf69sQuuFXB3s5LFxKuX6Z7aaZeIkdDLTwZ2pt1GAzkVItR6sqD
        wmJXT55KGVhuiwEcTigvhOkehqLyyATGCjlofHc6DeSHoJLp/dfgbkhULK+ylWD9
        4vnL7Xy31HYGDtM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBE2317FC9A;
        Tue, 18 Jan 2022 20:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 452E617FC97;
        Tue, 18 Jan 2022 20:09:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v8 09/10] grep: simplify config parsing and option parsing
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
        <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
        <xmqq8rvcr73v.fsf@gitster.g>
        <220119.86wniwo9mz.gmgdl@evledraar.gmail.com>
Date:   Tue, 18 Jan 2022 17:09:09 -0800
In-Reply-To: <220119.86wniwo9mz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Jan 2022 01:17:28 +0100")
Message-ID: <xmqq35lkpm4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6873EDE2-78C4-11EC-B404-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> If we had a grep IPC call of some sort we'd surely limit it to the
> "modern" config of grep.patternType, and take the opportunity to
> deprecate grep.extendedRegexp from that interface.

A process that visits more than one repositories, with different
configuration, does not have such a choice.  As far as I tell, there
is not yet a way to undo the static in the code after these patches
so that such a process can reset between repositories.

A member that is necessary only during configuration parsing is not
a problem as long as the field is marked clearly as such (I wouldn't
even call that "not a NEW problem", since it is not a problem to
begin with, and I am sure there are more examples in other
subsystems).  A static inside a helper function that has subtle
interactions with second and subsequent invocations makes the code
much harder to follow, on the other hand.
