Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D205BC433E0
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9E164EE1
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTDcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:32:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51185 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhBTDcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:32:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 832109D621;
        Fri, 19 Feb 2021 22:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PCMQRpTfDcPlkQXZm1oI3OMpCcI=; b=iZDxVC
        FPV+KS3GMx6cshsnaysK6kh9AaVUO2scOaeZow3ZztCGAyAkDw6A6I7nd9E25Dw/
        ieN9CXRGTLCbJ+C/y5EpsS/9kjT6nhFdQ45WufYEkyVDyGduCsuDbS6Ou9Th7n3S
        s622N+qj/Rp7b3+Ql6XpsCiQFlTcPIAJan/Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jmCI/r/AbvtZTTt4u/atNUEzO8wFto3F
        Jf8IiPFXp2wvgDkZQxYBE/gZkhFab+wVMtTjgOR0D9RisH/GT8wuA2pWASITUhkJ
        AnwoiE9+V35Usdsg4iOxBcz7Y22Qy29/bEvYBYMaceKkYY0MdsXpigOLMREI5k22
        Evgj8k/SSdM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 788359D620;
        Fri, 19 Feb 2021 22:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA6B89D61F;
        Fri, 19 Feb 2021 22:32:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        me@ttaylorr.com, peff@peff.net,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/5] Speed up remove_redundant()
References: <pull.852.git.1611851095.gitgitgadget@gmail.com>
        <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
        <7a1a8990-59e7-d538-d382-446fdc270810@gmail.com>
        <xmqq8s7lc61j.fsf@gitster.g>
        <4ca2931f-3e3c-12d5-e12a-6c63699a98d7@gmail.com>
Date:   Fri, 19 Feb 2021 19:32:07 -0800
In-Reply-To: <4ca2931f-3e3c-12d5-e12a-6c63699a98d7@gmail.com> (Derrick
        Stolee's message of "Fri, 19 Feb 2021 07:17:32 -0500")
Message-ID: <xmqqeehb9zyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35980848-732C-11EB-A515-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 2/18/2021 6:25 PM, Junio C Hamano wrote:
>> This topic seems to have been forgotten?  Is the only thing missing
>> is an updated 2/5 or is there anything more that is needed?
>  
> I had forgotten about the comments on patch 2/5, sorry. That explains
> why it hasn't merged yet...
>
> I'll get right on it.

Thanks.
