Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08DC3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D062420705
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsssH6wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEEAqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgEEAqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:46:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4CC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:46:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u10so106739pls.8
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LRcDhXGmratLTfjJMDv/CP7Oe4lgjNAWDzlWvs0saYE=;
        b=GsssH6wfp5ugZWb55vciGs2Bo6pYII9gkgViZ0+u0yOjVfpPogD3bkSJdNQYmkt8e1
         WYXxv1cqy9UcjEpp59ngifQjkNMr50lSUVaqBKgSvdPxxKUVOnBYmQHu7oGM9JAthDPm
         TryeVXNDpbpFTSqT/pa3e1dHa04cw5qMff73iWiATnNWdOEDZNeZmoIQLgpimChA5Ghm
         MLLmT1H17QYq3xmD8Ted8Eg3TR/nDv/iWw7rS1B4pnP1Q7zAgSz3LEm2Dxbm5D4IUpFe
         CaCdwccyo7KT2GM0i7tpf8Jt6p4IwvDTg14VKSDOQimgHP3yU2AbhYETorEjUsxINFiU
         3BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LRcDhXGmratLTfjJMDv/CP7Oe4lgjNAWDzlWvs0saYE=;
        b=TQJ7QZLsGpSjYXfnQfdL1B1Te1qRAs8R2QyRI8mEDpUuuiGkJ9LCoEMKD/YOG1GJmU
         X5ilNzEcG8GwCo8McKKIKqRnUux2Xv/41vG8jQTNbFvhn14oL8lq4HbpCXh36A4eYzsh
         We2paxu7L3fddlqd12gE1X+Auf7rILWo5T96AzHgnkhwS53LmSs+r7WBg3fFfkBVmpZs
         wmFBsOF/dabPygInBYu+WZJv4VLy3FbG4up/nyJEuJxgEpaGOW12h3qrPePoRUEcnIM4
         Z0nmfXBUITe2WzkE39pwxxxUH7vyIyUCgXJd06b1oOXVe5PhXsXvbrP+EuWUoLRl/0Xd
         KYwg==
X-Gm-Message-State: AGi0PuaQR420WJHVp9w24Min8mT89743tv77xYf69+Wjnfm3xECtn5IO
        DMdSY3Lpv7LtEpAOzcoH6VqNuOHZ
X-Google-Smtp-Source: APiQypKyC1x1CSLNOxxshe01fG29jl7jkjX806Zxvy8pw+9icP5CR4E+ZQHsvMVbIg/mukwKWiZN8g==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr623775pla.336.1588639566134;
        Mon, 04 May 2020 17:46:06 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id h31sm175245pjb.33.2020.05.04.17.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:46:05 -0700 (PDT)
Date:   Tue, 5 May 2020 07:46:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] SubmittingPatches: advertise GitHub Actions CI
Message-ID: <20200505004603.GB927@danh.dev>
References: <20200504150105.GB11373@coredump.intra.peff.net>
 <cover.1588607262.git.congdanhqx@gmail.com>
 <24a8fefe5add61d557a29f070bd2ca0d0f43d844.1588607262.git.congdanhqx@gmail.com>
 <xmqqmu6nhd1k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmu6nhd1k.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-04 09:37:11-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > +Alternately, you can use GitHub Actions (which supports testing your changes
> > +on Linux, macOS, and Windows) by pushing into a branch whose name starts
> > +with "for-ci/" or opening a GitHub's Pull Request against
> > +https://github.com/git/git.git
> 
> Can you tighten the description of "for-ci/" a bit?  It's not like
> the convention is offered in _any_ repository, but it is active only
> if you push to a fork of git.git, right?

The convention will work in any repository with
"$TOPDIR/.github/workflows/*.yml" exists.
Since GitHub Actions will look into the file ".github/workflows/*.yml"
in current repository.

> If your fork is a fork of
> a fork, what happens (e.g. github.com/gitster/git is marked as a
> fork of git/git; when somebody forks from gitster/git, would they
> also get the for-ci/ convention)?

Yes, they'll get that convention.

-- 
Danh
