Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DDC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 15:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiHPPHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiHPPGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:06:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90F128
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:03:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AA4C1A276B;
        Tue, 16 Aug 2022 11:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cewic/Iy7T8KIodsPh0qUImve/MsF3CY0lK8GM
        F65e4=; b=hXGj60niREd+vbMTpGjoSZ/XUIgLc8cL0MbrL3sDM/4HIPvKP8u6je
        BM188rbDL4Z0t7H7J/LpOd7oqgZpuwiNY3/IB1dcuSCDi7Kds07tqUFrxaCUD+j7
        ju8zETjMteRl/SuKfZhr+i19yGleJuYo+8LdyRuYStRk1OtvA9X6k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71ACC1A2769;
        Tue, 16 Aug 2022 11:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12A7D1A2767;
        Tue, 16 Aug 2022 11:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
        <xmqqczd12zhv.fsf@gitster.g>
        <c5b01472-7da9-6051-b127-1a8b8ddd2944@gmail.com>
Date:   Tue, 16 Aug 2022 08:03:42 -0700
In-Reply-To: <c5b01472-7da9-6051-b127-1a8b8ddd2944@gmail.com> (Phillip Wood's
        message of "Tue, 16 Aug 2022 14:50:05 +0100")
Message-ID: <xmqqwnb8xmb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F184A0A-1D74-11ED-8A59-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>>   -	merge_bases = get_merge_bases(onto, head);
>>> -	if (!merge_bases || merge_bases->next) {
>>> -		oidcpy(merge_base, null_oid());
>>> +	if (is_null_oid(merge_base))
>>>   		goto done;
>>> -	}
>>>   -	oidcpy(merge_base, &merge_bases->item->object.oid);
>>>   	if (!oideq(merge_base, &onto->object.oid))
>>>   		goto done;
>> Looking at the change in "git show -W", it seems that this function
>> no longer touches merge_bases at all, other than initializing it to
>> NULL at the beginning and then calling free_commit_list() on it at
>> the end.  Shouldn't it be removed?
>
> There is still the line
>
> 	merge_bases = get_merge_bases(upstream, head);
>
> lower down. I should remove the call to free_commit_list() just above
> that line though as it is no longer needed.

Yup, that is correct.

Thanks.
