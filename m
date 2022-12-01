Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7777AC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiLAV07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLAV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 16:26:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36917C82C9
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 13:26:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3dfb9d11141so575227b3.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYCiraKw42N2VN3a1Lqx1n+9dfjtYwvwtD3YFW5yVRM=;
        b=rxjeiz9sPGx49LGf4AzKQz6LxHjRN718p+etTYGgRArY7BNUDMYlfUPnijzrOFzvo9
         aZcEQGSU0C/Lou2N0MhIrYqcRHWauaDUfBB2l6xiGZrZ/x8Q27TiBwi1D2NRCLvPJIWe
         jEqSg2pBKR29zUbHIVM0czA5jgMvqFcNJvnJj2GBTlFtES/Gvn2ObFTzBt/ooueNTXaq
         OURnyOOhZBZjbvjfIQEsWfr+FY5dNNZJ4soY/ZW6mIr5K/v4eBjMEwQmHhGD+K7lfmXw
         viIA/x8m5S6Swst6FLWg2G8/Q7GduqY+NWEpRZY21kZFwIPHivuf5JNAl3fDH4uA9EZH
         qdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYCiraKw42N2VN3a1Lqx1n+9dfjtYwvwtD3YFW5yVRM=;
        b=KykMYEg+hczCt0prjJfW66vgrVCKNA/VrGZnYoxxY7W+ODyn5WO2zSNPXvHHqF7mAA
         DWptc+Y25V22fhyGOqRG7LurgC05NZ3Ia4ZY7uw28EoISwvhDDkdX/YhPjyalVtMPYSz
         yEVGFYls6zgq1H9Zs/BoStNLiguM+3Cx2nVdTvyvsSyFOvLOIrRqnl4P9X2ntNq2IlIV
         HLEcF505OfqS/hHyqdwcTK9ddsHvwp0k2fidt5kjhK6giF5YVDsgO4j8GXhhzG1+z6Yv
         Fnv/IvTvRJuaM7wxYUs0ZRI+1IEvWFru5fEfUCCB69XD8XmDIRnYERolWodsoSZO/kPQ
         omVg==
X-Gm-Message-State: ANoB5pnZGFkmITxJzvujICiaCenA1IpU24Q66Oep1xbXGgKwe12VBzbt
        hiw6RZqj7fiSuVrfWJH5ahtATsPhhSlmzUm98KVf
X-Google-Smtp-Source: AA0mqf5OO5WUPWCA9vxp28V/ud4/TuGCtplLCXYdE4ymMjzH7Ms9BJfl+kxnLAu+kXD+sjWTYKrNv6q51K5/WsaR30eV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:c84:b0:3d4:f6cb:6dd4 with
 SMTP id cm4-20020a05690c0c8400b003d4f6cb6dd4mr9642914ywb.365.1669930015510;
 Thu, 01 Dec 2022 13:26:55 -0800 (PST)
Date:   Thu,  1 Dec 2022 13:26:50 -0800
In-Reply-To: <Y4kGiEXdTOpn5Eyi@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201212650.414069-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> On Thu, Dec 01, 2022 at 11:27:29AM -0800, Jonathan Tan wrote:
> 
> > Thanks everyone for your reviews. Here is a reroll with the requested change
> > (just one small one).
> 
> Thanks, this looks OK to me. However Junio noted in "What's cooking"
> that it seems to break CI on windows. The problem is in t5318.93:
> 
>   2022-12-01T09:26:44.8887018Z ++ cat test_err
>   2022-12-01T09:26:44.8887414Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8887825Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8888240Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8888639Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8889052Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8889512Z error: Could not read 0000000000000000000000000000000000000000
>   2022-12-01T09:26:44.8889991Z fatal: failed to read object 0000000000000000000000000000000000000000: Function not implemented
>   2022-12-01T09:26:44.8890401Z ++ return 1
>   2022-12-01T09:26:44.8890761Z error: last command exited with $?=1
>   2022-12-01T09:26:44.8891263Z not ok 93 - corrupt commit-graph write (broken parent)
> 
> Looks like the check in die_if_corrupt() is seeing a different errno
> value than ENOENT. I wonder if we need to take more care to preserve it
> across calls. It does look like we hit the same sequence of functions
> that read_object_file_extended() did, but perhaps this was buggy all
> along, and you're now exposing it through a new code path.
> 
> In particular I wonder if obj_read_unlock() might be the culprit here,
> and something like this might help:
> 
> diff --git a/object-file.c b/object-file.c
> index 8adef99a7c..db2d35519e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1641,9 +1641,12 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
>  			     struct object_info *oi, unsigned flags)
>  {
>  	int ret;
> +	int save_errno;
>  	obj_read_lock();
>  	ret = do_oid_object_info_extended(r, oid, oi, flags);
> +	save_errno = errno;
>  	obj_read_unlock();
> +	errno = save_errno;
>  	return ret;
>  }
 
Copying die_if_corrupt() until "failed to read object":

> 1734 void die_if_corrupt(struct repository *r,                                                                                                                                                       
> 1735                     const struct object_id *oid,                                                                                                                                                
> 1736                     const struct object_id *real_oid)                                                                                                                                           
> 1737 {                                                                                                                                                                                               
> 1738         const struct packed_git *p;                                                                                                                                                             
> 1739         const char *path;                                                                                                                                                                       
> 1740         struct stat st;                                                                                                                                                                         
> 1741                                                                                                                                                                                                 
> 1742         obj_read_lock();                                                                                                                                                                        
> 1743         if (errno && errno != ENOENT)                                                                                                                                                           
> 1744                 die_errno(_("failed to read object %s"), oid_to_hex(oid));

I wonder if we could just remove this check. Even as it is, I don't think that
there is any guarantee that obj_read_lock() would not clobber errno. Removing
it makes all tests pass locally, but I haven't tried it on CI.

(One argument that could be made is that we shouldn't have any die_if_corrupt()
refactoring or other refactoring of the sort, because previously its contents
was part of a function and it could thus rely on the errno of what has happened
previously. But I think that even without my patches, we couldn't rely on it
in the first place - looking at obj_read_lock(), it looks like it could init a
mutex, and depending on the implementation of that, it could clobber errno.)
