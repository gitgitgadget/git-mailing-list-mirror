Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E97DC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 23:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BB72074F
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 23:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZR02Wuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgC1Xvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:51:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61468 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1Xvx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 19:51:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC445E938;
        Sat, 28 Mar 2020 19:51:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SY5gjQbcHBJ/EKQv9zJk6SPDfaI=; b=KZR02W
        uyWe5zJC1F9+h531ZPT3Vqf0PfH8E61RmvUW3FzM26h3vALB33P+PUOd/QdVZIOT
        lTOEffhYxbIERMQ1dlr/elP0b+aztHViXATGhhEsp47bgI7dbuq1e7/vV5sAfLtq
        nMLylMyF0BUywRUCrO/2mwl4SuvCUVDolLeoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TXQ4tEL06baH9dnt3cepZyZA6/uO2r6E
        HvNlwp7vfHvKQaXeIfl6VecUVhLPDLuLunnODI1WyzjbwUaLGrZZkawipJ6f8YX4
        pDxBNJF9mhyPDHOVtOZXe2+afd4ip32Nm8CX6NUzt/1groXgipuOZEyPpI6Vix4w
        6IAvbZtOK68=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 141AD5E936;
        Sat, 28 Mar 2020 19:51:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 971F75E935;
        Sat, 28 Mar 2020 19:51:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v4 1/1] midx.c: fix an integer overflow
References: <20200326213534.399377-1-damien.olivier.robert+git@gmail.com>
        <xmqqbloiitnv.fsf@gitster.c.googlers.com>
        <20200328222342.jfxsk3gvujgqdt4f@doriath>
Date:   Sat, 28 Mar 2020 16:51:49 -0700
In-Reply-To: <20200328222342.jfxsk3gvujgqdt4f@doriath> (Damien Robert's
        message of "Sat, 28 Mar 2020 23:23:42 +0100")
Message-ID: <xmqqlfnkca22.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17F2BB74-714F-11EA-96A9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> Mathematically I think of this as a truncating in the ring of 2-adic integers,
> but I did not want to write this in the commit message :)

;-)

>> The patch looks good; will queue.
>
> Thanks. I just sent a v5 with a microfix (which is not really important, so
> v5 can be dropped). Since pu is subject to be rewound anyway, I guess you
> prefer a new version rather than a patch on top of v4?

OK, will replace.  Thanks for your attention to the details.
