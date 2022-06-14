Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93577C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 23:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFNXqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFNXqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 19:46:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E04CD4A
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:46:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t21so7259311qtw.11
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vuQJ6DetrtUH/XiK1XTl6h763X+bpWODd2hOuouazL4=;
        b=VAwaAWKkdBRloesxJlxW3mq0DpLSmxEBDVTbbWQ45T+zRuVFDIMW1UEA+tempL6m1e
         /K3L+xqefmIerhUtB2OtSACtr9FBXadFy+wZeqOQDm1b6ZHYtl5VB+tbhsOAbfIzB6lJ
         qk5+wvC/Ug3zbdoel88uNe2fVzToTAqnQ2pOfq8NPjVyvtDF8jiBmiO0nDKFfvWscRG9
         bTziFCdlJ2qJLGrEPykha3s2n/kjt8kpWz0SJbxz4q+5HLwUUabr0SA6UqHzjdJ0CdER
         YSlmHFQBZ1HRnUs/jWDRwl/Y+TzEBRDOKKIxnQU7zBsOV2zWignh2Ehm0Cn2Wa4WoriZ
         +84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuQJ6DetrtUH/XiK1XTl6h763X+bpWODd2hOuouazL4=;
        b=I3nlg9Lm/C9u0e5ZsO5oO7koOUBF6JWOc9o7YJB2TDt4vwr69P1PjXMqsTlle5jhbY
         yoZFRPLj4jK0Hl78pywjJ3XHYSDmNpLxkLnhXszGpjaPInVcCgBmVYjEBgxcsG0zMuF5
         uVcPnayikTSl4B+iADQrMiLFHhrSzdrp5As3BxYSU0pSgSvjpRzDa2P/awKaXUgqMpsJ
         4Ftz3q1r53R1PcG2v0ib9Snr1oIXQelsDgPRC588mCILD+SGo/TabnAg1j4UgdsjIEbi
         KVFB6NHxs9sz6ZLH3mw6i/A3hJG+tgomHxNElFD/sX5wenqABLCIJ1Pf+Z1eW4L6+PLl
         gH9w==
X-Gm-Message-State: AOAM533+hylfoVfP3Fotr29xh+/RI78e2aO4uX2RJ+T3pDagO6gqcOLY
        YJzBeU9u8F1aj18NwZTijClUAbVSvBi8QpJW
X-Google-Smtp-Source: ABdhPJznKbjgyo1njI3dpLPVOtfX4/pxLrBnPFv2mnuwBpQRb18CgJ0dvLbV4zB0n0cII4zc9X7JEw==
X-Received: by 2002:ac8:5f50:0:b0:305:c06:362c with SMTP id y16-20020ac85f50000000b003050c06362cmr6534601qta.150.1655250406321;
        Tue, 14 Jun 2022 16:46:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006a6f57fe2e1sm10813244qkp.98.2022.06.14.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:46:45 -0700 (PDT)
Date:   Tue, 14 Jun 2022 19:46:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: Git Test Coverage Report for v2.37.0-rc0
Message-ID: <Yqkd5GNYAKBnPQxz@nand.local>
References: <00a57a1d-0566-8f54-26b2-0f3558bde88d@github.com>
 <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d1c6dfd-1df6-3393-df5e-692719375772@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 04:20:05PM -0400, Derrick Stolee wrote:
> > Taylor Blau	f9825d1c builtin/repack.c: support generating a cruft pack
> > builtin/repack.c
> > f9825d1c 680) strvec_pushf(&cmd.args, "--cruft-expiration=%s",
>
> The --cruft-expiration option is not tested.

Note that only the `--cruft-expiration` option of `git repack` is
untested. This code is just passing down the expiration from `repack`'s
perspective down to pack-objects, which has extensive coverage of the
`--cruft-expiration` option in t5329.

It does feel a little weird to leave this uncovered, but I don't think
it's substantially different from the uncovered lines in setting up
`cruft_po_args` on lines 86-90 of the repack code.

> > f9825d1c 708) fprintf(in, "%s.pack\n", item->string);
>
> This is related to the existence of .keep packs. A corner case, but maybe
> worth exploring.

Probably worth testing. We're ensuring that `.keep` packs in addition to
`--keep-pack`s are excluded from the cruft pack. That isn't tested and
probably should be.
>
> > pack-write.c
> > 5dfaf49a 330) unlink(mtimes_name);
> > 5dfaf49a 331) fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
>
> This appears to be an interesting case for the write_mtimes_file() method,
> since its first parameter is 'mtimes_name' and all tested cases are
> passing NULL, it seems.

Ugh, yes :-). That's imitating a common pattern in the write_xyz_file()
for xyz referring to auxiliary pack data. The cleanup should be pretty
straightforward, I'll send a patch or two shortly...

Thanks,
Taylor
