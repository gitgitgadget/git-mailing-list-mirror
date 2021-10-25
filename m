Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB6BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE1460F9D
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 09:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhJYJk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:40:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64891 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhJYJk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 05:40:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1350BD8786;
        Mon, 25 Oct 2021 05:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=aQn/E0CsPYdIFOZBwJaHxh3IZ
        uwRubxs8mVYe18uCXc=; b=ESIFLxte9dVRk3RuKVveCeWfgD3LhFFP1Y3mR/yDd
        5IuTRhBpXZzb2guT72DQ2VM7zlEJHAqZUAisHkma+MIXoJHZNAAHb8ifQdWJnt1a
        fwE/BDoYw82N6YpTq6FfEMwutGHA6zHlDC/I6CW3ygnVAI1bs8xUpA3uCezqIvLq
        /A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04DF0D8785;
        Mon, 25 Oct 2021 05:38:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5032FD8784;
        Mon, 25 Oct 2021 05:38:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 10/10] progress.c: add & assert a "global_progress"
 variable
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
        <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
        <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
        <20211025050202.GC2101@szeder.dev>
Date:   Mon, 25 Oct 2021 02:38:04 -0700
Message-ID: <xmqq35op4f7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 413BFCC8-3577-11EC-8D42-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I still very much dislike the idea of a BUG() in the progress code
> that can trigger outside of the test suite, because the progress line
> is only a UI gimmick and not a crucial part of any Git operation, and
> even though a progress line might be buggy, the underlying Git
> operation is not affected by it and would still finish successfully,
> as was the case with the dozen of so progress line bugs in the past.

I too recall that we have fixed numerous bugs in the past year in
the area, but weren't they kind of obvious ones _once_ they are
pointed out at you (e.g. progress never reaching to 100%)?  Yet the
developers have failed to catch them because their eyes would coast
over without paying attention to them, exactly because the progress
bar is merely a UI gimmick.

I haven't formed a firm opinion on this yet, but I think the idea
behind these BUG() is to help such problems be caught while they are
still in the lab.  You may not notice when your live progress bar
behaved a bit funny, but if you hit a BUG(), that would be squarely
in your face and you cannot ignore it.
