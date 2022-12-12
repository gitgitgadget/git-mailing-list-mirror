Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C233C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiLLVBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiLLVAk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:00:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCD186E7
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:59:59 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v16-20020a17090a899000b00219b1f0ddebso705483pjn.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HgD3LvHOqmdivoiS/CbnMVcTlvtK4+atpwZhfLEOSqA=;
        b=iV6nIiuscDH8oYyFiZKk7u7FTRBReyGEdg7p59ZXlOQgbAkdRe7a6IH8LW/HzNbaII
         APbmApZMI0UvLoLpFF4QsKSS3DudtamNiVQQNsC9NTAFF7aUJW+7wQUJ8kEYO0QM6gEv
         QuDfR97JD2k17ztFLiaaXsYJeZJP6Q+LEviR9wj0G8p+U6UdTZ/WWdaiYIzWqFW8lj5R
         XMkP+9pzPgUTZZSyUV95mPukIjINIU16k+1YRjWoXMQaueqoKYTmFSx6S0SvfFMpwHk+
         b12imjbg1QW+GIAZS3Oq9hil2ZXyoiFkXPjV0CzWIxxH/uU4RU7ebIiXYC+dOquf3ImT
         OQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgD3LvHOqmdivoiS/CbnMVcTlvtK4+atpwZhfLEOSqA=;
        b=1oFrH3JHLI2GdcXJgtQUx/pBa/CfFLIupMrpwZzavZmPNpjwMtc6f9ffRGDCs7O67I
         SQxXP1PyGQb8ltMyu0Affndz3IcTeQq3pap32CSqAUf3nCqjec9Gqz3HFCtYuxgcdpaD
         9rRSp9+qygRMzcLm8du+Zbw7NFb/ZZz6HPXJvJqS6CTKRh6YG8oqV6yF4IgI7SkX6Agl
         EbPJ0JMF9hhVvlYl7q4CepMaM421kXCUcTm/XHLTAAMkbKymfwBqT2ZVCCejRsVF1M8f
         ypWUlXMKIbIWzHs+OeKH29S9wD3vjsaPhn0svu7FtoeFdICmiasAm/Wwkpux0Q1pvPzP
         umUw==
X-Gm-Message-State: ANoB5pnWf29CQYmHS//ZVmwa/o7Yf7Mnggh0jIOrWEAHsFRJl08EUmJ7
        hETW+EmAsanpjJO2a/c9qytUmjl1JQOF/nS9aoVb
X-Google-Smtp-Source: AA0mqf4eHBrP8wyaA39rwI5av1bKk6H6qckyFXib7BHqaa5sIijC+ul1rhWE/UDswcDjF2MLn7VkAOeXUBiABYqAxQGJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:813:b0:578:46bc:fea2 with
 SMTP id m19-20020a056a00081300b0057846bcfea2mr461103pfk.37.1670878798177;
 Mon, 12 Dec 2022 12:59:58 -0800 (PST)
Date:   Mon, 12 Dec 2022 12:59:55 -0800
In-Reply-To: <Y5eT6jodUdNr6hK6@coredump.intra.peff.net>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212205955.956380-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:
> Actually, I think it is much worse than that. The code as written above
> is already buggy (which is my fault, as I suggested it).
> 
> In open_loose_object() we'll continue to iterate and pick out the "most
> interesting errno". But we'll throw away the path that gave us that
> errno. So we might well say:
> 
>   unable to open loose object /some/alternate/12/34abcd: permission denied
> 
> when the actual problem is in /main/objdir/12/34abcd.
> 
> It's fixable, but with some pain in handling the allocations. I think it
> would be sufficient to just say:
> 
>   error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
> 
> here. 

OK, let's go with this.

> And possibly put a comment above open_loose_object() that "path"
> is only guaranteed to point to something sensible when a non-negative
> value is returned.

Junio made a point that there could, for example, be no path when the
odb list is empty (maybe in the future) so I don't think this would be
sufficient. But there is already a comment there pointing to a comment
in another function that states "path ... (if any)" so this is something
that callers should already take care of. In my changes, I'll initialize
it to NULL and whenever I use it, I'll check for non-NULL first.
