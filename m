Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEC9C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 16:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbiE0QIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiE0QIR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 12:08:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6687314916B
        for <git@vger.kernel.org>; Fri, 27 May 2022 09:08:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 889ED12DBB9;
        Fri, 27 May 2022 12:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vnYab2YZZI2gY/kvjuS26yzkYm8L7Vsu2GJnwG
        iHZRE=; b=jqnc9O4LdPM1x2yBjVc+mqkDostnMnZ0AqFaK3LYIltIcZLUQXlxZG
        lgziCVYi9zeoshaxugb5+cPowO6sslhq13Rmqx0eo/FHMcBm+G0phbxUtV1FoSpb
        aIjixjOqbbyH1X/BbeSzjbw2QLZ608l2UIxS/AXOtRKRY0689knEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80B6112DBB8;
        Fri, 27 May 2022 12:08:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA95912DBB7;
        Fri, 27 May 2022 12:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 5/8] run-command: add an "ungroup" option to
 run_process_parallel()
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <patch-v2-5.8-c2e015ed840-20220518T195858Z-avarab@gmail.com>
        <Yo+2cbMueQyAI186@google.com>
Date:   Fri, 27 May 2022 09:08:13 -0700
In-Reply-To: <Yo+2cbMueQyAI186@google.com> (Emily Shaffer's message of "Thu,
        26 May 2022 10:18:59 -0700")
Message-ID: <xmqqtu9b5576.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36DD1006-DDD7-11EC-B0DD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think we actually could even automatically set ungroup if jobs=1 as
> well, because then there is no reason to buffer the output - it uses
> additional memory for us, and it makes output slower to see for the end
> user. But I do not really mind enough to want a reroll.

Not doing so would protect us from future end-user complaints,
similar to the way that made us consider the change in 2.36 to be a
regression.  Those who are used to see their stuff run in submodules
(which I recall was the original purpose of run_processes_parallel
was invented for) with their standard output and error streams not
directly connected to the original end-user terminal will start seeing
the expectation broken but only when there is only one submodule, no?

Doing it when an explicit "ungroup" was called for would hopefully
avoid such an inconsistent behaviour.
