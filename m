Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D57DC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06132087E
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CebnyrgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUSY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:24:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:24:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4929C5711F;
        Tue, 21 Jan 2020 13:24:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=al64t5wB3F0MLSyKRmX+FZeRwBc=; b=Cebnyr
        gPvosTUbaWExyJy+l2VXSZUiq0r/oHtXUL5qh6mDHxFIO8vzIhHius3qHheFdQch
        GHL/z5DyHSGSEJ/1XFOvt2wTZUqm+6JHxdCXSj1rP2oZrgD4c1acAGI1/U7PsZ5i
        hbkLLj92sW5RhhlWTzb+LadZtm/FTDsb18kCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Se/Ay4geD3+d6qV79hAnVGabzuSuWhvZ
        HOJS0UCGepmqUo1I2z+f/zzh2bHej9PIMnZspi8Z8Fp51lzilr83ix50IbnW0GHi
        tBWhA7PAU19jnB5vwtVwzajuM0QAij5mCl6XqSa7HB2Z+o5PgCYV9OVnNvs/L1sl
        cHE20bCrpn0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AD45711E;
        Tue, 21 Jan 2020 13:24:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA9945711D;
        Tue, 21 Jan 2020 13:24:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] fetch: document and test --refmap=""
References: <pull.532.git.1579274939431.gitgitgadget@gmail.com>
        <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 10:24:24 -0800
In-Reply-To: <pull.532.v2.git.1579570692766.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Tue, 21 Jan 2020 01:38:12
        +0000")
Message-ID: <xmqq1rrsbrc7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40FC42E6-3C7B-11EA-8BDE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> To prevent long blocking time during a 'git fetch' call, a user
> may want to set up a schedule for background 'git fetch' processes.
> However, these runs will update the refs/remotes branches due to
> the default refspec set in the config when Git adds a remote.
> Hence the user will not notice when remote refs are updated during
> their foreground fetches. In fact, they may _want_ those refs to
> stay put so they can work with the refs from their last foreground
> fetch call.
>
> This can be accomplished by overriding the configured refspec using
> '--refmap=' along with a custom refspec:
>
>   git fetch <remote> --refmap= +refs/heads/*:refs/hidden/<remote>/*
>
> to populate a custom ref space and download a pack of the new
> reachable objects. This kind of call allows a few things to happen:
>
> 1. We download a new pack if refs have updated.
> 2. Since the refs/hidden branches exist, GC will not remove the
>    newly-downloaded data.
> 3. With fetch.writeCommitGraph enabled, the refs/hidden refs are
>    used to update the commit-graph file.
>
> To avoid the refs/hidden directory from filling without bound, the
> --prune option can be included. When providing a refspec like this,
> the --prune option does not delete remote refs and instead only
> deletes refs in the target refspace.
>
> Update the documentation to clarify how '--refmap=""' works and
> create tests to guarantee this behavior remains in the future.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks.  Looks quite good.

Will queue.
