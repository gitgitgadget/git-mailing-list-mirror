Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF1C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC7A20714
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 08:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGHVouOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgFNIDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNIDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 04:03:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C3C03E969
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:02:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c14so12918087qka.11
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/ar2y65Vy2T+5ueMLrp+FNavhX7pbcUWM5/RxnhmLQ=;
        b=OGHVouOXfYtIERp4D3DIMNVR7SGN7b7LPW3cmKfHR1fyeKG6E4DujUPxwV/WkaabJx
         HGJd8SUd4MJvm/Bw+LERmd6IzScDR7tjocb8bBa7gaO1i2ah4xAlQSvesrp2pVZw7zRC
         T1LNJ2MBViyMsw8H2TBwEKgkAU8UNwathD52B3a7C5voe3BnLyJtreH6gJc/wcqEQ1uf
         g2pGFXrJ9aFwGXq5Mi7Q/P9c9ete/uXiNG1hnmqt+nEHUsdTR0/4O/C2SPNzKWRxQ/Zp
         JWLEAHVQ0Q6rWTF2QmOvz++dB/G2lC/UDzzll5hGBuGEcTwag3N4b5kapM5W4myEr2vI
         Shgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/ar2y65Vy2T+5ueMLrp+FNavhX7pbcUWM5/RxnhmLQ=;
        b=SDev95moZGPE63GBggjbiTaEPFOVSRPl3P8jjNgvXJDYz/0ES3wJEvQkCOAVraczqr
         Bdzg2J/yW0W+/fVlPeOely5Ayh3ZNSzblaB+dboQNhcOiMv8W2vB6mWVpAlEWwE9HoWb
         NY1xdZ8LMFaO9KOu+gVZx7FOUFT0VQkRsenFZOuMgr1ILmDOC0aMVEpG6GtGKhmFvB84
         TVkkKInf2Q1ROIJM0NCojINWCvA+eq3rCyLTkH94B/G7RVcAHK5ntU58erdxHx4sGRL6
         Hs4o9eNlzC1TNdIw/aIIk7UEB3gteHuzk/qshHoNJyIw0nMHNIJao/5TdlVoD3zxbwUQ
         45DQ==
X-Gm-Message-State: AOAM532pG/3jFUCAP30OBXrbzu2TbNoIpt6SinYNG9sq53wdGJvzSlLB
        IHw5IX29MPzgzkU6yR1BDY9YvGIuwMk=
X-Google-Smtp-Source: ABdhPJxxzyXYh0DUFsWWKoNxuEi1PCbDnWEf3aTRvBv2Ws8N/wo+j8F6PePwhJjoXi/AkBmdcUHqVw==
X-Received: by 2002:a37:bfc1:: with SMTP id p184mr10222760qkf.207.1592121776571;
        Sun, 14 Jun 2020 01:02:56 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id k26sm9665447qtk.55.2020.06.14.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 01:02:56 -0700 (PDT)
Date:   Sun, 14 Jun 2020 04:02:54 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: teach --worktree
Message-ID: <20200614080254.GA1202945@generichostname>
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
 <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
 <20200614074439.GA617439@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614074439.GA617439@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 03:44:39AM -0400, Denton Liu wrote:
> Hi Eric,
> 
> On Sat, Jun 13, 2020 at 10:51:47PM -0400, Eric Sunshine wrote:
> > On Sat, Jun 13, 2020 at 10:25 AM Denton Liu <liu.denton@gmail.com> wrote:
> > > [...]
> > > Teach `git checkout --worktree`, allowing users to checkout files
> > > directly into the worktree without affecting the index.
> > >
> > > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > > ---
> > > diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> > > @@ -264,6 +266,12 @@ When switching branches with `--merge`, staged changes may be lost.
> > > +-W::
> > > +--worktree::
> > > +       When writing contents, only modify files in the worktree. Do not
> > > +       modify the index. This option is essentially a no-op when used
> > > +       without a `<tree-ish>`.
> > 
> > Why a no-op rather than actually diagnosing that --worktree makes no
> > sense in that case and erroring out?
> 
> I decided on this behaviour because I assumed that an empty
> `git checkout` has `git restore` behaviour but I guess I was mistaken.
> I'll change it to error out.

...Disregard the above. I misread your comments.

I thought about it some more and I think that the real bug is in how I
phrased it in the documentation. I meant that --worktree itself was
essentially no-op, not the whole checkout operation.

I think that it makes sense to allow this behaviour. The documentation
states that we only modify files in the worktree. So if we do
`git checkout --worktree <path>`, we should overwrite the worktree with the
index. This should be exactly the same as running `git checkout <path>`.

However, one additonal behaviour I should implement is running
`git checkout --worktree` should behave like running `git checkout .`.
So this would make --worktree not a no-op without a tree-ish.
