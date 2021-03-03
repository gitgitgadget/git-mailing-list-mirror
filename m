Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740CC433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F2164EA4
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359251AbhCDAYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57961 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhCCUyy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 15:54:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECA3FBDB42;
        Wed,  3 Mar 2021 15:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OIZCFcRbz/fjVIpDxm8G9/Dq9Q8=; b=pxVW96
        z5zsV6sI5hmKfx4kycWBG41LZauH55mKa8UEIo/1dMMdhk6vWfStoL1W5K5XT9M0
        TLxRzlrYK1yJKO0HIFZdGid50V9vmD/z02ABWgtxjtE04dHoe/xRXN9pVUfURXkF
        kgpjVVSxuysUvy2FGwGNwFmJNEsdTNu+93szM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JXV9knyIScyG4h7xKgtee0946tRN+r6d
        iv2qGn3tT5EQDIGWXayzL+GKHOnIao4YqTH0BWhmUp6DyOY4tA1Ugr8lFXcos4TG
        wi68Kh6h69t7f4g62EKJdgfDsFXXRgTZLNUMAHtQgXxDZ19xugURHihCxrQM+BsZ
        a2n55v2cRUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9253FBDB41;
        Wed,  3 Mar 2021 15:54:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0032BDB3F;
        Wed,  3 Mar 2021 15:54:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 08/12] unix-socket: add backlog size option to
 unix_stream_listen()
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <985b2e02b2df7725d70f1365f7cd2e525c9f3ade.1613598529.git.gitgitgadget@gmail.com>
        <YDijhRaib5It/apG@coredump.intra.peff.net>
Date:   Wed, 03 Mar 2021 12:54:03 -0800
In-Reply-To: <YDijhRaib5It/apG@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 26 Feb 2021 02:30:13 -0500")
Message-ID: <xmqqim68hsb8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9707B5BC-7C62-11EB-B846-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 17, 2021 at 09:48:44PM +0000, Jeff Hostetler via GitGitGadget wrote:
>
>> @@ -106,7 +108,10 @@ int unix_stream_listen(const char *path)
>>  	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
>>  		goto fail;
>>  
>> -	if (listen(fd, 5) < 0)
>> +	backlog = opts->listen_backlog_size;
>> +	if (backlog <= 0)
>> +		backlog = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG;
>> +	if (listen(fd, backlog) < 0)
>>  		goto fail;


Luckily there is no "pass 0 and the platforms will choose an
appropriate backlog value", so "pass 0 to get the default Git
chooses" is OK, but do we even want to allow passing any negative
value?  Shouldn't it be diagnosed as an error instead?

> OK, so we still have the fallback-on-zero here, which is good...
>
>> +struct unix_stream_listen_opts {
>> +	int listen_backlog_size;
>> +};
>> +
>> +#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
>> +
>> +#define UNIX_STREAM_LISTEN_OPTS_INIT \
>> +{ \
>> +	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
>> +}
>
> ...but I thought the plan was to drop this initialization in favor of a
> zero-initialization. What you have certainly wouldn't do the wrong
> thing, but it just seems weirdly redundant. Unless some caller really
> wants to know what the default will be?

Very true.  The code knows the exact value input 0 has to fall back
to; we shouldn't have to initialize to that same exact value and I
do not offhand see why the DEFAULT_UNIX_STREAM_LISTEN_BACKLOG needs
to be a public constant.

Thanks.
