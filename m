Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC037C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 17:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiBQRc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 12:32:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbiBQRc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 12:32:26 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E916040B
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 09:32:11 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36FFD1778C6;
        Thu, 17 Feb 2022 12:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FqkZF1p6CaDU
        +pjOKzw1gG3kgyzZZXltfaExd0O0O/E=; b=EpTc4tusmSBjf8JhFMcHlJGqF/3S
        dYx91mHj/g1OZ7M7zZ9+X0byWyf3mQhjksH/fhk1Jx+5y65l0duhyJWtWAri78W9
        9zCiUlwHYAZ8l64E7zbncM6JpgYvP3Hn3aqtNrIzVdmBCPIgYvHp+EhGisPP8MT9
        U/Ib9pqLW5xMJyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FCA91778C5;
        Thu, 17 Feb 2022 12:32:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CD3D1778C2;
        Thu, 17 Feb 2022 12:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        "Git ML" <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
References: <20220209012951.GA7@abe733c6e288>
        <20220209013354.GB7@abe733c6e288>
        <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
        <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
        <220216.86leybszht.gmgdl@evledraar.gmail.com>
        <20220217012847.GA8@e5e602f6ad40>
        <220217.86ee41izpq.gmgdl@evledraar.gmail.com>
Date:   Thu, 17 Feb 2022 09:32:05 -0800
In-Reply-To: <220217.86ee41izpq.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 17 Feb 2022 10:29:23 +0100")
Message-ID: <xmqqfsohbdre.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 870A77FC-9017-11EC-A78E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> ...
> If it's XDL_BUG() the primary project (git.git) needs to carry the
> XDL_BUG() -> BUG() shim along with libgit2's XDL_BUG() ->
> GIT_ASSERT(msg) .
>
> If it's just BUG() we don't need the shim in git.git, but you'll need a
> BUG() -> GIT_ASSERT(msg).
>
> I don't see the benefit of requiring two shims instead of one, both in
> terms of code, and the readability of the codebase in git.git
> (i.e. grepping for "git grep -w BUG" or whatever, then remembering it's
> prefixing everything...).

Renaming symbols with preprocessor macro "#define"s, without forcing
people to change the names they have used in the code and have to
write in the future, sounds like a sensible direction to go in.

Thanks. =20
