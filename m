Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F05C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A79206E9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Am1JFMSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbgDOWTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:19:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53987 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbgDOWTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 18:19:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 304F8C7287;
        Wed, 15 Apr 2020 18:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=812SZhGX7YNyiNEmw+GUx/VwOYw=; b=Am1JFM
        Sij/VpT5nkFu5D9XJ3aiOI/Rz60MRzlFotGCC/tEaT3LjaauW+yU/5L/TiH4R45z
        pJXW8HN7I+pQKFYAv13lH1OymAliiy0NWHsYt5r+/vGK7gzBVmEd59mlPVlvZBtD
        hZhc/ZWsKATOso+pNhT+RUmJitWFauDI/0efQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M50lf8Je5zeU7gJI+Xvuqo98uQPwGOfX
        O9bUmlzr1EC2I8bw5xh0iN+sypE0jJ9IixuAaeUQDmybt8Q3sRhQVntNW/iuby3L
        dBpFj7+5mnn1QE7OygOrKptLra0h5AQlueaJt5SkPlpMrAnY0LNov+KXVbQcd2Y9
        lePv7/m1fCk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27E27C7286;
        Wed, 15 Apr 2020 18:19:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7080EC7285;
        Wed, 15 Apr 2020 18:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20200414005457.3505-1-emilyshaffer@google.com>
        <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
        <20200414203247.GE1879688@coredump.intra.peff.net>
        <0f661f31-ee75-15fb-0272-48d459176f29@gmail.com>
        <xmqqd088950d.fsf@gitster.c.googlers.com>
        <20200415203029.GA24777@google.com>
Date:   Wed, 15 Apr 2020 15:19:39 -0700
In-Reply-To: <20200415203029.GA24777@google.com> (Emily Shaffer's message of
        "Wed, 15 Apr 2020 13:30:29 -0700")
Message-ID: <xmqqv9m04cjo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33BF7470-7F67-11EA-84A1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Or, to put it another way, I don't think we need to solve the config
> ordering problem today - as long as we don't make it impossible for us
> to change tomorrow :)

OK.
