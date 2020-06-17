Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E3C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DAA21707
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9VK6+3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQR64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgFQR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 13:58:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D0DC061755
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:58:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x25so2713143edr.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d/gOlvx6vPp/yc4UESFusaHlIs2k6Zp2+i7zli3ZOvA=;
        b=h9VK6+3B0pmBssyiTB/7nm7ffIuXwyt2pok2cSHqSaUiOpsF+bfpZ5mMjBTeWWe6KG
         GUND/E7josiNmiuOzVQeB3VLI45iwm9QVgLgkUlwHE78ZGlpMn9X1qWoxd805MXMRGp/
         FEscY0bNSE9tt2v0Zka4K3XzGrzzpnMoWQbH6aOhvLUSy5Tjfp0OLQUbB8DBIZUAcP7J
         3oUqwQVx1W1eneXTNdWdKk532f5lo9yd9jbAPKuccZihMKE+OV774/e2r8pz/kxyILlx
         C7ancB+K7FlihFGEgcUqmwCRTtc0gUnvg8z/KS0LTkfiCc8HyJ9tARUGui4Mslz7YTrH
         YF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d/gOlvx6vPp/yc4UESFusaHlIs2k6Zp2+i7zli3ZOvA=;
        b=EhNBx70KmAGWvs9IfuCOvroJZfh1bXld+5y+S+gjfcaZtjNYg8w3rU/NW4lb//4+tq
         06fGldLtWzFJQRpqNq7YWcHKALmzGySDsbuE0qfHWMfL8lIcdL4YgNzntoEhz4+wbKBO
         EbzGyI4M5doHWbzN+kJAt9gw/kAdUljbH+2QeMKDIhNzmBDmc0KgsU4IyqiAoEiFplXJ
         iwNCl77nGUz/Q/RMhStYEA/MGyCkLPDcmklXEg5q/7Gm2/HxL+FsYpEufLF1akWu2IpD
         EbCejfBGgXFoBbaCvEs7vM9FEYM2ID5rqa0GwhqWxwuZ5N4W1IclUPBNMtj3vW+pxl6Y
         FKaA==
X-Gm-Message-State: AOAM533lRMaIoWm9hacizCK7pjeuOryfjs1Vh0ak8r2UN4g9IvUthXHv
        lGIXvq+hNRXSiHYbWKar5Ug=
X-Google-Smtp-Source: ABdhPJyTX9a2o+TQbecFhj/TcuVFpZFGE5E81xwieL3AVuyjLPCzDspRrPO2TppPd9r504M57khkZg==
X-Received: by 2002:a05:6402:312a:: with SMTP id dd10mr357556edb.320.1592416733305;
        Wed, 17 Jun 2020 10:58:53 -0700 (PDT)
Received: from C02YX140LVDN.corpad.adbkng.com ([2a02:a210:ca2:9c00:a0e3:4489:832f:5f61])
        by smtp.gmail.com with ESMTPSA id h16sm476174ejq.62.2020.06.17.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:58:52 -0700 (PDT)
Date:   Wed, 17 Jun 2020 19:58:50 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Sparse checkout status
Message-ID: <20200617175850.GA57254@C02YX140LVDN.corpad.adbkng.com>
References: <CAL3xRKf+rQuq=j_4NJpNbRq4Rdxz7MjQaxi3c9usS+c615k19Q@mail.gmail.com>
 <CABPp-BHyc=aYqY+YuvNRsFsrMPL6+O=CX37jzXx38_-SXw5gLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHyc=aYqY+YuvNRsFsrMPL6+O=CX37jzXx38_-SXw5gLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, Jun 17, 2020 at 09:48:22AM -0700, Elijah Newren wrote:
> 
> Well, there is `git sparse-checkout list`, assuming users know they
> are in a sparse-checkout, but the whole point of my suggested change
> is that they sometimes don't.

Ah thats true.
This was added recently and definitely slipped my mind often.

