Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F145AC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79816044F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 22:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbhIGWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346774AbhIGWh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 18:37:26 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7466C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 15:36:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q3so597918iot.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZeEmDvmycvhSYRGijgp/PnCqrc+hitrI89ukA1d+o5c=;
        b=DOugiw08ea/m5iBPfYmYsrwcdoft93sr2fVwocupRcTFrb8r+UXqaQn5k38c8floIo
         hSD2rU+lGkOrsYL41PRLrZegiKbqJr2aJLlE3PfVW90gtUeJ9HS85MMacjPzRPNjEUlJ
         51ppC7mctaCD9w/IR92EJZy3EdG4m+S8grZX43i1j3hbDw5pDkJKOkFoffOB/KfVNDtv
         TeVnfQer/dqHCz/VB0XtGcy1F+pNp449y2HQvCNUun79dCbm2IPOfm/rC304f5N7TbSs
         RXY+e/eFCLJU9ckqe4s+qXvVRl4EOQX7Owdc8Bjs+3WDjxbqqZZ31HpCDFA59rQ7xII4
         Uxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZeEmDvmycvhSYRGijgp/PnCqrc+hitrI89ukA1d+o5c=;
        b=FZYMOoQYFx8xAGLU2BNo1P9okLSyTzy29bIjPitU/ReKiC65oDIZl2lBKNHA1wKc9T
         xtWxHTcLZMHd0pWUP7svaFZVJKtRoxEJrwjaviTioZMnL3Dc1UwlBadqKazBcCB979hj
         d5Po9zVrVKpb4phj0IP7LmnGaRsm3g6gkc1E31I4+RWtEGNEeHwykLijMaw4YDLq1ysH
         4SOV6aaLZUApTtix1kHgoVswqzdhpg52eMAyqyf/CNrR1Sv194aQ2cbXgFn3w9fXpXNH
         FWwUvhabv/73XYi7l0DUcHFHHVYV7ApN2MRasH1o0GnzHVasLmeArFHKzVNVwkpSiVh1
         ofcw==
X-Gm-Message-State: AOAM533sQOI5vXq8m4fNY93WjImUcrz+xS/ryEAJlFxsRmM8KrdrcFXw
        ojmWhcAXbNI8MfntY/2LQcvvHA==
X-Google-Smtp-Source: ABdhPJzQCg/C/iYXUffVA85xTSZpRaHc4hblpeF0Wvfin5qfY/aA8Bjv5S1G6IPSb3ibZLfA/SnWUA==
X-Received: by 2002:a05:6602:2c05:: with SMTP id w5mr448461iov.160.1631054179433;
        Tue, 07 Sep 2021 15:36:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u13sm140174iot.29.2021.09.07.15.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:36:19 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:36:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] rename *.idx file into place last (also after
 *.bitmap)
Message-ID: <YTfpYsJ0J5t+xf8v@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 09:42:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I came up with this on top of Taylor's series which fixes the order in
> which we write files associated with pack files[1]. His series fixes a
> race where we write *.idx before *.rev, but left the issue of writing
> *.bitmap after *.idx, this series fixes that. Now we'll really write
> the *.idx last.

Nice catch. And fixing this race (by moving the .bitmap into place
before the .idx) doesn't create another race, because
open_pack_bitmap_1() returns early when the call to open_pack_index()
fails.

(And furthermore, open_pack_bitmap_1() is only called on the list of
packs generated by calling prepare_pack() over each file in
objects/pack, which only adds a pack to the list if its .idx file
exists, too).

I reviewed this series and left a few notes which I
would like to see addressed/responded to before queuing, but this seems
to be generally of the right approach to me.

Thanks,
Taylor
