Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1CC433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B6264FD2
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 00:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCJATS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 19:19:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60180 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCJATF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 19:19:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5885111B95;
        Tue,  9 Mar 2021 19:19:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A8QQ00ZrbFB3+cXJDWlXgo2yPQw=; b=qVmWE0
        BdetsjpgdRY4iOm2j1ZEZKYFFbsrQ768SKf4znc9Dr2exlv0W63iqt0qoTnwbK+4
        B8pmZAbqmFcMVWd3+zkikYl7V9zop8nlimDT9vbPbtk9uEs8kWEXZWB4/v2owdHp
        z3ovtfjYnTS6LvNUdrVo7qUJqcs5pzRXF+oeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZdcTVhZnG2pYziBeFvrjdkfFkgz1SZRI
        kiK2Dz2YD92NtxRasbvrxJQSGQTEam07PMDVaePJfC/pB+/9NAmtj0pZQNEgFEjY
        V/ne9l29vOGKfolOavjFMIW3JwuWCE8yiy0iUpL83WXHPzBcI6mXaS3J7yMOWdHJ
        WmTF7sunLY0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD21C111B94;
        Tue,  9 Mar 2021 19:19:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E2377111B91;
        Tue,  9 Mar 2021 19:19:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 10/12] unix-stream-server: create unix domain socket
 under lock
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
        <1ee9de55a106e46dab6126fe8ca2a0aeace57b1a.1615302157.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 16:18:59 -0800
In-Reply-To: <1ee9de55a106e46dab6126fe8ca2a0aeace57b1a.1615302157.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 09 Mar 2021
        15:02:35 +0000")
Message-ID: <xmqq35x3zwr0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 369D5BEA-8136-11EB-B17F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct unix_stream_server_socket {
> +int unix_stream_server__create(
> +void unix_stream_server__free(
> +int unix_stream_server__was_stolen(

I think we reserve __ in our API for names of symbols that normal
callers never have to write (both data like git_attr__true[] and
functions like cmd_bisect__helper()).

It seems that list-objects-filter.h may have introduced the
"name_space" followed by "__" followed by "name" convention,
but I am not sure if that is a desirable convention to spread
throughout our codebase.

Also "unix_stream_server" is quite a mouthful.  Perhaps abbreviate
it to uss_ or something?  I dunno if that is too short and invite
confusion with other kinds of uss.



