Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015BEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 05:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C450920820
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 05:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wMEPVncI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFKF0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:26:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62666 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgFKF0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 01:26:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 045BE67F9E;
        Thu, 11 Jun 2020 01:26:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AgjPrQokljr/AYgAKB315vCLOF0=; b=wMEPVn
        cIJjdo1NEFsu4Y+0p3L5NeZZ3nH1P9gXrBVeXJc2RwG/ko8xUcmlLbYowsgxut1P
        SiYRCdrH8Mcdut2pS+xLGoJCWqHRh+YxfGUC9fmaKlf6KubGXznxzinW+6/yW8g3
        NLxYe5lXkdtXQDwQ1ZkyfNNzwXa3M7HnVrvWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+obtTevrQ6bVnXKHnF3xWzFc52RNkk+
        rRDPLjvHtlxBG2C8xUaDP+TNrt66KThyNJNy+UqUZTErZs6Vqk/uWU9dp/QcVEag
        RuzUWdBIT6RDraXxzTJ6GW3j+AyZkUK7/K9VOXc3Yluc2uttio6XKany5kxjhuYG
        4Puz2nTWIN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0C7B67F9C;
        Thu, 11 Jun 2020 01:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B7EB67F9B;
        Thu, 11 Jun 2020 01:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/9] fast-export: respect the possibly-overridden default branch name
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
        <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
        <20200610233912.GU6569@camp.crustytoothpaste.net>
        <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
Date:   Wed, 10 Jun 2020 22:26:15 -0700
In-Reply-To: <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
        (Matt Rogers's message of "Wed, 10 Jun 2020 20:20:39 -0400")
Message-ID: <xmqq3672cgw8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12A36562-ABA4-11EA-A71E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

> I think that's not very convincing.  If branch names in general are identifying
> enough to warrant anonymization then shouldn't the default name be too?

It is a good argument.  I also heard a rumor that often branch names
contain codewords given to pre-released hardware that are highly
confidential in certain circles, and heard that it is one of the
reasons why Gerrit has server side ACL that lets you hide some
branches from authenticated users that can access other branches.

Again, the original comment explains why 'master' without such a
configuration knob was not worth protecting, but what it does not
explain is why keeping it (and only that branch name) unmunged gives
a more useful result than munging everything.  From the point of
view of "I want to debug the shape of the DAG, without the actual
user data", munging 'master' to 'ref47' while other branches like
'next' are munged to 'ref%d' does not make it harder to use or less
useful for the debugging than only 'master' is kept intact in the
output stream.
