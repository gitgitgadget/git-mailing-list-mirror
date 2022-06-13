Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344231AbiFMUZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345301AbiFMUZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:25:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E994
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 12:10:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29FE8136872;
        Mon, 13 Jun 2022 15:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u9lcNhJSVLGD
        bgoIdahPLDyDZLqjcRBPtK5hTt7/V6Y=; b=UUEgYFPv/xIVzOFoBq8pHOKuuYxu
        up/52fjyZt6XWy81EiJHaxzXlroLjWNo7PpIfOyHWxGFcboBYg32YuwUY/H3TuIA
        AiVnzbeHg80kaCz3lCc714e0eSwYQ7U90aU+zqn5YETtkRuRLADSXeKocmqirPZf
        7EOoETNEEb5aAvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EF38136871;
        Mon, 13 Jun 2022 15:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86FF2136870;
        Mon, 13 Jun 2022 15:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/5] archive-tar: add internal gzip implementation
References: <pull.145.git.gitgitgadget@gmail.com>
        <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
        <75e76d0f-2ab0-ebf7-4a4e-7a6e0fca0b1a@web.de>
Date:   Mon, 13 Jun 2022 12:10:25 -0700
In-Reply-To: <75e76d0f-2ab0-ebf7-4a4e-7a6e0fca0b1a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 12 Jun 2022 08:08:35 +0200")
Message-ID: <xmqqilp45qhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B9F02D0-EB4C-11EC-9B39-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> @@ -148,7 +148,8 @@ tar.<format>.command::
>  	format is given.
>  +
>  The "tar.gz" and "tgz" formats are defined automatically and default t=
o
> -`gzip -cn`. You may override them with custom commands.
> +`gzip -cn`. You may override them with custom commands. An internal gz=
ip
> +implementation can be used by specifying the value `git archive gzip`.
>

The new sentence didn't click and I was lost in figuring out what is
set to which value and where, before looking at a test the patch
adds.

I think it is not entirely a fault of this patch, but the badness is
already in the original.  I wouldn't have been as confused if it
were like so:

    The "tar.gz" and "tgz" formats are defined automatically to use
    `gzip -cn` as the command by default.  An internal gzip
    implementation can be used by specifying the value `git archive
    gzip` for these two formats.

for example.

Thanks.

