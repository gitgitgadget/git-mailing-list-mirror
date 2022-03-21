Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCCC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiCUUye (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCUUy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:54:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999ED2FE72
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:53:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39DEA186F83;
        Mon, 21 Mar 2022 16:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hcQhnVGppgvXhyJz3jllFUKc4VAYVvDZUTDwsg
        BKp7Q=; b=RaCsMhnDmQ5lVgk3caDulwx1rJSReexF7Lhk+hYIypsXkD6fkRF85w
        6dm9ytR9KmO7S0r5nJdOwmCZd9axQKmpwsPMa3Mg+lXDp+TIs6VdQ31Pcg9BxWLP
        KRmsaPC36BPY8sbGrM9v+kNyKzBCo1bPEjTwIaUynzzAdVM8DEQKI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A02186F7E;
        Mon, 21 Mar 2022 16:53:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D783186F78;
        Mon, 21 Mar 2022 16:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/3] unpack-trees: increment cache_bottom for sparse
 directories
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
        <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
        <cf8dc50c300a08f54d0cf69c82d4d979922a8143.1647532536.git.gitgitgadget@gmail.com>
        <df403c7b-5152-492a-96b5-575ccc1520de@github.com>
Date:   Mon, 21 Mar 2022 13:52:57 -0700
In-Reply-To: <df403c7b-5152-492a-96b5-575ccc1520de@github.com> (Derrick
        Stolee's message of "Mon, 21 Mar 2022 15:03:01 -0400")
Message-ID: <xmqqr16vvxhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3DAE4B2-A958-11EC-83E9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/17/2022 11:55 AM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>> 
>> Correct tracking of the 'cache_bottom' for cases where sparse directories
>> are present in the index.
>
> Thank you for the detailed background (that I cut from my reply).
>
>> CORRECTING CACHE_BOTTOM
>> -----------------------
>> The problems observed in 't1092' come from 'cache_bottom' lagging behind in
>> cases where the cache tree-based advancement doesn't occur. To solve this,
>> then, the fix in 17a1bb570b is "reversed"; rather than skipping
>> 'cache_bottom' advancement in 'mark_ce_used()', we skip the directory
>> contents-based advancement for sparse directories. Now, every index entry
>> can be accounted for in 'cache_bottom':
>
> I have sufficient background to be confident that you are doing the
> right thing here!

;-)  

The "partly lagging" walking of the index guided by cache_bottom has
been a tricky thing in the unpack_trees machinery, and I am very
happy that we now have two more experts on the topic ;-)

Thanks, both.

