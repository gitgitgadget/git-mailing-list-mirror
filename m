Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4430AC3F68F
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF021734
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 16:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWQhB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 23 Jan 2020 11:37:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52249 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAWQhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 11:37:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3252990wmc.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 08:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XCVR5qFBAxAF/PfwTR3IA87qoOaMDtoxbFXybgvMLUk=;
        b=oyHAlw+LHrjZEUK2ygYChVhgSh5o7YbBA9UDMWPxpXFzSCxJXUzTBJu+6cDyiBJxcb
         OeUVSp1ggBT0ybpYVnn7GBwQxejyw8jSn5cRUQor2N1nQjfpZHUUDPgjfkgdwdlLlN4k
         ICqkQXQScaWzqxsth8w99kO1TLKhBR2eI3KLo7R4qWITPrj1o5RH9LHdx/qCt2eeTaXx
         BZPoOh5UGlY9WMpQumf8A07lyVLmc2jxarGUVauXGq04JWHv4aLztJiWfUBaX6vFRrZr
         ExDDgHRrnZcOutwJd1eM/6ciOhd0/FO6VALKCx99FKfMY/FEsaBub54B7odRv0o18FAo
         eyRg==
X-Gm-Message-State: APjAAAUfSKTvOP40OpKIV3bHMeyZSZKumejYdPY106ksCNNCCtQCXId0
        l7hp0ZS8+fnr6/R8EayWdhfIOGja9mHYZ6HxZcA=
X-Google-Smtp-Source: APXvYqy/GKdOyuo1x27XJAWIvj9S5xXbUzlVEgeE2SECGbz2ZuSD60iWHft9agsE/SAUz5tg8eOPgHR/NssOh2Fq3Cs=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr5092288wmi.107.1579797419913;
 Thu, 23 Jan 2020 08:36:59 -0800 (PST)
MIME-Version: 1.0
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de> <20200123163151.GC6837@szeder.dev>
In-Reply-To: <20200123163151.GC6837@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Jan 2020 11:36:49 -0500
Message-ID: <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
Subject: Re: [REGRESSION] gitk can't be run from non-worktree folders
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+peff]

On Thu, Jan 23, 2020 at 11:32 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Jan 23, 2020 at 05:04:09PM +0100, ch wrote:
> > I recently updated my Git installation from 2.24.1.windows.2 to
> > 2.25.0.windows.1 and from the looks of it the included version of gitk does not
> > support being run from non-worktree folders of a repository anymore (like the
> > .git folder for example).
> I've stumbled upon the same issue when I tried to run 'gitk' in a bare
> repository a while ago, but it refused to run with the same error
> message.
>
> Are you sure it's a recent regression?  I have no experience with
> 'gitk' in Git for Windows, but on Linux this has been broken for quite
> some time, namely since 784b7e2f25 (gitk: Fix "External diff" with
> separate work tree, 2011-04-04) in the v1.7 era.  FWIW, reverting that
> commit on top of v2.25.0 makes 'gitk' work again in bare repositories.

It's a new regression introduced by 2d92ab32fd (rev-parse: make
--show-toplevel without a worktree an error, 2019-11-19), as far as I
can tell. I have many times used gitk on bare repositories as an
interactive replacement for git-log, so this is a unfortunate bit of
fallout from that change. That's not to say that 2d92ab32fd should be
reverted, though... perhaps gitk itself needs a bit of a fix.
