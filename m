Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F4C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACC42074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUaVip2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgFJU5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJU5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F6C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u186so3918441ybf.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HBvTLtGL6cn9/dUSHJAOPvyg0RoG6H8kR4DyIxsmpl8=;
        b=kUaVip2YxFGH3aFP+dNJ5gpZIdHHQMofi1hMrvw3voDqQsnlTRnN4gJuhpRyCty4AG
         EsCY5Qg149zGq6tAz2WJaWdAJJIjATKMIvY/lCqoi33phW+xXPwnfPcP1d7RTUalhJwn
         sHjqaV6j0n7ZJpycVOCydOFICZe9EwKsFa6Rfu0iykl+l/kl+DjlCtZApdnVv7WMmItR
         DcXksB2JmLNEgdJmbpWJh+3iytoZkyAxaIHEeo3yFVoUg4Cs3yNSkNgFjQXtj3lvKBNr
         aRMm/3yZRGqTVwlcYV3CdD2161CHVLA38KkGSW02iucSyyEuiexDV+zNRgtkQBMbVM02
         7UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HBvTLtGL6cn9/dUSHJAOPvyg0RoG6H8kR4DyIxsmpl8=;
        b=Fh87mHiW5Tocs6FYle9UdvOzCygpTlemSyNS/bCDrxGMpzL/Q7TI2Aa2feZb6B8KgZ
         RLAy5vypnJdAQUV//t1M2GF0iyirSgU50HKIVvA8MsZ33I8Niq6ndcWnYJEv1wjCRv1a
         l4KRTRalYIOLgWXzuXOXelr6RuNRv2skqqs2vUDFqD6nArTM5jNXTO6eUP2Bo8iLK1JD
         pom2gYYvGhO+eErNNIjXtEC2PnGVU9D0fOvKUDVCi5Js45tU/WfqGtW7gaWDn7K2a9jE
         R4G6a/tfO+iFZMJia6btX21YvkksOikClQVk0comsr4BNccuLU6qYkz/8cDVr0WTsMzh
         L2Nw==
X-Gm-Message-State: AOAM533CdTep7PyfFa0tu/dEWf1Gu2bDq4GLym6IB5lS5S3z+AQZhf6q
        uZPtI50sNfXDP+FH/2bF8+CiyMHWAX3+oNRybFYSB9JESsAUrJXC7sEHkOTBIqiY2ss5pXTPHv6
        yLdcaR8vjS0/HOeffJGgSi5gIGJ+bTCPFB8VTbOARTQnm2SUk7I8c52wsmKzZMrNG4W7BnF+YLT
        hv
X-Google-Smtp-Source: ABdhPJweyw/IAfjdA8LqtQVvj/OifPXdp8ORzqiIfj1D7sPWM2Zv695hpt5g/S1ey6umdK0tQ/es7fnWJh6z+EK8MirU
X-Received: by 2002:a5b:74e:: with SMTP id s14mr8531283ybq.104.1591822648421;
 Wed, 10 Jun 2020 13:57:28 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:14 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <cover.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 0/9] CDN offloading update
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Junio, for taking a look at this.

This version is based on cc/upload-pack-data-2. I thought of retaining
the base from the original version, but trying out the rebase showed
that there were some code movements that would clutter the range-diff
anyway, so I went ahead with the rebase.

I tried to avoid the need for the first patch, but it turns out that
index-pack can operate with custom names for .pack and .idx
(".pack.temp" and ".idx.temp", as used by http-fetch) but not .keep, and
we need .keep, so changing to --stdin instead of using custom names is
necessary anyway. I've updated the commit message to use that
justification.

The main change is Junio's suggestion [1] to refactor into smaller
functions. Quoting from [1]:

>  - Whether we are fetching a single packfile from a URL, or walking
>    to fetch all the packfiles in the repository at a given URL
> 
>  - Whether packfiles taken from outer space are marked with the
>    "keep" bit
> 
>  - Whether the obtained packfile(s) are internally "installed"
>    to the running process

To which we can add:

 4. Whether to close the index mmap
 5. Whether to delete the packfile from the given list

The 3rd, 4th, and 5th concerns were refactored in patch 2, and the
others were refactored in patch 4.

I also updated the documentation to hopefully make it clearer that the
client should download all packfiles, including the inline packfile,
before performing the connectivity check.

[1] https://lore.kernel.org/git/xmqqeer2xr0f.fsf@gitster.c.googlers.com/

Jonathan Tan (9):
  http: use --stdin when indexing dumb HTTP pack
  http: refactor finish_http_pack_request()
  http-fetch: refactor into function
  http-fetch: support fetching packfiles by URL
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  fetch-pack: support more than one pack lockfile
  upload-pack: send part of packfile response as uri

 Documentation/git-http-fetch.txt         |   9 +-
 Documentation/technical/packfile-uri.txt |  78 +++++++++++
 Documentation/technical/protocol-v2.txt  |  48 +++++--
 builtin/fetch-pack.c                     |  17 ++-
 builtin/pack-objects.c                   |  76 +++++++++++
 connected.c                              |   8 +-
 fetch-pack.c                             | 137 +++++++++++++++++---
 fetch-pack.h                             |   2 +-
 http-fetch.c                             | 126 +++++++++++++-----
 http-push.c                              |   8 +-
 http-walker.c                            |   5 +-
 http.c                                   |  82 ++++++------
 http.h                                   |  24 +++-
 t/t5550-http-fetch-dumb.sh               |  30 +++++
 t/t5702-protocol-v2.sh                   |  88 +++++++++++++
 transport-helper.c                       |   5 +-
 transport.c                              |  14 +-
 transport.h                              |   6 +-
 upload-pack.c                            | 157 +++++++++++++++++------
 19 files changed, 752 insertions(+), 168 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

-- 
2.27.0.278.ge193c7cf3a9-goog

