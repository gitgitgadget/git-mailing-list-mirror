Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C09C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4347920639
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 17:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6jG7Hz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHXRz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHXRz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 13:55:56 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D600C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:55:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g13so9604320ioo.9
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z+ErQfVHnYFsJWPoUO2u6jry3xS4kl54PhrlY+eQu6k=;
        b=W6jG7Hz5Xu6mSWZtvRO9COlpS1T3KcUA42+lCnJcfvJONJubHZkuBbbgW7EjlST2/U
         gt9gl7G1hONjNKmjk/PY/Slv2wDFGvG/Y9MztNE/8XE/T/E5kzAl3pQcuiXj8J7lpD83
         /qE/as7bzBcsFgZFKbBqGCruIBHZkf85qOfo1wmvFDONvS5zXog/JjfScajRLBxfUivo
         QbDU2tQ7jQob6GqSwQF0cn1j9K5LKd12WKQ/ZlD+36Vu4cKJ1vsHD5tyXvxp7riWcYk5
         CmBB7g09H5EPS5MuDyzVPdzaZ2HvVjSrUZBNS0Jy093isjVb6wf+JcTuIXS3gb6zVxme
         1cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=z+ErQfVHnYFsJWPoUO2u6jry3xS4kl54PhrlY+eQu6k=;
        b=NAbUBywYqMeBAzz0Q3unHEQ+KvrYEc6HGJm0sopAtGf46hc+6SsjOChxK1qXUSGDll
         WLdG2xIK7BhrBGoBMR8/VUYaBmCUiSs6qMLbSgjVf0F/GflNr+Fwinqj4EmM89AQsfFB
         Dt+hOnBwygwvX+g82p9S9Ra1ImB0O5y7XdkTpJihLHaP/ETusH9uHE/+OOMtzu7qTgJU
         qRtx30wL10ax1nia+6lJ7E5Sa90BpT/h7J2QYM8WPa03hHgZe90ia9ut059MvuPj0Dd1
         YqwRltHHuLi1689bNt0Ux1QqY8ad+OoCWgyei6vMgz38+iDUWa0RmG9Cv8F6NLI5xmNz
         xk+w==
X-Gm-Message-State: AOAM531Q/5XO0NXzsyfKFLvVwF5QghEyEIKCyiMM6vPsjkrCZe3jGlQb
        gSwvFjqo+E8nEdhMB+3M/8k=
X-Google-Smtp-Source: ABdhPJwnI/e20Nv2taIWp682fZZdFt/ClTaf4G1mVVSFLpDiCNoawWkR3PRnnx94C4pUzN/U2IrLuQ==
X-Received: by 2002:a5d:841a:: with SMTP id i26mr5700195ion.144.1598291755671;
        Mon, 24 Aug 2020 10:55:55 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id h2sm230562ioj.5.2020.08.24.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:55:55 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:55:47 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] index-pack: adjust default threading cap
Message-ID: <20200824175547.GA9245@flurp.local>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821175800.GC3263141@coredump.intra.peff.net>
 <20200822011607.GX8085@camp.crustytoothpaste.net>
 <20200824173735.GA673908@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824173735.GA673908@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 24, 2020 at 01:37:35PM -0400, Jeff King wrote:
> So I'd be very happy if people on other platforms (especially non-intel
> ones) wanted to run:
> 
>   cd t/perf
>   GIT_PERF_EXTRA=1 \
>   GIT_PERF_LARGE_REPO=/path/to/clone/of/linux.git \
>   ./p5302-pack-index.sh
> 
> and report the results.
> 
> I do have a slightly-old AMD machine with 4 cores (an A8-7600). Here's
> what it says:
> 
>   5302.3: index-pack 0 threads                   447.67(436.62+6.57)
>   5302.4: index-pack 1 threads                   450.80(441.26+7.20)
>   5302.5: index-pack 2 threads                   265.62(459.56+7.30)
>   5302.6: index-pack 4 threads                   177.06(477.56+8.22)
>   5302.7: index-pack default number of threads   202.60(473.15+7.61)

I tested on my 9.5 year old 4-core iMac with 2.5 GHz Intel Core i5,
spinning platter hard disk, and 12 GB memory (recently upgraded from 4
GB). I used git.git rather than linux.git because I didn't want to
wait several days for the results (plus this is my primary machine
which I'm actively using). Results were similar to what you saw:

  5302.3: index-pack 0 threads                   14.85(14.10+0.66)
  5302.4: index-pack 1 threads                   14.65(13.83+0.63)
  5302.5: index-pack 2 threads                   9.11(14.40+0.80) 
  5302.6: index-pack 4 threads                   6.89(17.03+1.32) 
  5302.7: index-pack default number of threads   7.72(16.15+1.15) 

Thanks for providing exact instructions for running the test; I had
never done it before, thus didn't know how.
