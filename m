Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B69C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFF720787
	for <git@archiver.kernel.org>; Tue, 26 May 2020 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KS3/PfLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEZPVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 11:21:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56344 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgEZPVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 11:21:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D40AAB8533;
        Tue, 26 May 2020 11:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9dggKvRsHIg3Fvmfz688IfSC31c=; b=KS3/Pf
        LSiuJrFI+zDf+g/qMDVNXbYkH9y3bWodRI4mvO5HERUi1AlWPbs2evcwArORSqfl
        6qb80gn4H0WlilPTtJNgIdNylfLoLf2rzAXV8RQTES3XrycPh+LhCjBrkMq3GsBE
        M4fmGWWzDKWgVo4R/qNHDPCrNjBPzo485ao2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cea5+xLXZmZ6phsAR63bJAPdDy710xVK
        n0+mDN1/RgqwDctRjw6953xNPW3/IOOiTtWvjXQrOiEKrE0iEzCCElPKNdXNRW/2
        kF7TH7XttvySO5nOO4hCGUIzv5BeuqktE/RT7LRL7zmlDCJUFIuvq9lNkhjnuXT8
        SrTNQKm7tjI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB555B8532;
        Tue, 26 May 2020 11:21:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17627B8531;
        Tue, 26 May 2020 11:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Assessing about commit order in upstream Linux
References: <20200526065320.GA18107@lxhi-065.adit-jv.com>
Date:   Tue, 26 May 2020 08:21:25 -0700
In-Reply-To: <20200526065320.GA18107@lxhi-065.adit-jv.com> (Eugeniu Rosca's
        message of "Tue, 26 May 2020 08:53:20 +0200")
Message-ID: <xmqqr1v6oh6y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91471284-9F64-11EA-AB30-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eugeniu Rosca <erosca@de.adit-jv.com> writes:

> So, the two approaches lead to different results. If you see any false
> assumption or mistaken belief, could you please pinpoint that? TIA.

Perhaps the assumption/belief that the set of commits in a history
can be totally ordered is the issue?  When multiple people work
together on a project, especially in a project where "pull --no-ff"
is not enforced, there can exist only partial order among them?