> 
> This surprises me; I considered performance while writing it and kept
> it simple on that basis.  In particular:
>   * This does not cause any reading or writing of any extra files; it
> is done solely with information that is already loaded.
>   * If users aren't in a sparse-checkout, their performance overhead
> is a single if-check, which I doubt anyone can measure.
>   * If they are in a sparse-checkout, then they'd get one extra loop
> over files in the index to check the SKIP_WORKTREE bit.
> 
> In which cases would performance implications be a concern?  For a
> very simple point of reference, in a sparse-checkout of the linux
> kernel (using --cone mode and only selecting the drivers/ directory),
> I see the following timings for 'git status' in a clean checkout:
> 
> Without my change:
> [newren@tiger linux-stable (hwmon-updates|SPARSE)]$ hyperfine --warmup
> 1 'git status'
> Benchmark #1: git status
>   Time (mean ± σ):      78.8 ms ±   2.8 ms    [User: 48.9 ms, System: 76.9 ms]
>   Range (min … max):    74.0 ms …  84.0 ms    38 runs
> 
> With my change:
> [newren@eenie linux-stable (hwmon-updates|SPARSE)]$ hyperfine --warmup
> 1 'git status'
> Benchmark #1: git status
>   Time (mean ± σ):      79.8 ms ±   2.7 ms    [User: 49.3 ms, System: 77.7 ms]
>   Range (min … max):    74.8 ms …  84.5 ms    37 runs
> 
> I know the linux kernel is tiny compared to repos like Windows or
> Office, but the relative scaling considerations are identical: it's
> one extra loop through the cached entries checking a bit for each
> entry.  If people are worried about the "extra loop", I could find an
> existing loop to modify and just add an extra if-block in it so that
> we have the same number of loops.  (I'm doubtful that'd actually help,
> but if the concern is an extra loop, it'd certainly avoid that.)
> Anyway, if you've got more information about it being too costly, I'm
> happy to listen.  Otherwise, the overhead seems pretty small to me and
> it's only paid by those who would benefit from the information.
> 
> However, all that said, I have good news: Peff already implemented the
> flag users can use to avoid this extra output, and did so back in
> September of 2009.  It's called "--porcelain".  Automated commands
> should already be using it, and if they aren't, they are what needs
> fixing -- not the long form status output.

When I wrote my initial reaction, the idea of having more than just a
percentage reported back stuck in my mind, specifically with using the
in-tree checkout that I mentioned.

But yeah, that's something down the line to address, you are absolutely
correct that the current patch has no performance impact. Thanks for the
reminder about '--porcelain'.

> 
> I think having a 'git sparse-checkout status' would be a fine
> subcommand, and output like the above -- possibly also including other
> bits Stolee or I mentioned elsewhere in this thread -- would be cool
> and would be helpful; it'd complement what I'm doing here quite
> nicely.
> 
> But you're solving a related problem rather than the one I was
> focusing on, and you have left the issue I was focusing on
> unaddressed.  In particular, if users forgot that they sparsified in
> the first place, how are they going to know to run `git
> sparse-checkout status [--all]`?
> 
> I think having a simple line of output in `git status` would remind
> them.  With that reminder, they could today then go run 'git
> sparse-checkout list' or 'gvfs health' (as Stolee mentioned he uses
> internally) or './sparsify --info' (as I use internally) to get more
> info.  In the future we could provide additional things for them as
> well, such as your 'git sparse-checkout status'.
> 

I do concede that this point could be a separate problem set and addressed
separately in the future.

> 
> An aside, though, since you linked to the in-tree sparse-checkout
> definitions: When I reviewed that series, the possibility of merge
> conflicts and not knowing what sparse-checkout should have checked out
> when the in-tree defintions themselves were in a conflicted state
> seemed to me to be a pretty tough sticking point.  I'm hoping someone
> has a clever solution, but I still don't yet.  Do you?

I am no clever person, but I often take great pleasure in reading up
works of smarter people. One of which is the Google's and Facebook's Mercurial
extension sets that they opensourced a while ago to support large repos.

The test suite for FB's 'sparse' extension[1] may address your concerns?

The 'sparse' extension defines the sparse checkout definition of a
working repository. It supports '--enable-profile' which take in definition
files ('.sparse'). These profiles are often checked into the root dir 
of the repo.

> 
> Thanks,
> Elijah

Regards,
Son Luong.

[1]: https://bitbucket.org/facebook/hg-experimental/src/05ed5d06b353aca69551f3773f56a99994a1a6bf/tests/test-sparse-profiles.t#lines-115

