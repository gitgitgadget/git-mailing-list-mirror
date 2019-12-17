Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360CC2D0BF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25C62176D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 20:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZbE5Tva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfLQUX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:23:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53051 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfLQUX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 15:23:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCA8F9BA26;
        Tue, 17 Dec 2019 15:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGKetz/JtCm4csif2VovKZnDLto=; b=VZbE5T
        vakLFY14a9n7xc/6F8cPq8R8SL6nbGSFZoBQpb+IIHEAu/1ZuPVK7a7SC5T6/iiQ
        uxakSv9/54Bdr/ZAweCRcpNHTZekZwI4EcJsHqE7/Of7I34cQHy0Kt19DmTFxDBG
        DNlCMqJfmMuDjTOAl2iqcRoyogN5UBcXTS3lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WGsGQXjqrl+bfGZjPkZ5UXZvPYDhJrgd
        aH6vV1oLwvzrQjTaVoy8k14DEBe52F4azCFgVfMwM6Qvl82z8jT6EicebFd0ymrW
        OTyCpYaN7Zux2PTNhv+HkvUC8195cbUipHra0sIy3Y712Ql7W6mF11Plj7SKKGeP
        MSfe//YxU+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5CD49BA23;
        Tue, 17 Dec 2019 15:23:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDEA39BA21;
        Tue, 17 Dec 2019 15:23:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/7] stash/reset/checkout -p: optionally use the add --patch backend written in pure C
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 12:23:49 -0800
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 17 Dec 2019 10:40:57
        +0000")
Message-ID: <xmqqmubqg0q2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23F61824-210B-11EA-8B5B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> At this stage on the journey to a fully built-in git add, we already have
> everything we need, including the --interactive and --patch options, as long
> as the add.interactive.useBuiltin setting is set to true. This config
> setting is kind of a feature flag that is currently turned off by default,
> and will be for a while, until we get confident enough that the built-in
> version does the job, and retire the Perl script.

Except for a few things that are all minor I already mentioned, and
that I'd need to think a bit more to form an opinion on 6/7 and 7/7,
they all looked quite straight-forward.

Will queue.
