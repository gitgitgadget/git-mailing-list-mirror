Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F87C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E095207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSoGz5Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHUV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:56:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHUV4M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:56:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BFE77C8E0;
        Fri, 21 Aug 2020 17:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZSVCp4m1+SUoqQGJRrkE4PCh33Y=; b=MSoGz5
        TsNSDBhuT2afmmUZgqaXpRa8g2GONDu7kz1nH+vm8624teRZt7THndFS7J4b+gDQ
        TL4zwmNjSHwVUG4I9qxQtyilcysG0ycppzEh4a7jR6257RUfWwa7StNge9JIz48O
        9WByLZ+Wp37Lu5KR+qIPEJ+HIpxFoVXeRKau8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W8qrqkcbg8WjDWR/fz+3AjzotkIEhDnt
        mSlG9NexZRMOGlB93OnwmlpFuTqeoPxoO1ndKwd+fltt+SwiErvxUf/zt+Z5uVto
        MqsBQvnD0wso9/8Xs3xIk5GKza37o1am92IjXx2VTW4PRKXjYhU/knAUnn7a7rOb
        kct+F6Tnc98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BA597C8DF;
        Fri, 21 Aug 2020 17:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A99A87C8DE;
        Fri, 21 Aug 2020 17:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/4] [GSoC] Fix trailers atom bug and improved tests
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 14:56:09 -0700
In-Reply-To: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com> (Hariom Verma
        via GitGitGadget's message of "Fri, 21 Aug 2020 21:06:12 +0000")
Message-ID: <xmqqft8f7jeu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F2521B2-E3F9-11EA-B8FA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Currently, there exists a bug in 'contents' atom. It does not show any error
> if used with modifier 'trailers' and semicolon is missing before trailers
> arguments. This small patch series is focused on fixing that bug and also
> unified 'trailers' and 'contents:trailers' tests. Thus, removed duplicate
> code from t6300 and made tests more compact.

I think we should focus on completing the first two patches and send
them to 'next' down to 'master', before extending the scope of the
topic by piling more patches that do not have to be part of the
topic.  Let's take the other two separately from the first two.

Thanks.
