Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CAC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiKNWOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNWOl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:14:41 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AD15822
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:14:40 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id h206so9323533iof.10
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrO/HxFyKt+a7nac1XB7wEabPlnceYbCv2le5kO7TmI=;
        b=ch/Sb8fAyVdJ8mwyofakEi0PlP9Z2enTOun+PAk0tWB2wzaKWQw821dvqDVWKopJRB
         BD3fOr4XEpw8AdQjcCeiu/ZyKkCvvtUdrvGqLA7s28V0e2BAaw8okol2vxAcYE7JlCZ9
         A4vXyYcyJMOu/HvZ72peQNlhNKzOebng9YSVgXGy83r5mooT9tU+ASJnapmrCb0WzOJQ
         z6HHARgbZnA/ajnnKvTRsMALeiO6CiSSeLATnX4kHN7wlBHJOElkJ8axjiq+aYCUQDzI
         d9rJ4baYr6s99XtCWdwF74ExuJl+mW40VG7WzJDSMQIX+o7tPm9RJOwHYBxseHDAOiEL
         xpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrO/HxFyKt+a7nac1XB7wEabPlnceYbCv2le5kO7TmI=;
        b=DIyclcHhtws9LPtbpsDJa8EppXIFKZ1nrMrWoHDuYXfAK8NmtWZk/bP0R1K2widF/Q
         yVby/diB5ZNJ7PCTdIHrzYcL3P/f3k5EpNG9noR1rSPE/rks0P+ItQq9fCoUlrNO0ZIE
         7BY+1PcjBSD/Cz4qx2PTBPB5kVpJkWQkNB1oo52wzgK0MkhDQUEq/Et7RKz4Uhd95bIp
         hWe7Dr9qROWgfAUxEd+mgqQSdW2F2gLHyXCy0fjnEbTIef13hzeh8iRARvfsvucEnpc1
         57ABsl4irSCtoccT1nNZEoAAIe/pbGElbC8eebjHyDdkkfKvkhgrB8+kiLc4Pza9BS6e
         Swfw==
X-Gm-Message-State: ANoB5plnRiQaa3wFRr2HyahYGnoS0QiL1A8h47OhU09ooAjjWjw1H9GY
        Bzybq6YWZ7NcNCt4PF9wSlFDxv8HgXlPdA==
X-Google-Smtp-Source: AA0mqf6z8M8CDJXwzDbNxBefh53kp+3cSK+yi8ZEjgk9vVf86FUt3MRNrag/l7Y9nw0dkTC2gnrUMA==
X-Received: by 2002:a5d:9b19:0:b0:6c1:dfd6:abd9 with SMTP id y25-20020a5d9b19000000b006c1dfd6abd9mr6395316ion.0.1668464079537;
        Mon, 14 Nov 2022 14:14:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6-20020a056e02152600b003007aba03c0sm4421576ilu.66.2022.11.14.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:14:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:14:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 1/2] pack-bitmap.c: remove unnecessary
 "open_pack_index()" calls
Message-ID: <Y3K9zVx7L9K85NrE@nand.local>
References: <cover.1668063122.git.dyroneteng@gmail.com>
 <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1668063122.git.dyroneteng@gmail.com>
 <Y3K7TEpB8EzczjTb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3K7TEpB8EzczjTb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 05:03:56PM -0500, Jeff King wrote:
> On Thu, Nov 10, 2022 at 03:10:11PM +0800, Teng Long wrote:
>
> > It's likely that we'll end up relying on objects in that pack later
> > in the process (in which case we're doing the work of opening the
> > pack index optimistically), but not guaranteed.
> >
> > For instance, consider a repository with a large number of small
> > packs, and one large pack with a bitmap. If we see that bitmap pack
> > last in our loop which calls open_pack_bitmap_1(), the current code
> > will have opened *all* pack index files in the repository. If the
> > request can be served out of the bitmapped pack alone, then the time
> > spent opening these idx files was wasted.S
>
> By the way, I wondered if it was possible to measure a slowdown in this
> case. It is, but you have to try pretty hard. Something like this:
>
>   # one bitmapped pack
>   git repack -adb
>
>   # and then a bunch of other packs
>   git rev-list HEAD |
>   head -10000 |
>   while read commit; do
>     echo $commit | git pack-objects .git/objects/pack/pack
>   done

OK, so with 10K packs, we see about a 1.6-fold improvement, which is
definitely substantial.

On a fresh clone of git.git, repeating your experiment with only 1K
packs (which is definitely a number of packs that GitHub sees in
under-maintained repositories), the runtime goes from 25.3ms -> 20.9ms
on my machine, or about a 1.2-fold improvement.

So definitely smaller, but even at 1/10th the number of packs from your
experiment, still noticeable.

>   - this probably isn't helping anybody much in the real world, as
>     evidenced by the contortions I had to go through to set up the
>     situation (and which would be made much better by repacking, which
>     would also speed up non-bitmap operations).

Per above, I'm not sure I totally agree ;-). 1K packs is definitely an
extreme amount of packs, but not out-of-this-world. It probably would
show up in carefully-picked graphs, but not in "overall git rev-list
time" or something as broad/noisy as that.

>   - it's worth doing anyway. Even if it only shaves off microseconds,
>     the existing call is just pointless.

Yes, definitely.

Thanks,
Taylor
