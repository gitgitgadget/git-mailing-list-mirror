Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C9C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 20:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbjEOUPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245194AbjEOUPn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 16:15:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C5C1
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:15:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba7730e47a4so3890598276.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684181734; x=1686773734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYged3vAbAbd2r3f1gXeiizfx+C7bIXxde8brdvk4lU=;
        b=yP11fJz2I33IRLyhHIuLqAspSmm7D/5KwHCB2ikbv0s9RDJNJhEHyViBPxW+Opj6rC
         7BB1ugOeWCU8t3gupzuGYTZipN3slUz3V6X9u/CCER2tXQ6ZzEfhq5M/Nes7MXnhvUxu
         i/LLTnoiFTCZJOiF3iB1963bZpfGSC7dFnHUX6N91WHwr3T9XC0esN3zIbGa98jJFTwM
         ljA7GsErmgg/z1TgeM/Xw1uFABXm9l4U3irxBFlndQONtfAEwlBIvx4PBCn9UHQAI3+Y
         /vKMPvVKAwhLKa+HAQ7x8b7SP3mBM8WVYSDa2idOEl2eGeAbE3ahHnMMB7I2fP8a+lBY
         rqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684181734; x=1686773734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYged3vAbAbd2r3f1gXeiizfx+C7bIXxde8brdvk4lU=;
        b=DUd4TY2nkkRJal/OW/+GDaaB+QQTt1agtT3ASCUPzYW48E9Qr5PzSmtqcPfA8E5JwH
         jvcUz+HFEGwPCcCqAf/OnI+3iAFtFtL/M4KyXRWmpbGwrfh2hh3i20DGXLHBFkHnh1Xz
         PjhsU/U86B18j8tWLcmiknw33JgAFU54hvRdUa8DI1qBj/Kq0cH3WybC/MWkWNw5nkXT
         MhqR2lFZmw1ZEBWSxDs+SuaIshPJRtXtjni4eYDma2oPGxLaHcmQdVlmhG42AIoOgLuF
         4M2WvTBM4gnudheEX/lnBHzay3qmyng3xBKHf2UGKwbLzMIt7OnFWG10QmjU0aQqkRkF
         /Gkw==
X-Gm-Message-State: AC+VfDwuSMiRkPdeXAtM/QpfMwvYNgA1oYy1JuNuo8vfPzNT4OokZXUt
        3jq+/QHA/1lD6WDUhacZGlT1SA==
X-Google-Smtp-Source: ACHHUZ7+njSb30u5avBRUZJtFwtti0ZxXg2i5ryeSUY14uUHQLs0fAPiZYFB3jW+cK759LrWoQ/fIA==
X-Received: by 2002:a25:c701:0:b0:b92:2b28:3461 with SMTP id w1-20020a25c701000000b00b922b283461mr29024850ybe.0.1684181733787;
        Mon, 15 May 2023 13:15:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w20-20020a25c714000000b00b9550fcb12fsm33820ybe.64.2023.05.15.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:15:33 -0700 (PDT)
Date:   Mon, 15 May 2023 16:15:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] builtin/pack-objects.c: introduce
 `pack.recentObjectsHook`
Message-ID: <ZGKS3gB5B7fbetFb@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <2ce8a79fa4bf98947728da4e6e22304a2f203fac.1683847221.git.me@ttaylorr.com>
 <20230512045853.GA2479240@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230512045853.GA2479240@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 12:58:53AM -0400, Jeff King wrote:
> I haven't looked closely at this whole patch yet (and I especially want
> to look at the new tests since this approach covers more cases), but I
> did notice that this version of the function still has the "we don't
> reap the child on parse failure" problem I described in:
>
>   https://lore.kernel.org/git/20230505221921.GE3321533@coredump.intra.peff.net/

Hmmph. I could have sworn that I remember including that feedback in the
new round, but I must have dropped it on the floor somewhere.

Thanks for pointing it out, I'm 99% sure that it'll be in the next round
;-).

Thanks,
Taylor
