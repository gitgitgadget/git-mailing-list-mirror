Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBDEC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797A4611F0
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKJAVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKJAVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 19:21:45 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC7DC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 16:18:58 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z26so765303iod.10
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E9ovvmWqu8DhgRnEtwJLahp5cCN+sIzw/k4mvFbiULo=;
        b=12g0fjD/73IO7urbqeypL4s4aoLAKyJPgtIkAGTwVyz74jLJbwNs1RdNKyN+DQP8M2
         ithOkaqkpPUcgMtZRYhGbCtV+pL19X3saErjZac3n7eItMpmkac+woSuKycSChQe7OBc
         p1p+sQrTbmUWB+PoU6rSt0uCq1e+6PU/0geqi67zxxFqowFQ0TNJ+1mbk/P/wutYL4YX
         MFWJChetcBmNeNKZvLFH+8MnxI21jbxiH394fToiSfNzRe47Jkw/pIoQ6H/M0WLzuywB
         pDeLuHVTdF0fv/cbpNxjm4Zvom97bR3r3jK4GtJU7AUQ7diWYRntmit6HsG0nuhDhNI2
         Uz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E9ovvmWqu8DhgRnEtwJLahp5cCN+sIzw/k4mvFbiULo=;
        b=w3CK/G4SLs01Eb+w9CTw4BEHwo8NhiHkx8OfaZ+S9ht6YDkvmVLh/0Q34CvbCGjz0l
         Z2ecd87OWLLa5PY5yZGKIpJVYx8RseompouvOOhQbPRrG21j77MjunInlRhStUhqjQSs
         DfZsua+Un/6BhpM2FDaHdc5rVJePFW/vqAhI0FHC6NVsxnYA6wTdDOUNcDGJJjBkDOZX
         yk4wkXg+ryam9fTvVOe/zOQccwYR5ywEcG4I4A8CZohxkqjuM5zvcn7AWjPwi3bc8Z+e
         HlVG7bGE/J7YPzsxaxQbzAe9yxuYlndZ/S10IpNN66TfaLaxuJ6mA17t2ziL02srNaB4
         jAsQ==
X-Gm-Message-State: AOAM5316/SURNjItMVhbOeusCVWjYIMQlKa+I36bDJr5FVHHDapxhk7q
        8fO0jemWUDTnIH4a1HlUn4AXmQ==
X-Google-Smtp-Source: ABdhPJzAb2gls0+OcJLcBtpp37RKaQYu0q0wgWAjBYKGmK6vzd8cx6Y6eHj3d1dlqGQVC+HWdt0JRw==
X-Received: by 2002:a05:6638:1382:: with SMTP id w2mr9216844jad.50.1636503538417;
        Tue, 09 Nov 2021 16:18:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i3sm11147331ils.19.2021.11.09.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 16:18:58 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:18:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 4/8] grep.c: move "prefix" out of "struct grep_opt"
Message-ID: <YYsP8WM14RvgE7w9@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-4.8-78298657d69-20211106T210711Z-avarab@gmail.com>
 <YYmO9xlgFGhQlFZg@nand.local>
 <211109.865yt2dqmf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211109.865yt2dqmf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 03:10:31AM +0100, Ævar Arnfjörð Bjarmason wrote:
> > All of that is to say that I share your motivation for this patch and
> > think that the direction is good, but I would have preferred to do it
> > without the caller_priv variable (unless there is something that I am
> > missing here).
>
> Yes, that would make much more sense. I just had tunnel vision while
> writing this, evidently. Yeah, just either passing it or using a static
> variable in grep.c would make more sense.
>
> Arguably we could even have it be read only (const char *const) and have
> a global "the_prefix" or something, but it's probably not widely used
> enough for that to make sense.

Either of the first two seem fine to me, but introducing `the_prefix`
seems both over-specified, and too big a step for this series alone.

Thanks,
Taylor
