Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32765C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EDF60F11
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhHSS4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhHSS4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 14:56:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A5C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:55:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so10557369wrn.3
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dVIZZYk3YAOdyBtZVgDcN8c8pePvInOSfRbBffG5vdU=;
        b=Sy/SkLQOj+dsxFVbXrAX/kP7fsQYwIvo+BRwp/GkRD/Iv+bv1HmzQ7zPTalSH4RMOh
         w1XsqV756hc6OMqSw/bwq7M3aQf1ObncPsZsWRXZUsvfBsfALyWWkaG2W7IPN/1P9K1A
         fXDq1cTvv6cBC8iyBgGr1zbAQXTpyB/Je7HPEKOy8HPn9TyQzu20589rxIKCky6enyMw
         9gik0oNhicczqhnvf7ZgKQXqk2DEpeK4kPIbt+B/yLdR8ME1DrMVsgTqU8e4jPQsMWH2
         Ky/zEEOeDGaX2WOZFMGW8cwIjotNQYEHNVxqvkMXXyNbTJbICpOUs3ZNCvdbZHApZ342
         s3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dVIZZYk3YAOdyBtZVgDcN8c8pePvInOSfRbBffG5vdU=;
        b=rAknDYQGFn6ZsnndwL8JLCaYX2LJNvdb+ehBFLIriFg0JyOcVhubemQRK2cJISCfXn
         Cg2bZ9C0YE0aOFIdInm5tR6U3WmS4H5Xf6EZwtkGDfznSzdjWQVpJWuKH7prAfctKKNC
         Am5BGbVerMZOXnhUumP8RNgmS43cYA5CVs1/JqfF3Ig6G07iPY3mhnoTelGZcMaHxZ71
         W/EWY7i9L5gO/C+Dr2rcg6Ph4lgkoSKYspX5VAJpMGc7MBpe7oFS/7xOp2uhHVH6EoDA
         cJsUOno5z6YUZxeIHsEFDAEdz3YwDIHZJbPkF3QAxiZtFiq1sXggTuwOvYSx61jGI3uY
         IAKw==
X-Gm-Message-State: AOAM530SPPJVzIkBjIndHu9v82q9JoDXkvdXqBnopOKHZ6wvKg679cwh
        D+db0Lhe0mLeMVRlsKAXHyJkXgh2nIE=
X-Google-Smtp-Source: ABdhPJwKo0pdSPsLfJeEZigxg6RsN3+4AwWMsnfloS8zJsbl0UbuzBwEzfHtej8TUdUrDhoy7DisWA==
X-Received: by 2002:adf:b357:: with SMTP id k23mr5648152wrd.94.1629399356773;
        Thu, 19 Aug 2021 11:55:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id z126sm3325455wmc.11.2021.08.19.11.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:55:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Aug 2021, #06; Mon, 16)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqv945ng61.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8bec1a6d-5052-50c3-4100-e6348289d581@gmail.com>
Date:   Thu, 19 Aug 2021 19:55:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv945ng61.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2021 00:06, Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> which means nothing more than that I have found them of interest for
> some reason (like "it may have hard-to-resolve conflicts with
> another topic already in flight" or "this may turn out to be
> useful").  Do not read too much into a topic being in (or not in)
> 'seen'.  The ones marked with '.' do not appear in any of the
> integration branches, but I am still holding onto them.
> 
> * pw/diff-color-moved-fix (2021-08-05) 13 commits
>    (merged to 'next' on 2021-08-05 at 7b5e312aac)
>   + diff: drop unused options parameter from cmp_in_block_with_wsd()
>    (merged to 'next' on 2021-08-04 at 4de4a451e0)
>   + diff --color-moved: intern strings
>   + diff: use designated initializers for emitted_diff_symbol
>   + diff --color-moved-ws=allow-indentation-change: improve hash lookups
>   + diff --color-moved: stop clearing potential moved blocks
>   + diff --color-moved: shrink potential moved blocks as we go
>   + diff --color-moved: unify moved block growth functions
>   + diff --color-moved: call comparison function directly
>   + diff --color-moved-ws=allow-indentation-change: simplify and optimize
>   + diff: simplify allow-indentation-change delta calculation
>   + diff --color-moved: avoid false short line matches and bad zerba coloring
>   + diff --color-moved=zebra: fix alternate coloring
>   + diff --color-moved: add perf tests
> 
>   Long-overdue correctness and performance update to "diff
>   --color-moved" feature.
> 
>   Will cook in 'next'.

I found a couple of regressions in diff 
--color-moved=allow-indention-change with this series today. One of them 
is a simple fix, but I think I will need a bit of time to understand the 
other (there's a change to the way it handles lines consisting of 
'\f\n'). Would it be possible to kick this out of next when you rewind 
it please.

Thanks

Phillip
