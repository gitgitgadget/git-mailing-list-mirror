Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D5C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA0222C4
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p/Hd4z1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLKWFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:05:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:05:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11F6038D79;
        Wed, 11 Dec 2019 17:05:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oq2uw8HXHx6++I+75OzU94vi3Hk=; b=p/Hd4z
        1DyjFhKzkFiZohA4Pb0Sni1Z2VDAiLFQDaLOs5kQsEfl80gtltHA+WmQPk9zPlZ4
        DUQ/n5AuU0lrx9WgGpRFHCND5P4eHzA8gupj9D5zDTuminvdE7aWkjdN4bthW2GP
        4fJJB/yRbQ2KTGgalA1fvqiNSFQA81D3UizV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PnnH1eeRT2XLWVdPgwblc3+q3DxKWhoQ
        P6AB6OvQGmD+Wwjh9DZX/BYW+QyYqTgij/tnlA4hVD4hGzZpnjRHUK0VstPciY7N
        01AfoHZ/hDYk3pzQ0dxSlYECV3sWmWh+GZe+4Bnb0y8PZbLbMjGO55u4yNHX38np
        UhpEsJMlQgk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0932438D78;
        Wed, 11 Dec 2019 17:05:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66F4B38D77;
        Wed, 11 Dec 2019 17:05:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] gitk: use --pretty=reference for copysummary
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
        <20191211215826.GA31614@blackberry>
Date:   Wed, 11 Dec 2019 14:05:13 -0800
In-Reply-To: <20191211215826.GA31614@blackberry> (Paul Mackerras's message of
        "Thu, 12 Dec 2019 08:58:26 +1100")
Message-ID: <xmqq1rtao6w6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EE736B0-1C62-11EA-91A6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Dec 11, 2019 at 01:39:50PM -0800, Denton Liu wrote:
>> In an earlier commit[1], git learned the 'reference' pretty format.
>> Update copysummary to use this pretty format instead of manually
>> reimplementing it as a format string.
>> 
>> With this change, we lose the double-quotes surrounding the commit
>> subject but it seems the consensus is that the unquoted form is used
>> more often anyway[2] so this change should be acceptable.
>> 
>> Since gitk and git are usually packaged and distributed together, their
>> versions should be in sync so we should not have to worry a newer gitk
>> running on top of an older version of git that doesn't support the
>> 'reference' pretty format.
>
> In fact my policy is not to do this (introduce a change to gitk that
> means it requires the very latest git).  I would want the code either
> to test the git version (which the code already does in other places)
> or handle failure gracefully and fall back to the old command.

For a case like this one, the policy would mean that a single liner
patch like this will never be accepted, right?  After all, the code
that would be used as a fallback for older Git is very simple so it
is almost pointless to add a check for feature with conditional.
We can just use the fallback code always, which is essentially to
keep the current code.

It is a tangent, but arguably the current code is easier to extend.
I can even see somebody arguing for adding a gitk.summaryformat
configuration variable, whose value would default to "%h (%s, %ad)"
when missing---that can be quite straightforward to do without
Denton's patch.

So I dunno.

