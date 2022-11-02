Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD4C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiKBR0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKBR0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 13:26:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14224BF2
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 10:26:02 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n191so15569947iod.13
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 10:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6HGmABgbrvSUrTkKQFTQ5fRTE0KlHyvIqPPh+4C/go=;
        b=rfXhBYbhaDxZSqMkuhot1VFAmlU8pDOf/avbls+ZwASRGooK8nlFfTiK88/TUVGsq0
         KrHpncowD7dXReh2GIJ9thPNIv91D53ewiT+KBFOJQvqqJzmN/Tio9b2NtPiMe5C2FRn
         R2mukhwydCjWyGf+12zwmXraurDfEy1UXIDEqGM8t4yGpz58/zOt6dfCx371vc55iDzF
         KnTaiyEXTGCDI2G01ahgqv2O6dJn3ktInN5B1sP4zb/wchGrVuLGcurFQ6HDvPoNw5F0
         8pITKehNyOWp1iJ12Pbz2sgdgHyQHmsm7nwjc/gOFSLGFMMD+28i6DIdjnf2MAQG/Jwi
         5Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6HGmABgbrvSUrTkKQFTQ5fRTE0KlHyvIqPPh+4C/go=;
        b=h8jIFOeQBMgxubg/BISqO9huQtuNUlujv5me4l9VVHhZVLRkS6SOUKB2ZAGb3sZy4e
         kVEDDnL71/wExvMJVBtydwbjE5QPo91iT+CaSvXIqAd3LXLZEAI1WMJoyFhOet7Y+vhP
         1FRjDtFnXyBNhE6VI1nqCyY3eNXpwDFzOXJ00UNlct7xACbhvO3/UihKnrrQ6Ko++Ob0
         7OkoYB1om+DltZ9iMc9pOTz/utTwFAbgodEmjBJogUviY45EmUFHQm/CorwhAY4O/4nm
         mXyCP0cPei1u5Oadoq2kYBmtG5SGS3pil0wL1DDhOQP6JOl3HvZcE2pkR74fAvgHaPp7
         Qsgg==
X-Gm-Message-State: ACrzQf1OrBC+QLaHyw4qq+hd136LDKLSZ25Piuyiq6XqS1qrgrzNKMPh
        Oyv2j2cX3hRMiawwGu2sKRqrPm/0a+S7drNT
X-Google-Smtp-Source: AMsMyM48HkQKcs4GURN4GIeLVflXJOakCH/BFXFoI4jxW3pOVIMZkE7g/mYyCqtT25MHJPzk4KHN1g==
X-Received: by 2002:a05:6602:2d42:b0:6d2:e10:ecec with SMTP id d2-20020a0566022d4200b006d20e10ececmr11387272iow.117.1667409962103;
        Wed, 02 Nov 2022 10:26:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q23-20020a02a997000000b00375664a365esm537917jam.1.2022.11.02.10.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:26:01 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:26:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
Message-ID: <Y2KoKO5Sj71Nfa61@nand.local>
References: <Y19dnb2M+yObnftj@nand.local>
 <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 06:22:17PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Oct 31 2022, Taylor Blau wrote:
>
> > What's cooking in git.git (Oct 2022, #09; Mon, 31)
> > --------------------------------------------------
> >
> > * js/bisect-in-c (2022-08-30) 17 commits
> >  . bisect: no longer try to clean up left-over `.git/head-name` files
> >  . bisect: remove Cogito-related code
> >  . Turn `git bisect` into a full built-in
> >  . bisect: move even the command-line parsing to `bisect--helper`
> >  . bisect--helper: make `state` optional
> >  . bisect--helper: calling `bisect_state()` without an argument is a bug
> >  . bisect: avoid double-quoting when printing the failed command
> >  . bisect run: fix the error message
> >  . bisect: verify that a bogus option won't try to start a bisection
> >  . bisect--helper: migrate to OPT_SUBCOMMAND()
> >  . bisect--helper: make the order consistently `argc, argv`
> >  . bisect--helper: make `terms` an explicit singleton
> >  . bisect--helper: simplify exit code computation
> >  . bisect--helper: really retire `--bisect-autostart`
> >  . bisect--helper: really retire --bisect-next-check
> >  . bisect--helper: retire the --no-log option
> >  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
> >
> >  Final bits of "git bisect.sh" have been rewritten in C.
> >
> >  Needs review.
> >  cf. <xmqqv8pr8903.fsf@gitster.g>
> >  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
>
> I see this has been ejected out of "seen", presumably due to the
> outstanding conflicts.

If I recall correctly, I ejected this one due to its age and lack of
attention. If you want to reroll it or if Johannes wants to take a look,
I'd be appreciative.

Thanks,
Taylor
