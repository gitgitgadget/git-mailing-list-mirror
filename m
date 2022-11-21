Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F13C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKUDOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:13:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255031DEB
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:13:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 130so10133363pfu.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrybnqkTSp52RjMDErQbYnCfInQoZbxQ3YbSlzfZKvg=;
        b=JA5jOQQJTBenYstL/8W2fxUlMGYKCyK9Y6SB3heJmwDzuiqIoe5Hgk5FjZGiHBQP+U
         kUSfqMQk2uerWfZRD2fCi0a37WKi+s1aFyVvKS9IqXfkzOGBU6HmOEZaXYJnx6CRXJ6B
         LWOF9j7kQ3n7PzxusGq2vcT5xu4tIzfR7IA6cy4a98zXRa/am1dIUR2LKDbC64af9Pou
         ulr3478bMXm5n68nhstyda+9DZ+dZjEO+/zke+jKJAd12vGcwb2qs6Ff85u0crZbrl8m
         ZSLFVdsgjRT0oCsNR+9cKG0P4bCQN2hEUFqrbqBgdaULd5v7lZaZRYKQcWa0hx2DoOtw
         yECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wrybnqkTSp52RjMDErQbYnCfInQoZbxQ3YbSlzfZKvg=;
        b=pRDKMvZ7yCjQh6AUO5Ba1v48K5SfDbIip+ZG8aRVSupLGcF7tQSwiLUEFhadsSn1K4
         /P99F8d8gXh3AEpANgp1h3cm2NtfTNfsqv7xV1/7R9+qevG0HtbCk3apOTHNn5UrrltG
         SUrfZ+MoBBNODD70eHrcdxDILlGvTfo1FsvglqUBVpOJvpINO9GFxn8eITbwuOha9C/w
         vU9k45LRZxGkV4UaqcPYjvc2B2+qVs7AWSCM5WhYtDrRw8vyk6g+xOs1tybcpCAsZ+EP
         hSFNVkQmpcmMv13csFekXqAG7MMnyTLeZgyjsFerl2DfKCfUATyXno/ljPpmPQ/syvEy
         CB6w==
X-Gm-Message-State: ANoB5plPF8M6BghSfjY6uabBDHF3YtfpLfK3O2+PDwBJ18dUjCFbSWga
        ywYDQmSeNvkYTwkyDf4h8ZY=
X-Google-Smtp-Source: AA0mqf7cw5tUMfZt111z6iEnhn8tSFNQgRY0s+9C7kkkf1cRilJKMxch665F+LpAj+EkNA7ZP2sOhg==
X-Received: by 2002:a63:e20:0:b0:440:6e64:fb02 with SMTP id d32-20020a630e20000000b004406e64fb02mr16010315pgl.84.1669000437946;
        Sun, 20 Nov 2022 19:13:57 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709029a4a00b00186c9d17af2sm8359068plv.17.2022.11.20.19.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:13:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
        <Y3B36HjDJhIY5jNz@nand.local> <xmqqv8nbkg77.fsf@gitster.g>
        <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
Date:   Mon, 21 Nov 2022 12:13:56 +0900
In-Reply-To: <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org> (Johannes Sixt's
        message of "Sat, 19 Nov 2022 09:18:09 +0100")
Message-ID: <xmqq1qpxyp6z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Use of "ignore-cr-at-eol" may allow such tests that are not ported
>> correctly to prepare expected output with a "wrong" line ending and
>> still pass, and I do think it may be an expedite way to make tests
>> appear to pass.
>
> The reason that mingw_test_cmp exists is not that Git isn't ported
> correctly, or that tests aren't ported correctly. The reason is that
> tests assume Unix LF line endings everywhere, but there are some tools
> that are outside our control that randomly -- to the layman's eye --
> produce CRLF line endings even when their input has LF style.
>
> For example, when we post-process Git output with `sed`, the result
> suddenly has CRLF line endings instead of LF that the input had.

That's exactly the kind of thing I meant by "porting the tests".

If we _know_ that the tests want to munge something (either the
hardcoded expectation or command output) with LF line ending, and
produce output with LF line ending, then platform tools like 'sed'
used for that task should be told not to turn LF into CRLF, with
something like:

    case $uname_s in
    *MINGW*)
        sed () {
            command sed --binary "$@"
        }
	... other workarounds come here ...
	;;
    easc

before we can call that we ported our tests to the platform.

