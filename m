Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2981EC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B3D21D7F
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GgLGdmd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgJOQJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:09:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51667 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbgJOQJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:09:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 170DE864CA;
        Thu, 15 Oct 2020 12:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FrkaLr3DRvX7YTj0Af4FgWd4//Q=; b=GgLGdm
        d3ZojgQKZZX2GbHfmuMOOAQBwDa0JbwykBW7iXvBxqcTJrkUN/HQX8T7hRJm+AKX
        aX7kx60ypb++3RpV1CEtBYnqlrqbE0ByVQ3TtnO+9fJ40fx4kFeMKveopqA54wrH
        2OCeA3XXzfwWSu12v5mMyNiKDlZo7S2js0AFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D+9+R5vLm/L26j2e8DmK2+yUAv3lnwoC
        LvuD23uqc66BuCWae1edfSUthUsoQByGe5CaTe9b6WPQa1VfZXjdlwSQda4Clzai
        RpXmqAXvtb4lnDcFLItoSwmFk2L+Y7CZ5yQ2fiWw35YR/NB/1G05RYsANW1O5lJp
        TnfINy6G/bg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EC4E864C9;
        Thu, 15 Oct 2020 12:09:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C848864C8;
        Thu, 15 Oct 2020 12:09:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by
 substring/regex with --run
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
        <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
        <20201014170413.GB21687@coredump.intra.peff.net>
        <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
        <20201014180707.GB24279@coredump.intra.peff.net>
        <CAPc5daU_aw=yWPKHG1XGt4X5A1AkEXeLfCmHqqVfZ+FzBD7nxg@mail.gmail.com>
        <CABPp-BE0_u=TAJKUGUTLrZbg8vk2MFYmfscT_+MgYwAS2rV8Aw@mail.gmail.com>
        <20201014194926.GB365553@coredump.intra.peff.net>
Date:   Thu, 15 Oct 2020 09:09:35 -0700
In-Reply-To: <20201014194926.GB365553@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 14 Oct 2020 15:49:26 -0400")
Message-ID: <xmqqa6wnii80.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D19A9886-0F00-11EB-91F5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thinking on it more, globs are probably a more natural fit here.
> Especially if we do eventually allow selection of scripts by name, too
> (e.g., for GIT_SKIP_TESTS), matching those filenames with a glob would
> match what happens on the command-line.

Ah, I didn't think of "match with filenames" but yes that is a good
complement to our "match with test titles" to be consistent with.

Thanks.
