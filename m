Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A03C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397AE20882
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCWUcWU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDVSXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:23:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60616 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVSXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 14:23:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2E43C333D;
        Wed, 22 Apr 2020 14:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Are32WNN25wsW5q2XOkHVIleWoU=; b=iCWUcW
        U6c/6kfkRgrswdVew6YX4YJwF4fyQoFUv3r1b0cplLCrt8C4c3/qia7Jl8kP8aCQ
        kaW8pNmZvh5id2KLAI/JFmbI6Y1d4yPBi0GELGgm1WZ60fCyI+R92Gj+lrAGV+KN
        hPlaQNBJPv99LbkYrpUgSwHaoCahJPwI1KUCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OHvHBEkWdUtrd3uLeC3TrVnSTKcNCOFe
        CKwiiI3peHp6rc7SFR1OXn/jRW9MZWAddSLNi6+LWvOJtnNx502X7/AXlM2DCU4c
        YqGw6vyGL1b/eEldU/GCHhx6bYjNq3wYxeST/jF8eGe2TpvgT9a2DGgZSO3pG03n
        sTVZ4viRVZ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 883E2C333C;
        Wed, 22 Apr 2020 14:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAF48C333B;
        Wed, 22 Apr 2020 14:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Lubomir Rintel <lkundrak@v3.sk>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "Dixit\, Ashutosh" <ashutosh.dixit@intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Revert "fetch: default to protocol version 2"
References: <20200422084254.GA27502@furthur.local>
        <20200422095702.GA475060@coredump.intra.peff.net>
        <20200422155047.GB91734@google.com>
Date:   Wed, 22 Apr 2020 11:23:25 -0700
In-Reply-To: <20200422155047.GB91734@google.com> (Jonathan Nieder's message of
        "Wed, 22 Apr 2020 08:50:47 -0700")
Message-ID: <xmqqtv1bidlu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BDC8754-84C6-11EA-AD37-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This reverts commit 684ceae32dae726c6a5c693b257b156926aba8b7.
>
> Users fetching from linux-next and other kernel remotes are reporting
> that the limited ref advertisement causes negotiation to reach
> MAX_IN_VAIN, resulting in too-large fetches.
>
> Reported-by: Lubomir Rintel <lkundrak@v3.sk>
> Reported-by: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

With the one-liner fix for resetting the "we haven't heard an Ack"
timer, I am no longer so worried by hurting users by keeping them on
v2 by default, but it will take some time for the fix to trickle
down from the 'master' track to a maintenance release, so I am OK to
apply this patch in the meantime.  But let's flip the default back
to v2 after the one-liner fix lands to see if (1) the fix truly
helps and (2) people hit other issues in the difference between v0
and v2.

Thanks.
