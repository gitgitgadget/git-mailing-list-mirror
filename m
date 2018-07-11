Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072D61F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbeGKVnV (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:43:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33271 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbeGKVnV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:43:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so552777wma.0
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NoW096YbpT1WTiIWa7ASKGUOY/CMnO84TkOQo7turA4=;
        b=WkGLddifJ0v8DOshOn4JsSxrF6W9bPqQLVrAsOukGVzaQr3gmEwGEUD6FZMJkgQXEq
         33gXCB1QO2JhD/tx/dXwBB/WZNoVNq2o/ngxHxiifAsVBqpVc1cej+VDF7OPJE83ZpBU
         WrlR7vC4xFr966NVwJgmROKXJpTsKlNbUmMWrml4o2+BZCVUSQ+a9UBl3OwRXyW5hGhT
         IxsjFxZRh3nFYhEvFUfSI2cPA7MJr9p3pptYiJqv3KzwgTgDUYOEykYhFmJ+MAHUJtfe
         2ysFfk0Bf5dw9AT4wYDZfecZgPC/KxQ4A+uOVl9iSF8cD79gvadu5ImnY2//cLOj5dbJ
         r7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NoW096YbpT1WTiIWa7ASKGUOY/CMnO84TkOQo7turA4=;
        b=hV6CYIwT1VrhTRJv5RVrFw4cXnX7OfBqcDQWKSqZx4IVlacTEeauGPTyYfVD5RALYJ
         8cIsB/M2hX5mTxoOC+xKnYefxKYOxkjiuWUxijsOdQ/dWex7bD3lVGeSxpXZ+L3nQ7N4
         mvXFxcVlDAV+QFNzql5J/2D3dmrvyVTfPJAO0r0BGHa+/FOEFSk+eVBD94vTiPpVdMnz
         4n/oQZUnBUYHHoYmxFrQGgVBUnjB1ROADEUIBzFdmHj7D1OlsVVEwTapMQKJ9GOTFQR9
         NzEbAnBTaaq7IQ6emzimfMbQv82BEQkHKTQCyjD7maf1rhvOGg9Y7fLq9GDN7hsHLmIL
         hcYw==
X-Gm-Message-State: AOUpUlFZfKq1ks8wCtzMMflHYhlOtoCjc9uqR3u07Sl1m01ndLsfo+Yt
        Pk2glbUniVgdhiOczZkHwg4=
X-Google-Smtp-Source: AAOMgpclWMq1s5ui3+fo6SdJfjYs4Iknn52qevttnbxC4Gm5G1aWPMPtg0HiWHPAFl9XtlUrjBJg5w==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr142042wmg.42.1531345021226;
        Wed, 11 Jul 2018 14:37:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u63-v6sm3556788wme.22.2018.07.11.14.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 14:37:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken &&-chains in subshells
References: <20180626073001.6555-1-sunshine@sunshineco.com>
        <20180711064642.6933-1-sunshine@sunshineco.com>
        <20180711064642.6933-2-sunshine@sunshineco.com>
Date:   Wed, 11 Jul 2018 14:37:00 -0700
In-Reply-To: <20180711064642.6933-2-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Wed, 11 Jul 2018 02:46:33 -0400")
Message-ID: <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The --chain-lint option detects broken &&-chains by forcing the test to
> exit early (as the very first step) with a sentinel value. If that
> sentinel is the test's overall exit code, then the &&-chain is intact;
> if not, then the chain is broken. Unfortunately, this detection does not
> extend to &&-chains within subshells even when the subshell itself is
> properly linked into the outer &&-chain.
>
> Address this shortcoming by feeding the body of the test to a
> lightweight "linter" which can peer inside subshells and identify broken
> &&-chains by pure textual inspection. Although the linter does not
> ...
> Heuristics are employed to properly identify the extent of a subshell
> formatted in the old-style since a number of legitimate constructs may
> superficially appear to close the subshell even though they don't. For
> example, it understands that neither "x=$(command)" nor "case $x in *)"
> end a subshell, despite the ")" at the end of line.
>
> Due to limitations of the tool used ('sed') and its inherent
> line-by-line processing, only subshells one level deep are handled, as
> well as one-liner subshells one level below that. Subshells deeper than
> that or multi-line subshells at level two are passed through as-is, thus
> &&-chains in their bodies are not checked.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

As with the previous "transform the script and feed the result to
shell" approach, this risks to force us into writing our tests in a
subset of valid shell language, which is the primary reason why I
was not enthused when I saw the previous round.  The worst part of
it is that the subset is not strictly defined based on the shell
language syntax or features (e.g. we allow this and that feature but
not that other feature) but "whatever that does not cause the linter
script to trigger false positives".

So I dunno.  I haven't spent enough time to carefully look at the
actual scripts to access how serious the "problem" I perceive
actually is with this series to form a firm opinion yet.  Let me
come back to the topic after doing so.
