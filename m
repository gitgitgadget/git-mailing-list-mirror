Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FFC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24EA2080C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v3CleJ6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgIPWwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:52:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52754 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPWwT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:52:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E1D07FF90;
        Wed, 16 Sep 2020 18:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iKm53d58pNCNuVxmwUSsyFW2nfE=; b=v3CleJ
        6jlEBaYXXJGhSFhv69haxTuxBP6Esg+qYqN4XFwx+Qoz48DfmDiWl3kDez4BTzux
        syFD/DpOLXWDS9aWFyzVOv5CMxEsi6Sy7xAOtHyzfU9gXvJGGclzJE5zIi6Apuz4
        Jmm4DLYG/AsG+uzDhqCGezim+IwnrOFrl6I1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AjIuxdYG73oCWzm8gg4QdBITH98N59ag
        KerrQGuhufCwWwx/oLHCcPN2MnLSFO42ZAgv0Fph/x+7i69K0z4J3HhQNJJ+9pO3
        TBi7U9kBWUWtZgCHWIgwN3jgLkbspjB0WWXoJcMVuIk/CMX5ZeSe2BAvieA/bgYf
        xwF6dnw8Bbc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 956827FF8F;
        Wed, 16 Sep 2020 18:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 269617FF8E;
        Wed, 16 Sep 2020 18:52:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
References: <20200915135428.GA28038@pflmari>
        <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
        <20200916201830.GA44969@coredump.intra.peff.net>
        <xmqqbli5uyj4.fsf@gitster.c.googlers.com>
Date:   Wed, 16 Sep 2020 15:52:16 -0700
In-Reply-To: <xmqqbli5uyj4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 16 Sep 2020 15:50:23 -0700")
Message-ID: <xmqq4knxuyfz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 450CCA30-F86F-11EA-A5E6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Adding a command-line option for "all" is a good idea, but will probably
>> mean needing to add the "unset" sentinel value I mentioned in the other
>> email.
>
> Sorry, I do not quite follow.  I thought that assigning the
> (misnamed --- see other mail) ALL to the "family" variable would be
> sufficient?
>
>     enum transport_family {
>             TRANSPORT_FAMILY_ALL = 0,
>             TRANSPORT_FAMILY_IPV4,
>             TRANSPORT_FAMILY_IPV6
>     };

Ah, I see.  We want a way to tell "nobody has set it from the command
line or the config" and "we were explicitly told to accept any"
apart.

But wouldn't the usual "read config first and then override from the
command line" handle that without "not yet set" value?  I thought we
by default accept any.

