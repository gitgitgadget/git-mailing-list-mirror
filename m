Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D8DC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A92C20735
	for <git@archiver.kernel.org>; Mon,  4 May 2020 22:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="nRyTdg/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEDWJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726419AbgEDWJT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 18:09:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF2C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 15:09:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id a4so121737pgc.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xef6t8FoFbjUQwAL5IFjXBngUL/Ye7SkvQocSPeyfUU=;
        b=nRyTdg/fiR0zKeP8EHkLfjAlwY26HBV5kQ6JYSGw2/Ygf8XJN6wWVvQf7oD7UPfhIw
         2qCOlWBxndCGzD9GcglSq0I3QVWcp/0IGSh0oYGKgtoRnMosbkMznsttN+NU+VYd6IYV
         a+s0KNNOYzNhtLM1G92MCBi4cx9+8iFMxceBJMegmvh7CIwVYKoMW2odFD9mG8XVxHXJ
         DSnpiF6hY/lJVd0QmPrUjkYI3OH7rNeupLsCSGmIot6nZ/62ic32WSfl2v4IP1k1CyKl
         JFppWpRkYIdYEmih/+znKYd2IIhfjN9mYf3kO/eXPoLN9Jy4R6Oih2ierf0RgMHM0weU
         yYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xef6t8FoFbjUQwAL5IFjXBngUL/Ye7SkvQocSPeyfUU=;
        b=YGbRy5YN//poo4dAyVxk7mYqWRJeo5xd3hbdX4PTdDt+36axhwMjDUcRmjuAi7yZdr
         7NIlwD0Nn5mjZh1gidEpf4PYFoZuhj7grs+toUaQMrkNDLS6nFHIKx3CEhI9BrthQFXr
         Oa1u//43+3veJdBLGycHDWMFcHXlyoFJudxnBWo1ykHobKRIEMXCzWGutK4hmMuTXPxu
         kpeTXRUv9xmcq1PtX3hhBqhJncqH4OUK4UkUWih1psy+qBYN5eDnODngifOV8dvrbr/3
         TbUBh9YTovY03SxZJvWh3nsLZP5z/mHZ+lbyNvV9KDAXGutdYUzfw5GokCl0bNiMn2Of
         iWxw==
X-Gm-Message-State: AGi0PuYZDUU8E/dd+hVdNZKpqx9aA/fFNNO7TWS+pYrNg7A5MSZ6Sy/E
        H96fpXrsWE3BhstRjpGKPwd2fg==
X-Google-Smtp-Source: APiQypIcPgyhiuIzqjrJgQbEjj6XouwNKb8rIkRnEYgyHt1zTcZ5lE3Yra8GExBgCIdjxaWh7aj3tA==
X-Received: by 2002:a62:3181:: with SMTP id x123mr25394pfx.109.1588630158496;
        Mon, 04 May 2020 15:09:18 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a15sm34152pju.3.2020.05.04.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 15:09:17 -0700 (PDT)
Date:   Mon, 4 May 2020 16:09:16 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
Message-ID: <20200504220916.GF45250@syl.local>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
 <20200504213326.GA31037@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200504213326.GA31037@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 05:33:26PM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 08:40:04PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
> > When rearranging the todo list so that the fixups/squashes are reordered
> > just after the commits they intend to fix up, we use two arrays to
> > maintain that list: `next` and `tail`.
> >
> > The idea is that `next[i]`, if set to a non-negative value, contains the
> > index of the item that should be rearranged just after the `i`th item.
> >
> > To avoid having to walk the entire `next` chain when appending another
> > fixup/squash, we also store the end of the `next` chain in `last[i]`.
>
> s/last/tail/, I think? (and below)
>
> > The good news is that it is easy to fix this: we can detect the
> > situation by looking at `last[i2]` (which will be `-1` if `i2` is
> > actually in the middle of a fixup chain), and in that case we simply
> > need to squeeze the current item into the middle of the `next` chain,
> > without touching `last` (i.e. leaving the end index of the fixup chain
> > alone).
>
> OK, good. I definitely had figured out how to detect the case, but
> wasn't quite sure how to manipulate next.
>
> But your fix here makes sense:
>
> >  			if (next[i2] < 0)
> >  				next[i2] = i;
> > -			else
> > +			else if (tail[i2] >= 0)
> >  				next[tail[i2]] = i;
> > +			else {
> > +				/*
> > +				 * i2 refers to a fixup commit in the middle of
> > +				 * a fixup chain
> > +				 */
> > +				next[i] = next[i2];
> > +				next[i2] = i;
> > +				continue;
> > +			}
>
> I do have one question, though. What happens if we add a second
> fixup-of-a-fixup?

Thanks for asking this question, I was a little curious about it, too.

> We'd see its "next" slot filled, but now pointing to the first
> fixup-of-a-fixup. And we'd add ourselves at the front of that list. So I
> think:
>
>   1234 foo
>   5678 !fixup foo
>   abcd !fixup 5678
>   dbaf !fixup 5678
>
> would end up reordering abcd and dbaf (putting dbaf first), wouldn't it?
>
> But when I tested it doesn't seem to:
>
>   git init
>   git commit -m base --allow-empty
>   git commit --squash HEAD -m 'this is the first squash' --allow-empty
>   s=$(git rev-parse HEAD)
>   git commit -m "squash! $s" -m 'this is the second squash' --allow-empty
>   git commit -m "squash! $s" -m 'this is the third squash' --allow-empty
>   git rebase -ki --autosquash --root
>
> So I think there's something I don't quite understand about how the
> chain of "next" works. If you can enlighten me, I'd be grateful.

Ditto.

> But your patch does seem to work as advertised. It might be worth adding
> the double-squash-of-squash to the test.

Yes, I think that this is a good, worthwhile addition to the patch.
Sorry Johannes for suggesting that you do more work on an already-great
patch. No good deed goes unpunished, I guess ;).

> -Peff

Thanks,
Taylor
