Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE0C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A399061100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhIJUYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:24:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59826 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhIJUYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:24:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB76F7767;
        Fri, 10 Sep 2021 16:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VV/CL6k/c4DesrNkrOL04Yh5fA4yZ5NWXq8i88
        tQOxM=; b=UVyeOuhkDc7qd6Fj+4GnbYUkt8VPdZAm7q+SmLXqWiliVBzHIU60ej
        YtF20cZ2yef40XzMb8pm+xpiQ1uPi6WcqlFWOoISSLtBAE/6/Pd8BtS9P572bCzY
        wKz17NyjPZXHV2aRpja0FBImsGSN3Ig9c1Y5dEsrnQqN86cRK4K5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E47FCF7766;
        Fri, 10 Sep 2021 16:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68522F7765;
        Fri, 10 Sep 2021 16:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>
Subject: Re: [PATCH v8 0/9] ssh signing: Add commit & tag
 signing/verification via SSH keys using ssh-keygen
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
        <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
Date:   Fri, 10 Sep 2021 13:23:23 -0700
In-Reply-To: <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com> (Fabian
        Stelzer via GitGitGadget's message of "Fri, 10 Sep 2021 20:07:33
        +0000")
Message-ID: <xmqqfsucrxhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3070F04-1274-11EC-B0AE-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> v8:
>
>  * fixes a bug around find-principals buffer i was releasing while still
>    iterating over it. Uses separate strbufs now.
>  * rename a wrong variable in the tests
>  * use git_config_pathname instead of string where applicable

I guess I'd better kick the topic out of 'next' before doing
anything else, as it still seems to want to be replaceable
wholesale.  Somehow I was given a (probably false) impression that
the previous one was in a more or less testable shape and we can go
incremental already, which was why I merged v7 to 'next'.

Will queue later, but may not get around to it today.

Thanks.
