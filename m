Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70173C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 05:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417DF64DF6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 05:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBHF40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 00:56:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56280 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBHF4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 00:56:21 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A65DC11748E;
        Mon,  8 Feb 2021 00:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YPPdJODlSni5/pbhRYX+29qAiEg=; b=VkI6ZU
        3M1VXKuTUC34xk08thYW6RjkwnoxX2ivftHdC3vP2suA05Gp+kxru6WfnK8BNef3
        iB8mu0rY8146CPVtKyFrhFVdy64Vz4V9YJhSizeaZQJrqIpKpqPNS+akUOb9VYxO
        k297dCEVo5Gxzn6d7XuJ170ixwywULJK1zcmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FyQ27cIe7acBLUIBeWNg+fxBbby4YVi3
        5hEC7V5zUH3dxEu7afq9iclUy4CK76fuiscCgs/w+I+xxscZyiaI9RnKSIjwn129
        CJ5uC7QrcOZjrLNJC92MLiExei+iP2qWGAcbArwAPgMRshy7troab77pMeCyVIe4
        osQ3J1voXbg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E2E211748D;
        Mon,  8 Feb 2021 00:55:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6EA3117488;
        Mon,  8 Feb 2021 00:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        abhishekkumar8222@gmail.com, Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
        <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
        <YBn3fxFe978Up5Ly@google.com>
        <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
        <xmqq7dnpewg4.fsf@gitster.c.googlers.com>
        <20210207190415.GB1015009@szeder.dev>
        <xmqqh7mn7i3m.fsf@gitster.c.googlers.com>
        <74f1eeab-3211-71e5-c83c-19c0b7c0257d@gmail.com>
Date:   Sun, 07 Feb 2021 21:55:35 -0800
In-Reply-To: <74f1eeab-3211-71e5-c83c-19c0b7c0257d@gmail.com> (Derrick
        Stolee's message of "Sun, 7 Feb 2021 21:01:44 -0500")
Message-ID: <xmqq8s7z6r3c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43FD18BE-69D2-11EB-9CE6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The reflog _might_ have something of value there, but the hope is
> that very few commits are actually being force-pushed away. The focus
> is to prioritize the deep history, and it would definitely be an
> anti-pattern if the commits in the reflog are so numerous that they
> must be tracked by the commit-graph. Of course, skipping the --reachable
> option enables a way to gather these commits as necessary.

Sure.  As long as gaps in commit-graph coverage only affect
performance and never correctness (e.g. even if the things that are
only reachable from reflog entries are not covered by commit-graph,
when 'git prune' wants to know if an object can safely pruned, we
will correctly say "no, do not prune it yet"), that is perfectly fine.
