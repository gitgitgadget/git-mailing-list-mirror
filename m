Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5687E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 02:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeKNMjj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 07:39:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61531 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKNMjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 07:39:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BC8318142;
        Tue, 13 Nov 2018 21:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ws3tIKkdHwdHY6RzNProI4Vm7gA=; b=ZVmaFN
        P8e03weH0Yfnkf26qRt9ZpnnbSYIPmRQpYWaXQYYmI8XqW/cVh1QlC6/kNx1qT5x
        uVBPQEhLwj/IRc2kgJ5OfN/MKO5JTJxICSVSuxK7302drCkug53tvdgVy0r7Z+Uj
        FHleM1Gnvb9+/+Glsk2ke6KJcxxfDzUmyIaqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eus0wYXSaEBaTZlXAg+7IQbjCgR4Y+MT
        DPbwTqeEpmWPp14bfC467uiZX7MLd1FG+pAcxte7g+sW1aF7ae8qdO7xSsOSWp5o
        mCKgi2JUl572E9ZUwZw2MJGKqAfXZjqFv3qaR5hAzF/X4zMPpvmDBVgxgxQItFXs
        JaNZtw2dOyk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0414B18141;
        Tue, 13 Nov 2018 21:38:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 183BC1813E;
        Tue, 13 Nov 2018 21:38:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
References: <cover.1539305180.git.steadmon@google.com>
        <cover.1542059029.git.steadmon@google.com>
        <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
        <xmqqr2fpwrqg.fsf@gitster-ct.c.googlers.com>
        <20181113225320.GG126896@google.com>
Date:   Wed, 14 Nov 2018 11:38:24 +0900
In-Reply-To: <20181113225320.GG126896@google.com> (Josh Steadmon's message of
        "Tue, 13 Nov 2018 14:53:20 -0800")
Message-ID: <xmqq1s7os7rz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CC2CA2E-E7B6-11E8-B4A3-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2018.11.13 13:01, Junio C Hamano wrote:
>> steadmon@google.com writes:
>> 
>> > Currently the client advertises that it supports the wire protocol
>> > version set in the protocol.version config. However, not all services
>> > support the same set of protocol versions. When connecting to
>> > git-receive-pack, the client automatically downgrades to v0 if
>> > config.protocol is set to v2, but this check is not performed for other
>> > services.
>> 
>> "downgrades to v0 even if ... is set to v2" you mean?  Otherwise it
>> is unclear why asking for v2 leads to using v0.
>
> The downgrade on push happens only when the the configured version is
> v2. If v1 is requested, no downgrade is triggered. I'll clarify the
> commit message in the next version.

OK, then it will still be confusing unless "we downgrade v2 to v0
because ..."gives the reason.

> In any case, the ordering of the server's allowed versions won't matter;
> we'll pick the the first version in the client's list which is also
> allowed on the server.

That sounds like a very sensible semantics.

>
>> I am wondering if the code added by this patch outside this
>> function, with if (strcmp(client_ad.buf, "version=0") sprinkled all
>> over the place, works sensibly when the other side says "I prefer
>> version=0 but I do not mind talking version=1".
>
> Depends on what you mean by "sensibly" :). In the current case, if the
> client prefers v0, it will always end up using v0. After the fixes
> described above, it will always use v0 unless the server no longer
> supports v0. Is that what you would expect?

Yes, that sounds like a sensible behaviour.

What I was alludding to was a lot simpler, though.  An advert string
"version=0:version=1" from a client that prefers version 0 won't be
!strcmp("version=0", advert) but seeing many strcmp() in the patch
made me wonder.
