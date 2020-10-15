Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6044C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785B222210
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUvNsV6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbgJOQeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389578AbgJOQeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 12:34:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17329C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:34:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t18so1913548plo.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNNMYpgOe+zvaBwuTj3nUMWH9hycQG0K9x85c/FSNSg=;
        b=CUvNsV6CK5hdGUJ2dxNGGzk9RCbXEzI8/0PQDkZNs8nn+HXmkjrZtzWmXLjeRxgaxT
         KUFOZNuFp0K0+7eo4WBm/tlzm7ZNR1QMYcx3ucgcNh+rqYwNFjisiNbj6OmKP2oi8Djb
         zZ/IfHil2QE5QMLTOwOa7/H7YQl3JZawLW4hYllLpDTEcfj88rFkyfU00fCq/PGNtJyt
         AQhzA1tQduYQPLZlyxSh5Ysyp0Ahia7YxqX26uSskbptedr0yqKKaHUtvp5LzvPAJEem
         hPpoa9kLJXqQYNxrf8cWZI3UoczxB5HEySCStVlTljRa1wzdo4ReJYVGJxumO2LmdY1D
         CZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNNMYpgOe+zvaBwuTj3nUMWH9hycQG0K9x85c/FSNSg=;
        b=LLgj22nQs6R7aLpbtYyIWPaDvUTamtg+gRb9d8+ASkbDe3Yx4nK5uxC9xC/ircrcKK
         btzfdCJ0k7HYFAO9Zv+8JhmyB+Prce70Q30UwiwLRi7naGGnqFGMs22cUgsq5rl35yMQ
         67Z1pifYw02+sz0VVGxEaHPHRxE4HxmXBSMEcCNwEudmYlG+8BmjwgwnymqXJ1ym+IgM
         JajLoD3cHqCXsQBnGOslr9gw57cG96UmRBJRhszFQo8y+/PXb09komu98IJP7GGtmEv+
         19GXvDt6amVeAvpGtY79exGxeBXpIxhCVloJNRLt0z9T9D/2tFZiwEevBVDALREXMVUb
         S5HQ==
X-Gm-Message-State: AOAM531OzYKlPQpMe5aZiQ4zbB1QE/U3E7OvFZ9s8vbtfgqL2+vrpM7g
        DCuGbBDNae0astw0yJf2EsunnsfDlrmwerHZ2mJmZg==
X-Google-Smtp-Source: ABdhPJx8sfz4cLOM/XuLWgOaVgz1kc4d/FTNTjZfEfYUC4Crju9u6SPfdVgSp/L75WSenhTEi5Sqm/gA0YhfHss1C30=
X-Received: by 2002:a17:902:ee52:b029:d5:b156:3ff8 with SMTP id
 18-20020a170902ee52b02900d5b1563ff8mr4515280plo.85.1602779648395; Thu, 15 Oct
 2020 09:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <20201014195544.GA365911@coredump.intra.peff.net> <CAM4o00eefXK2CJ_FxwwVPpBKL01JsJANf+SdjCtw_0NVV82L+Q@mail.gmail.com>
 <20201015162343.GC1104947@coredump.intra.peff.net>
In-Reply-To: <20201015162343.GC1104947@coredump.intra.peff.net>
From:   Sean McAllister <smcallis@google.com>
Date:   Thu, 15 Oct 2020 10:33:52 -0600
Message-ID: <CAM4o00ehgWp6nHi9yN7TyvoNu593OaMWW1f9FA1q9Cw+HdLZeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> I was less concerned with the overhead of the strbuf (http requests are
> pretty heavyweight already) and more that it could simplify your parsing
> if you could just do it left-to-right on a single line:
>
>         char *line = xmemdupz(buffer, size);
>         const char *p = line;
>         if (skip_iprefix(p, "retry-after:", &p)) {
>                 char *end;
>                 while (isspace(*p))
>                         p++;
>                 opts->retry_after = strtol(p, &end, 10);
>                 /* if you want to be pedantic */
>                 if (*end && *end != '\r' && *end != '\n')
>                         opts->retry_after = 0; /* warn, too? */
>         }
>
> If you want to be clever, you could probably avoid the extra allocation,
> but I think being able to parse with simple string functions makes it
> much more obvious that we don't walk off the end of the input.
>
The latest code effectively does this per Dosch' suggestion.  No more
string splitting, it just
parses it as a single big string as you mention.  It sounds like we're
quickly settling on using
CURLINFO_RETRY_AFTER when available, and not retrying otherwise, so it
might be OBE.
