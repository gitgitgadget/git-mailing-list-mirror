Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA9EC433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE6761502
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhKKSin (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 13:38:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54627 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhKKSim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 13:38:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1CA8F15CF;
        Thu, 11 Nov 2021 13:35:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QVh929LbIpGl83k/nr18llTtm1RTN+7Z0Hxmrv
        Iygbc=; b=lMp8OHr+KZ1vSIodpGX32YyYzQWhMSqmzINomTCJSb7REaUlfZ7LTF
        MpRvCCwhsGpBezvG92mk8N9i+JHb67C1GYh6R3/3W59Y+fLc3UDnRvadHLBkyqim
        owvzxdY8Dbgw/E4rrNWirFDgFn2hOwL7Vva1374GmBBFyiiEpHTJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94759F15CE;
        Thu, 11 Nov 2021 13:35:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09ECEF15CD;
        Thu, 11 Nov 2021 13:35:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com,
        me@ttaylorr.com, peff@peff.net, rybak.a.v@gmail.com
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
References: <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
        <20211111030302.75694-1-hanxin.hx@alibaba-inc.com>
Date:   Thu, 11 Nov 2021 10:35:50 -0800
In-Reply-To: <20211111030302.75694-1-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Thu, 11 Nov 2021 11:03:02 +0800")
Message-ID: <xmqqzgqaleux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32B6D88A-431E-11EC-8AC2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

>> @@ -2582,8 +2585,6 @@ int read_loose_object(const char *path,
>> char hdr[MAX_HEADER_LEN];
>> unsigned long *size = oi->sizep;
>>
>> - *contents = NULL;
>> -
>
> Deleting "*contents = NULL;" here will cause a memory free error.

Good find.  I see in the discussion downthread we have a band-aid
for this issue already ;-)

Thanks.
