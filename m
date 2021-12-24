Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C7C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353283AbhLXRGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353281AbhLXRGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:06:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71AC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:06:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so35309544eds.10
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lhqKAtAET1S8wE+Ja7CVp5l8yLDiLLp0lbnZtn/ViAA=;
        b=o+4gE2oxzMqJrWjMMNqoFYTPafkQ4fvXXFMvtX4eK3wb8/lLz1ynHA/iCbIzpwYec9
         2wPSlZngfYy5LP/3eV0bqPPuiF5AYBf9tgbL6f8f43WMz66VEdhQbr3zYg3LfJTqNJwL
         HlxYJLeFKpymokwOxzI4yqXFEyyYBoglitvEhJyu1vLyNFfjxwF8MJG1bEZJWl6pc1MF
         O5ezlTqf/9+jWuVOn1oD8o7JoY6slHdIUXokbbfHFtV4WbF6Miwfs8EK52SvJruJBfQ3
         yq3/I9LbXNPT8mrBNW7S/WKQNhMf9SGGMIdgWnyOsSqJsEduNcmNHReallfxEZF15yyV
         H0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lhqKAtAET1S8wE+Ja7CVp5l8yLDiLLp0lbnZtn/ViAA=;
        b=xCPeC8FjCULND/C5qlnxgB3MeEVqj/rOhIjbgodQqdeJCfHRU8Zt5MkPObStTBYm4Y
         +xabZ7fq7DXFBo5oEMSqNSpI5joz9u0i3mtkCpq0Yz8+iUKvJ6CHWUAigRBwsFmYUTJ6
         Im9LvBo0Is3/nqmTbYWgx1tllaKncmWdGW2OtNlIwCCxH46LOFsyIstbA0NgLCUTA6mA
         /ICHN0ndWXb8cjwCcB8JO6tGTMqB6+nsE3EeYk6iFK3iavd8R0cZjQis1jXadFBPapc+
         dNXvQRURJpR+vdBJ6md7h74+EygwX4qqDBnY158hjfkAPdc4UXrBUGzEQb5gSi2vOZxO
         +gfg==
X-Gm-Message-State: AOAM531mNvYLNxClrENmfYcAR32j4nQs676EFWHInwfw1lJPxMc+vQeM
        wpmGKeG6PbiXEMIwD3Dq4fI=
X-Google-Smtp-Source: ABdhPJxBulThD90x9MyBnmICQLrptZOBy9jxvu1OZYMUVQL3f81KiSuxGMPc/EKJNQsRslKejYpYNQ==
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr6391039ejc.15.1640365569064;
        Fri, 24 Dec 2021 09:06:09 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id z26sm3169672edr.11.2021.12.24.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:06:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0o19-0002fD-Fv;
        Fri, 24 Dec 2021 18:06:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        me@ttaylorr.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 0/6] usage API: Add and use die_message()
Date:   Fri, 24 Dec 2021 18:01:01 +0100
References: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
 <20211222185715.1090524-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211222185715.1090524-1-jonathantanmy@google.com>
Message-ID: <211224.86r1a2gcg0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 22 2021, Jonathan Tan wrote:

>> A small set of fixes to usage.[ch]'s API use that will go towards
>> enabling nicer things down the road. See [1] for the v1 summary
>> 
>> I believe this should address all the feedback Junio had on the
>> v1.
>> 
>> Aside from the substantially rewritten 6/6 and much simplified 4/6 the
>> end-state is almost the same, but things are better split up,
>> explained etc. now.
>> 
>> 1. https://lore.kernel.org/git/cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com/
>
> I haven't looked at this round of patches yet, but for the convenience
> of reviewers, it would have been great if you linked to a prior
> discussion [1],

FWIW this is (indirectly) linked-to upthread. I linked to this RFC
series which this is peeled from:
https://lore.kernel.org/git/RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com/

Which in turn links to the earlier series you commented on that
die_message() is peeled off from:
https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com/

> including an email from me with comments that (as far as
> I know) haven't been addressed [2].

Is there anything to address in the context of this current series?
I.e. you're commenting on leak detection, which isn't at all the goal of
this series.

I.e. I had these die_message() changes that I worked into that series,
but there didn't seem to be any interest in code changes that "solved"
issues of SANITIZE=leak interaction with various non-CI compiler
versions/flags, so I didn't think it was worth pursuing.

But as this series shows die_message() is also something we can use in
other contexts.

> [1] https://lore.kernel.org/git/patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com/
> [2] https://lore.kernel.org/git/20211027215053.2257548-1-jonathantanmy@google.com/

