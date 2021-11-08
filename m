Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4EC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE78610E9
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 04:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhKHESm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 23:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhKHESl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 23:18:41 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E97C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 20:15:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id k21so121595ioh.4
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 20:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQLdh+L40gsqXj1iqNOqLgaCug7D9JZn3iqzi01WfpI=;
        b=x+6IE689LZqaelYSKCXQr+dc24+Fns+uf/U2LFGzK8W6xhC+pGDl7lqXjkHsVTtFXB
         mckMv661YNNTL2B/IYXdFV2XzTTDJDbrwOT1sLRvx26kmAltn4DeFDUdGLEJb8IunruP
         df901SLR/XcYFcgegEdO/bHHigulQZDeAYHiXckbY+bhbRjiSo6NVZIIvbjogts2kQvd
         CLtRAEoIbuC2upHSGO/wzJfj2TvMzvLkaFVyskDx2dyE7lc7+OTa34YJbcz/dPSsABHL
         JJ3RJd4Y9l9phm3WBatoU2MhTWZqQ0atJmSC1oV+bPBXtUePxoWuXjNLpWOCSrv1GGPi
         t7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQLdh+L40gsqXj1iqNOqLgaCug7D9JZn3iqzi01WfpI=;
        b=CMi0Bdr8AC4/FOpUFsJXz83bebYXMSdnyKQQ/Iyoiv/bLgZGng+6LB+IGlx4mhSY/7
         sf2AdiyRk8mtjHY78ZbC/yg6pfFFPmMqVCnIMjmvHGj6LlrHn21xGlbNvKr0A7dM/PPh
         7c+fPX3MS0xIP4jwq90Td/pY/vAXcGoHaTPMvxvdo1PQYKffLqZobrb2BPSaWxvnir28
         D8uRRMHQzDgFKlrcxor1OAPsNqNvuJNrOqeoElERSa6v+GXGZPWChl3BMT53qkuyBueG
         WB8LAdsME7uUj8FguGxrjDsqM1tLY7bkvc5cWDnxOrCqunQvhReDfZ04IDejty+pDNJN
         KIPA==
X-Gm-Message-State: AOAM531wjVOPpU+MgKovouKmew8M1BGjEDiPjurY21SAr4ZDSFeSTKM9
        L8TCdtR9YsDFwnZ/UzSfbx5IoA==
X-Google-Smtp-Source: ABdhPJxk+SDzak9Sfjog0DP10CrYjmrKLu2bj9dqeZ+LJPKPSC976veAg4ceSlwCOYcKFEYeYV41qQ==
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr9810886jat.22.1636344956785;
        Sun, 07 Nov 2021 20:15:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f11sm9048655ilu.82.2021.11.07.20.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 20:15:56 -0800 (PST)
Date:   Sun, 7 Nov 2021 23:15:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Birk Tjelmeland <git@birktj.no>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
Message-ID: <YYike53eJEjSX3er@nand.local>
References: <20211107213012.6978-1-git@birktj.no>
 <YYiXw41upJfPS7l0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYiXw41upJfPS7l0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I forgot to mention in my earlier email, but in this hunk:

> diff --git a/builtin/stash.c b/builtin/stash.c
> index a0ccc8654d..977fcc4e40 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -501,7 +501,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>         const struct object_id *bases[1];
>
>         read_cache_preload(NULL);
> -       if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> +       if (refresh_and_write_cache(REFRESH_QUIET, 0, LOCK_REPORT_ON_ERROR, 0))
>                 return -1;
>
>         if (write_cache_as_tree(&c_tree, 0, NULL))

Not the fault of your patch, but this hunk is unlike the others in that
it only checks the return value of refresh_and_write_cache() is
non-zero, not non-negative.

Looking through refresh_and_write_cache(), we can return a non-zero
value in any one of three cases:

  - We could not acquire the index.lock file with
    repo_hold_locked_index(), or

  - We failed to write the index (indicated by write_locked_index()
    failing), or

  - refresh_index() returned a non-*zero* value, which happens when it
    sets its `has_errors` variable to 1.

So because even non-zero positive return values from this function
indicate an error, this is OK. In other words, the current
implementation of refresh_and_write_cache() (and the functions that it
calls) make it so that it doesn't matter if you check whether the return
value is negative, or non-zero.

But at least for consistency with the other callers (not to mention
saving future readers in this area the same thought process I just wrote
down here) it may be worth changing this to:

    if (refresh_and_write_cache(...) < 0)
      return -1;

Thanks,
Taylor
