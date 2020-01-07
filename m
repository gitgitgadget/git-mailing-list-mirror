Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E70C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE47D2080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nanbHtSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgAGUVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:21:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53666 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 15:21:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D67D1AF74F;
        Tue,  7 Jan 2020 15:21:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gb98ZY4P5mZbtooSHqUNYummCdA=; b=nanbHt
        Swy4NLhdPrhi220UOigwxRsaMxqObtD26hsE8/vwYN6tLwFsQjEw1kRxoOjdiJAX
        /wOSzZ6xfIU6ttQT39dADRURx1SLRZeUD5HcXiHxDSvWP5VvmNYo0W31Qzntz0UA
        70ur4WzmYJNfw7W9V3AgOIKVHx6e+1ga7nb8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sYxxwhU9vsU9jPhKsPfd1OMDbEvaWNuf
        gI2pEGtDrw1XVLPTnQ9cNf7wj4na/6HylujHvTG6FGNWNaziAh10L9TdGH+GLsC7
        Zxtc+q/oNbWC9LNLxdF1o3BgupJKgx6K3xEwnEo+VKTPDt/zxfN0Zr4jL4Trk2xX
        +SiCvkgWpic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF2B2AF74E;
        Tue,  7 Jan 2020 15:21:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0558AF74D;
        Tue,  7 Jan 2020 15:21:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] graph: fix case that hit assert()
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <65186f3ded251e0bcf1fcb18160163a3efd97c37.1578408947.git.gitgitgadget@gmail.com>
        <20200107153006.GA20591@coredump.intra.peff.net>
        <xmqqblrf5azn.fsf@gitster-ct.c.googlers.com>
        <20200107193143.GA56858@coredump.intra.peff.net>
Date:   Tue, 07 Jan 2020 12:21:05 -0800
In-Reply-To: <20200107193143.GA56858@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 7 Jan 2020 14:31:43 -0500")
Message-ID: <xmqqlfqj3tn2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CE411E8-318B-11EA-BC03-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2020 at 11:21:00AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> Second, the horizontal lines in that first line drop their coloring.
>> >> This is due to a use of graph_line_addch() instead of
>> >> graph_line_write_column(). Using a ternary operator to pick the
>> >> character is nice for compact code, but we actually need a column
>> >> to provide the color.
>> >
>> > It seems like this is a totally separate bug, and could be its own
>> > commit?
>> 
>> I think so.
>> 
>> And with that removed, all that remains would be a removal of the
>> assert() plus an additional test?
>
> Yes, though note that the color thing is a v2.25 regression as well. So
> we'd probably want both of them.

Sure.  Those two would make perfect pair of commits to finish -rc2 with.

Thanks.
