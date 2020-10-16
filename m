Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B93C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69A5212CC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZGjjB8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393582AbgJPUWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:22:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56825 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393560AbgJPUWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:22:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98F9A1012DB;
        Fri, 16 Oct 2020 16:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kEuKKbCorXluMEb3oawNXS3laIw=; b=KZGjjB
        8QErVVXChlmfR1ducHgAfh4pa0GUVW38yesrJ4HFSEPi91KvcPtFAGbOvcwnpq90
        1SOCsSNWIMKfCbAbIVQYaLZewhSfd6WvQ7MBzszpXHzgjjropdhTQWbh1tQAM1Xj
        gSSxOhVXyq4DovLi/NoX22Yw+CF6S9RHY99UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FJGAcWeWHDwxM0/oY+qHdAdXMweRrab3
        0QaaTmHfy0zBbD0zVp6mVNUzVggQlOigYldXDP5G8aQhdqafGqxwbxVIYcsZFJ0r
        J252vecqs147pWy/ACr/X73tkGLh5FKm1+SCWOzmaS3ALK39yp1xgEdMf9Oxkb18
        8XAPkXKBOfs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 916A51012DA;
        Fri, 16 Oct 2020 16:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D07831012D9;
        Fri, 16 Oct 2020 16:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <xmqq1rhzihqa.fsf@gitster.c.googlers.com>
        <20201015194648.GB1490964@coredump.intra.peff.net>
        <xmqq7drrfe15.fsf@gitster.c.googlers.com>
        <20201016003847.GB2932796@coredump.intra.peff.net>
        <xmqq7drqdu2u.fsf@gitster.c.googlers.com>
        <20201016200642.GB3355643@coredump.intra.peff.net>
Date:   Fri, 16 Oct 2020 13:22:09 -0700
In-Reply-To: <20201016200642.GB3355643@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 16 Oct 2020 16:06:42 -0400")
Message-ID: <xmqq4kmtc45q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4544268E-0FED-11EB-A523-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think we are on the same page, and my intent was to match full names.
>
> So now you get "t0050" from some failed-test output (prove, or just the
> output from make failing), and you copy it into the command-line to use
> with "--test". And instead you'd just copy the full text name. It's a
> little less convenient because t1234 is short enough that I'd type it,
> and I'd probably cut-and-paste the text name. But other than that, I'd
> expect the procedure to be the same.

Most often, they are no longer in my scroll buffer, though.  Two
4-digit integers I can easily hold in my head and type.  Full names
of two test scripts?  That's a bit taxing.

So, not really.
