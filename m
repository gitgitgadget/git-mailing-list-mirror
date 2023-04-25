Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C749C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjDYSDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjDYSDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:03:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3239217A3E
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:02:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517bb01bac9so4386856a12.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682445747; x=1685037747;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ0B4+pMLnWRVOI7fyEsY4nmgAOLraA65QiTtdXQyEY=;
        b=hXC2CzkRRdVdcYNlJsiGlUoDvA7NkS+M9XQ7VZfbO3Eqhr/ACfNjOXoqh76ZTybwdT
         x/SJgJB8sdtsL372ljKPnoBAuEVvlgmrGyZhb/0Kp4rIDhdfkF+UHbRowx8qvXDTDyET
         fjifpoRJfPhnmrok7pYeo5b9ptEvT/j+k1gj1iCOzZGWcOut5/KWNlmH/nPRwyDe7IFv
         HiVCypg6z6XNpJnr0JWOr+s7lsNt+5/qaPRiwBZGhKMTwlD3UuoUXYV/Ul3itahPKJAo
         /U2x3yZzNQrBkimKgyIIzZ1I4ZiGt9JQ4NdfMmTXUZg2F+JvoxoozyMHhLK6pLhPkFDY
         H0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445747; x=1685037747;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJ0B4+pMLnWRVOI7fyEsY4nmgAOLraA65QiTtdXQyEY=;
        b=RZKZcCncElGAf2B5n87f9vjMw2Ym8oqLqdZ5rJbfoDYipmHw5m7ECG2Y8+eKf1sDh2
         IvPRVoi+7wt5G/lIsT4kAh9fON3aBCsJgNjM3oJvFiqtXo42GFfMb3Ts5ADHEVnO9dQk
         OZmsDf3dXLi1qQuY+6993Pj16xn92FzTmIr5yh6gpdDpi2/7qc60hVFtjugd11Hv2YYb
         id2jvjjqH/dehO3VT6gtxGVGfAe4+FwT5gPVms7/KGqLYpl6ISyi6MnlYfm5ALiEuN4H
         lQ5zUPq9/8sgfsL6Z2TedDO9BFQLWOT7SDtoYAuoL6SKqslRdPo6gk2elXXnQ/LA4f1l
         DLUw==
X-Gm-Message-State: AAQBX9cky/n4FPTkZAYveqkoUtwJcNIBphLiUJKTgrf+7mDFPtKE5/y/
        /M10DiHXQ7GzRa3iRgw3ABw=
X-Google-Smtp-Source: AKy350YlbUGYypaq6xoLhz2nQpqvCPxjWvYJsl4chsHHI9AGxN8+O1Y7YRZJc051CCZ/OHKbnKPwEQ==
X-Received: by 2002:a17:903:40ca:b0:1a6:ee5a:7208 with SMTP id t10-20020a17090340ca00b001a6ee5a7208mr18661590pld.18.1682445746748;
        Tue, 25 Apr 2023 11:02:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b001a95c7742bbsm5513288plq.9.2023.04.25.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:02:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
References: <cover.1682380788.git.me@ttaylorr.com>
Date:   Tue, 25 Apr 2023 11:02:25 -0700
Message-ID: <xmqqy1mfzvpq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This improves many cases where using bitmaps was significantly *slower*
> than regular, non-bitmap traversal. In some instances, using bitmaps is
> still slower than the non-bitmap case, but it is a substantial
> improvement over the classic bitmap walk.
> ...
> In a large repository on GitHub.com, the timings to compute the objects
> unique to "master", as in:
>
>     $ git rev-list --count --objects master --not --exclude=master --branches
>
> improve as follows:

Curious---when would it be significantly faster to use bitmaps?
"Most of the time"?  "In not-too-large repository?"

