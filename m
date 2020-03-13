Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD8C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F2206B1
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SVGofXBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMTmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:42:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59630 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMTmn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 15:42:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70737AF3A4;
        Fri, 13 Mar 2020 15:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWHlYGnW0LVzCF8uoryy7BEbHMk=; b=SVGofX
        BePkEF95n+vML2653vyn4INtoedRw1RpIm6bn6lD4sLe9i8oyn3szYkuutFZB/Fi
        4A62RvluR82A9Hk+s87e+xuekZdCU9FJNG4Yxf3KWl4wixKAXb3jpuCttSw9bZeU
        er5+9jIXVGu4VjAzkE6X7jM4pQhAq4PPPIINc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwbIEXU5AfQwxmS3cVwIykbAOyIphlP8
        hc6YIdX3GmizYpWDnm+RcszDrkCKmz3FsjOpduRh0yJj4GCZjci9DenvxSO7iRNO
        /2HsuDFoz9QmLzNGsxmUGbRj4Gsy2Gm7vX6zBFHjuAaE2oSJgVc2jPF5nk+jwQZL
        d3U4NYmODDM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6775EAF3A3;
        Fri, 13 Mar 2020 15:42:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B142CAF3A0;
        Fri, 13 Mar 2020 15:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t6022, t6046: fix flaky files-are-updated checks
References: <pull.725.git.git.1584125875550.gitgitgadget@gmail.com>
        <xmqqtv2sawsf.fsf@gitster.c.googlers.com>
        <CABPp-BHGsED9noSgAt_OH5G8iXOAvS2cjEV-MDL=hjk365=NdQ@mail.gmail.com>
Date:   Fri, 13 Mar 2020 12:42:37 -0700
In-Reply-To: <CABPp-BHGsED9noSgAt_OH5G8iXOAvS2cjEV-MDL=hjk365=NdQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 13 Mar 2020 12:27:18 -0700")
Message-ID: <xmqqlfo4avo2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBBA320C-6562-11EA-8A65-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, a larger value might be useful in the face of leap seconds
> and ntp time updates, so I should probably move that direction.
>
> Any preferences on whether I should I pick something like 3600 (large
> but easily recognizable), something more round like 10000, or
> something else?

As long as filesystem timestamp monotonically increases, any value
that is the same or larger than the time granularity should be OK,
and it sounds reasonable for filesystem timestamp to have at least 1
second resolution.

Ehh, do we still need to worry about the ones that has 2 second
resolution or coarser?  What does "adjust the file timestamp by
decrementing 1 second from the current value" do?  Do we risk ending
up with the same timestamp as we started with?

I have no strong preference between 3600 and 10000, but to me 1
smells a bit iffy.  "test-tool chmtime --get -9 file" is still
spelled in the same number of bytes as one second offset and has a
larger margin ;-)
