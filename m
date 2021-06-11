Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842BC48BDF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089DC61278
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFKDTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:19:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62347 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFKDTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 23:19:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 889A0D4077;
        Thu, 10 Jun 2021 23:17:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=T9vVIbxNcB3tEqzr0In3f7Paw48NRTW0ubtkxUiIkuw=; b=gnTG
        p530hNvrEN7RA8Z/uzatj5e3SnnKAAbF6si8d1X/Mvb07nmOVRwiVX+jRNmib0s6
        sZGzXq0Uk2GB56hc8kXxD6AL01EhWP1rjHTRu8bOi7/rniJTMXgsL70EL8sXZyLk
        cZxVCWVK9zPDT/YbA2WiMrEbi2OPp1W5WwLS0Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80427D4076;
        Thu, 10 Jun 2021 23:17:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F46CD4075;
        Thu, 10 Jun 2021 23:17:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 5/7] xdiff: rename XDL_MERGE_STYLE_DIFF3
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-6-felipe.contreras@gmail.com>
        <3168eb15-25a6-a3eb-a498-8effa0c79855@gmail.com>
Date:   Fri, 11 Jun 2021 12:17:08 +0900
Message-ID: <xmqq5yyl5buz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82411A02-CA63-11EB-9A7E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The subject would make more sense as 'xdiff: rename XDL_MERGE_DIFF3 to
> XDL_MERGE_STYLE_DIFF3' rather than using the new name of the constant
> alone.

True.

>> If we don't specify we are talking about a style, XDL_MERGE_MINIMAL
>> could be confused with a valid value instead of XDL_MERGE_DIFF3, which
>> it isn't.
>
> I don't object to the rename but what is the source of the confusion
> with XDL_MERGE_MINIMAL?

I do not see any confusion, either, but the current XDL_MERGE_DIFF3
being a boolean (i.e. if false, use the output style of the 'merge'
command) and our lack of an enumeration constant for 'merge' means
that a future addition of the third output style would require us to
add XDL_MERGE_$STYLE for both the new style and the traditional
'merge' style.  And If we would end up with XDL_MERGE_DIFF3,
XDL_MERGE_MERGE and XDL_MERGE_FOO for that third output style.

The 'merge' one simply looks strange in that context.  And from that
point of view, this change might be a good way to futureproof the
codebase.

Thanks.
