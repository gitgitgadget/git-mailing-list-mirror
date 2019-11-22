Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D02BC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA30720708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 09:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebk/gE80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKVJ6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:58:21 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46058 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVJ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 04:58:21 -0500
Received: by mail-oi1-f177.google.com with SMTP id 14so5947107oir.12
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 01:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tfFp8Cg/6IT7ZZC5xhfnjiLL1g83y1ZXv4svk0a6TqE=;
        b=ebk/gE80VV/0G+ydNZ0qR978KYuj9A9LLQCF5qNR2p/af/ps+Gm9kefTrFW4TIKitq
         OjQPxchdtMejEzyVwr3iTulk32+HisdDeHUHYe3vCeQEJSq2d9Budr29KQIt6e8bhmdl
         f5By0jNUH5ic2uLbnLCWdNuweCEVF3hBatOJsWvdm3M0VDdJPSoH4+ir0cKKOqfLzL27
         sxMKIY5L5UpzSSmgfPY5KpT2Ayj+ttccgQIvMucZGHrzn4w2tMRJ31eiYK01w6kQRJza
         bB5J2E16xEY6PNb35GgGIE2o1tecxU9Ri7zpqdxYvXiQHTWGzZqS19N9rLOzg8PGODbB
         qEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tfFp8Cg/6IT7ZZC5xhfnjiLL1g83y1ZXv4svk0a6TqE=;
        b=inbjhz4+iIDfGPY5gPrayNlX9t2jhHNFKyjEON/jfchh3ycQDDNiNvZ6ZJ/dn9YG8g
         /Cnhu2rH4/NOLi167mwGvcw0dVoLx9DTY7M9leo+G3GrBC6HO/DONkipdMHNub4thdpC
         O1X5QL0U+JA5YtkGqQ48VAdWdx6fJto2cigVGEjWsqg+HFTjAAqn+9Vzg+Mc1fxpSlm8
         +XVh+LdGPs+FRHfEJ4VnWJYg/r1OY5S7OpJm5VR4FWrwVJ25uOeHy4cZQ7iSfqMLLDtJ
         IXj4bCTrYMruN1nmmy5NWQsZe2sGywsej5GEvVchuQjR3b10kPsGM632o874rmBjdsVK
         mF1A==
X-Gm-Message-State: APjAAAWbGZ4XJsyUdhgNGEKdVe1dF0qmPQHxB7nqbWwy8h3v5jCXkAVx
        pCDZ+ACEi7kByx/AJg6Ez44mJJ4G1g7LwMl31unkRMo6xwQ=
X-Google-Smtp-Source: APXvYqy7YKWzeEjgdZHYrioVfI1DHxfio2eqWAviv8kcXkfobuqxHRcPq6jGS9pQ3mGBN4+XDfOoFuODiODJ/rRCYuk=
X-Received: by 2002:aca:d558:: with SMTP id m85mr11104906oig.43.1574416698675;
 Fri, 22 Nov 2019 01:58:18 -0800 (PST)
MIME-Version: 1.0
From:   "Szelp, A. Sz." <a.sz.szelp@gmail.com>
Date:   Fri, 22 Nov 2019 10:58:07 +0100
Message-ID: <CAGn30R_C0BDCF-v0Ok5ekto9LK9wHUfHaKQi94wrKbaWaX6ezw@mail.gmail.com>
Subject: How to fetch all tags in the history of selected branch, but only
 those tags?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found a discrepancy in the documentation around `git-fetch` where it
describes a default behaviour (and the described behaviour is what I'd
want) but that does not seem to be the actually implemented default
behaviour (on 2.21.0). Well, either that or I misunderstand the
documentation. Then it might be an indication that the documentation
can benefit from clarification.

I described my issue in a question on
[Stackoverflow](https://stackoverflow.com/questions/58953115/), but I
figured I'd get more informed answers here.

So, the documentation for `git-fetch` says:
> By default, any tag that points into the histories being fetched is also fetched; the effect is to fetch tags that point at branches that you are interested in.

However doing `git fetch origin master` I do *not* get any tags. Doing
`--tags` on the other hand fetches *all* of the tags, defying the
benefit spelled out in " the effect is to fetch tags that point at
branches that you are interested in".

What am I missing? Is this indeed a bug (either in implementation or
in documentation), or am I missing something obvious. Also, how can I
force the desired behaviour (fetch the tags in the history, but only
those).

Szabolcs
