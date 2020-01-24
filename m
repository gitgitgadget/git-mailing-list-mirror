Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD05EC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1C2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oqnmVCnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbgAXSMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:12:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390883AbgAXSMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 13:12:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D30524A4BD;
        Fri, 24 Jan 2020 13:12:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=FKBLKmgoo/IKgyKPvrwvbCUfwVA=; b=oqnmVCnKOE7sgwI9fyjw
        x8aGFtiNcPc96FKYxgeoME2mnVOueJJv81Ga4mW4bAnYfAXNiG345X4DR5SLu5SC
        tIw3uYAGW8dEMPPxHbNyYwQ2y7hw7axbTqRDPNwSrqAt01DpgBXrcBdTC3dTNPTJ
        qL2b8ciVRw3v15988M8REeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=uE5vZbaSXcDbR8zeEA3uE8zPhl/R45N5GX8KMq4JFjH7gE
        hhBlxNrVE2bdb8Pf+PtT7Qz8LaSLzl1ybh35EoAivsMekNyqw4sxGAxVAmLAKoyS
        vwIqo5tlNRvCVJjbrVRGX7BW4qh4U9AGXatqlvYOUAhvdrkcRSxkT1Ydg7y/w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C71484A4BC;
        Fri, 24 Jan 2020 13:12:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D7B94A4BB;
        Fri, 24 Jan 2020 13:12:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: stop checking out the tip of the branch to rebase
References: <20200121191857.23047-1-alban.gruin@gmail.com>
        <20200124144545.12984-1-alban.gruin@gmail.com>
        <9221098c-cba4-5db5-5870-bf6af721c448@gmail.com>
Date:   Fri, 24 Jan 2020 10:12:30 -0800
Message-ID: <xmqqv9p0206p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16E78680-3ED5-11EA-8553-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Forget this patch, I forgot to clearly say that the `am' backend is not
> affected.

The phrase "is not affected" makes it sound like "Do not worry, I
made sure it is not broken by this patch", but I do not think that
is the more important part ;-).  

The shared codepath for all types of rebase before dispatching
already knew what commit at the tip of the branch being rebased is,
but the sequencer-based backend was doing unnecessary work to figure
it out again by checking it out.  And this patch is about fixing
that, isn't it?

So I do not think singling out 'am' is a good use of readers' time.
The first paragraph can be further tweaked why the extra checkout is
unneeded.

    Before dispatching the control to one of the individual rebase
    backends, the shared codepath in "rebase" figures out what
    branch is being rebased, because it is necessary to compute the
    range of commits to replay to run any backend.  The rebase
    backend based on the sequencer machinery (used for '-i', '-r'
    and '-m') however computed this commit range by actually
    checking out the branch and reading HEAD, which was unnecessary,
    as the working tree is then immediately gets reset to that of
    the commit on which rebased history is built (aka "onto"
    commit).

or something along the line, perhaps?

With this patch applied, the wasteful prepare_branch_to_be_rebased()
has no caller, and the patch removes it from sequencer.[ch] as well,
which is very good.


