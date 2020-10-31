Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33B3C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 18:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03E220706
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 18:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1qd5ZiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJaS6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 14:58:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56616 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgJaS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 14:58:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 624D18FAB8;
        Sat, 31 Oct 2020 14:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a3GzvdU5evF2FWYNAx8SF+h68aU=; b=l1qd5Z
        iRivtGlxQPj/GBHnyCXLyqQY4OAA7l0hPN3GlhQCeaA6LOQOqyTevcAApqcOelJD
        IZfVhCxzoAAyQlXRb6LTZQzsBtfgM8ZBdLDEP5gY78+/e1rqNjWyTaZTkrMl50Fq
        Bz2OrpAGSrsEeEred3FwuTej3UFiiZfES2dp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oc2DNH250SmEaAy7dS12bw9lzP+kVArk
        x6KboL4lReCL8KuEr9J4STs7xdxJDgbyX0IC7Awrmyn8x+SMx5PGaE2XYwuKAXbu
        I6BrSCWDo4W/vTSpxerz4pva1aeNTJoBEX1ms1oGnE4N58Yyn+IjFBltjwK0Eu+f
        4XSBvajTrQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A05C8FAB7;
        Sat, 31 Oct 2020 14:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2A5F8FAB6;
        Sat, 31 Oct 2020 14:58:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 6/6] blame: enable funcname blaming with userdiff driver
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <a1e1c977d0978424fb07c97be0479f43a325cbea.1603889270.git.gitgitgadget@gmail.com>
        <xmqqy2jo6a0z.fsf@gitster.c.googlers.com>
        <81143637-F77C-49C5-B55A-57E92AC45881@gmail.com>
Date:   Sat, 31 Oct 2020 11:58:33 -0700
In-Reply-To: <81143637-F77C-49C5-B55A-57E92AC45881@gmail.com> (Philippe
        Blain's message of "Sat, 31 Oct 2020 14:02:16 -0400")
Message-ID: <xmqqimaq43za.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 131A847C-1BAB-11EB-85D5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> * In patch 6, I considered fixing that bug in a different way by
>   initializing sb.path inside blame.c::setup_scoreboard. This function
>   already receives 'path' as its second argument, so changing that would not
>   impact the API. Probably Thomas thought that sb.path was already
>   initialized in sb when he modified builtin/blame.c::prepare_blame_range 
>   to also send sb.path to line-range.c::parse_range_arg in 13b8f68c1f (log
>   -L: :pattern:file syntax to find by funcname, 2013-03-28). 
>
>   Initializing the path in setup_scoreboard would mean we could also
>   simplify the API of blame.c::setup_blame_bloom_data since it would not
>   need to receive path separately and so its second argument could be
>   removed. I went for the simpler alternative of just sending 'path' to 
>   parse_range_arg instead of sb.path since it felt simpler, but if we feel
>   it would be better to actually initialize sb.path in setup_scoreboard,
>   I'll gladly tweak that for v2.
>
>> But that is merely a potential future clean-up.  The local variable
>> path is still used one more time in the error message given when
>> this parse_range_arg() fails, so at least this change makes the use
>> of path more consistent.  I like the simplicity of this fix.
>
> I also like its simplicity, and that's why I chose to submit this as v1.
> But I completely agree with you that it is "dangerous" in the sense
> that some further modifications to the code could then make the same mistake
> and use 'sb.path' thinking it is defined when it is not.
>
> So I'm thinking of instead initializing it in setup_scoreboard for v2.

That does sound like a sensible way to clean it up.  Thanks.
