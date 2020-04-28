Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213D9C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD98220737
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 23:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hi1/hnO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgD1XWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:22:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51648 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgD1XWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 19:22:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 520B04E575;
        Tue, 28 Apr 2020 19:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iTTPY/+LZ1hAHKvlLebvFwIIPzY=; b=Hi1/hn
        O1DAlxE63iVwviLwe/NWs9x4YOHIsDXOGffsdAhlfhx0DFbPSsg4YELloPxYsMxL
        z8tZofcLI4uUpjEbtiu1wbzt2ktVSqGZUfdIiafbbJ0Sc4mAiAVu0GGBEMmn4sd9
        Ja2Lf2mWzk3RLtues4mJE016A/XpWyewIDelY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g1eQiTourV6zUQoUd0+o+h8qdJ1OAsDP
        ElziS92FE/C41HxgrSkvPArIosfXKdsWSlZvWDHF96bTedu+7qvx3SzvjEwkVq3D
        ksEPnhTz2Ee/0fkhX5vX8Dq4xMmASslnaQPyxH8jjcRphqLWHkHxXe0L5ytqNAHF
        zXSnR/JuFF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4927B4E573;
        Tue, 28 Apr 2020 19:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC0C24E572;
        Tue, 28 Apr 2020 19:22:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as read-only
References: <cover.1588004647.git.me@ttaylorr.com>
        <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
        <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
        <20200427235935.GA14984@syl.local>
        <20200428033438.GA2369457@coredump.intra.peff.net>
        <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
        <20200428205913.GC4000@coredump.intra.peff.net>
        <xmqqd07r1fu6.fsf@gitster.c.googlers.com>
        <20200428210821.GF4000@coredump.intra.peff.net>
        <20200428214413.GA47690@syl.local>
        <20200428215815.GA8526@coredump.intra.peff.net>
Date:   Tue, 28 Apr 2020 16:22:13 -0700
In-Reply-To: <20200428215815.GA8526@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Apr 2020 17:58:15 -0400")
Message-ID: <xmqqmu6vyz4q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17B531D0-89A7-11EA-AD80-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Apr 28, 2020 at 03:44:13PM -0600, Taylor Blau wrote:
>
>> What do you want to do about the final patch that I stuck on the end of
>> this series in [1]? If I don't hear from anybody, I'll send it as 5/5 in
>> v3 and we can feel free to not apply it if it's controversial.
>
> I have to admit I don't care that much either way about it (see my
> earlier response on three mental models). I'm happy for you or Junio to
> decide. :)

My gut feeling is that our longer term goal (if we had timeperiod
during which the codebase is quiescent enough and infinite energy to
dedicate on code clean-up) among one or your options should be to
consistently create files that are rewritten-and-renamed read-only,
to discourage casual tampering, so I am OK with that 5th patch.

Having said that, I suspect that Derrick and friends are larger
stakeholders in the "chain" file, so I'd prefer to see us basing
the choice on their input.

Thanks.

