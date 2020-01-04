Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E22C2D0C2
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5DE21734
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CZwor3NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADR6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 12:58:54 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39941 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgADR6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 12:58:54 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so44481000iop.7
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Jb0WGlP4Ocz9GRKEN59nKGnrhuuQSZFxcMiA5pbtXs=;
        b=CZwor3NVE1jL00eSuSLjvWW+qK8axfcgY4lM1eDmXo4Q25SsDKN1Px/2erhfkdm2Jz
         P/pm8AkN8KOHeIwsgtx91dBshcby0cy8HRyLAlxg1zw7/90p/XSNG2gVewiiVPVrsnKJ
         I72rxBglpkUYXMUpmLJ+f39OmNRVJA0AakHebqjL0torAsxWVyVU6r1x6LdN4K6GRaso
         9oFU8p4beX9qExEvCGRO0Gg4YXDe6rXAY+fbkYjpu7gFgLPxwFS96lxPHhefXKRTXz5b
         8vyJsdViSp3om5ehrtzzBhZoIj9ylRGP7OrBx4rna4zt1zQLC0ck4zDxEv00nl6mpvXS
         UU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Jb0WGlP4Ocz9GRKEN59nKGnrhuuQSZFxcMiA5pbtXs=;
        b=najr1bNIdNj3SlejUoGKtf1ps0uxfN62CYtq1fDJs+gPKPAKQXVT+VnDgMP2x39wss
         MpBFuGdUtRioB2pEUsoHqaOfeYsZgyGI9pDp4sHWrq2VEUg1LBsLffJj+Mr0RiGaw2fg
         ATg8biZSTvJC6A8fIKsBjL4x2CLmXpm+E5Xsn/x7CedhD8ZYk+7riZNH0zS+8MtvmCTZ
         qaS3Wt9Iq5esZo2PgdsgLSA63eB5C/Ar9dg6/ETiWB8sl+QEu+T5APqe236rNMhXcnnw
         v4WKtvS6V0IZBzQGDmBFBqDTMVD95g2n6SVUNz5EWcFK3PzTR6pOpekJGqeiw+B6IOOU
         Z6WQ==
X-Gm-Message-State: APjAAAWwkNplG6pQtS6fQabDNIC9ywdyK8ZtE/jO5BH5wXh1IQg8C+EX
        yk7n7nvI6dzQGecQTp+fmh0Erg==
X-Google-Smtp-Source: APXvYqxoZZoeDpmJ08RpD9VaPNjh3/2NWJGOoc/xAVcTlQKbjBbtqybAGsGRkCFK+1bp8LMGLdhRKg==
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr74998169jac.126.1578160733533;
        Sat, 04 Jan 2020 09:58:53 -0800 (PST)
Received: from localhost (75-166-236-123.hlrn.qwest.net. [75.166.236.123])
        by smtp.gmail.com with ESMTPSA id u10sm22451513ilq.1.2020.01.04.09.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 09:58:52 -0800 (PST)
Date:   Sat, 4 Jan 2020 10:58:51 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0-rc0
Message-ID: <20200104175851.GA14628@syl.local>
References: <xmqqblrwm65l.fsf@gitster-ct.c.googlers.com>
 <20200102221921.GA81596@syl.local>
 <nycvar.QRO.7.76.6.2001032036420.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2001032036420.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Jan 03, 2020 at 08:39:34PM +0100, Johannes Schindelin wrote:
> Hi Taylor,
>
> On Thu, 2 Jan 2020, Taylor Blau wrote:
>
> > On Wed, Dec 25, 2019 at 01:44:54PM -0800, Junio C Hamano wrote:
> >
> > >  * The beginning of rewriting "git add -i" in C.
> > >
> > >  [snip]
> > >
> > >  * The effort to reimplement "git add -i" in C continues.
> >
> > I noticed while preparing GitHub's blog post for 2.25 that the work to
> > rewrite "git add -i" in C was mentioned twice in the performance
> > improvements section.
> >
> > I'm not sure if this is intentional, or if this was added twice during
> > the merge(s) of and f7998d9793 (Merge branch 'js/builtin-add-i',
> > 2019-12-05) and 3beff388b2 (Merge branch 'js/builtin-add-i-cmds',
> > 2019-12-16).
>
> If you mention this feature in the blog post, please note that the
> built-in `git add -p` is not feature-complete until the
> `js/add-p-leftover-bits` branch is merged.

Yes, and thank you for reminding me. I have this in my list of 'cooking'
topics. This section is used to highlight ongoing work (e.g., NewHash
transition), but I often omit it from the posts. If other cooking topics
accumulate during the drafting, I'll make sure to include this in that
section, and note its in-progress status.

> And if you mention the built-in add -i/-p work, could I ask you to include
> a note that it is based on one of the two Outreachy projects in winter
> 2018/2019?

Of course :-).

> Thanks,
> Dscho

Thanks,
Taylor
