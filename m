Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF9C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2740D20872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NleYgleU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgKYXJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:09:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56291 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgKYXJU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:09:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97A55A0016;
        Wed, 25 Nov 2020 18:09:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/ZtXPmWSSPBKijpRMm3//qe2YxU=; b=NleYgl
        eUkbBbiYWaQJDQXwvP/EqP+jZfgNqP7wRZmIbkkZ4aLgEo9tPoL/NXZ3FMQMS6mn
        +swzJTGa2TTSxsemMiMkfcUGI9ys/xDN/yEGw9O4on1G1LHrfUNNZ3gL+4YQ8VPA
        Y9U/CI2Xon0oMT4OKN/nBB9CL8i2NWNeyzvR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iknsmppEjZ4v3imINkNSpVBp0rvNRfBm
        F3pXwH6JQt+X6vDWvdlKF0c62sVce0X0bnCl+i3cDm6W7MbePPEieSCFEZ1Bj3X0
        6yzJ29RmG21gXsutwxA7+z549uRakpSC999itPiRoY3O+mSIVV2302Yo6peCE2rb
        oG8q4gewHLQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E60CA0015;
        Wed, 25 Nov 2020 18:09:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12553A0014;
        Wed, 25 Nov 2020 18:09:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 8/8] maintenance: use 'git config --fixed-value'
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
        <558775f83d7cbf7ad0e2090ab13be404cdf16b24.1606342377.git.gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 15:09:16 -0800
In-Reply-To: <558775f83d7cbf7ad0e2090ab13be404cdf16b24.1606342377.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 25 Nov 2020
        22:12:56 +0000")
Message-ID: <xmqq360xc9ur.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DE27954-2F73-11EB-B998-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When a repository's leading directories contain regex metacharacters,
> the config calls for 'git maintenance register' and 'git maintenance
> unregister' are not careful enough. Use the new --fixed-value option
> to direct the config machinery to use exact string matches. This is a
> more robust option than escaping these arguments in a piecemeal fashion.
>
> For the test, require that we are not running on Windows since the '+'
> and '*' characters are not allowed on that filesystem.

Thanks.  

I was hoping there would be some byte we could use, but it seems
"a[]b" would not work if we go back beyond VFAT or NTFS.  !MINGW
it is, then.

