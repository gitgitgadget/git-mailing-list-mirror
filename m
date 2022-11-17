Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E90C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiKQWEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbiKQWEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:04:20 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9185EE6
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:02:38 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x16so1642797ilm.5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zsu37OT3ioE9PmMgFdyDOIoFrY4Fiklny5rGn9yGbPw=;
        b=4uWQ5Cgs8REZoqr5LZqnQlrpixxJAnZm8dyGxl3rBccRyBuTPlJTkXtSGR4U0BTSRJ
         0KBWa779DaGkYSdM3x1ktjUmdPr9a+pcINVBT2Qv15M5afVc6a6hxS6DdRpeuO+e4HUf
         S8R86LtMezz9OVnjYtqP8IIq7xKSOBiapL8F/HBoB9H3x31jqzzi8asbPIHCnbP8ihO1
         ITyBT92jaqeoOWIoZVissCNUol8THgj0467YU6wJ1dtCSFkCOdItgtS/gy1QoJv2OZoI
         g5KNNx77qcYcxF+mawCKtscLjc4k1ijK23Onu8noOdKWLzPj1DMhYjt3NLd+eeJpE/uI
         wZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsu37OT3ioE9PmMgFdyDOIoFrY4Fiklny5rGn9yGbPw=;
        b=gwCFPQOpAXVcdFZwGISoLFYpUDVp/3MYxDOMmfctixnAoS5E6jiSR61S0yd5nM+wnR
         Sh2rrZX3V1blGbXwxo8uR1XZFEqxxX9WwGLRpS/KsZD9LVmmjVcoNhW/eDhF1n2cSfl+
         VJjb1+Dgfzx2Z2uq7jotMY7F7DoYWnO18R64AyAYK4TKPhY3QPZs4UaCD6MK0YWAlPLi
         5C2f28hUtbLQ16ncocxICltSLtrFstL9yn/SOCNpRRBaM4JOXHIdsMzsZgg+A8wjVUpv
         GBwmXb4IEquhToM3TeCXJtTcSSxvYK39DKftdva+DSkjXfHEYZljo72xAS0Umsi14Mty
         zTLQ==
X-Gm-Message-State: ANoB5pkyycEUkE13NVCpTNAnzIm4dgOIV5au6juL3a0k7X0gL+nl9gMM
        ui/eMn2eXy0VbZFYmQzQQozgGw==
X-Google-Smtp-Source: AA0mqf7fRcYSk9jUtoTQpzxF4zBRMVd8NF13RYPSO0s7K47Llv067pBTj2XhxsGjBkQ/DMQziXcr3Q==
X-Received: by 2002:a92:680f:0:b0:300:e393:34c3 with SMTP id d15-20020a92680f000000b00300e39334c3mr2056108ilc.112.1668722557924;
        Thu, 17 Nov 2022 14:02:37 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a0566022bef00b006cecd92164esm724061ioy.34.2022.11.17.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:02:36 -0800 (PST)
Date:   Thu, 17 Nov 2022 17:02:35 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 0/6] ls-tree: introduce '--pattern' option
Message-ID: <Y3ave2+kEwLTvtE6@nand.local>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <221117.86k03tiudl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221117.86k03tiudl.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2022 at 02:22:20PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Thu, Nov 17 2022, Teng Long wrote:
>
> > From: Teng Long <dyroneteng@gmail.com>
> >
> > This RFC patch introduce a new "ls-tree" option "--pattern", aim to match the
> > entries by regex then filter the output which we may want to achieve. It also
> > contains some commit for preparation or cleanup.
> >
> > The idea may be not comprehensive and the tests for it might be insufficient
> > too, but I'd like to listen the suggestion from the community to decide if it's
> > worth going forward with.
>
> I applied this series, compiled with CFLAGS=-O3, and:
>
> 	$ hyperfine './git ls-tree --pattern=[ab]c.*d -r HEAD' './git ls-tree -r HEAD | grep [ab]c.*d' -w 10 -r 20
> 	Benchmark 1: ./git ls-tree --pattern=[ab]c.*d -r HEAD
> 	  Time (mean ± σ):      14.8 ms ±   0.1 ms    [User: 12.0 ms, System: 2.8 ms]
> 	  Range (min … max):    14.6 ms …  15.0 ms    20 runs
>
> 	Benchmark 2: ./git ls-tree -r HEAD | grep [ab]c.*d
> 	  Time (mean ± σ):      12.5 ms ±   0.1 ms    [User: 10.0 ms, System: 4.0 ms]
> 	  Range (min … max):    12.4 ms …  12.8 ms    20 runs
>
> 	Summary
> 	  './git ls-tree -r HEAD | grep [ab]c.*d' ran
> 	    1.18 ± 0.01 times faster than './git ls-tree --pattern=[ab]c.*d -r HEAD'
>
> So the value-proposition isn't really clear to me, and the included
> docs, commit messages & this CL don't answer the "why not just 'grep'"
> question?
>
> That's faster even with another process for me, but likely that's
> because you're doing the regex matching really inefficiently
> (e.g. malloc-ing again for each line), which could be "fixed".
>
> But in any setup which cares about the performance you're likely piping
> to another process anyway (the thing using the data), which could do
> that filtering without thep "grep" process.
>
> So I don't see the value in doing this, but maybe I'm just missing
> something.

I think this falls into the same trap as the series on 'git show-ref
--count' that I worked on earlier this year [1].

At the time, it seemed useful to me (since I was working in an
environment where counting the number of lines from 'show-ref' was more
cumbersome than teaching 'show-ref' how to perform the same task
itself).

And I stand by that value judgement, but sharing the patches with the
Git mailing list under the intent to merge it in was wrong. Those
patches were too niche to be more generally useful, and would only serve
to clutter up the UI of show-ref for everybody else.

So I was glad to drop that topic. Now, I'd be curious to hear from Teng
whether or not there *is* something that we're missing, since if so, I
definitely want to know what it is.

But absent of that, I tend to agree with Ævar that I'm not compelled by
replacing 'ls-tree | grep <pattern>' with 'ls-tree --pattern=<pattern>',
especially if the latter is slower than the former.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1654552560.git.me@ttaylorr.com/
