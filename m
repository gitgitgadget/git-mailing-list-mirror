Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7020AC47256
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8A8206B8
	for <git@archiver.kernel.org>; Tue,  5 May 2020 04:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E0zoYapB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgEEEoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 00:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgEEEox (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 00:44:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D89BC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 21:44:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so319687pfc.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 21:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RZlxAYQ7C6mQfft/2DQRnBgXel+OYAsJvH6/VFaDpAc=;
        b=E0zoYapBFcFRdkRm/8GEqu7lnBUxg/Y26a6MVpUODGxCEdBB+kXLxZ6MFbLfO+cQD3
         Hn2p7M0+y+pbFNzP870tx1NRUGqaEEu4ZYNOqEw6TrH1tGmHHOiXa0tIjG8SOUps8eIH
         d0IE5UYfwKV4YrfFypNE/LWgyJ47iHg1gsFxK2GCD1Ieh8Za/hk1xNWUYAKUVLTHx1EZ
         8mUQOtYBvAfHZbC/pMIqn2lnBUnHkGaL0U6Fqs3PyyofRvAOHVFogqLilxfLoYWjSc1t
         IxxxWTDm1vWjr9JFAgmvP0ULULBxlVJIrZGnfu5tK+5jY6Hotiq4/TNbI2UFpcqXA2XL
         80Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RZlxAYQ7C6mQfft/2DQRnBgXel+OYAsJvH6/VFaDpAc=;
        b=B956D4W4LaGhkEEHykYxlnI/3PQLdplmEpOmA6zJC4D1Z5pa9Ox2UiTCUcWM97zGPy
         8XsyABtY3XHcvM2Q5FtbHtULuRjHlvzSKUtO/lWZ1hH/2i9UX76yNUoidW505NM9BEVK
         bPuc1g9oNOKtEeFsCZqxsx7lSnP0EYwyEgl2440w53i/B4zpnjqvLV/kznMNGe1vVyiL
         IyRWUsl2cPsEATjhgoC3FU855QUl5Sx1zfOMfCpOweqalzB9hYdY7McTTOiZXgxMorII
         5nO7Ah41Gi/wj1J1TmY1qTXK6Wyftfjid43A7OrJGcRsags2wvaI8IoQRblA1DoBM7uA
         pdZA==
X-Gm-Message-State: AGi0PubCBdTKfKZZ2J9L6kpe+oZDg9m797eIPa/y3xApFpn35L2IeOST
        Ks8ck9vkQJu9oR/eXoZmzrJBKQQlPbIH9A==
X-Google-Smtp-Source: APiQypJ5qn/g+XnFcYJHqFv73zKQlbqUD4BhOb6QzoxBoWz0CwxoSn1pOJmWGmNZgyEKZzyDT/y2Kg==
X-Received: by 2002:a63:6747:: with SMTP id b68mr1485215pgc.142.1588653891728;
        Mon, 04 May 2020 21:44:51 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m7sm721783pfb.48.2020.05.04.21.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 21:44:50 -0700 (PDT)
Date:   Mon, 4 May 2020 22:44:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Harri =?utf-8?B?TWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] restore: default to HEAD when combining --worktree
 and --staged
Message-ID: <20200505044449.GA67132@syl.local>
References: <20200501082746.23943-1-sunshine@sunshineco.com>
 <20200501082746.23943-3-sunshine@sunshineco.com>
 <20200501221951.GD41612@syl.local>
 <CAPig+cTAab6E4TPLL5AA75Ss9hQxCo2ZKLQaDakO=gGPvse+cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTAab6E4TPLL5AA75Ss9hQxCo2ZKLQaDakO=gGPvse+cQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 12:00:08AM -0400, Eric Sunshine wrote:
> On Fri, May 1, 2020 at 6:20 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Fri, May 01, 2020 at 04:27:46AM -0400, Eric Sunshine wrote:
> > > The default restore source for --worktree is the index, and the default
> > > source for --staged is HEAD. However, when combining --worktree and
> >
> > I think that you could very reasonably drop the first sentence here,
> > especially because it is repeated verbatim from the previous commit.
>
> The repetition is intentional so that each commit can be understood
> stand-alone (without having to know what came before it).

Fair enough; I figure that the commits will probably be read most often
in conjunction with one another, but a little bit of extra commentary
doesn't hurt, either.

> > In fact... this whole paragraph looks similar to me. Maybe just:
> >
> >  When invoking 'git restore' with both '--worktree' and '--staged', it
> >  is required that the ambiguity of which source to restore from be
> >  resolved by also passing '--source'.
>
> I'll see if I can trim it down a bit -- Junio also found it too long.

Thanks. I'm happy to read whatever you have once you're ready.

> > > -By default, the restore sources for working tree and the index are the
> > > -index and `HEAD` respectively. `--source` could be used to specify a
> > > -commit as the restore source; it is required when combining `--staged`
> > > -and `--worktree`.
> > > +By default, the restore source for `--worktree` is the index, and the
> > > +restore source for `--staged` is `HEAD`. When combining `--worktree` and
> > > +`--staged`, the restore source is `HEAD`. `--source` can be used to specify
> >
> > This is extremely nit-pick-y, but is this line a little over-long? My
> > memory is that Documentation should be wrapped at 72 characters instead
> > of 80. I culd be totally wrong.
>
> Column 72 for commit messages, certainly, but I don't think there is
> any such guideline about documentation also being wrapped at 72. As an
> old-schooler who still uses 80-column terminal and editor windows, I'm
> quite sensitive to line length -- these lines are wrapped at 79.

Hmm... I've always wrapped changes in the Documentation tree at 72
characters, but I could very easily be in the wrong there ;). I tried to
find something in Documentation about wrapping at 72 characters, but I
failed. So, please disregard my original suggestion, and sorry for the
trouble there.


Thanks,
Taylor
