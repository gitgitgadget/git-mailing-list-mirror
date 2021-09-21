Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D4F60F13
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhIUVWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhIUVWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 17:22:16 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04A0C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:20:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 134so448846iou.12
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kq4Egq99patHf5Iddl73YeeacUr6EpI6vXouSSVlgnQ=;
        b=hjry335ARWbWLr58tvUEs2AwvdMbUFbczvupf59uUSb4jFS02UZslsuPTxHN7O8KOj
         XB7TcBcIpeMq3xd/hBCTqOws0PXR+Czk0es58X2OiAbz23kwrvv8z/6/uoo8K9+S57TN
         1NnHuHfp7n1LyaN5bXy8+c9QaBD0BjL2OazoNrcx/G/XOlo9JeTISIPajcFBxNioZFW1
         WxeMnvN82ad5BMgtn7X9ZJnNYGYpQkFHd2XbTeG0rR6zphH4UvGlnWu7IxFwRjKG/FpL
         DVmjRLe+6ZMhhaCrI3xAJLByEliriGVAIWoXZv/MkwAQpAbuFhuc9RxfgHO4P/2VbeZY
         Yj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kq4Egq99patHf5Iddl73YeeacUr6EpI6vXouSSVlgnQ=;
        b=vVuacP9FaZ1PNabtD4zxe62i8ex3aYqe4A3+Mu4pKbDVNp7Df6Y697p+btHH07MFaZ
         livqkv+xmZG28dx4QFwUz2DKuWnajXeAiIXeuwy3WbPd+SGyjHru+mXlxflDPl4PkTKi
         Dgzrgcvno2HINh512fhTyN9ChUqVhp3a4MKpRtKjxU6zZnkUKgpdPZr5STSI9s0Cm+jF
         bRqRl+NOk5wTg7KumG92HdQLXWHhaogcDicWdI35sw+3one2l5cB2Omky9XpDXsV1F76
         R0BRewPQp+eSSszF+ll796E06IC7jorVqMr7fHE0SS83a6fuULqR1p+gQzfVn76IZ7u7
         cmcg==
X-Gm-Message-State: AOAM530xYbSTgaVWrsXgQEBZ7rph42VEbdsFgNKt3PcqCJhStlF+2ngU
        TtSSt5BxTqdt5Qj5jodRcg9yLjphhd1Ndw==
X-Google-Smtp-Source: ABdhPJxHnR1NB2sEGE0UqB/X4Zjlzj6aabvp1VPtN9ty2LMYrjzequabW5kQjBf4lukqIxtV5RAfZQ==
X-Received: by 2002:a6b:be02:: with SMTP id o2mr1689727iof.103.1632259247146;
        Tue, 21 Sep 2021 14:20:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o3sm100006iou.20.2021.09.21.14.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:20:46 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:20:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUpMreNwBDSygFSf@nand.local>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:15PM -0400, Jeff King wrote:
> When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
> other) headers in our GIT_TRACE_CURL output.
>
> We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
> It passes them along to curl_dump_header(), which in turn checks
> redact_sensitive_header(). We see the headers as a text buffer like:
>
>   Host: ...
>   Authorization: Basic ...
>
> After breaking it into lines, we match each header using skip_prefix().
> This is case-insensitive, even though HTTP headers are case-insensitive.
> This has worked reliably in the past because these headers are generated
> by curl itself, which is predictable in what it sends.
>
> But when HTTP/2 is in use, instead we get a lower-case "authorization:"
> header, and we fail to match it. The fix is simple: we should match with
> skip_iprefix().
>
> Testing is more complicated, though. We do have a test for the redacting
> feature, but we don't hit the problem case because our test Apache setup
> does not understand HTTP/2. You can reproduce the issue by applying this
> on top of the test change in this patch:
>
> [...]
>
> but this has a few issues:

I'd be fine with assuming that the http2 module is available everywhere,
but only because the tests are optional in the first place. I agree that
we'd want to run our suite of HTTP-related tests in both HTTP/2 and
HTTP/1.1 mode.

But that doesn't mean we have to reconfigure our Apache server midway
through the test, since HTTP/2 servers should keep the HTTP/1.1
conversation going if the client doesn't reply with 'Connection:
upgrade; Upgrade: h2c'. At least, I think that's the case based on my
fairly rudimentary understanding of HTTP/2 ;).

>   - speaking of which, a later test fails with the patch above! The
>     problem is that it is making sure we used a chunked
>     transfer-encoding by looking for that header in the trace. But
>     HTTP/2 doesn't support that, as it has its own streaming mechanisms
>     (the overall operation works fine; we just don't see the header in
>     the trace)

Yeah, presumably we'd want to have a few protocol-specific tests.

> On top of that, we also need the test change that this patch _does_ do:
> grepping the trace file case-insensitively. Otherwise the test continues
> to pass even over HTTP/2, because it sees _both_ forms of the header
> (redacted and unredacted), as we upgrade from HTTP/1.1 to HTTP/2. So our
> double grep:
>
> 	# Ensure that there is no "Basic" followed by a base64 string, but that
> 	# the auth details are redacted
> 	! grep "Authorization: Basic [0-9a-zA-Z+/]" trace &&
> 	grep "Authorization: Basic <redacted>" trace
>
> gets confused. It sees the "<redacted>" one from the pre-upgrade
> HTTP/1.1 request, but fails to see the unredacted HTTP/2 one, because it
> does not match the lower-case "authorization". Even without the rest of
> the test changes, we can still make this test more robust by matching
> case-insensitively. That will future-proof the test for a day when
> HTTP/2 is finally enabled by default, and doesn't hurt in the meantime.

Yeah. We could probably rewrite this test as:

    grep '^[Aa]uthorization:' trace >headers &&
    ! grep 'Basic [0-9a-zA-Z+/]$' headers &&
    grep 'Basic <redacted>$' headers

which I even think is a little clearer to read (but I could equally
understand how other readers find the existing version easier to grok).

Anyway, all of these musings could just as easily be ignored in the
meantime. It's certainly neat to see HTTP/2 more often in the wild :).

This patch looks obviously correct to me.

Thanks,
Taylor
