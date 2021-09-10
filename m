Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CFC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE87261250
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhIJSqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:46:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51353 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhIJSqD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 14:46:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EA1EF6E2D;
        Fri, 10 Sep 2021 14:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PCtFWgFI/AzvTnIXqoYc2HAHNqitjFOJUjvhYp
        IKQhw=; b=KMxf+ftmHX3iiAOOFQSDZ+L162J29k01c4axnTPzy3C7yUP1sMUFIH
        g4e+BXbAeNtKselXq+dBE5xcXSqbX0z3XQNrIBywY76C1TRl7XkJu9k+OigqQ1/2
        +rvy7bjUdVckPxlZdsrcLJBB6c/UOChCsmJiLM9CLkY2gs8zHINJ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 140E3F6E2C;
        Fri, 10 Sep 2021 14:44:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67B8EF6E2B;
        Fri, 10 Sep 2021 14:44:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     carenas@gmail.com,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
        <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <xmqqczpv99u4.fsf@gitster.g>
        <9075cdd1-e34d-5dcb-f2b8-69ae4abf587b@gigacodes.de>
        <xmqq4kawcmqg.fsf@gitster.g>
        <4500892e-9efe-550c-73fa-37a3a69bc737@gigacodes.de>
Date:   Fri, 10 Sep 2021 11:44:49 -0700
In-Reply-To: <4500892e-9efe-550c-73fa-37a3a69bc737@gigacodes.de> (Fabian
        Stelzer's message of "Fri, 10 Sep 2021 10:03:59 +0200")
Message-ID: <xmqqsfycs21q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E026742-1267-11EC-9AF2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> It it not so much an incompatibility but a hard bug in ssh-keygen of my
> own making :/
> There is nothing we can do on the git side to fix this since the
> find-principal call will always segfault no matter what.

So... we cannot do anythying utnil a corrected OpenSSH is made
available, but once we can link with a corrected one, do we need to
do anything further on the patches in your topic?

I am guessing that the ideal endgame would be that we can merge what
we have down to 'master' and ship it in a release with a note that
says "OpenSSH 8.7 is broken---do not use the ssh signing feature if
you cannot update to OpenSSH X.Y (or stay at 8.6)", and that is why
I haven't kicked the topic out of 'next' and kept it there.

> I will continue writing some tests for the verify-time/key validity
> feature. The tests will need some version/feature detection from
> ssh-keygen as well so maybe i will still stumble on something that
> allows us to detect and warn on this.

Thanks.
