Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A1C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEDD2087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 16:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSKLmxNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgBDQLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:11:34 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45474 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBDQLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 11:11:34 -0500
Received: by mail-ed1-f49.google.com with SMTP id v28so20253566edw.12
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 08:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjBPpWvICH+IT3sviP5cHqew3WvQyXifJ6X5IAbe9cc=;
        b=hSKLmxNbYVTRoaQ5HjfF6eVpmk+EiBTurzmDhkBOuvqsLGodvMW8erV6Qbp907/nV9
         vdWf053oymtpzl6qmz7N6iqEDnnkd6AHXJTOCBbbIBflp/SPTub5uGDlo/7we7xQFhoP
         SNquUYLmFSzYbGwIxITo1J7Yz54SezpOLU9a70Ww9pPGzTK/YddmVb4/fsmKDrRvZt83
         gzeOHQEgx7jhB621owYWT9h4bLpfpjFvf/waQP34yHx+ybskrsL2+2pkJv4qhLJu48s6
         K2RNlXR0W3qKf+CjJpGCqGYRXB6R+B863UKeZ1HJ3OnUjedxzZWhPfSo0KNtAYsAh9/B
         j+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjBPpWvICH+IT3sviP5cHqew3WvQyXifJ6X5IAbe9cc=;
        b=WbLKIddZ9/TWYy9aQondTbuuupexbRQBEQOLUXylHm3nRLfuSfbQnzD4synTwnxBPe
         L/Xiz3dYHMWdOjF1O7AVk18uTjC6Kfl1VKnTkNbf2bYh9jtYXbwVpPxPbNi3evmkK3Gl
         4w0lqjDvVvo4ptU+agIvAb1v6FUQ9cPF/VZDyJolJ7PuC+GS7EtiFLHBi6376BzCi+vB
         DVSv7AHXfbmWBGd3EsVG1s52p++rOvr/3Z4044XnmIYtPgMJzP7LyxUvIY3iPwDLbnB/
         x3unQ5fY9nBPR6bFSV2/1QApc4Q4DnJce0/8NWYfeQ7MUsvBMAL+gzKokJq1G6NHHn00
         nEZA==
X-Gm-Message-State: APjAAAU8eTv1Pu1N292rWIY+i9H1dlmHVAIzp9J5dxz1VNqGjhYK4420
        r+nuNHYyYsaA8aSkHe3T+AcOXUV5oN+Mt1whaCotDrF2kXI=
X-Google-Smtp-Source: APXvYqx36vQtH0OSwazoUVY1HjGREIul5hpmd77pOT0XVOyR+vzWJS5QVf34rN5KTLU74JjEU8Iu4VX8ZuIRFud8HhM=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr27519626ejj.6.1580832691430;
 Tue, 04 Feb 2020 08:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net> <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
In-Reply-To: <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 4 Feb 2020 17:11:20 +0100
Message-ID: <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 12:55 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Jan 22, 2020 at 6:34 AM Jeff King <peff@peff.net> wrote:
> >
> > I notice deadlines are approaching for Git to apply for GSoC (Feb 5th)
> > and for Outreachy (Feb 18th), though we still have some time. Do mentors
> > have sufficient bandwidth for us to participate?
>
> I am willing to mentor or co-mentor someone for GSoC.
>
> (Sorry about replying only to Peff previously.)
>
> I also just added the following file, made from SoC-2019-Ideas.md:
>
> https://github.com/git/git.github.io/blob/master/General-Application-Information.md
>
> As with https://github.com/git/git.github.io/blob/master/General-Microproject-Information.md
> the idea is to not have separate documents for each year and each
> program (GSoC or Outreachy), but rather point people to the same
> document that we should update regularly.

While at it, I just applied on behalf of Git to the GSoC 2020 and I
sent invite to possible Organization Administrators. I am one of the
admins already but we need another person to accept the invite before
tomorrow as they require at least 2 admins. This is the only thing
left we need to apply.

The information I used to apply is in:
https://git.github.io/SoC-2020-Org-Application/

Thanks,
Christian.
