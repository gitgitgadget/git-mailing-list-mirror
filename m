Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7622C211B3
	for <e@80x24.org>; Fri,  7 Dec 2018 00:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLGAMd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 19:12:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57852 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLGAMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 19:12:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71A6D12A514;
        Thu,  6 Dec 2018 19:12:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9RWrWmhJqUD4zV52RbZj+MHoVk8=; b=D3qs9v
        gvjRN9iBGIu5CJ7ojgTcvEo54rKHjw4IG9hG98eVAFjgL5LbL6SWgwODxdorh2xb
        TrUZDdhn3B/bpc+00qHY4uKDSW4sbl+Nni2MMxl055zJg00Gx2iE1SLnoCEZYw2V
        1EJSgXAebALUm8uDL/NXjhXb+uUpLgKdbepH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yhF+ws09olBsVAzypTywQW0ROURKVq0i
        yCj7MTLnC+O7gJt/j7db+H5E81LXBqIykUTNTQ2hCO+FpfEHWs1sqxLl1dM272xV
        RwfdH0zwXAJDj8ytKKKdy84vIiwarxFiibCOhM40ndDES2PHzwqH4qnFIDmXH4wy
        PzDY7S4CsMg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 683E312A513;
        Thu,  6 Dec 2018 19:12:31 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D659312A511;
        Thu,  6 Dec 2018 19:12:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Khomoutov <kostix@bswap.ru>
Cc:     Konstantin Kharlamov <hi-angel@yandex.ru>, git@vger.kernel.org
Subject: Re: Any way to make git-log to enumerate commits?
References: <5e5c6d1c-6b3e-c94a-17be-a2af518c1607@yandex.ru>
        <20181205145419.vbbaghzzrnceez45@tigra>
        <xmqqa7ljbimv.fsf@gitster-ct.c.googlers.com>
        <20181206114835.oro32chgf4qp2yqd@tigra>
Date:   Fri, 07 Dec 2018 09:12:29 +0900
In-Reply-To: <20181206114835.oro32chgf4qp2yqd@tigra> (Konstantin Khomoutov's
        message of "Thu, 6 Dec 2018 14:48:36 +0300")
Message-ID: <xmqqr2eu8aaa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9BE28CA-F9B4-11E8-BE28-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Khomoutov <kostix@bswap.ru> writes:

>> I do not see why the "name each rev relative to HEAD" formatting
>> option cannot produce HEAD^2~2 etc.
>>  ...
> My reading was that the OP explicitly wanted to just glance at a single
> integer number and use it right away in a subsequent rebase command.
>
> I mean, use one's own short memory instead of copying and pasting.

As everybody pointed out, a single integer number will fundamentally
unworkable with distributed nature of Git that inherently makes the
history with forks and merges.  Besides, there is no way to feed
"git log" with "a single integer number", without which "making
git-log to enumerate" would not be all that useful ("git show
HEAD~4" works but "git show 4" does not).

All of these name-rev based suggestions were about using anchoring
point with memorable name plus a short path to reach from there,
which I think is the closest thing to "a single integer number" and
still is usable for the exact purpose.  "HEAD~48^2" on an
integration branch would be "the tip of the side branch that was
merged some 48 commits ago", for example.
