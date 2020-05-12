Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42734C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF050206F5
	for <git@archiver.kernel.org>; Tue, 12 May 2020 23:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pEpKwTMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgELXj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 19:39:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63492 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 19:39:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 297845BB83;
        Tue, 12 May 2020 19:39:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+jQoNYdB/1v2Aki8f7WbqJ177Sc=; b=pEpKwT
        MWtU/aH3mYRWNUjERwFDKf97uOapWmUwJpI3zFvedS7lQFYwmse5YztPIJbVVBYl
        ftkumS0n5VSQo0YlFN40mTKadVfMiwgM1t8nVqi9gkuN8A5cDAVr6QK8zwteeWaX
        3bYNymH5VkYNxApmeZPIyKkvTKBUaRsVWr2PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z94McvI0jxGTHmO96ANN8IAXbQiekPd1
        X5CliUPn1EBtdR7bJzd1oZ52A3FkATQtxjW06NYuF0Z68rYIaCcsGqvpDMOvwFj6
        UpO9naDF9YGtDdA6TdmVLNz/yzOxSdEn0pUSTiTcifN5BEJKNe3sz0wYrQ1KQCMA
        8xmE+phOTW0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 203E95BB82;
        Tue, 12 May 2020 19:39:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6EF85BB81;
        Tue, 12 May 2020 19:39:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid pounding on the poor ci-artifacts container
References: <pull.632.git.1589316430595.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:39:26 -0700
In-Reply-To: <pull.632.git.1589316430595.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 12 May 2020 20:47:10
        +0000")
Message-ID: <xmqqimh0afkh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D11E43E8-94A9-11EA-8A22-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Let's switch back to using the Build Artifacts of our trusty Azure
> Pipeline for the time being.
>
> To avoid unnecessary hammering of the Azure Pipeline artifacts, we use
> the GitHub Action `actions/upload-artifact` in the `windows-build` job
> and the GitHub Action `actions/download-artifact` in the `windows-test`
> and `vs-test` jobs (the latter now depends on `windows-build` for that
> reason, too).

I guess this answers a question I sent earlier to the list (our
mails almost crossed, I guess, as two of us were looking at the same
problem at around the same time?).

Hopefully when cmake-for-windows-build topic lands, this can go away
altogether, but that is probably at least 8 weeks away (3 weeks
remaining before the next cycle opens, plus a half of 10 week per
cycle for a typical major release).

Today's final integration (these days I'm pushing out twice or three
times a day) contains this one, and it seems to have passed ;-)

Thanks.
