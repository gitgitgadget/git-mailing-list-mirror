Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C82C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF6206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725320AbgEEEAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 00:00:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44794 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEAV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 00:00:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so736976wrm.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 21:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=admErnufjK33NAG/UgFg/dodqPVbBaC6T/fqEHNIIno=;
        b=kbsAxmnnytFB9SVskmrtjPJZA418t6er3UWpYWfxU0vMG8rDc/uKnEIuUlftZuXW6Y
         WHAxKLnySX+83b5mNVuwW3UjdP0+ub91IdD7C+X6sqI3JhLDtUS5QPIfkhiRleJe5A3N
         rTNkHIli/G+psOEXqvP7J9JqwbFpbriZIvMZMJFm30Ej+TFIMhzmmRJlHCzND7WsE8zU
         91vqLI59irm220qEck6HWgVaLFWMl2WYLQZz0fNeqEgf+5rxJe7xcaHEUvfA95jZ5iYM
         oajCDFobCCTRdxOTbuLhxqGHCYjeZ6dvr+iYElzMRS2pQjgDvCrl86l2PygRbZgv9awu
         AEew==
X-Gm-Message-State: AGi0PubHTSkm27P61IhraquprQ6Ho5vuwWXZbPLy/ZMju79+eckEUGBQ
        Dcj0TSTi3g1iTDNY81ptjutMRF5sZQp7avRG76I=
X-Google-Smtp-Source: APiQypJ0mc6QgmmLKvrASZIDi2sZQaQTcyjFmM3OZV1DViFOMl0+y0zcdFJVgUd5ThTMNKqn0jLDCDMfCIGgpmDM9fU=
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr1299384wrw.277.1588651219358;
 Mon, 04 May 2020 21:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200501082746.23943-1-sunshine@sunshineco.com>
 <20200501082746.23943-3-sunshine@sunshineco.com> <20200501221951.GD41612@syl.local>
In-Reply-To: <20200501221951.GD41612@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 May 2020 00:00:08 -0400
Message-ID: <CAPig+cTAab6E4TPLL5AA75Ss9hQxCo2ZKLQaDakO=gGPvse+cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] restore: default to HEAD when combining --worktree
 and --staged
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?SGFycmkgTWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 1, 2020 at 6:20 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Fri, May 01, 2020 at 04:27:46AM -0400, Eric Sunshine wrote:
> > The default restore source for --worktree is the index, and the default
> > source for --staged is HEAD. However, when combining --worktree and
>
> I think that you could very reasonably drop the first sentence here,
> especially because it is repeated verbatim from the previous commit.

The repetition is intentional so that each commit can be understood
stand-alone (without having to know what came before it).

> In fact... this whole paragraph looks similar to me. Maybe just:
>
>  When invoking 'git restore' with both '--worktree' and '--staged', it
>  is required that the ambiguity of which source to restore from be
>  resolved by also passing '--source'.

I'll see if I can trim it down a bit -- Junio also found it too long.

> > -By default, the restore sources for working tree and the index are the
> > -index and `HEAD` respectively. `--source` could be used to specify a
> > -commit as the restore source; it is required when combining `--staged`
> > -and `--worktree`.
> > +By default, the restore source for `--worktree` is the index, and the
> > +restore source for `--staged` is `HEAD`. When combining `--worktree` and
> > +`--staged`, the restore source is `HEAD`. `--source` can be used to specify
>
> This is extremely nit-pick-y, but is this line a little over-long? My
> memory is that Documentation should be wrapped at 72 characters instead
> of 80. I culd be totally wrong.

Column 72 for commit messages, certainly, but I don't think there is
any such guideline about documentation also being wrapped at 72. As an
old-schooler who still uses 80-column terminal and editor windows, I'm
quite sensitive to line length -- these lines are wrapped at 79.
