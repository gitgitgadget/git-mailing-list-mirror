Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC296ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 23:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIUXLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 19:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiIUXLM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 19:11:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93391A6C40
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 16:11:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E398153D7F;
        Wed, 21 Sep 2022 19:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=svOESnBhgtbMp6DmHGaqTLlBag+hVFguYL21ly
        p9NGk=; b=uX6E9Mo2TavssVnCo8fPlYMfY4KET2BWcR1LAHfWMsKrwR8XtP/zDk
        nHVqG/j8SA1Y1vZANVUz90AKcJ5hNaGBhNM5K9Zj4ev3P8DPGJM3UKwqxwKIBJoJ
        jdauwnbVGzuNOG9xIhPKg7YyM52azUc2deouldVWRYFwMWQQcc+do=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86085153D7E;
        Wed, 21 Sep 2022 19:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DEF04153D7D;
        Wed, 21 Sep 2022 19:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] merge-tree: fix segmentation fault in read-only
 repositories
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
        <pull.1362.v2.git.1663798083240.gitgitgadget@gmail.com>
        <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
Date:   Wed, 21 Sep 2022 16:11:08 -0700
In-Reply-To: <CABPp-BGUiDXxv8eQhKQXHcem3ke9e=Q99a_FDExZ5XZYUgir6A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 21 Sep 2022 15:56:37 -0700")
Message-ID: <xmqqpmfoz5kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADD8CB00-3A02-11ED-90D8-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> @@ -473,7 +475,7 @@ static int real_merge(struct merge_tree_options *o,
>>                                               &result);
>>         }
>>         merge_finalize(&opt, &result);
>> -       return !result.clean; /* result.clean < 0 handled above */
>> +       return !result.tree || !result.clean; /* result.clean < 0 handled above */
>
> Thinking out loud, should this logic be at the merge-ort.c level,

True.

> ...  However, I do think
> merge-ort should be returning a negative value for the "clean" status
> in such a case.

True, too.
