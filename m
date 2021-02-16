Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26598C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAC564E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhBPW0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhBPW00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:26:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0583FC06178A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:25:43 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id do6so8656612ejc.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=2o4jyvnws9WErlN1ptMmiJ6h3ircanCVm3d+Hw5iRwM=;
        b=IaF0I+Q7aQgv14Gdz91hmFVtCCG1CrVOet1BhA+hjzaAALCbYB1v9JwH4wFoXE+9iO
         kHHNfau+d1NL0KHhcbqSt2cztkPLRK/qYx+RbFPJSYfpqId10gJhjcp3hQ53PVE6jzfU
         kgntW5LqbzQRlk+j6Af28Y40t1qElos0pfRD+shQV6AgTOwrbQr9uUu8A/mDH6sdNvTD
         uGlpCS0D6xvVqwZPserlV8j5uTwsnGE4rBBzQ5JRncmPYcFFXnE/Rs14ns145C6WzqcK
         N39Fh7K1y2S1EZHXLJ7y7QzC7N+GRrADWWv2W6+8m/E5xzaxEFrWT2BDJkFlwOJKLMqP
         9Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=2o4jyvnws9WErlN1ptMmiJ6h3ircanCVm3d+Hw5iRwM=;
        b=mTZzDPLn4b3pQsp2R8B6Nqv82KgRSWiEUrEjewrdtFvjrc7nycfSPm/2/56qtu9oA0
         GkwjJzU1eiWxkQ9KGLlE3t+H1uSU+V1yVofstPKl4rMecp4gmGz8RXM3+ripiWGBUPwo
         86Haka9snZq388B3AuzmMHH+MzgSIBbVxvHA5qXfyXRyTkhunx6vutMUd1GxwuACM/Uc
         RjY9t3Oheg5wn566q2lXvBuiIwEpILPVwn8rwSFkUeo4eYz4Itvwz+glyGRLvCiLviK+
         fqC/nJreOJqNt47UuxsmxjxDF0xUGzWqKY8c6HK2rOZR5fVrIW8t2XEiJQ/q0rxjJiEq
         AmzA==
X-Gm-Message-State: AOAM530JQ5kxvGC8V4HQGwV6ZmpoB9r05C5GuHp+hpZG7DL7fj3xAU1/
        Xv6gQ8nVQrI3AtJgTslNCik=
X-Google-Smtp-Source: ABdhPJw2t3JRfBgLkZ6nCWQaHEmGrQxKJDgxfiaCEH6I5w4VfL5oc1B7TLiMTkI8eIYyvaIllF3gBQ==
X-Received: by 2002:a17:906:710d:: with SMTP id x13mr392416ejj.383.1613514341710;
        Tue, 16 Feb 2021 14:25:41 -0800 (PST)
Received: from cpm12071.fritz.box ([79.140.115.26])
        by smtp.gmail.com with ESMTPSA id b11sm84774eja.115.2021.02.16.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 14:25:41 -0800 (PST)
References: <20210216163151.76307-1-rafaeloliveira.cs@gmail.com>
 <20210216163151.76307-2-rafaeloliveira.cs@gmail.com>
 <YCv8nvJ6faO7esoj@nand.local>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/1] blame: remove unnecessary use of get_commit_info()
Message-ID: <gohp6kpn0z7j2b.fsf@cpm12071.fritz.box>
In-reply-to: <YCv8nvJ6faO7esoj@nand.local>
Date:   Tue, 16 Feb 2021 23:25:40 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Feb 16, 2021 at 05:31:51PM +0100, Rafael Silva wrote:
>> When `git blame --color-by-age`, the determine_line_heat() is called to
>> select how to color the output based on the commit author's date.  It
>> uses the get_commit_info() to parse the information into a `commit_info`
>> structure, however, this is actually unnecessary because the
>> determine_line_heat() caller also does the same.
>
> Interesting. It looks like this micro-optimization could have been
> safely performed as early as 25d5f52901 (builtin/blame: highlight
> recently changed lines, 2018-04-23), which is when this feature was
> originally introduced.
>
> I looked at 25d5f52901 to see if there was any reason that we didn't at
> the time, but couldn't find anything.
>
> So this looks correct to me. I'm a little disappointed that some of
> your more detailed performance numbers from the cover letter didn't make
> it into the patch description, but it may not be worth belaboring the
> point further.
>
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>
>

Thanks for reviewing this patch.

I wasn't sure whether adding the performance number into the patch was a
good idea or not.  After reading your message and the response from
Derrick and Junio, I'll definitely re-roll this patch adding those
information.

> Thanks,
> Taylor

-- 
Thanks
Rafael
