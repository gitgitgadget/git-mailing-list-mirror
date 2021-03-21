Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEFC433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921FB6193A
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCUQwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:52:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60782 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCUQwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:52:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3B2111A4AE;
        Sun, 21 Mar 2021 12:52:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pvmffCwp+bqjmfB+XRrUI3clQfk=; b=l5xfNY
        leBQhjEd+JcBcdCE1Hm5BG+ANlr0KQVmRLotrlkGTY1pg93KKWDIfUHFJqJnddif
        eA4LoJlmXPgrGCIM8gEE28j/dmPTBuFtWWZnj2M+ClPyqSwUG11f0MR/z99on+8p
        q2J2vm7gGr8o5ALUGKvg24VJ4a59JXWYKIq3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m+DYDttlIPCCcZ8fEdf+m8boN6ANJ4gc
        yGUJ5nvjyt5KZDl+l3NKNmkTVI0uy8647lhcH7OUdnyUSSOuaIc6GieZZmAI6JSV
        ZCJEZ6JV2k0r4nhzHhK4Fc8c6T67rx5rTathWKJ+0AUeTzC1njPhQmL6FlhdmTxg
        3F5knEwTlQs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BC6111A4AD;
        Sun, 21 Mar 2021 12:52:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FE4C11A4AB;
        Sun, 21 Mar 2021 12:52:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
        <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
        <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
Date:   Sun, 21 Mar 2021 09:52:30 -0700
In-Reply-To: <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
        (Christian Couder's message of "Sun, 21 Mar 2021 14:15:11 +0100")
Message-ID: <xmqqwnu0bga9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D47A9D22-8A65-11EB-ADE6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> "Signed-off-by:C O <Mister@email.com>" is often too
>> verbose and error-prone.
>
> The 'trailer.<token>.command' config option can already be used to
> help with that, for example:
>
> -------
> $ git config trailer.sign.key "Signed-off-by: "
> $ git config trailer.sign.ifexists replace
> $ git config trailer.sign.command "git log --author='\$ARG' -1
> --format='format:%aN <%aE>'"
> $ git interpret-trailers --trailer sign=Linus<<EOF
> subject
>
> body
> EOF
> subject
>
> body
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> -------
>
> So even without this patch, after your first patch that implements
> `git commit --trailer ...`, it should be easy to setup something less
> verbose and less error-prone.

It is nice that it makes the complexity of 2/2 unnecessary ;-)
