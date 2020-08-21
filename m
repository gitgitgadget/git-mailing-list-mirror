Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E1CC433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C396520732
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8OB4/uM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgHUQoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:44:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53431 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgHUQmr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:42:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26DFE7A3E4;
        Fri, 21 Aug 2020 12:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8J/iAn90zfcFDe8P6Who6XuXJQs=; b=f8OB4/
        uM9bfqFzDtcG5XqBWMv0nWHoZGgyCnzTVXkO65ncXKEUbJeWlhUSaNlbqLRndako
        JRh5cYwJnOnze8RtJQmZ2SMjqoj2m/7DWfBkFtc3IH3M2NoF3U1srO8k9582FX48
        stvuxhxI0a/ZBk0tEvMyhTKj8NenvhtWRWt4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=apSTqNYxNMcsCN3QOHupDkaqMvmZqyKf
        zClkiLnlEDxQ137K6SbFklQJSG3VLqqr+9IVE1JhYcdtmJbtWVOb1/XylBhQN2V9
        z5WWQqzldi7ZRKgA6LE9hXVR7mzUPZE8rrzhLv/iMzRdK4ldNn4P+EHlgU0eckxR
        I4532+canM0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E5517A3E3;
        Fri, 21 Aug 2020 12:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 704617A3E1;
        Fri, 21 Aug 2020 12:42:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] refs: remove lookup cache for reference-transaction hook
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
        <20200821143727.GA3241139@coredump.intra.peff.net>
Date:   Fri, 21 Aug 2020 09:42:45 -0700
In-Reply-To: <20200821143727.GA3241139@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 21 Aug 2020 10:37:27 -0400")
Message-ID: <xmqqeeo09chm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 578B4CCE-E3CD-11EA-BDA4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> However, I wondered...
>
>> +test_perf "nonatomic push" '
>> +	git push ./target-repo.git branch-{1..1000} &&
>> +	git push --delete ./target-repo.git branch-{1..1000}
>> +'

Is this a bash-and-ksh-only test?  At least, the above would not try
to push 1000 branches with the version of dash I have.
