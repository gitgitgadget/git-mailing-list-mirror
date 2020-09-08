Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D5C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64923206D4
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 01:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NVEE63R2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIHBac (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:30:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57469 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgIHBa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 21:30:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 920FDE70A5;
        Mon,  7 Sep 2020 21:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Evc2r88BilNUs7ur6FE3cHSMXcc=; b=NVEE63
        R2WudFEgXvgLWqRJGsHL+lVHzaTP0K//mOTUBkBYavrzJRjL/Wli5cRrOYwy8vmZ
        xy0GIofkEv2Lon2H+h5iu6Od+dBp/SzLvGODdFlyPxIzzEBvJMYaE9MCMdTPfQG/
        9LWaCvW+qgSJdBQLWzrx3Af3001i6aOQuNhRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hBU1KCvICYrhlAJMyCqN5VzQrFwJ6pYV
        n6lWT66e7Z/Fh6Pzgtly2Ow2HyjpG610VJL/8DQsMnZbFK0S87Ot1whIjSctqr89
        ez5N94qMHEvDsQnpvJfxfEAik0taH6uokU2VOVsi1yLXqk4gxOdUhTTrRzbff3q/
        CCwCPjrSJeY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AA6DE70A4;
        Mon,  7 Sep 2020 21:30:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2307E70A2;
        Mon,  7 Sep 2020 21:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
        <20200908011756.GG241078@camp.crustytoothpaste.net>
Date:   Mon, 07 Sep 2020 18:30:23 -0700
In-Reply-To: <20200908011756.GG241078@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 8 Sep 2020 01:17:56 +0000")
Message-ID: <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE715F3C-F172-11EA-876B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> git-status(1) says:
>
>   If a filename contains whitespace or other nonprintable characters,
>   that field will be quoted in the manner of a C string literal:
>   surrounded by ASCII double quote (34) characters, and with interior
>   special characters backslash-escaped.
>
> Note that that differs from the standard behavior of not handling
> spaces, which I expect is due to the need to handle renames
> unambiguously.

Not really.  We use "rename from" and "rename to" extended header
lines in our output to unambiguously handle renamed paths.

cquote was indeed invented to serve "diff" output (actually, nice
things in the internal implementation of Git from the early years
were all invented to serve the diff machinery), but we deliberately
excluded SP from the set of characters that needs quoting because
it was thought to be reasonably common, compared to things like HT.

I agree with your "the special case handling needs to be taught to
the wt_shortstatus_other()"; a refactored helper function called
by both places would help.

Thanks.

