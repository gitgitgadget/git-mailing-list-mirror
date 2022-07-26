Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30753C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 01:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbiGZBSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 21:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZBS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 21:18:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C02656E
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:18:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b21so9515822qte.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rzANS/7lMQ+SdRm83QHZd27nsBHtSHgqrQKYcJd/D4A=;
        b=UUmVhpMAEA9XJIs3vWX1jQ6NFzo2QphF1cuQ9s4zbSXOXhHAyFBAqrudu1wSE67DwB
         UWtcZsxoDdvCdp/6RWY7hpugAg77Qjt3zt3quTb3z+0BDbw99KjpCRvgubsTZVCBZ8xe
         viSx132sTUhjcFLbMGAsEkBkkJk6WTn+NubqwMYlrsFFxc9Y7/XOLb48buJwyfFIIDTe
         TufRVDGcQRS5c12wQEOljrv0Sv/b0qnJjbCXVMlVjMCKwdxcj8ItP+mx9vs0oM5A1fyg
         051c2PmAUteRzgsjTKoJfPRAqCNUfgfT4TdDzSvVwG/kW4IGwy4X3DawqGfJigapPsml
         FdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzANS/7lMQ+SdRm83QHZd27nsBHtSHgqrQKYcJd/D4A=;
        b=7+DT0XKPjIPZmUUEQkVsVJqHRhk0ksGk6FHiUvVwpJaz89tzlqcJBbfA7h8SI+7j2/
         uU4Mrlbs7XLPHCIpcRjAaquBlxOPjaVc/dGIEBTBPCfcAWkAplcWjV/UcxzCP5MbBOt1
         hJpV86Axray6jLhphZi00MYV248US5YpZIgVwuxsGjCyMUK62lIX5t9H8gWGTILVc38j
         bdbsTHMSt9tQ1L42jaPzLvDEpInPYTICyLf/DK1RqERjJcU6WwPtYxnRD4fsee8WULly
         H17ZAEB4a9fIDY5rWSQ9UMgfSfi0oL1gS1QkXjpFOjzg53keynETQN0ZrZ7UA87YCNLJ
         9hxw==
X-Gm-Message-State: AJIora8meGO5C0cGS7dvuaIf4bptdbwZKs0ahZ6+m7Yv21PqHcag9x+l
        d/CLzPsLv1uG95/tZMDgwoy4EQ==
X-Google-Smtp-Source: AGRyM1sYUGpGrfh15Y336V5HW9D2QeIUEwNJj9Bhg1T6uZEKh+bD+kRSF9JDbavpB8BJw7YbIL8Q1Q==
X-Received: by 2002:ac8:4e54:0:b0:31f:403d:ea1 with SMTP id e20-20020ac84e54000000b0031f403d0ea1mr1152024qtw.143.1658798305080;
        Mon, 25 Jul 2022 18:18:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fv27-20020a05622a4a1b00b0031eb5f07b95sm8424859qtb.57.2022.07.25.18.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:18:24 -0700 (PDT)
Date:   Mon, 25 Jul 2022 21:18:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable
 `pack.writeReverseIndex`
Message-ID: <Yt9A4Lh5MzHigeVe@nand.local>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 20, 2022 at 06:38:23PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Enable `pack.writeReverseIndex` before running pack-bitmap related
> performance tests.
>
> The performance difference with `pack.writeReverseIndex` enabled and
> with disabled are given below -

Thanks; this order of changes in the t/perf suite makes sense to me. One
note, this sort of change where we're comparing all of the tests in a
single t/perf file against themselves before and after some change, it
is helpful to do (in t/perf)

  ./run HEAD . p5310-pack-bitmaps.sh

which compares HEAD to what's in the current tree. You'll get the
results side-by-side, which makes them a little easier to scan. You can
also aggregate results together from multiple runs with the
t/perf/aggregate.perl script.

One gotcha (that has often bitten me in the past) is that when running
the perf suite with `.` as your build target, it uses whatever git
binary is sitting in your tree. So make sure that it is both (a)
up-to-date, ie., that it is the result of compiling what's currently in
your tree, and (b) that it is compiled with the same settings as what
you built HEAD with.

I have often scratched my head at why the result of running some perf
suite on '.' seems much slower than it should be, only to realize that
the "git" binary sitting in my tree was built with -O0 or something.

Thanks,
Taylor
