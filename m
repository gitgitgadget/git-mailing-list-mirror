Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2492C207EC
	for <e@80x24.org>; Sun,  2 Oct 2016 09:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbcJBJVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 05:21:03 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37259 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbcJBJVC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 05:21:02 -0400
Received: by mail-wm0-f49.google.com with SMTP id b201so27464066wmb.0
        for <git@vger.kernel.org>; Sun, 02 Oct 2016 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7zSTYb67/N4nqrZwVJDCE06Zi7RnHCD2bNlU6i/ycao=;
        b=R/LCmeRit6X3Ce3jw1BjcvUPf1nWl7nIO3d9qlkQg4AMKRKDwuhCfqNAE77+Bhy2RT
         jlPoP8Ew9RNjb3+Pqu8ZaXliOCHzOciY3rzYAfpVkbFmKWm6O06BYygLPxYz1u+6fFEW
         RygCm/InlVii3CexpEl6tY9x4noCcd4skg4ZetC3/zM3IAQvuHvh7cWuqFZeLQ8+WTyR
         pa/i6ko5f0DFyMxRygbE1wWromTNTVPNj4rcsStP7nuVE5jie+PuTz7MHpbIYbbbSwcC
         1/Zt1B3MtpU/KvC9Q61Exd/0SzMdeVqcEOj2DZWVwOLbIh9u7gStXjdZ18d5kg5dNA1H
         I9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7zSTYb67/N4nqrZwVJDCE06Zi7RnHCD2bNlU6i/ycao=;
        b=avcaS+ew5fIFVK8MTrCsL5P4pXeCix9MZACNxy4rQIH9+FfoNy3RBv4eVdOA7c+vi3
         w1vzZ5ckZpAaMedtjpTEjL/rcXl1gCB80Aq56+zGLifvor7neO7P6XNTTsgGiV5/IFiZ
         Yq+hsH8i7lfE43MwlCBDwoVU1uFppNtwtcNTc4URyfw6C7OH3VDazU+piX2D6pz4peUY
         tATsJTSWfZxX7ZQHaUhShkOzijuds90aHK5inWLOPocSXe5gBD+4XJ0I3MyfQuECPXim
         pgjQHDa3RxJlt+JucG4Rdwvj9rzFU0+f9iOZA31QKSpbzCC2vPvaTERKfKtSJ/RfRvyh
         NPyA==
X-Gm-Message-State: AA6/9RnunB8yOx5WgzAqi/lcFz1x0Tyxa5FbRGIQpg2/bPpv5aDWQWsVWsJAJZKdl43hcPGoyZ/8Tigrfrr3Lg==
X-Received: by 10.28.136.197 with SMTP id k188mr5207737wmd.54.1475400060392;
 Sun, 02 Oct 2016 02:21:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.38.132 with HTTP; Sun, 2 Oct 2016 02:20:59 -0700 (PDT)
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 2 Oct 2016 11:20:59 +0200
Message-ID: <CAP8UFD3Y1du+L9DRgz01wgbsCYiebu2DgyePH41MaDhjV24oHw@mail.gmail.com>
Subject: Re: [PATCH 0/6] receive-pack: quarantine pushed objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <dturner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 9:35 PM, Jeff King <peff@peff.net> wrote:
> I've mentioned before on the list that GitHub "quarantines" objects
> while the pre-receive hook runs. Here are the patches to implement
> that.

Great! Thanks for upstreaming these patches!

I wonder if the patch you sent in:

https://public-inbox.org/git/20160816144642.5ikkta4l5hyx6act@sigill.intra.peff.net/

is still useful or not.

> The basic problem is that as-is, index-pack admits pushed objects into
> the main object database immediately, before the pre-receive hook runs.
> It _has_ to, since the hook needs to be able to actually look at the
> objects. However, this means that if the pre-receive hook rejects the
> push, we still end up with the objects in the repository. We can't just
> delete them as temporary files, because we don't know what other
> processes might have started referencing them.
>
> The solution here is to push into a "quarantine" directory that is
> accessible only to pre-receive, check_connected(), etc, and only
> move the objects into the main object database after we've finished
> those basic checks.

I guess if we fail the receive-pack because the pack is bigger than
receive.maxInputSize, then the "quarantine" directory will also be
removed, so the part of the pack that we received before failing the
receive-pack will be deleted.

[...]

>     These two patches set that up by letting index-pack and pre-receive
>     know that quarantine path and use it to store arbitrary files that
>     _don't_ get migrated to the main object database (i.e., the log file
>     mentioned above).

It would be nice to have a diffstat for the whole series.

Thanks,
Christian.
