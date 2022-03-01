Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EBCC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 06:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiCAGjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiCAGjV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 01:39:21 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC2BC1F
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 22:38:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o23so13599675pgk.13
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 22:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0qRt0aS619E2RoI6/kd/hKxAsIKRaCVzycx/SZs06Y=;
        b=OjpXNu65HjnevEP3QYLHxPbkaln82p0ztyOKvZz2tAWZuMqpQqsmaoqmZlO0Q2aLiw
         2z0UtlVXNXP6Z9IWREszWFoVo0cBip7ZIPF5Cekx0guWWvXn5gQG7VXXUV8U/LrnATCx
         pxq8vi2HbZFqpQ7Tuy4sXc8T8ZXV2ei0MvrKk9M63tUvY62w3twTK0fElGWzXj/0maM3
         CUZjZZ7EE1eoX7fiX9vItZQgGbYYZ/iJJyp/qVQyEg6QO+5cOAfhrdhLFiGODD7uxMkZ
         CAwnu/gGaxfAXHOz6rFmsJQ9Ipnl+3c2kHU8vlJZXprob1zeMZA4jMq/cZbJUjIhLRPL
         CBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0qRt0aS619E2RoI6/kd/hKxAsIKRaCVzycx/SZs06Y=;
        b=P4wg4Nu3h/oui3g5vjSK1XHdihklBsIwFmag/CxQsvAmChF1GD6p+g3kXj2sPGU9oY
         U4B/XpRYZ50VzU9JftjZFE242k2ca8HQGC0EpIY+49pvSftvF+sA1UW+52SpoSJgpGJ4
         aMJg7h+aBhtFK2vm31616J+p5L0lKD2X2sl1lqbGk/nUFORHx3JsFCZaWARgLU8f6xlk
         ry7fh57TX4JMQG9slIURyiJi0I83OVpeACE9J2N1E8KZvF8c8yVKAz4sWW/O3E00K4CK
         ng4kU/ojeDiI79QYvNzAtbgQEGRRgbrIC7vd3BPPJpOeussxp95LVRGa3bp1YT3olmFq
         evZg==
X-Gm-Message-State: AOAM533Mx9Hfjztys0AKMP+hkZzPXcN85cJGqwQsiRm5x2Xep9CctESO
        WqT+o8+UvtDcMIIGPjW9VZU=
X-Google-Smtp-Source: ABdhPJxeCxZul+c8ZwoGa11aly0g3oeW47OSxOWLB9QxklylEC0NCjDRtUwHYb53hpntJqUBg2qNhw==
X-Received: by 2002:a63:fa4a:0:b0:378:5d07:96d3 with SMTP id g10-20020a63fa4a000000b003785d0796d3mr14103525pgk.54.1646116719899;
        Mon, 28 Feb 2022 22:38:39 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.67])
        by smtp.gmail.com with ESMTPSA id lb4-20020a17090b4a4400b001b9b20eabc4sm1063930pjb.5.2022.02.28.22.38.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Feb 2022 22:38:39 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
Date:   Tue,  1 Mar 2022 12:08:01 +0530
Message-Id: <20220301063801.26732-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqzgma287n.fsf@gitster.g>
References: <xmqqzgma287n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> I  also think Dscho simply overreacted only because the check broke
> an in-flight topic that is from his group, which is not universally
> built, and the tests in it was written in such a way that the error
> output from the embedded check was not immediately available when
> run in the CI, making it harder to debug.  None of that is a fault
> in the approach of using the embedded check.
>
> If the embedded check were there from the beginning, together with
> tons of the existing checks done by parse_options_check(), the
> developers themselves of the in-flight topic(s) would have caught
> the problem, even before it hit the public CI.  I am very sure Dscho
> wouldn't have complained or even noticed that you added a new check
> to the parse_options_check().

Hmm, that's true.

>  (2) Rethink if parse_options_check() can be made optional at
>      runtime, which would (a) allow our test to enable it, and allow
>      us to test all code paths that use parse_options() centrally,
>      and (b) allow us to bypass the check while the end-user runs
>      "git", to avoid overhead of checking the same option[] array,
>      which does not change between invocations of "git", over and
>      over again all over the world.
>
>      We may add the check back to parse_options_check() after doing
>      the above.  There are already tons of "check sanity of what is
>      inside option[]" in there, and it would be beneficial if we can
>      separate out from parse_options_start() the sanity checking
>      code, regardless of this topic.
>
>  (3) While (2) is ongoing, we can let people also explore static
>      analysis possibilities.

I agree with you. But I think these two points(specially (2)) deserve
a dedicated discussion/patch thread. Because, the latest version of this
patch series (actually this patch series itself) only cares about the
`usage strings`.

So, I argue you to not discard the last commit for now. As you said `There are
already tons of "check sanity of what is inside option[]"`, integrating
one more sanity check would not affect it. I am saying it not because
I made that commit. The discussion or patch integration of (2) and (3)
may take few weeks (or more than a month may be; I also would like to
take part/contribute to that discussion/PR). I fear that another
set of invalid usage-strings would be added in that time. In that case,
we have to make another commit/PR for correcting those strings - disrupting
the purpose of this first commit you are willing to merge.

As Ævar also said - 

> I think with in-flight concerns with (0) and (1) addressed what we have
> here is really good enough for now, and we could just add it to the
> existing parse_options_check() without needing (2) and (3) at this
> point.

Thanks :)
