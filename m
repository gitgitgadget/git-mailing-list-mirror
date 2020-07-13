Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC83C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413FF207DD
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BkC+ps3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGMTpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:45:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51145 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMTpj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:45:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F13175CCE6;
        Mon, 13 Jul 2020 15:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y736qoCSMtCU8cQjbdUXYb0Y7jQ=; b=BkC+ps
        3FqGl8OGu2AgUVPzcMLX7rZAYktqo4Y3ok14aDVtfnNL+7sslm5WSE/IkBZTZVZD
        ypuahoV7L1AlvAmoLxz11n6byMiXzwwqMJsTg3CH5owesYEqHHqUfspBuyxwf5Kv
        bfMLvid6842BVgCbK/fOzvfFbhBJzjuPtkGJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=feiJJpiNbCT0xmsPyfmvbjZKtZ1gBXqp
        7nmQz2Ae5dUTF2wHFSXulLe/obX2BpjD8LeQ00D/lj8yAubsgDytIm1H9q5N8HnR
        94+6lhzxa26PQZm7dOxgzZNpdW8I3Rj7dZrcaoxSrQJcIVorQYp0KSFmVsDOmBRz
        AeG7D9pzZ0c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7F5B5CCE4;
        Mon, 13 Jul 2020 15:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 648275CCE3;
        Mon, 13 Jul 2020 15:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] fetch: optionally allow disabling FETCH_HEAD update
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
        <xmqqimetrcay.fsf@gitster.c.googlers.com>
        <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
        <xmqqblkkr63u.fsf@gitster.c.googlers.com>
        <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
        <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
        <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
        <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
        <xmqqft9vnvce.fsf_-_@gitster.c.googlers.com>
        <20200713190834.GA77607@syl.lan>
Date:   Mon, 13 Jul 2020 12:45:35 -0700
In-Reply-To: <20200713190834.GA77607@syl.lan> (Taylor Blau's message of "Mon,
        13 Jul 2020 15:08:34 -0400")
Message-ID: <xmqq7dv7nqqo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C0922AC-C541-11EA-9F64-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> -	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
>> +	const char *filename = (!write_fetch_head
>> +				? "/dev/null"
>> +				: git_path_fetch_head(the_repository));
>
> Ah, because dry_run ==> !write_fetch_head, so this is an equivalent
> translation. Makes sense.

Yup, now dry_run is merely one of the two cases we turn
write_fetch_head off, and the logic to prevent us from writing
FETCH_HEAD (hopefully without any other side effect) was already
there in this function.

> Test coverage all looks good, thanks for working on this. I don't think
> there's anything left, so this would be great after 2.28 is released.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks.
