Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E73C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF53206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLTSeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:34:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54008 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSeu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:34:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so9901600wmc.3
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jw7hQ1AEhQGkxczr49zfYavZP/d0oPSVn8orYM3HY5c=;
        b=OeIvC8XHTkwJMIzOMcUT6rAeZT/RPTvVbVBnnmDHPhYwhi5hggfsALXtJKTBBd0OmP
         Nv4K58rBTEmlgutQqMJoTC9Tgl2E3VPDn5YJhaxuuxk9pxy/u4G9lRO/9FS4hS2IP6wz
         jSsM4Rx7CQN8JSaV13boJ22fVft5DRtRDCldKBg8vo8Ro1vg9ZdF5lkogMrOBkiGgDOp
         QSqagVt+VyYFZl2GgX/3pkuq6LDkx8TNT4XGkd57d2m7FgoCKFB9G2AIZ9t3/+1HS6AT
         5HKrcRNg/o/R//FVo42L4Tga4xfNoXVgGnhdSsHhw0Ads5oHU2WWKKsvlzgIfSGM04qn
         pgtg==
X-Gm-Message-State: APjAAAVmp0BAA4IfRwhWPezL4Q+xPZYvO6oXYrqdDCgaX9NkGN5CiViG
        ZCrIzl5+BLcBhuTCPARvu/+iF+bq3OOBNvjegDw=
X-Google-Smtp-Source: APXvYqzLYswXvQsIDGVJhwQERWqcP4IZUj+OCvtQspvgSc7Qwbt707CDZkVx9B8HLIZHUp4GK994NGZhr0v/pretnog=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr17521157wma.84.1576866888143;
 Fri, 20 Dec 2019 10:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191220153814.54899-1-emaste@FreeBSD.org>
 <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com> <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftheamea.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Dec 2019 13:34:36 -0500
Message-ID: <CAPig+cQ29dEbQgnJmGvODy9kGYq9TqKaJV5-mOPXbGFZ1HRWmw@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ed Maste <emaste@freebsd.org>,
        git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 1:21 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > anomalous behavior is still present. It would be helpful, therefore,
> > to mention such an implementation by name:
> >
> >     ...some 'ls' implementations, such as on FreeBSD, include...
> >
> If we _were_ to add an in-code comment, we may want to say something
> like
>
>         # Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
>         # enables "-A" when run by root without being told, and ends
>         # up including ".git" etc. in its output.
>
> to warn future developers against improving and/or cleaning up.

I would find this comment more helpful than the existing one since it
spells out the issue precisely. A minor tweak:

    # Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
    # enables "-A" by default when run by root, and ends up
    # including ".git" etc. in its output.

> Not that we encourage running our tests as root, though.  I am
> slightly worried that the above phrasing might be taken as such.

I'm not sure we really need to spell it out, but something like this
might allay that concern:

    # Do not replace this with "cd "$1" && ls", as FreeBSD "ls"
    # enables "-A" by default when run by root, and ends up
    # including ".git" etc. in its output. (Note, though, that
    # running the test suite as root is generally not
    # recommended.)
