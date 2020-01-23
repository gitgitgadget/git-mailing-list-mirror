Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C8C3F68F
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5672824125
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtcXqpLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWRER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:04:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38483 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWRER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 12:04:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so3313994wmc.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 09:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6U8YbujK4GUI2OqfDnEPFrDtX+uzmWaMj7YXbQt7MjM=;
        b=GtcXqpLQN6asbJGRfY6c1PAhKKDZUzHb6X6BdDp+NFJvq5wAaWx+sX649aVt4upR6A
         WWPzdEyz8IcChCZTVK3hxgmlkARv3W2wnTZDJz0V2+XGjPBF8hjeO6j7U72C8DP+4M5D
         ABwJy/uKKq6cChVIiBkLlsELATvyPJPRe+9KuTCBte1O/UDVTWT0knT1UesDu/8VjK0n
         wynncjkB69W7dUOJffLUPTeeTLR36WTClq2uv1ceR6Re6K1rnNbqqk0tp5pwAxGevrVH
         0qyx1tgbnTaSqztW9Q65y1jDlHJlmbggLf74DbisCkMiVpv/lqkQTHRHcI8cRidGPy67
         1TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6U8YbujK4GUI2OqfDnEPFrDtX+uzmWaMj7YXbQt7MjM=;
        b=Jl43av47pnxb9QkaY5vzEZvZxrKCkkNARgu6Rwu24nWX7kwqprhYZckU6fzy8YFTcx
         euABpIHwTEtkkakNKqeswteEidsNYB/FiXYpzcMCwAd6CldJWOZKaaOw1EvkVuv6461d
         QX2CwisBZ6jTk91Jt20Vz73G+9pNqVmLB2AtBUJ8cCLrS8zQZc24nzVf06kb8dXEDsX6
         frnvcKLkotm1rkkZusSjeVTc+b5dDKZ7uIWsAaUGpXkeb0Cl5Lb52UcPd8xHNKm32ukN
         ++sUz5EdSdjn7FJGOswdw476wOrqXYYHKRiloyzxU6yGU4It7UPS6L1Z3WVSB9UNQdoQ
         Dc4g==
X-Gm-Message-State: APjAAAX1v/VhWkpDdSUrswEAl6JsSbd6G6o+nUOxrSrIAqCvHX8HNe1c
        cQl6tJyVOhKAxnl4mK2b47A=
X-Google-Smtp-Source: APXvYqx6zovPFN7asu7PI6QX/YoZUOpM5ZYzRPRxfxKD7gOn31H8b6R+32QgQtQkMyzZfEqcw6QFeA==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr5368414wmg.161.1579799055602;
        Thu, 23 Jan 2020 09:04:15 -0800 (PST)
Received: from szeder.dev (x4db607d2.dyn.telefonica.de. [77.182.7.210])
        by smtp.gmail.com with ESMTPSA id i10sm3811031wru.16.2020.01.23.09.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 09:04:14 -0800 (PST)
Date:   Thu, 23 Jan 2020 18:04:12 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
Message-ID: <20200123170412.GD6837@szeder.dev>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 11:36:49AM -0500, Eric Sunshine wrote:
> [cc:+peff]
> 
> On Thu, Jan 23, 2020 at 11:32 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Thu, Jan 23, 2020 at 05:04:09PM +0100, ch wrote:
> > > I recently updated my Git installation from 2.24.1.windows.2 to
> > > 2.25.0.windows.1 and from the looks of it the included version of gitk does not
> > > support being run from non-worktree folders of a repository anymore (like the
> > > .git folder for example).
> > I've stumbled upon the same issue when I tried to run 'gitk' in a bare
> > repository a while ago, but it refused to run with the same error
> > message.
> >
> > Are you sure it's a recent regression?  I have no experience with
> > 'gitk' in Git for Windows, but on Linux this has been broken for quite
> > some time, namely since 784b7e2f25 (gitk: Fix "External diff" with
> > separate work tree, 2011-04-04) in the v1.7 era.  FWIW, reverting that
> > commit on top of v2.25.0 makes 'gitk' work again in bare repositories.
> 
> It's a new regression introduced by 2d92ab32fd (rev-parse: make
> --show-toplevel without a worktree an error, 2019-11-19), as far as I
> can tell.

Oh, that's interesting.

My local commit reverting 784b7e2f25 that I build my Git with is newer
than 2d92ab32fd, so maybe that's why I haven't recalled seeing this
issue earlier.  I did try to bisect it, but had a real hard time with
gitk being subtree merged, and ultimately gave up on that, and started
to look for a commit adding '--show-toplevel' to 'gitk', which lead me
to 784b7e2f25, I reverted it, my issue went away, which then lead me
to the wrong conclusion.

> I have many times used gitk on bare repositories as an
> interactive replacement for git-log, so this is a unfortunate bit of
> fallout from that change. That's not to say that 2d92ab32fd should be
> reverted, though... perhaps gitk itself needs a bit of a fix.

Well, I don't speak much tcl/tk, but as far as I understand the
changes of 784b7e2f25, it added a 'git rev-parse --show-toplevel'
invocation to 'gitk's main code path, but the result of that command
is only used if the user clicks on the "External diff" menuitem in the
"Patch" pane's context menu.  So perhaps the scope of that 'git
rev-parse --show-toplevel' could be limited, and executed only when
the user actually clicks on that menuitem (I've never done that
before, in fact I wasn't even aware that there is a context menu
there).

