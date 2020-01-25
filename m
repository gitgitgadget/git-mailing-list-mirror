Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12643C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65672073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kRTlJRJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387540AbgAYAKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:10:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbgAYAKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:10:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0CFABDE39;
        Fri, 24 Jan 2020 19:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SgIAAz0BGWbevjZb6/Z7n19gDcs=; b=kRTlJR
        JTeUPlCJjit4NPgV5bNBOmsu7DgoX+jqUt8fjOrs24xSI2PFYhFp2QYfqFoK/Yug
        ZBJdqJNcabyZSQXphf/+Wq0kuMEJ0mlwCGoR0lwizZh9nDmeEVESdrWSoqUu8ttc
        4XTeus8UDdhZe0rPRWXvyxRufYJOCoLOBzNYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VN858fR0eQWt0HyGc/t532i/Vv1G3yBc
        ASuSdpSoa/IBq+umeSGBZSeUaAzNm8G9fTgLtdioa+FlkgwPrVRaZKugCLOh8Pmi
        mDdzmnfMnAvoCEdTrZwK5TePh4WcXMSpIESKLZKnx/ERCuik9JoPs/BqlVoAxvCs
        RJkZ/t5k+00=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C93BDBDE38;
        Fri, 24 Jan 2020 19:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8C29BDE37;
        Fri, 24 Jan 2020 19:10:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 6/6] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
        <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
        <xmqqblqszjs9.fsf@gitster-ct.c.googlers.com>
        <CAOjrSZsTZic1daj7zG1tZbgENUxt7XGU3mTJAC4_gdiybFMt0Q@mail.gmail.com>
Date:   Fri, 24 Jan 2020 16:10:13 -0800
In-Reply-To: <CAOjrSZsTZic1daj7zG1tZbgENUxt7XGU3mTJAC4_gdiybFMt0Q@mail.gmail.com>
        (Matt Rogers's message of "Fri, 24 Jan 2020 15:49:38 -0500")
Message-ID: <xmqq8slwcs62.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1057983C-3F07-11EA-AECB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Rogers <mattr94@gmail.com> writes:

> I think this was a mess-up on my end.  I had meant to rename it to
> config_scope_name() (after talking with Bert) but it appears that I
> had messed up, so I think my mistake wasn't to rename the function, but
> to fail to rename it.  So I do apologize.

No need to.  I just wanted to make sure everybody involved is aware
of what others are doing to avoid wasted effort.

Now I do expect the (hopefully) final reroll of your topic, so that
Bert can fork his topic on top of it.

Thanks.
