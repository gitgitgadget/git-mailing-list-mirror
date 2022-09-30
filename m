Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F23DC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiI3WK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 18:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiI3WKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 18:10:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236B85D118
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:10:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r7-20020a632047000000b00439d0709849so3549950pgm.22
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1czbsvaoztJrN0sykzLh1VPKO5MnAEQXguHyN7nl+U=;
        b=eK6I/jffvoyRzezQxzZi7QmCrIv1QRy/cmEGhNLBn3OclxYYgHQ7K5WeAAqKWKT1TM
         VkNDde+kNi1QBow06kDszwNiR7PL/Cm1l6dmDpC0l1nKMgD3WK332O+vqCbGfloMOeig
         1ezEttURVRVw19YeYSNBEaI1bq+RA0NyAvy71FPI66vv65Zi707zPisb6AS+zmBSglXc
         UyHUoV9vmUZmYxiEAeaB6xDlSJPwqZibuSKMm70b+1kIlWR4fX/iE8NVGxe3r4VgMbte
         RXN1Hf+4iIALxmoC47JMAKKwEFVM8785dpeenNUbbyHDS4Tm0ZXH8PpVbzvY00vabjrr
         C58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1czbsvaoztJrN0sykzLh1VPKO5MnAEQXguHyN7nl+U=;
        b=NiBd8UV3afChhIwbnTpiepnHOPQeGDxkJpTkGnFBt4iuV6mh+tf4v9KfUfeDJvFZrz
         rAqYRy3LuKizxA9oRfLQLTYPBo9RgnoXHf2Uk1qGol1XxkwrsMNj+S7aMejFpglPpIsb
         FKFxrYX2vX7VGguLVZeXyDFdMucLyi2r9EgEuOn1leXSK/wbLUOsiLNfeoh1+IzFhMbl
         +B3PHrBEafjJB2m4abHuNS/7expBNaFvtWWxEKTEKMP7VFWAAxGxK6nv7eoQliF4s1jg
         IClubD0j9nTiyM7JPDrdFkZeba6tak7fhtDs0DhVhTjDH5q757nxIkNSnGBM/Rs11zpM
         lQCg==
X-Gm-Message-State: ACrzQf0AZXQDqryswCfrdPExMOlgm3a5kI/r4zbeZFzXTRoXzCaVDlLS
        XnUBaIEjwFvytRDSxePqAIQqpXoOwkxI/ozCzqmx
X-Google-Smtp-Source: AMsMyM4tpv0khsvywdstOFRsL6g42k1Pf9uSFU0KRzYaQgtLtsXRbUOHdMd/HV9DBkA71km43JOIk1t66v7Wb9N/W83K
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with
 SMTP id d6-20020a17090acd0600b00203ae0e6a21mr478538pju.0.1664575818121; Fri,
 30 Sep 2022 15:10:18 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:10:16 -0700
In-Reply-To: <kl6l8rm3mm2x.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930221016.2081461-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] promisor-remote: die upon failing fetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> I'm not certain that this fail-fast approach is always a better user
> experience:
> 
> - I could imagine that for a small-enough set of objects (say, a very
>   restrictive set of sparse specifications), one-by-one fetching would be
>   good enough.

I think that in this case, if you couldn't fetch a small set, you
wouldn't be able to fetch a single object too.

> - Even if one-by-one fetching isn't fast, I'd imagine that each
>   individual fetch is more likely to succeed than a batch prefetch, and
>   as a user, I would prefer to ^C an operation that takes longer than I
>   expected than to have retry the repeatedly.

Hmm...but when you ^C, you have to retry it too right?

> Here are some other arguments that you didn't mention, but I find more
> convincing:
> 
> - Running prefetch in a non-interactive process (e.g. running a job in
>   CI) and the user would prefer to fail fast than to have the job run
>   longer than expected, e.g. they could script retries manually
>   (although, maybe we should do that ourselves).

That's true.

> - Fetching might be subject to a quota, which will be exhausted by
>   one-by-one fetching.

I'll add a note that lengthy execution can be bad for quota reasons as
well (in addition to others).

> As such, it _might_ make sense to make this behavior configurable, since
> we may sometimes want it and sometimes not.

I don't think there is a compelling reason to fallback to single object
fetching (which is there not because it is useful, but just so that Git
commands that haven't been updated to prefetch will still function), so
I'd rather not add an option for this.
