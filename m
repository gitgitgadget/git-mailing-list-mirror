Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8107FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FE360FE8
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhHTSrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTSry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:47:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD2DC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 11:47:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso9686419wmc.5
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acesquality.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Tr4H1vlWGo1azahvRy1G5ni2nYinpa6dB/3UHAYhl8=;
        b=NPUN3XJqrHHCpZW0RAPHyIu1iObGtRGhMyhjR871bqLi0kl6h2lJ+PUk4GnboWqWfq
         zRXZNG2AUqeqOYlbgPHPaa9Miwnd4eLvssmfiywzuqIx7z/It/6xR8Rgj8/CRvJ0Sg6a
         LyPAPHgx1fQF9w7kncu0jlhF7lW0HKdYYTisQ7dKfjzFWBXcXS0SJXZfTwvX/SwlNMPQ
         aRFCWooR0B0M61BND6OMd4NcxjS60voBOw/HIBTQO0TlK4NV8AoJlQttNt4rXRKtJohy
         cnrFi0liEqWCLGmKCMHyH4SNA2hYxS/z52gczOJY+gd0aNXzjJTzEm+z5Hj0OFsBRQaj
         sC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tr4H1vlWGo1azahvRy1G5ni2nYinpa6dB/3UHAYhl8=;
        b=o8VzH+e4vvJL/QBDOEhuAxCXxZUuI1gyDwjyeP1nEhwlfaRUcWmYQzx+fmMyk2sOJo
         tO09PsjbsAlg89YaXb4OviSsZ3tkq69AD5BRTKEWO+uIYF+oloPOF0e10gAwA8AbQwLe
         g5yRqIInYaiFQKA73GYlT7X1+D02am921r/VklYoWGCeJ3Y83rbA1+qv18EbBWdhgFmU
         wLgvnCCUXCFqH08gmWtGoKTHMHVzeD4VbRiqo1niWiSbVS2wb3C5BhH5qqclHR+mKNLQ
         qS/Wxn47VOPnWoet5+2B3+GgCy7uekeav5tbpEmotoBZS2vfaNf0Njon3VKqSaOTPTXV
         Pfcg==
X-Gm-Message-State: AOAM531JpL3REY6Wt4co+fTH6cv1jf+by5qI5kOH0u5XPYyiRncQNzv1
        XDhxmMgwLkVSdo/WPgbPPsK+QDZd/+/rSePu5r6nJg==
X-Google-Smtp-Source: ABdhPJzAVjzgmR30wCcoP+jRrfl8JWA8VWfNSyt8scUbnMKsP/9Z48xe5MRZlESKzvTNSrlZHAI3Kve0SXxw1+tFTg8=
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr5426931wmn.114.1629485233969;
 Fri, 20 Aug 2021 11:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com> <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
 <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net>
In-Reply-To: <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net>
From:   Jonathon Anderson <janderson@acesquality.com>
Date:   Fri, 20 Aug 2021 13:47:02 -0500
Message-ID: <CAG83euofNXHx8-=7Obj-Ju5U_fjwNBuLVJjmccVhe9bqRFyBiw@mail.gmail.com>
Subject: Re: Git Modifying DLL
To:     Jeff King <peff@peff.net>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 1:00 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:
>
> > I had not. I tested that and it worked. I assumed that git would
> > automatically treat dll files as binary. Thanks for the help!
>
> Git doesn't know about any file extensions by default. Its default "is
> it binary" test looks for NUL bytes in the first 8k or so of the file.
> I'd expect your DLL would probably have such a NUL byte.
>
> Is it possible you have other .gitattributes set which are confusing
> things?
>
> You might try:
>
>   git check-attr --all <path>
>
> or:
>
>   git ls-files --stdin | git check-attr --stdin --all
>
> -Peff

When I remove '*.dll binary" from .gitattributes, I get this:

$ git check-attr --all ./PSWindowsUpdate.dll
./PSWindowsUpdate.dll: text: set
./PSWindowsUpdate.dll: eol: lf



When I add "*.dll binary" to .gitattributes, I get this:

$ git check-attr --all ./PSWindowsUpdate.dll
./PSWindowsUpdate.dll: binary: set
./PSWindowsUpdate.dll: diff: unset
./PSWindowsUpdate.dll: merge: unset
./PSWindowsUpdate.dll: text: unset
./PSWindowsUpdate.dll: eol: lf


I can also confirm that there are null bytes in the first 8k bytes.
These are the first 16 bytes

4D 5A 90 00 03 00 00 00 04 00 00 00 FF FF 00 00

Thanks,
Jonathon
