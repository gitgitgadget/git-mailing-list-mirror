Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B592C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A4A20787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r+V9Nf06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgD2RXq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:23:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61560 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2RXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 13:23:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B1BED6D3E;
        Wed, 29 Apr 2020 13:23:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=56Tqhd+SKtNzF4nHKPql91ZIikQ=; b=r+V9Nf
        06C/x+c4Hd1yDUBQObZt8wb5kA+eHpx3TXEKo+CSOam5yQasPcWnhLgmmrmOXpgW
        lXVNFYpzVYkr469bCgsYTixYMhVX+qI0TbNBhnh2ikjyJeNOjGrmrePjYIf8JLY6
        Ppg5EbBXlh+QXEOZBG95TLW6xl04Of1kP+Y8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lQgyVXki7LNWYBr0NaxOltAd/Xm3pSDK
        Y26tm8v+t/O4WLiKzr+vw5RR6pRN5tARtXQv9T0QhL5P8H3OU1T6VAFomvH4EMGR
        kjxh48yA5qwvd71MSCXqcnyNGP63LYt0FJjpbe7G0FAiwuD13I8V051bu/5Ikq2d
        taTswKAr1G8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33954D6D3D;
        Wed, 29 Apr 2020 13:23:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E38AD6D3C;
        Wed, 29 Apr 2020 13:23:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2020, #03; Tue, 28)
References: <xmqqimhjyy9c.fsf@gitster.c.googlers.com>
        <20200429155701.GA83442@syl.local>
        <xmqqr1w6xmtf.fsf@gitster.c.googlers.com>
        <20200429165501.GC83442@syl.local>
Date:   Wed, 29 Apr 2020 10:23:39 -0700
In-Reply-To: <20200429165501.GC83442@syl.local> (Taylor Blau's message of
        "Wed, 29 Apr 2020 10:55:01 -0600")
Message-ID: <xmqqy2qew6hw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BC79108-8A3E-11EA-9290-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Right... but I'm not sure that I agree that this other topic "builds" on
> the whole series. There is nothing in the last commit that the other
> series is dependent on. So, I was suggesting something like:
>
>   $ git checkout tb/commit-graph-split-strategy
>   $ git revert HEAD
>   $ git checkout tb/commit-graph-fd-exhaustion-fix
>   $ git rebase tb/commit-graph-split-strategy # making sure to drop the final patch

We cannot do this, as fd-exhaustion-fix is already in 'next'.

>> Why don't we do this:
>>
>>  $ git checkout tb/commit-graph-fd-exhaustion-fix
>>  $ git revert tb/commit-graph-split-strategy
>>  $ git checkout master
>>  $ git merge tb/commit-graph-fd-exhaustion-fix
>>  $ git branch -d tb/commit-graph-fd-exhaustion-fix tb/commit-graph-split-strategy
>
> That's fine with me, too.
>
>> That's the simplest solution and we'll have two fewer topics we need
>> to worry about when we are done.

OK.
