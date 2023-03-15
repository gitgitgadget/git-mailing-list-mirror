Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC0FC7618D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 19:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjCOTYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjCOTYX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 15:24:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486C2333B
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:24:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so3268955pjg.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678908259;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTr9x9LWAySC/SCRms4yRFdvq46nRekwS14te7fPdWI=;
        b=RDIlSxdcU3Yh/5eAhSnZ3wmTgAWUBfStFVjjUyX5lbDvi+N2C2dYaVNcMu0ogrFvBD
         YFMNzQUl1b1Fe5y7xkO0eCgTuGPmKocyqeOAfqktHJSVz68BawTaidYETQoL2ILhKjxM
         XhvCLYC23Lays8rPkb2bkZc8Z3pFLLzTAiJNbdUrhvL15v+w8BlI27HmgRU8OSBztBfw
         wUsLk897lyZRYPycu+ccAfuXzBMDJj96K0loPatts0zUHjEySPhdyJiMkBspWOQFl4Wd
         3K1q6TzxHGsIrIRlMT6qq0bNe0EWOiIv9KNqH8KQmAWeteyQlrW6dBJ5nRiVYW0CmWcK
         4Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908259;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTr9x9LWAySC/SCRms4yRFdvq46nRekwS14te7fPdWI=;
        b=Df8CRYLsJhyefdGSoBCYs+dtOj1kSR6tjiMeICKh9McxooJvGLOAL0KxwhK7ndClE/
         GMSUhtI5cvTY32mpb42xEMENZfDFEzSUlRxrMbCeyVfTbY0rYPOgZQo50vCl3JKLboFq
         fhq03/dXu4xqLXAI8RrYt2hF5U8TsTwtLq8NIdb7J9vYkaQzQbSfEDNHar6vhsaQ8hx5
         g9eCHlor0B92naGfc3cA6It5NloWoNsqjq/gETZBT8BWRl6kGriRaP3YEGblETs1tu/9
         OsINr4w3FkfA3eO1x4Jp2lAlwmA/8IztmU4zhZ+XKvmkoOm+3L39rQgnZ3wFaBF5Lvhm
         K1MA==
X-Gm-Message-State: AO0yUKXpkG/+72wR/E2H+qvweGeQzT7bsQdhza32Ql4TrHHONXId12c8
        4l086hS3J07zxY4CjX7xE14=
X-Google-Smtp-Source: AK7set/TtRmACqmHkT0x4Pxp3JddF5gNNg4ET+hy/TVzSfxGTlvIJIHvvf3JoVmBzHf9L4vJnFG1bg==
X-Received: by 2002:a05:6a20:4916:b0:c7:7874:f677 with SMTP id ft22-20020a056a20491600b000c77874f677mr788357pzb.37.1678908259001;
        Wed, 15 Mar 2023 12:24:19 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s24-20020a62e718000000b005a8b882a239sm97113pfh.109.2023.03.15.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:24:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
        <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
        <ZBIFEXuE5Um9Z4zM@coredump.intra.peff.net>
Date:   Wed, 15 Mar 2023 12:24:18 -0700
In-Reply-To: <ZBIFEXuE5Um9Z4zM@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Mar 2023 13:49:05 -0400")
Message-ID: <xmqqpm99om1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... we may
> want some kind of "literal" mode, that takes in a list of refs rather
> than a list of patterns, and does a sorted-merge with the list of
> available refs (or uses a hash table, I guess, but for-each-ref also
> tries to avoid even being linear in the total number of refs, so you'd
> still want to find the lowest/highest to bound the iteration).

Exactly.

I actually was wondering if "literal" mode can just take a list of
<things>, and when a <thing> is not a refname, use it as if it
were. I.e. %(refname) would parrot it, while %(refname:short) would
not shorten and still parrot it, if the <thing> is 73876f4861c, but
something like %(subject) would still work.

For that, I suspect ref-filter.c::filter_refs() would need to learn
a different kind fo finter->kind that iterates over the literal
"refs" that was fed from the standard input, instead of calling
for_each_fullref_in() for the given hierarchy, but the new iterator
should be able to reuse the ref_filter_hander() for the heavy
lifting.


