Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA1C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159652225E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jmDe2V6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKCBDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:03:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61037 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:03:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3AD290B87;
        Mon,  2 Nov 2020 20:03:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fJFVBJd/+7b5p03eXJ5854k76jU=; b=jmDe2V
        6lKX42boJ0d/C2446Ai5ukiFemd7alrfg/1Pp72Oa+36NcdbXTw9UTN46jDaRB9v
        Bq39P1ba8RHrw5gB3H6dTgjeTuvCJIYCkPfX8bnT2zxVGj807lQpSp8che+39t6U
        ARz2KO1Gm1vNG9uIM/qYkn7y37X6ijschpr5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P8luILec8nlO7z7JeQeFxXxj5vTkxxWG
        bCLQFpxeIgzB2k3elFFYwD39jYbAvS2ckos2Mw36XsvdLIuftG9UmyigLhqkjt33
        Hs7dNDptCdyWkU7TD6MGz4vUg3KJw/EhpqQLkFO8pf1Ay12wOljd075luDwUriPK
        o/AbTD9UH0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA2F990B86;
        Mon,  2 Nov 2020 20:03:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E14F90B85;
        Mon,  2 Nov 2020 20:03:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 0/4] Beginning of new merge strategy: New API, empty
 implementation
References: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
        <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 17:03:27 -0800
In-Reply-To: <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Mon, 02 Nov 2020 23:45:30
        +0000")
Message-ID: <xmqqtuu7p7z4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 621F71BA-1D70-11EB-B1A4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In this series, I show the new merge API I have developed in merge-ort, and
> show how it differs from that provided by merge-recursive. I do this in four
> steps, each corresponding to a patch.
>
> Changes since v4:
>
>  * Fix a bug where 'cherry-pick --continue' would report 'fatal:
>    cherry-pick: --strategy cannot be used with --continue' when pull.twohead
>    was set to ort (found by user of internal deployment at $DAYJOB)

Will replace.  Thanks.
