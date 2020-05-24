Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F4C433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F25207CB
	for <git@archiver.kernel.org>; Sun, 24 May 2020 16:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t9M98lab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEXQ0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 12:26:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgEXQ0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 12:26:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9058D1355;
        Sun, 24 May 2020 12:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=YWdu/bU4S3Ae8T4zcZx+K4VbRwk=; b=t9M98labR7tDC86UcRCg
        ZH/QSpDO4k8wQc105r2Wa/V9c50yaoeOylEgueilojbS3CgMoO64Yyft7bXMEpsh
        SXqqLUprKMpXb2Hft1ubDQfBg2piq+wcM5Mg1Zr57R6N6qDHwq5mXuzqN23hXgZ3
        LuGQS/uQ7pWohjXn1Ml+RvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=DklnGT6jr9pR7tw8DIGM9hf471bZiLBL/q7krA8/PNXHA7
        WcsvbELnDMaZrMERpwam6G6Grgaz/Xl3AzePe7Mm8WdU5MoPpbPd62eB5PN8Q9Wy
        5Xl188jP2yyg/LbYp95lSZic48E1Kiih+i1W1j1Mkd3IZrmEK69jFPX2/3+EY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2C81D1354;
        Sun, 24 May 2020 12:26:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DD02D1353;
        Sun, 24 May 2020 12:26:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     John Carlissi <johncarlissi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git stable releases
References: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
Date:   Sun, 24 May 2020 09:26:12 -0700
Message-ID: <xmqq367pqoyj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 494C84E4-9DDB-11EA-83C6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Carlissi <johncarlissi@gmail.com> writes:

> I noticed that with 2.16.6 development stopped whereas with the latest
> security update, everything 2.17 and newer got the fix. Is there any
> formal definition as to when a minor version is EOL and no longer gets
> security updates?

Nothing formal, but I try not to give a false sense of security by
backmerging a fix to maintenance tracks that are too old.  Unless
a "fix" is quite trivial, it always risks introducing new bugs,
given that most developers and testers work on the more modern
codebase.  A call to a helper that is made to "fix" an issue may be
safe in today's codebase, but the same helper in the ancient
maintenance track may not have been updated to match what the new
callsite expects it to do, for example.

Limiting backmerging also is a way to encourage people to update to
the latest major releases.

I currently aim to limit to at most four or five of maintenance
tracks.  Each development cycle usually lasts for 8-10 weeks, so
that means the shelf life of a major release is about 8 months at
the most---but sometimes people get greedy and demand backmerging to
way older tracks.  The last one for 2.17.x track was an example.

Of course, the above does not mean distro packagers and managers of
platform specific ports are not allowed to backport the fixes to
older codebase than I cut "official" maitenance releases for.

