Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDEC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjHHUe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjHHUej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:39 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEDD7283
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:01:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d5869d9651aso1705832276.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691524908; x=1692129708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VP9YBHCg/urFwWcXlxRgNj4VZyPaxrsnUtiosiWvJS4=;
        b=t2UGlaZ7P+YQMZ7kEqrjNvJPww82pPOC0fsBAPNvGbEoIORpOejm3NQYiYZBTkov+m
         3Qg+mWhmQIzCxGnDK9DDIihVFkFJcao2dE17/liV1B2dhakENHyLr6lYY6GCJ+URb9LY
         qh40BiBdLS33Zmpy/uP+ShA17Gv/62MASWEBwOt5Arx4Eq4oO93nMglvqXyYzp1Zen7c
         o6eThJXnImLLEhv45mAwXZKle+JGFHq/RfrdZ/PLC6Gcs+7yGpSU1bjDNCPudTpi9A17
         UpAv45KnQjq3/RxZeu6ZowQrCxtpH1m8kVnjr3lseEs8dmx/QOdSGY3hLpzl3qACTGcH
         XM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691524908; x=1692129708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP9YBHCg/urFwWcXlxRgNj4VZyPaxrsnUtiosiWvJS4=;
        b=RsO0M9yow1KXI1OlivmmFlCeo0qc5xCGh/S4saqw91s+lW2VNIZmgeHElSjtnECxki
         9RxbqftmEglN5PVEHGgD2eThPKHm2ut1rmIcRYB/puumflI7Tzdks4ksF9JOajvBbTvX
         TwX57RUL3jduzCJEyF8q1t2BD8CEoGBT0dcObYJGdpoWGaYAg0wDUKH+/nptmmJlornL
         ECMrFYXay6G6Pvnzcvx46rz3cXaaYruzNhD0qsrdVaKpsczULqTOdRPfXuq0XBwFM00L
         uXFoRysaQxlQZmG3MobdIv+eOrB5l+WvpACEaaScj/DAvXwj0uoWc51ATYWpR1Xjn96Z
         mnMg==
X-Gm-Message-State: AOJu0YzjSHMS5db+Yx58OWroiaDegflhcGdL+GSg0a4g/uPrLWSH/rzB
        UUySLvrhE0ufDh1t1eX6y4403A==
X-Google-Smtp-Source: AGHT+IHRqvAEUnERgYSigj9s1XH4Ww9Ieeit4ZrBz7lzZfRhXh/8cJKjTlyTLYgszmnXHp8t5cnSKA==
X-Received: by 2002:a25:b00e:0:b0:d08:5632:6b78 with SMTP id q14-20020a25b00e000000b00d0856326b78mr533469ybf.47.1691524907724;
        Tue, 08 Aug 2023 13:01:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m9-20020a258009000000b00d474cf6f53dsm2165627ybk.45.2023.08.08.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:01:47 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:01:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
Message-ID: <ZNKfKs1mLQhnybvF@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
 <ZNFgIyuhlNd8I9Y2@nand.local>
 <xmqq4jlabea3.fsf@gitster.g>
 <xmqqzg329ycm.fsf@gitster.g>
 <ZNJVycLBUIXqZ0Xb@nand.local>
 <xmqqbkfha3xu.fsf@gitster.g>
 <xmqqsf8t8oo5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf8t8oo5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 09:49:30AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Provided if code simplification is a good enough rationale, the
> > patch looks sensible, but I find its use of u64 a bit questionable
> > (though not wrong).  I would have expected that the type of "rand"
> > would be the same as backoff_ms and wait_ms, two variables involved
> > in the same expression.
>
> Ah, not so fast.  The use of modulo means we need to be careful
> about about the fuzzing factor going negative, and use of unsigned
> type allows us to forget about it.
>
> (fuzz % 250), when fuzz is of a signed random integral type, ranges
> between -250 and +250 and because we want the center of our
> distribution at 1000, so I think the following is equivalent.

[...]

> -		wait_ms = (750 + rand % 500) * backoff_ms / 1000;
> +		wait_ms = (1000 + fuzz % 250) * backoff_ms / 1000;

I was going to say that having rand be an unsigned type was the right
behavior, but with this change it can (and should) be signed. Thanks for
the simplification :-).

Thanks,
Taylor
