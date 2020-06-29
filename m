Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6DC433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 01:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2121B206BE
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 01:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUmf23cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgF2BWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:22:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52866 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgF2BWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 21:22:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F7DCD3619;
        Sun, 28 Jun 2020 21:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RTt/Fg30oistgAOJK/Guo+jWJ2M=; b=UUmf23
        cCVqsKbuZcamQGmF+zl0MkreCxwryhGI0yoNti4143p8a6fG+TRENxP2fYOksKzR
        X1neFxIz2sqzFlUCkb7G6JlPp2/NufJxQiwQ7gH0Frjwp/QZhDxEiUW9ERTMR9gD
        UfQxhu/91SYXGIhpP6WeDFPIOqGzAg9bbnofM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FazAK03fZqSR5oQS6jVmB6k05+jtS7Ka
        DR96v3SPH+n1dPCdz7SJVH2PaJhVDtHRL9AWnUlaOkHguiMggsepTwQ7q5mYurEP
        eYSHi54XDvI2i4ZxR1D8BWy4zj3Yxk3FU06tFvL8V/vPZ+Fdj6PFMn6iLVIwtGzL
        RF1T1l24s20=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97E4BD3618;
        Sun, 28 Jun 2020 21:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3A8AD3617;
        Sun, 28 Jun 2020 21:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@yhbt.net>
Cc:     git@vger.kernel.org
Subject: Re: `seen' datapoint [
References: <xmqqimfid2l1.fsf@gitster.c.googlers.com>
        <20200628192227.GA20227@dcvr>
Date:   Sun, 28 Jun 2020 18:22:46 -0700
In-Reply-To: <20200628192227.GA20227@dcvr> (Eric Wong's message of "Sun, 28
        Jun 2020 19:22:27 +0000")
Message-ID: <xmqqy2o6fyxl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AC37B28-B9A7-11EA-A43E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@yhbt.net> writes:

> So I had receive.denyNonFastforwards=true set, and a
> special cases for `pu':
>
> 	fetch = +refs/heads/pu:refs/remotes/origin/pu

Hmph.  I thought receive.denyNonFastforwards was for pushing into
the repository, so it is a bit puzzling that you bring up "only
updates to fetch into 'pu' is allowed to be forced" like this.
Such an arrangement would let you know when 'next' got rewound,
which is another plus ;-)

> Which necessitated s/pu/seen/.  So I wonder if there's other
> denyNonFastforwards users out there affected.  Anyways, just
> a data point...

I can sort-of see how the special case would work, but what makes
your setting fetch other branches like 'master', 'todo', and 'next'?

Do you have a separate "fetch" refspec for each of the ones you are
interested in?

Or "remote.origin.fetch = refs/heads/*:refs/remotes/origin/*" which
serves as the default catch-all (which overlaps with the "pu can be
fast forwarded" you showed---I don't recall how we designed such a
set-up to work offhand, so I am a bit curious) works as a natural
"require fast-forward in general, but a more specific rule about
'pu' allows non-fast-forward updates"?




