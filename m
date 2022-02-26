Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A0C433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 01:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiBZBg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiBZBg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 20:36:57 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D859207A2B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 17:36:20 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F34F118EAE4;
        Fri, 25 Feb 2022 20:36:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eUIaiM9dnekBTjWLTqLYd/Jvx1au42WnmdcL5f
        08ZCE=; b=ajXvYxXOcRWjOHPmqMepQRZQx5FurVxXgAosdh9ez4xJ6c27YPPE8p
        RfezYFNLUTcjWGbIf+An0NRNxQt7732q7uKPWwmZBBDj7yQzxr8sKGbB6VS+34ct
        9rn6Tioy0KhcnSlqvqE4Ai/AjtTA3HWhPxD9fNmkGf+nTl5KZgoAs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAAE218EAE3;
        Fri, 25 Feb 2022 20:36:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C86F18EAE1;
        Fri, 25 Feb 2022 20:36:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com>
        <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com>
        <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
Date:   Fri, 25 Feb 2022 17:36:16 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 25 Feb 2022 16:36:30 +0100
        (CET)")
Message-ID: <xmqqpmna76jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DF996A0-96A4-11EC-854E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Add checks to the `parse_options_check()` function to check usage
>> strings against the style convention.
>
> As I just pointed out in
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejvaqbjf.bet/,
> it seems that replacing the static check presented in v1 by a runtime
> check needs to be reverted.

Sorry, but I am not sure how that conclusion follows from a breakage
in a topic in flight that was discovered by the check.

I do not know if a coccinelle based solution is sufficiently easy,
simple and robust enough to encourage us to scrap what has already
been proposed and reviewed, instead of leaving it as a topic for a
future incremental improvement that we can make on top.

> In addition to the example I presented, there is another compelling reason
> to do so: with the static check, we can detect incorrect usage strings in
> all code, even in code that is platform-dependent (such as in
> `fsmonitor--daemon`).

Yes and no.  

I would imagine that large enough platforms that have their own
conditionally compiled #ifdef/#endif block already have CI to build
their conditionally compiled block in practice.  I do not see the
above as a compelling reason to grow and shift the scope of these
two patches.

Thanks.
