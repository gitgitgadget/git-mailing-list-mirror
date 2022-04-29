Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B182BC433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379263AbiD2Qry (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354902AbiD2Qrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 12:47:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA431D5547
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 09:44:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D7881880AD;
        Fri, 29 Apr 2022 12:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e+DhpOHMyoE9VMC5aRueLLNNDRs1NHpl3yXpnR
        U+O3c=; b=VJrf0ff6xcahebplOskxsNxB9Gd28pi/H3AuwCWovDTx8K0X2lMPYw
        ZZ60flvYFWhRhX202q6dv2GT1ndnKfiNwqzbq9qbZxU6bEKyCq+J+6cp0HqESi6H
        l5mkbeLZDvLq5Su/OIGO2dPY2jrl4zhTBY7uGcQeFSOQ15+ihnLio=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16A781880AC;
        Fri, 29 Apr 2022 12:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9070C1880AB;
        Fri, 29 Apr 2022 12:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/6] run-command API: replace
 run_processes_parallel_tr2() with opts struct
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <patch-1.6-8bf71ce63dd-20220421T122108Z-avarab@gmail.com>
        <YmsgWj5vPEWNyGFA@google.com>
Date:   Fri, 29 Apr 2022 09:44:28 -0700
In-Reply-To: <YmsgWj5vPEWNyGFA@google.com> (Emily Shaffer's message of "Thu,
        28 Apr 2022 16:16:42 -0700")
Message-ID: <xmqqv8urdekz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A379EB42-C7DB-11EC-A66D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> If I'm being honest, I'd rather see everything _but_ the trace2 stuff go
> into an opts struct, and then see the same entry points we have today
> (run_processes_parallel that takes a struct, run_processes_parallel_tr2
> that takes a struct and two tr2 string args). Or, I guess, a single
> run_processes_parallel() that only takes a struct, does the right thing
> with the trace args, and entirely removes the
> run_processes_parallel_tr2 call.

Yup, it was the impression I had when I saw this patch for the first
time.

