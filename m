Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAFC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010120759
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lixBqhh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgIIAA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:00:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59818 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIIAA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:00:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95B5BE8C5B;
        Tue,  8 Sep 2020 20:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uyjKU0PnjlV8ANAxYurWDkQA2Y4=; b=lixBqh
        h87pZhfdv0rv5x+p7Y/BlFmuKVIW2PVxDZXB7YbPdq1G05YZ9j7be123RpP9l0zZ
        Dkdbty0IZjE3PI1WN1mAQwPaS7TBDmn5Q9NZo+VZgidYp7/nxQOKMfD11htNVZuO
        OUW3wAK+X8gom7Ajo5Nx//AcRUcnvyGtF7uMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lOi+GptucAEgbhCo+SCuUwcUyC7TM8N6
        FRe0SEaD4OS7ZGezC0BTr5Zs72zVPGpHnPe2OpId0KmUK4yoG/S/4qCAnLbFjlaK
        f/GV1eeemhPW43ELl0emWrmqqsJMHbJFYcfp2IhfgOIpz6S/V4bJD1UlWhEWvK/m
        Uw/0uQ5f0tQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EAECE8C5A;
        Tue,  8 Sep 2020 20:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2865E8C59;
        Tue,  8 Sep 2020 20:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: allow merged and no-merged filters
References: <20200908153759.36504-1-alipman88@gmail.com>
        <xmqqsgbrx4xo.fsf@gitster.c.googlers.com>
        <CAEJZ43ivtDS4mG35gt7HyKVWqLdS6XCwt5j8ZEYgDZDTdwE0OA@mail.gmail.com>
Date:   Tue, 08 Sep 2020 17:00:53 -0700
In-Reply-To: <CAEJZ43ivtDS4mG35gt7HyKVWqLdS6XCwt5j8ZEYgDZDTdwE0OA@mail.gmail.com>
        (Aaron Lipman's message of "Tue, 8 Sep 2020 19:57:52 -0400")
Message-ID: <xmqqblifx1hm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8816204C-F22F-11EA-A86A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

>> That would mean the rule would be "refs must be reachable by any one
>> (or more) of the <merged> commits, and must be reachable by none of
>> the <no-merged> commits".  I am not using the same phrasing you used
>> (i.e. "must satisify ... filter"), but are we saying the same thing?
>
> Yes, that is how I've implemented this. (Your wording may be more
> clear, I'll plan on updating the commit message.)
>
>> The expectation is that topics in flight are either reachable from
>> 'next' or 'seen' (there can be commits in 'next' but not in 'seen'
>> when fixes to mismerges are involved) and those already graduated
>> are either in 'master' or 'maint', and the above "log" and "branch"
>> would show the stuff still in flight.
>
> I think we're on the same page: If a branch is merged into 'seen' but
> not 'next', it should show up in the output of
> "git branch --merged seen --merged next".
>
> If a branch is merged into 'master' but not 'maint', it should not
> show up in the output of
> "git branch --no-merged master --no-merged maint".
>
> To clarify, is that the behavior that makes sense/seems useful to you?
> If so, I can add some test cases for those filter combinations in v2.

Yup, drawing the parallel to how revision walker combines multiple
positive and negative starting points would feel the most natural to
experienced Git users, I would say.

Thanks.
