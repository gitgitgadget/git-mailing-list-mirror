Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B63C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 02:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiBSCmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:42:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiBSCmO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 21:42:14 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098E66CAE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:41:56 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id c14so18390182qvl.12
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dms3iM2v+SmFxfNh8Uy6pe6F3svD54Fh+k/eCJBv4W8=;
        b=AximFEsyvu0kJatfgd/FmfTPC7gKnrAegR+y3OQQ9hjV+NmqxRgUfuuYhM2uIDvDp/
         WiOjoTWwAugEnDf12jK71ojTFaT06jsmVnuHJXDyyJp2U/cRaZ9039xzBithx408qHtn
         7cskM1A/h9haqn8DnLKqzPrUgJ9KVvWiIHM4PKKytGfTFic/8Q+lZiBJpP7OHqKuGMaU
         mGlZVgBp9UmzhucaAqhw8vkgE3ZRN6+/HkNr9VO45dq3bA5JKhnp0CU4MdT1gRNZxJiT
         ePNqys/yk+6iv7gAee9VYPprlXBR1aBRfCd4+gtEnDhsGaXmuuikjGwAUKpYFrbLYfoU
         KSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dms3iM2v+SmFxfNh8Uy6pe6F3svD54Fh+k/eCJBv4W8=;
        b=wFE7k6Rb5BqXgUQTlB//ACNX7eL66mE/FHHq0gRoBn1oAqU+KLa0jiseyNV4i9gqtB
         5DaNPM94ycQ2ZiSR9P8m7qSUVKpVCYh9cWPJhbz5p+dqX7SOBrJkYX44s6gJx4/kBu2o
         Q8R1O3ezZARmrfDihnDH6R6eFN255fLEVt+hIhnG9uYBTKww9czs4w5JDUHmfRJfSkIN
         x0nxskSOkLBINR6XLw0baeV6FawyxEoXAbQnNycrS0edQCMH6V1VEqwouAxqkAVn5Z+x
         QQYDfkVs++hOf9bLyhX1L39wDcmhsapMloqgxQEYUx64e30/szxfsRc6iAFGf+4T34Ry
         VtQQ==
X-Gm-Message-State: AOAM530rcZMDznN9GMDZp1kNKF5vS3+Eq4cGliDCZAiXq22+ls4fZJed
        CaTGYeKZtGc2SOQR9qg5Cj0DwQ==
X-Google-Smtp-Source: ABdhPJzlNNHuWkJmKJmZsfKzK3+MtunOvXZCHej0meyYDZ+5gf3TJn6ote/67RgaSlCQmZhQUVWjFQ==
X-Received: by 2002:ac8:20a:0:b0:2dc:ec16:7e72 with SMTP id k10-20020ac8020a000000b002dcec167e72mr9321904qtg.428.1645238515313;
        Fri, 18 Feb 2022 18:41:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e17sm151125qkm.26.2022.02.18.18.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:41:55 -0800 (PST)
Date:   Fri, 18 Feb 2022 21:41:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Message-ID: <YhBY8oD/xJZUQsj9@nand.local>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 <xmqqley7yd6e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqley7yd6e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 03:20:41PM -0800, Junio C Hamano wrote:
> > +# Usage (using ":" as a delimiter):
> > +#
> > +#	prepend_var VAR : $1
> > +prepend_var () {
> > +	eval "$1=$3\${$1:+$2\$$1}"
>
> This one is correct; the above sample, when passed ":" and "VAR" to
> $1 and $2, will specialize into the above example.

> > +}
> > +
> > +# If [AL]SAN is in effect we want to abort so that we notice problems.
> > +prepend_var XSAN_OPTIONS : abort_on_error=1
>
> XSAN_OPTIONS stands for "options that are common to all ?SAN", I
> guess.

I was also unclear on this. Looking around in the google/sanitizers
repository, I don't see something called "XSAN_OPTIONS" mentioned
anywhere (neither in documentation nor in the actual source code).

Is this a convenience variable that we use to store options that are
common to both ASAN_OPTIONS and LSAN_OPTIONS? If so, I am not sure the
extra confusion is worth it, since it only contains abort_on_error=1.

I guess it makes it (along with the prepend_var function introduced by
this patch) possible for a caller to write XSAN_OPTIONS=... into their
environment and then run a test script and have their settings feed into
ASAN_OPTIONS and LSAN_OPTIONS. But I don't know that callers would find
this super useful (or, at least not dramatically more convenient than
setting both variables).

I could be wrong, and I'm obviously biased towards my own usage of the
ASAN/LSAN builds, but to me this patch might be clearer without the
extra variable.

> >  # If we were built with ASAN, it may complain about leaks
> >  # of program-lifetime variables. Disable it by default to lower
> >  # the noise level. This needs to happen at the start of the script,
> >  # before we even do our "did we build git yet" check (since we don't
> >  # want that one to complain to stderr).
> > -: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
> > +prepend_var ASAN_OPTIONS : $XSAN_OPTIONS
> > +prepend_var ASAN_OPTIONS : detect_leaks=0
>
> This makes me wonder if you want to generalize prepend_var even
> further to notice when "$3" is an empty string.  It already avoids
> spending an extra colon (and introducing an empty element in the
> colon delimited list) by paying attention to the current value of
> $1, so it would make sense to do the same for the incoming value.
>
> IOW, the current prepend_var implementation relies on $XSAN_OPTIONS
> and detect_leaks=0 both being non-empty string.

Yes, agreed.

Thanks,
Taylor
