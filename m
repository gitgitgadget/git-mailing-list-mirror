Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CEAC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 15:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiKKPNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 10:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiKKPM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 10:12:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D976B83690
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:09:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v27so8042525eda.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 07:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKmRS+lI91BkhBM+btlJJiGAhXzm93g3/tuUhVtzLuk=;
        b=jsbC0OCdGoQdNjOHCmmBSx2jMYGtY1uwitt7PB08+xZ8sp6OvAnZF2lvglWXgXCwc3
         n7dw09NSu4wpw6Zo3B+qgOvtadKye5mUemAa6HYsLCLqQxWU1lpmhJDKqXSMiimc8W2Z
         +Gcg/0gJz+MCiKjLnsRTczLN1vTfbTggNm/UVdM4dWN5BZTtAIbGTKGIMRb8sDg20XdV
         1L9Afu1bHiF7unFnzsZzQ6FhEbPuMSeypklzeco7IlXMgxKw/Hns0gOptC9GlGU26vD9
         gcgk6NT2QY9DFJ0l31N7khqupm2OHqQAdmptKYAyzCWQlbqZ8vLb54AhM+7WH4OXuP7o
         K9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKmRS+lI91BkhBM+btlJJiGAhXzm93g3/tuUhVtzLuk=;
        b=qvV5GguHUlbd15azRolRucf0wtB33OPKT71QQCRfbqc0ZuY2vk5mn4ClnhuVO88snk
         BVeMiFrqjAfSEFfhhCJaoKGA7/6p0k6giUFo3dMhmAvLnH7YViSzmZugBh29zZoAKEln
         1hnUdeY89dlL1Ofvt5nyav7tBf3N0cCVOHezQlvxjwlyWv3/qhqL4fZl2/A/3hb63rOd
         pAMs9AmHjPBVoCsM9XBq0PJNq6lC9R/pLd2VsrqOvN2hq6ylToGhJ08c0d0JMareMVyH
         fg2V7DGwozJsjvjGyc/K2ZUAOxnadGBeFJU44wa5NkFvLpgnUBfm8s/IBbHXAR/1eyFL
         uTHw==
X-Gm-Message-State: ANoB5pnjcETdWzdjtdiYaj33fM/AMl4goxqF6rOIEL+CgsrSm1TZGtwg
        0X7kkakIWBkE7JYHjKhxJubgxauFkmOXBQ==
X-Google-Smtp-Source: AA0mqf6yNQiFNaOzOlFphxSiYHt+MNyMxJcDsw2NwbpYVMVSh8DAVN9IuHa2lWkP4u2OIysiqWE7KQ==
X-Received: by 2002:a05:6402:2931:b0:463:ce05:c00e with SMTP id ee49-20020a056402293100b00463ce05c00emr1848185edb.46.1668179388784;
        Fri, 11 Nov 2022 07:09:48 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0073d7bef38e3sm586365ejb.45.2022.11.11.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 07:09:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otVf9-001wu6-2J;
        Fri, 11 Nov 2022 16:09:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t: run t5551 tests with both HTTP and HTTP/2
Date:   Fri, 11 Nov 2022 16:06:20 +0100
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local>
 <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
 <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y22ze1m6ayQCv9B5@coredump.intra.peff.net>
 <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y25hDr7aHvKnxso3@coredump.intra.peff.net>
Message-ID: <221111.86wn81mssk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Jeff King wrote:

> On Thu, Nov 10, 2022 at 09:29:15PM -0500, Jeff King wrote:
>
>> We don't get the _whole_ test suite running with http2, but hopefully it
>> gives us a fairly representative sample. And it does find this bug.
>> 
>> I can try to work the above into patch form, but I may not get to it for
>> a day or two.
>
> So here's a patch which finds the bug you're fixing. It's set up to be
> prepared before your patch, which helps confirm the bug (and that we're
> correctly using http/2 in the tests!). You'll want to unmark the !HTTP2
> prereqs as part of your patch.
>
> Alternatively, it could come after your patch to confirm the fix, in
> which case it would omit those !HTTP2 prereqs from the get-go.
>
> Let me know if you'd like to pick it up as part of your series.
> Otherwise, I can submit it separately in the on-top form (but my
> preference is for you to take it, since it makes testing the fix
> easier).
>
> -- >8 --
> Subject: t: run t5551 tests with both HTTP and HTTP/2
>
> We have occasionally seen bugs that affect Git running only against an
> HTTP/2 web server, not an HTTP one. For instance, b66c77a64e (http:
> match headers case-insensitively when redacting, 2021-09-22). But since
> we have no test coverage using HTTP/2, we only uncover these bugs in the
> wild.
>
> That commit gives a recipe for converting our Apache setup to support
> HTTP/2, but:
>
>   - it's not necessarily portable
>
>   - we don't want to just test HTTP/2; we really want to do a variety of
>     basic tests for _both_ protocols
>
> This patch handles both problems by running a duplicate of t5551
> (labeled as t5559 here) with an alternate-universe setup that enables
> HTTP/2. So we'll continue to run t5551 as before, but run the same
> battery of tests again with HTTP/2. If HTTP/2 isn't supported on a given
> platform, then t5559 should bail during the webserver setup, and
> gracefully skip all tests (unless GIT_TEST_HTTPD has been changed from
> "auto" to "yes", where the point is to complain when webserver setup
> fails).
>
> In theory other http-related test scripts could benefit from the same
> duplication, but doing t5551 should give us a reasonable check of basic
> functionality, and would have caught both bugs we've seen in the wild
> with HTTP/2.

Looking at the diff below, would it be much more work to just support a
GIT_TEST_HTTP_VERSION=2?

Then:

> diff --git a/t/t5559-http-fetch-smart-http2.sh b/t/t5559-http-fetch-smart-http2.sh
> new file mode 100755
> index 0000000000..9eece71c2c
> --- /dev/null
> +++ b/t/t5559-http-fetch-smart-http2.sh
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +
> +HTTP_PROTO=HTTP/2
> +. ./t5551-http-fetch-smart.sh

This would just skip_all if it was already set to 2, as we'd know we
were testing it in other tests, and lib-httpd.sh would do
GIT_TEST_HTTP_VERSION=1 by default.

There's the "!HTTP2" additions, which you mention you'll be "fixing
momentarily", but this is a stand-alone patch, so maybe I'm missing that
context...
