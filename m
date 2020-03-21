Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B26C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60020663
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mMIZGCUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgCUTY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:24:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52558 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgCUTY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 15:24:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E90851260;
        Sat, 21 Mar 2020 15:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9nxZ/GEzqiG6w0f0vWcyrywJdhw=; b=mMIZGC
        UFymP+KTWQ1LDWhhCvT2gww4atibEtSfnTo/STmmvbvy5QFq1IFYVh+/hlEvfgF+
        DnWTkjblc7ijJf43keZLtP6QLAFK/7xDt9COdfSxMoYzuE0fPTFOHpgXIfSfmPIz
        JpsBfxzu8euLxaZeeqh597EliWIHxOrxD5P5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h3aIYx9UQyLwOhNrdl3FAp4Sz0FYhk3u
        +8G8F1MnDnl01K1cfMMQxg4Pi4nK6KP564JEEvinTXYx5Dd27i00HKjVPcQ69D78
        hF5B+uiex3RA9lJvG0wp6BG3OJnz/hU+ksj9omdZeZ6WRHrsyDN2j9/1G7RzAkng
        aaHXkZ4fP4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 346455125E;
        Sat, 21 Mar 2020 15:24:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD0105125C;
        Sat, 21 Mar 2020 15:24:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Lib-ify functions in builtin.h
References: <cover.1584786523.git.liu.denton@gmail.com>
Date:   Sat, 21 Mar 2020 12:24:24 -0700
In-Reply-To: <cover.1584786523.git.liu.denton@gmail.com> (Denton Liu's message
        of "Sat, 21 Mar 2020 06:29:21 -0400")
Message-ID: <xmqq36a1a4uv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 938B670A-6BA9-11EA-BA0B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In builtin.h, there exist a couple of functions that are very lib-ish.
> Extract these functions into their own files which should make more
> organizational sense.

"very lib-ish" feels a bit subjective, but I agree that among those
functions that are currently only allowed to be called from a
built-in command (hence, cannot be called from anything in libgit.a
or non-builtin commands like transports), there may be some funtions
that may make sense to be callable by non-builtin users of libgit.a
(e.g. cgit perhaps?).

I do like the direction these patches are taking us to.  I just do
not know how best to phrase it, and having trouble coming up with a
non subjective description.

Thanks.

> Denton Liu (2):
>   Lib-ify fmt-merge-msg
>   Lib-ify prune-packed
>
>  Makefile                |   2 +
>  builtin.h               |  16 -
>  builtin/fmt-merge-msg.c | 655 +---------------------------------------
>  builtin/prune-packed.c  |  44 +--
>  builtin/prune.c         |   1 +
>  builtin/repack.c        |   1 +
>  fmt-merge-msg.c         | 653 +++++++++++++++++++++++++++++++++++++++
>  fmt-merge-msg.h         |  13 +
>  prune-packed.c          |  43 +++
>  prune-packed.h          |   9 +
>  10 files changed, 724 insertions(+), 713 deletions(-)
>  create mode 100644 fmt-merge-msg.c
>  create mode 100644 prune-packed.c
>  create mode 100644 prune-packed.h
