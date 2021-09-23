Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10574C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D884560F0F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 02:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhIWCTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWCTk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 22:19:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60857C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:18:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e82so6012136iof.5
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iTROrfD6KVbO/qKzYer9U7Z28M7Gt/lZ64WAltwbZRs=;
        b=glxemuRXJ9FUAArbBOTw8f168FBSLtPs1nSFsj5jh0Kkmaa/pYn2xsJKcmYqKEcgrN
         IDKnVyCWudWJRVfISSiluBfZQFHL4SmkYAPEXeGr2VDx3EqXDS/hiJKGgmV2DRhiJt6S
         VtFSTwexQXuuMwuxB+Cqudhlf/uHNhapVZJ36tW7OZOoj/1J42Ao8W0D+iPuE520UpFw
         h7U/QCBhtqmFhtSTCQAMQfnPb6+t224+6lxnbcViiJaq1iH8PALSDzL1lajpyCZcGOol
         vcAKokfriRNzqNJy/USnnDpcIoPha2aDKPNcKZwj3egHEFUdj6ibW/rdqXzQ2xed3hGA
         RqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTROrfD6KVbO/qKzYer9U7Z28M7Gt/lZ64WAltwbZRs=;
        b=5JooJsaxlNkhnelxcixUC4cehqOI4iy9hLB49fJ/taBaCvcDXnB6ZCyR2OWvGtbdbp
         z2Cp8vNpi9G5fzG/QJZwBLmIu7wokNPIq1qbkO14sjbQYZ4IZ2B3u6NyiWdijC47KaP9
         TDOMFRBGfoJL0WW8zdrJaoWBKq7EsJzmsM8pji6iM1MhsjkG5522WwumGyvWuWh3RBiy
         Fb7lDVjN+efO23pnyjyd8HX+BeaCbVstBwmMm18e/9LyjrUtcFKolBxVTLFCF0F5QsSD
         VDIu4WswpC7oFHaXBmqN15OQijSlp70GY/OHCtpdCsY1athQMfpHgeb5fGFU1bRB6H9W
         TPOA==
X-Gm-Message-State: AOAM531P/xW1fNTxF9eYqA+8/vIxWsvQzufPnuW3HvwOppe/6+4ckFF1
        hO7EmRWZcTTvlk4ntqWqr/Dynw==
X-Google-Smtp-Source: ABdhPJyRIPHSF0c05DxeHeuDrI4DeUKCjqUoKV5DcY5caGgeP0j/pFDll+PJxPhhARgUd6i6q9mcUA==
X-Received: by 2002:a02:cd17:: with SMTP id g23mr1924572jaq.29.1632363488570;
        Wed, 22 Sep 2021 19:18:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h18sm1803780ilq.40.2021.09.22.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:18:08 -0700 (PDT)
Date:   Wed, 22 Sep 2021 22:18:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, peff@peff.net,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 3/8] midx: preliminary support for `--refs-snapshot`
Message-ID: <YUvj33QX5fvjNoiJ@nand.local>
References: <42f1ae9edeb55d8e1b0c8f2c3110e9c8326a5fc1.1631730270.git.me@ttaylorr.com>
 <20210922230012.2608849-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922230012.2608849-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 04:00:12PM -0700, Jonathan Tan wrote:
> > This approach will cause a problem when multi-pack bitmaps are able to
> > be generated from `git repack`, since the reference tips can change
> > during the repack. Even though we ignore commits that don't exist in
> > the MIDX (when doing a scan of the ref tips), it's possible that a
> > commit in the MIDX reaches something that isn't.
> >
> > This can happen when a multi-pack index contains some pack which refers
> > to loose objects (which by definition aren't included in the multi-pack
> > index).
> >
> > By taking a snapshot of the references before we start repacking, we can
> > close that race window.
>
> I can understand why we want the refs to remain the same both for the
> MIDX generation and the MIDX bitmap generation (one reason that comes to
> mind is how we select the commits for which to generate bitmaps), but I
> don't understand what referring to loose objects has to do with it. I
> think that using the same set of refs for MIDX generation and bitmap
> generation is a good enough reason to do this, and we don't need to
> mention loose objects.

The point there is that a pack which contains objects that are ancestors
of loose objects can show up at any time, including just before we
select which packs to go into a MIDX.

This is particularly common at GitHub, where all of our test-merges and
objects created via the web interface are written loose. So we could
compute a test merge, store the result loose, and have somebody push a
pack up on top of it.

If that pack shows up after the repack, but before we write a MIDX, then
without the refs-snapshot code, we would include that pack, select its
commits as candidates for bitmap selection, and then ultimately discover
that the bitmap isn't closed, since the loose object won't be included.

But that may be a little into the weeds for the patch message. Anyway,
I did have to think about it for a minute, but I'm pretty sure that's
what I was thinking when I wrote this.

Thanks,
Taylor
