Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E98C433C1
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EB6197B
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCSVCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:02:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53178 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSVBu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 17:01:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4307012C35B;
        Fri, 19 Mar 2021 17:01:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mr/8wlaWEirCvkwQQ3tTKNL4mKc=; b=H8XqtQ
        xdGqxUkH+/1bhvzJKqLIgiLsYSR5Bo8uCpz0q+ffMcZnspqzfcHqyH6f9R9AUYcj
        eim7eIhT/X2efg2fMyMVrmKS09mpo7KsULEV1SB0I0US2AKKfVUGx7qesLwawHzL
        BjNQ0kF/3so0Ym09tTKWBn3HjCB5Sh++RtbOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uIZLoorrJw7QOj/qy7Mzhz8zaUOfoPMy
        cRbUc+jYwvFnRIz+gPKaI3tDSe4ApAFq94XZCwOnPIWWIJcvOQ5zKnljYce/Vmyk
        U7Ra+I+qPUhbnjFBrCqCub8prCwFT5lMM53e+wLDcLWoSwnXcMJcpCJN1gt8EOyD
        VgfZCbqAK9I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C15612C35A;
        Fri, 19 Mar 2021 17:01:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E1D312C359;
        Fri, 19 Mar 2021 17:01:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 01/27] *: remove 'const' qualifier for struct index_state
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 14:01:45 -0700
In-Reply-To: <628e16dd3fc7be96d40a7b3201573a71ae7fbbd6.1615929436.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 16 Mar 2021
        21:16:49 +0000")
Message-ID: <xmqqwnu2lux2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 517B7812-88F6-11EB-9D85-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Several methods specify that they take a 'struct index_state' pointer
> with the 'const' qualifier because they intend to only query the data,
> not change it. However, we will be introducing a step very low in the
> method stack that might modify a sparse-index to become a full index in
> the case that our queries venture inside a sparse-directory entry.
>
> This change only removes the 'const' qualifiers that are necessary for
> the following change which will actually modify the implementation of
> index_name_stage_pos().

This step has a bit of interaction with Matheus's "git add/rm" work
in sparse checkout (mt/add-rm-in-sparse-checkout), which I believe
is still in a bit of flux.  I didn't check potential conflicts the
remainder of the series may have with other in-flight topics.

So, I may throw review comments at the patches in this topic as if
they are standalone, but please do not be upset if it didn't appear
in the 'seen' topic.

Thanks.
