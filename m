Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E111F462
	for <e@80x24.org>; Tue, 28 May 2019 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfE1SA2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 14:00:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52236 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 14:00:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C2656EE30;
        Tue, 28 May 2019 14:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M7YklV3pSqid5x3h3R08LqGqePo=; b=FAjj3s
        48ysozR6YrIpYdV4rUI8CekjcwDnm/p1yDcr3PuE/uQMU/mRyh5jsxWcKxuIQ+C4
        YGanXnAxHnlJexmaQavncqWJ+VtbOW/MBD0Od3BACSEpRkruxERWnWg1eVISOLZ/
        exVPktCasiP26rxXhvOKZsfz2NT2eH7h9zXYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PqGR2QMtA6UxJonDrURpLnTdS5/hw1zI
        GsYrC9ua7g6gWCEkflL05QcHqBU7CkX1BHUkJ5fkoxbefFovxL+6PJllqzC3GoVq
        O0qTrn94+64Vn8AZYDm8myfnjLscmKgkGNV6sfi83F9O1emi37T5XVUl/WmuluL3
        n0SUdtw2N9A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BE166EE2E;
        Tue, 28 May 2019 14:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 803536EE27;
        Tue, 28 May 2019 14:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: send server options after command
References: <20190522200822.176870-1-jonathantanmy@google.com>
        <20190524191151.GA14606@google.com>
Date:   Tue, 28 May 2019 11:00:22 -0700
In-Reply-To: <20190524191151.GA14606@google.com> (Jonathan Nieder's message of
        "Fri, 24 May 2019 12:11:51 -0700")
Message-ID: <xmqqd0k231e1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77AA093C-8172-11E9-A207-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Tan wrote:
>
>> Currently, if any server options are specified during a protocol v2
>> fetch, server options will be sent before "command=fetch". Write server
>> options to the request buffer in send_fetch_request() so that the
>> components of the request are sent in the correct order.
>>
>> The protocol documentation states that the command must come first. The
>> Git server implementation in serve.c (see process_request() in that
>> file) tolerates any order of command and capability, which is perhaps
>> why we haven't noticed this. This was noticed when testing against a
>> JGit server implementation, which follows the documentation in this
>> regard.
>>
>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>> ---
>>  fetch-pack.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Oh, dear.  Thanks for fixing it.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>


Yeah, looks good.  Thanks.

>
> 6e98305985 (clone: send server options when using protocol v2,
> 2019-04-12) is part of release candidates, but it looks like we caught
> this in time to get the fix in before the release.
>
> Should we add an interop test for this to t/interop/?
>
> Thanks,
> Jonathan
