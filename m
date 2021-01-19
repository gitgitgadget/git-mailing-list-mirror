Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BCC433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9859B22E00
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390529AbhASADp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 19:03:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390458AbhASADm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 19:03:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 649A6A3ECC;
        Mon, 18 Jan 2021 19:03:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9aa40zBJFKq/gR3DjXaBrCYhTq8=; b=VpGtLqQVC709cFsVgq/p
        NzOhILrZujxJN8HA8csITabTcTqIv6Jx7Rw/SbbpAF5YyJxrYoBRCtljw6ffKXwu
        txky39h2di7ouJAe4HIa4HNb5lgeSDGTXHmGgIu1GF5SW6RKxMU7TnCbvlGcUwt3
        zdFiPheCnM+oyyuAJvVuHls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Zewkr1/Fp8TTv+A+nn6nB4wHRpVjvFPcT3n+knTpd5JOmo
        8+41a132+NUy3WkGG4cVvccxF0RzkjtLKT1dvTOq/jYqSTZNamMDF/aocflu04Oc
        BkjR7AwftXCyxMeHff1k5lY4X0ZOubIL8rhKTewDePmNmOA/eN4V18WpzvXRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 496FFA3ECA;
        Mon, 18 Jan 2021 19:03:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBFC3A3EC9;
        Mon, 18 Jan 2021 19:02:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 00/11] [GSoC] Implement Corrected Commit Date
References: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
        <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <2437ba7c-f9d9-34bd-5e08-eff96cadcf91@gmail.com>
Date:   Mon, 18 Jan 2021 16:02:59 -0800
Message-ID: <xmqqft2xiyj0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1117EFC-59E9-11EB-821A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/16/2021 1:11 PM, Abhishek Kumar via GitGitGadget wrote:
>> This patch series implements the corrected commit date offsets as generation
>> number v2, along with other pre-requisites.
> ...
>> Changes in version 6:
>> 
>>  * Fixed typos in commit message for "commit-graph: implement corrected
>>    commit date".
>>  * Removed an unnecessary else-block in "commit-graph: implement corrected
>>    commit date".
>>  * Validate mixed generation chain correctly while writing in "commit-graph:
>>    use generation v2 only if the entire chain does".
>>  * Die if the GDAT chunk indicates data has overflown but there are is no
>>    generation data overflow chunk.
>
> I checked the range-diff and looked once more through the patch
> series. This version is good to go by my standards.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, both.  I'll give it a (hopefully) final read-over after
replacing what we have kept in 'seen'.
