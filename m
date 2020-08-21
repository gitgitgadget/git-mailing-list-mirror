Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF02EC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9764F20724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R77ZZpPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgHUVmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65529 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUVmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:42:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44F00E2A5A;
        Fri, 21 Aug 2020 17:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mjFjJVMPS7FZYMtJChoc3AR2Tuw=; b=R77ZZp
        PYiVRgAWWNZ0SDnOOVz4jh1TCQZRe1SLdbMTg8I0At/nIEO4GmsBXleCWg9Z9rf3
        ZC0rr9HkdYlPrQJLevdVi4biCk/bMdayzq4B6xGgePJHxPC6G0Zh5LHvWjlA2xPR
        lg3uau/q1BT/pcnBpOXo7fJr3Yl7iS0dwuD+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D03yzEviLoJPkRWQLisqAjKqYlFVfNTW
        aog2ThoFTLh3wnxdtTYspoTD+v7CP8qsRuV0IuQdlwRDKVc5CWeOIypHSmS+fRC4
        NhLqtSkgc39sA8ckz2vIxIGq+3ubmKWBoUTnpBBjWHGEGAgs6XJLXkE4j1q3pnXX
        3cQWKzvQWq8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 35061E2A59;
        Fri, 21 Aug 2020 17:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 62ECFE2A58;
        Fri, 21 Aug 2020 17:42:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: in partial clone, pass --promisor
References: <xmqqimddaxhz.fsf@gitster.c.googlers.com>
        <20200821210827.1203531-1-jonathantanmy@google.com>
Date:   Fri, 21 Aug 2020 14:42:16 -0700
In-Reply-To: <20200821210827.1203531-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 21 Aug 2020 14:08:27 -0700")
Message-ID: <xmqqo8n37k1z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FA811F4-E3F7-11EA-832E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > When fetching a pack from a promisor remote, the corresponding .promisor
>> > file needs to be created. "fetch-pack" originally did this by passing
>> > "--promisor" to "index-pack", but in 5374a290aa ("fetch-pack: write
>> > fetched refs to .promisor", 2019-10-16), "fetch-pack" was taught to do
>> > this itself instead, because it needed to store ref information in the
>> > .promisor file.
>> 
>> So is this patch a fix for a regression in v2.25?
>
> Yes. (Just checked with "git merge-base" that 5374a290aa is in v2.25.0
> but not v2.24.0.)

Thanks.  

I wonder how we missed the breakage back then, but better late than
never ;-)
