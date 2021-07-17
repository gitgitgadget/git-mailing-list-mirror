Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAEFC636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229D0613D3
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 05:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhGQFYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 01:24:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57020 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhGQFYk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 01:24:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB0AE4896;
        Sat, 17 Jul 2021 01:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8kYD17qKe+E9ZPjIwrogWL+BglqR55CTW++9Gs
        Cq3Ak=; b=jecaq0oo/KBMd/xuwQ4YBMyLglYWt+EU5TBLzHX2LS3a/+KP4osSiI
        u3dwR4qdCHBgCoYXMR2qRaG+P7p+AXB662pEGRPeAuMdVjQxxOmAZUHKctCctEST
        sS3ApSLiUKrfupPeUM6N8nbYip+i62NmOMHLMIbaI1qeY0YER/tKE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0264AE4895;
        Sat, 17 Jul 2021 01:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FD25E4894;
        Sat, 17 Jul 2021 01:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
        <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
        <87v95tbqgh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2107161747010.59@tvgsbejvaqbjf.bet>
        <87y2a6w61l.fsf@evledraar.gmail.com> <xmqqa6mlplo7.fsf@gitster.g>
Date:   Fri, 16 Jul 2021 22:21:42 -0700
In-Reply-To: <xmqqa6mlplo7.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        16 Jul 2021 22:13:44 -0700")
Message-ID: <xmqq5yx9plax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFA7CB06-E6BE-11EB-8579-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> #!/bin/sh
> cat >make.file <<\EOF
> all::
> ifeq ($(FSMONITOR_DAEMON_BACKEND),)
> 	echo it is empty
> endif
> ifdef FSMONITOR_DAEMON_BACKEND

An obvious typo.  This must be "ifndef", of course.

> 	echo it is undefined
> endif
> EOF
>
> echo "unset???"
> make -f make.file
>
> echo "set to empty???"
> make -f make.file FSMONITOR_DAEMON_BACKEND=
>
> These two make invocations will give us the same result, showing
> that "is it set to empty" and "is it unset" are the same.
