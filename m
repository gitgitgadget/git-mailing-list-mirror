Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C24C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 23:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJXXbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiJXXaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 19:30:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E1D8F4F
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:51:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 454031406AB;
        Mon, 24 Oct 2022 16:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nmgu+cVT2Q/ODTtvzFLrVXe3JHoVCVBRT/j3KC
        rGOBU=; b=tNjY1ZwryQQrB5jeOsG5dhyxkyHJl8D1JTz2Fc9UO6xawgJ4RuWvb3
        eix8oD/xBuqCKwh89emLq45WGYYQgxj5eLR56x+ULjm1iwdOX4XXbz3BmsTzwTPj
        LmlLYOgTunoFh8Lz1tYA4PwkOQINIsZwLmvjZsY5WIHiuoWX77A+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EC2E1406AA;
        Mon, 24 Oct 2022 16:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76D301406A8;
        Mon, 24 Oct 2022 16:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/4] builtin/repack.c: pass "cruft_expiration" to
 `write_cruft_pack`
References: <cover.1666636974.git.me@ttaylorr.com>
        <7d731d8dd5ebe0570a5dd8a88b3dd3104a79592a.1666636974.git.me@ttaylorr.com>
Date:   Mon, 24 Oct 2022 13:50:45 -0700
In-Reply-To: <7d731d8dd5ebe0570a5dd8a88b3dd3104a79592a.1666636974.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 24 Oct 2022 14:43:06 -0400")
Message-ID: <xmqq5yg9rlne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88B92F82-53DD-11ED-BFC7-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> `builtin/repack.c`'s `write_cruft_pack()` is used to generate the cruft
> pack when `--cruft` is supplied. It uses a static variable
> "cruft_expiration" which is filled in by option parsing.
>
> A future patch will add an `--expire-to` option which allows `git
> repack` to write a cruft pack containing the pruned objects out to a
> separate repository. In order to implement this functionality, some
> callers will have to pass a value for `cruft_expiration` different than
> the one filled out by option parsing.
>
> Prepare for this by teaching `write_cruft_pack` to take a
> "cruft_expiration" parameter, instead of reading a single static
> variable.
>
> The (sole) existing caller of `write_cruft_pack()` will pass the value
> for "cruft_expiration" filled in by option parsing, retaining existing
> behavior. This means that we can make the variable local to
> `cmd_repack()`, and eliminate the static declaration.

Looks good to me.
