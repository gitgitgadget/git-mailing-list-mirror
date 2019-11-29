Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB3C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048B21721
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=loskot-net.20150623.gappssmtp.com header.i=@loskot-net.20150623.gappssmtp.com header.b="NoaGeZNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfK2IFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:05:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46754 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2IFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 03:05:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so2310473edi.13
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 00:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MR3U4EBtTE4fPEj8HBbt0QVnOf569e9HEuMpVnOdPoc=;
        b=NoaGeZNOlFvyJU3T5GZ8ezxf9WNUB04+FetwNNSCwlWWJai2vMs99Ma4AYn+GMrNM2
         UYkrJFs5lhuF4RqRmUPhJ0HG4k08/uSg0+zFT855HJUhe88Qa3oLPNesg6isn6K/pnTt
         dDIONW3y2qcv8iM2NFi73/lsAc7zlCYej9YxsBM85vMQ7n2UXJtyhPGu7zCJPQObbgbX
         sDhZXDF//wfs0SE9WknntfZq2y1wtGJOBXWkNvL5HzJAQnxdKQ2WWq31j538JiBn1bMD
         a5K8oW3Jt7J9m1EB/bz8Vz31vBYqkYH7lQUb+lzZ3VQu8e41XUEmUtdApuykx3HubIf9
         xv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MR3U4EBtTE4fPEj8HBbt0QVnOf569e9HEuMpVnOdPoc=;
        b=hgJwPbWUIO3+fsmNQjqz4ADmr6mP0Hx2K1Sg4/Y5b6gAJlR3ckCOgwkmfQpunqCwTe
         zh/yjg+5pV6+P7UI4E7iuJnXaNwmKfNbmwXq58eGCPALGz3q8pYQZyk9g6ObkLCRc2Kt
         vCrO1TJu5CZTsKl8VBAZJXu4Fegg33Kl+FomCQCGCg2sbbWkT5ZjwIKikNDkxIWWDMSp
         LLzVUCT5fSYXIRsD/7RW5MK+d6A94iTq742R/rujILwXIKsuVOCgc4eWzNSQCqYHm2hq
         9b2D96gLjaN+QumHY4u27XYfBI4JbE95D3255Nm96tVWtjjG6lQgPsklaKTzZJHwxKH4
         1BIA==
X-Gm-Message-State: APjAAAWn/rj3In91rjhQy7jR/oRRXnEDXh2cCaSUM6BJBw3zh8DD0nvG
        FnM9XsNWpSmHRkoyqvF2DcFvVH9hSO7AUxoZKpnkUEainc3CzQ==
X-Google-Smtp-Source: APXvYqxJyhvVnYUsmBO8jVscGu/cUpY95G1tw20oxz0DBI47wzIzxngzP26NDcVc0Z9Slsf7luutBp55OzTbQaZjw1A=
X-Received: by 2002:a17:906:9153:: with SMTP id y19mr11561921ejw.274.1575014730101;
 Fri, 29 Nov 2019 00:05:30 -0800 (PST)
MIME-Version: 1.0
References: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
 <20191113051530.GA3547@sigill.intra.peff.net> <xmqq8sokb673.fsf@gitster-ct.c.googlers.com>
 <CABUeae9m+r-p-aaix_NFTFB1cAomFHgC8mckRHPiiRt1qRwv_w@mail.gmail.com>
In-Reply-To: <CABUeae9m+r-p-aaix_NFTFB1cAomFHgC8mckRHPiiRt1qRwv_w@mail.gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Fri, 29 Nov 2019 09:06:13 +0100
Message-ID: <CABUeae9jBpvkxPGZPC=vFsuxB2r63W457LqWvXynF4Jnbm4HXg@mail.gmail.com>
Subject: Re: Merge commit says refs/heads/<branchname> instead of <branchname>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Nov 2019 at 22:54, Mateusz Loskot <mateusz@loskot.net> wrote:
> On Wed, 13 Nov 2019 at 08:12, Junio C Hamano <gitster@pobox.com> wrote:
> > Jeff King <peff@peff.net> writes:
> >
> > > If I do:
> > >
> > >   git reset --hard tip && git merge --no-edit refs/heads/side
> > >   git log -1 --oneline
> > >
> > > then I get:
> > >
> > >   Merge branch 'refs/heads/side'
> > >
> > > And the behavior seems the same going back to older versions of Git. Are
> > > you sure your workflow hasn't changed somehow?
> > >
> > > Can you show an example that triggers the behavior for you?
> >
> > Yes, I am curious, too.
>
> Jeff, Junio,
>
> Thank you very much for your responses and confirmations
> of expected behaviours.
>
> I will try to confirm with my colleagues what's changed,
> what are actual commands and Git versions in use.
> I'll be back here if I discover anything suspicious.

Apparently, the workflow involved Git client Fork and one of recent
updates of the client introduced the change in the behaviour:

I reported the issue
https://github.com/ForkIssues/TrackerWin/issues/570
and the bug has been confirmed
"we replaced git merge branch with git merge /refs/heads/branch"

Jeff, Junio, thanks for help.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
