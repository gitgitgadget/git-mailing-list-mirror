Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D45C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiBPQzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:55:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiBPQzp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 11:55:45 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DAA29410B
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 08:55:33 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 720F01038DF;
        Wed, 16 Feb 2022 11:55:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L+3jy9P0eZjy
        Qwg9a6nK1lPNnKm/noAaRPsRJa5D1ek=; b=UO4VZ1YdTCg9lNtELs78CWoTJfNQ
        4teMF1zEXCDowiKnRbTXdP9wEx79u5xbAVHMUqYbGlFI5YxMoSNUkljVCOZHorv+
        cQuawgZ4YuYxl3G8Xub42giDKd8W6qYWHr0SQ7AuwbizNVCmEknIjCOHY9iLMGXM
        k09LZT+BwJfhmDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67ACD1038DE;
        Wed, 16 Feb 2022 11:55:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A83461038DD;
        Wed, 16 Feb 2022 11:55:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 1/4] xdiff: fix a memory leak
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
        <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
        <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
        <10c8dfa8-ab98-4a46-8baa-97857bb914b0@gmail.com>
        <220216.86h78yuar0.gmgdl@evledraar.gmail.com>
Date:   Wed, 16 Feb 2022 08:55:30 -0800
In-Reply-To: <220216.86h78yuar0.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 16 Feb 2022 15:38:08 +0100")
Message-ID: <xmqq7d9uvji5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4060109C-8F49-11EC-A19A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> They are not dealing with it because they do not initialize it - it is
>> an "out" parameter that is used to return data to the caller. This
>> patch changes the logic to "whoever initializes it is responsible for
>> freeing it if there is an error". By doing that we localize the error
>> handling to xdl_do_diff() and can leave the callers unchanged.
>
> Yes, I'm saying that we're needlessly piling on complexity by continuin=
g
> with this pattern in the xdiff/ codebase. I think it's fair to question
> the direction in general.

It is perfectly OK to question, but I'd prefer to see local
consistency.

Thanks.


