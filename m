Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE7C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 17:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiG1RhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1RhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 13:37:19 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0672EFD
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 10:37:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FFE019CEBA;
        Thu, 28 Jul 2022 13:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yTQPncOXJ/9Fehyb/BjlS6/OKzoSYG/SB03gqh
        1f30U=; b=GgR6nrI9NINKa5Jrxz/Taybo2fN68kishQ7OMOX/7SpbALZmCfBHup
        mOfrXS/xPWZljsuFn855KYVdFpsBVuehQgLC7YItUX0sUIbhYt1YBXqcmQAvYUVg
        8jn6qbX4F30acpZu3SvSSXSNN714DOXYsCGEOCZiXrTz3gMpmDV/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A05919CEB9;
        Thu, 28 Jul 2022 13:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6C1819CEB8;
        Thu, 28 Jul 2022 13:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] lstat(mingw): correctly detect ENOTDIR scenarios
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
        <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com>
Date:   Thu, 28 Jul 2022 10:37:13 -0700
In-Reply-To: <pull.1291.v2.git.1659018558989.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 28 Jul 2022 14:29:18
        +0000")
Message-ID: <xmqq8rodcf5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB4603B4-0E9B-11ED-8CCE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In that code, the return value of `GetFileAttributesW()` is interpreted
> as an enum value, not as a bit field, so that a perfectly fine leading
> directory can be misdetected as "not a directory".

Nicely analyzed.  So after all ENOTDIR was a buggy response and by
fixing it we help all callers of lstat(), as pointed out in the
earlier review.

>      * Thanks to Eric's excellent review, the reporter and I dug deeper and
>        figured out the real bug (and fix).

Yeah, thanks all.

Will queue.

