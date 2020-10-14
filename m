Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D1C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E46922203
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 14:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fg614Ofj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgJNO3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgJNO3c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 10:29:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFAC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:29:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o9so1845754plx.10
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 07:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEQ0dxUACzDkYLOlqODdjDJpEoNWUJtDy+jJGO27KNg=;
        b=fg614OfjKlcUHQ7cGImkRAASulzLVGfNFOA6WEAEAzp5ZBv4ITUH/2NAuQtUrzQJXI
         LyvONL+3IMUs7uH0evz+EYyR2GboXXOUx5ZyIP6oi0BHjUgbZR6o7d5uaDG1eJqaw6yb
         23AsMVpjraZKyyzpTW1kUSGCjyBmUKaLxoLDCBSVrNMn6vb09DfPNfIRtuTkf7S5pu29
         L+Nh6iOY1dPOhqAc8pYACuBYypHrsmx09c+4Zt4azcEIknLweRzizidhSCW1WwKZd6Oh
         5GX4EFDQ0ASk4RDteROs/LAjOuXm2JTGBsnOSa/vcziUXC+BiMt6y9/3eU/RW9tsaEqZ
         T5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEQ0dxUACzDkYLOlqODdjDJpEoNWUJtDy+jJGO27KNg=;
        b=aZxEVT+1VOgjMgCcu56GxctY0p8rsFn43GXlkDJBuHidu+FZtpWW0NFIDJjSs9v37K
         e/PBjLc+z2Zfa9/+E6XIQ9oBX7ywQq85cbAceIsMlxmJ/4BPwz2l7/PpmkBJY02E2TDS
         mIm1MRkvP/hWyEn4bq4Zcy4O6auOriVtsH9k7QpZpzdu/Zl2/azDbPxizs6yTEHBDUY5
         C1H4BCjFHzVGUPMMonWPJMgMMPNiwluejjPahS66igK6x+3K4UdN5A86xzLVohXNYA/j
         UENfC0mT7+NFnCymCaNMkFxLcXctUW43Q37//vEAZdeZFf1I2ftM2DP2aSiNbvRM+hIf
         sPvQ==
X-Gm-Message-State: AOAM533MV5MJnNoDaksoHoCm1hv2X+KVxGWjabEBoFE/INxnT+3P3KYt
        UnjWY83b+jeZEFxVsEx4N1kicpmh3+yeroTC81z5WQ==
X-Google-Smtp-Source: ABdhPJwo4wHXf6JOBaUSs4sx5CCHBeV+dyKKR8Yo4TPhdhIYISuO++OQmweSdhG/iHTBH2nZPvaS8GjJqtDvhpXGB5g=
X-Received: by 2002:a17:90a:19db:: with SMTP id 27mr3797114pjj.110.1602685770213;
 Wed, 14 Oct 2020 07:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-2-smcallis@google.com>
 <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 08:29:13 -0600
Message-ID: <CAM4o00cFdD2mcnm8SmupTSrWeetUN+pC_ZFNQijdia6uGGpYPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Sean McAllister <smcallis@google.com> writes:
>
> > CURLOPT_FILE has been deprecated since 2003.
>
> I thought that Dscho already mention this, but updating the above
> description to mention that _WRITEDATA was introduce to overtake
> _FILE as an equivalent in the same timeframe would be more helpful
> to readers.
>
>
Yes he did, I'll update the commit message to give more history on the
change and why it's safe.

> > Signed-off-by: Sean McAllister <smcallis@google.com>
> > ---
> >  http-push.c   | 6 +++---
> >  http-walker.c | 2 +-
> >  http.c        | 6 +++---
> >  remote-curl.c | 4 ++--
> >  4 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/http-push.c b/http-push.c
> > index 6a4a43e07f..2e6fee3305 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -894,7 +894,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
> >       slot->results = &results;
> >       curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
> >       curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> > -     curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> > +     curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
> >   ...
