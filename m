Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2741C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 13:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B506C61074
	for <git@archiver.kernel.org>; Wed, 19 May 2021 13:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbhESOAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhESOAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:00:15 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672EEC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 06:58:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f8so10132751qth.6
        for <git@vger.kernel.org>; Wed, 19 May 2021 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L601jB5H10eJshe6JGirbvkd/viw/gkf0/WnYBGZ8gg=;
        b=eSNPQAyFNytsFPgGvwcDQoNI9+uZp6Bxcv8OQOzpTH2cMB3x7G/tCnoeZtFAXhV2Ax
         5mxR7od/bZxdpmEbHwynPcEWx/VXZsc2MQkJpmytcFE6iq11eyvy/l8ymycMsHSP9k3S
         51toFxIVAf9nwtos354uq5Off2JkQ6jc+3YPbbhP3RgT+Bp0VJRcY05+fyTG5Ek5L02C
         jIRbYCLD5SatJMEwvmjvqcZk5C0Rckm6hpcy0Seu8Cg/rImFdnseZY6+BfiG9ZbDwg8R
         K13fLojzJ0U76FSKSDhVuMNRjMfhvZnGQcc2ScWUUkFXT7VvSsD7IoWXdRB3yNIiKN06
         7g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L601jB5H10eJshe6JGirbvkd/viw/gkf0/WnYBGZ8gg=;
        b=Chficjv/IIFLz986zMOMRGPu2IJy45Nk+ktWc7Xu9n7vFJFXHYAJQ3sh4T+ugp+Chh
         8z1RMbFzY2IV/r4QD8jNCrrTirtRrtJeEVurSa0FgeiQV4xD09O2pNm1Q7GKrFAY5EKZ
         uO6CmpVbmH02cwqjg9UCs7PulblxPqFp85gTS49Hs7KFAFPhALEpV3Hfn0MsbwjUeez+
         PP5ko+DJcIIGJ8usno89+WRW6L0cyVN/d52p6oTRUUP0hxA1kRXMFxtSgYyIECkCTg/u
         R5jeFEr+hUhcG+NSNq6JsXgNIXnR5im+JEE7VyDR/GCFF3bXATgMnUbyX5VzMKuZ5IZS
         TeeQ==
X-Gm-Message-State: AOAM531+SvPb+RbgTiRny/dGx0kaiIyGyKI2Tmonu6L9GDOmeI44JRZ/
        WkUKl971zQEhyF0C8f0QR8s5Riv9CFV35w==
X-Google-Smtp-Source: ABdhPJxZoBc/blczoKmwQJeZ8PaKdUGbTZ40aN4a9iKgakKrd22ga5OiY+ecUO1zT19tad/qdvagng==
X-Received: by 2002:a05:622a:30e:: with SMTP id q14mr11250886qtw.278.1621432733722;
        Wed, 19 May 2021 06:58:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:a1ee:38d:5766:9f4f? ([2600:1700:e72:80a0:a1ee:38d:5766:9f4f])
        by smtp.gmail.com with ESMTPSA id s20sm705743qke.2.2021.05.19.06.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 06:58:53 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "remote-curl: fall back to basic auth if
 Negotiate fails"
To:     Jeff King <peff@peff.net>,
        Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
References: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
 <YKNeXq3JzxYWkxKl@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <43035278-5742-607a-57bd-971685deece8@gmail.com>
Date:   Wed, 19 May 2021 09:58:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKNeXq3JzxYWkxKl@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 2:27 AM, Jeff King wrote:
> This reverts commit 1b0d9545bb85912a16b367229d414f55d140d3be.
> 
> That commit does fix the situation it intended to (avoiding Negotiate
> even when the credentials were provided in the URL), but it creates a
> more serious regression: we now never hit the conditional for "we had a
> username and password, tried them, but the server still gave us a 401".
> That has two bad effects:
> 
>  1. we never call credential_reject(), and thus a bogus credential
>     stored by a helper will live on forever
> 
>  2. we never return HTTP_NOAUTH, so the error message the user gets is
>     "The requested URL returned error: 401", instead of "Authentication
>     failed".
> 
> Doing this correctly seems non-trivial, as we don't know whether the
> Negotiate auth was a problem. Since this is a regression in the upcoming
> v2.23.0 release (for which we're in -rc0), let's revert for now and work
> on a fix separately.

I think the revert is sufficiently justified here.
 
> (Note that this isn't a pure revert; the previous commit added a test
> showing the regression, so we can now flip it to expect_success).

Keeping the test is excellent, because it gives us a way to confirm
that a second attempt at a fix is at least as good as the first.

The only thing that could improve this situation is to add a test
that checks the bug that the previous version introduced, so that
the next round doesn't repeat the mistake. That can be deferred
because it is more important that we get this fix in time for the
next release candidate.

Thanks,
-Stolee
