Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45557C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1614F21744
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VY64zaXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbgAMAnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:43:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbgAMAnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 19:43:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CBB7A3387;
        Sun, 12 Jan 2020 19:43:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r/ppObTaIfek36D4lLc8IdOg608=; b=VY64za
        XGP0Em9c2JYVIUO4avGlR5QcXMv77XwOISfRGH2XEnpoQL4O4wn5ZUUvE8CGV2UA
        jIMPU3A/yoFzWX9+Biw7830aiTI7PrkyDhBsB/5/6ExHCOZf3OVun7PpVFdOGIeT
        1AIJIo2b9Nxgjj1ReEeBn71HrQTgxxve7W+R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxEsInvDYI0jsz2zdlP5aAUtlAJZpR1A
        dZYv5HlohZBwr7JXnRATSkaSiRDnXp66VyX3FQ2y0r0tLXwCb8nIIvCcfu1v/exM
        1EhVouwG0C4MzA/Xwmhjxh4hq+PIadqIKOkNq4lfagb6vdgif2a+JtMwvjKrakCu
        s3V+SjnSqkc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7577AA3385;
        Sun, 12 Jan 2020 19:43:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A58DA3384;
        Sun, 12 Jan 2020 19:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 12 Jan 2020 16:43:38 -0800
In-Reply-To: <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 12 Jan 2020 13:12:08 -0800")
Message-ID: <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE43F242-359D-11EA-A87B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 12/01/2020 16:12, Phillip Wood wrote:
>>> I'm concerned that there are some bugs in this series and think
>>> it may be best to revert it before releasing 2.25.0.
>
> Let's do that.
> ...
>>> J
>
> In any case, the tip of 'master' (hence the one that would become
> the final) is simpler to remedy by just reverting the merge, but
> there are a handful of in-flight topics that may have been queued by
> forking 'master' after the problematic merge was made (iow, anything
> after the fifth batch for this cycle), which I'd have to be a bit
> careful when I merge them down, lest they attempt to pull in the bad
> topic again.  But that will be something we need to worry about
> after the release, not before the final.

I will push out what I wish to be able to tag as the final [*1*]
shortly but without actually tagging, so that it can get a bit wider
exposure than just the usual "Gitster tested locally and then did
let Travis try them" testing.

Thanks.


[Reference]

*1* The tip of 'master' as of this writing is v2.25.0-rc2-24-gb4615e40a8

