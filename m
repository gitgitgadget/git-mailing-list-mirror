Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEFEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFVW0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjFVW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 18:26:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B272121
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 15:26:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so7777072276.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687472800; x=1690064800;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWK3Gi9r2sRJZn9I7lfDvGlX9e/mtZWXNTPp8aAT7X4=;
        b=YmSimUq/NJvGEIO45SlQh+ZdS1oFbTtTsu4wU/PoFvpaDCbtd+/wytxgZYzpeYNc7/
         pj0sqTV8IAes4p1f8HzwT8xNUoHScZTxulLALmuLjbyPDnLXVmjq3GK8pFumcMTKIS0b
         p4TXYy3VXEQLfP4evn1Bihxvp4qcYxOJ7jArASW88wba1HVp7h8dQAa+U8orePp/thyc
         WJLsYEOPlKcDKh5uqv7W31fyWFA0AvZGfhwuYKdVa0CbwfCk56PK+Z2FLixspdwrceZq
         yYfV9Whyaw31xhK3NcggiVijDpw8S/NQ6k6PovtVcovk1PyOirLLjHySwzE4ziB6W1Ov
         2/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687472800; x=1690064800;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWK3Gi9r2sRJZn9I7lfDvGlX9e/mtZWXNTPp8aAT7X4=;
        b=UN40PTS1TltWv6ChD3XaZhSGXZtV+CjTIZM3f0dvCk2FnjgeKCkiynS4GWJ/PsBQHC
         M7SyjaJRtpegfKNh2/QwV6ORK+i5+Jq+89kBXoaRze83qWEl8yH6C2xleAnxyPqxQZ4m
         jEPVzR+UadrROmX/iEF08CiqONR1pqN6bju1K0vbZaE3vjRNAeatf7MxOk100b9deidC
         qWrgh+6pUXai46Ae8ePm2Y1zcW+KRhRjCgZRZOOXp8GzCUtPiBCdIjhi+smIPTPrvKQ7
         Hy6vlIjavajMiJSX1WQe50rzdpWYjxpVMkKk2gyr+1aFwbIdFxIjpiHlyThDURreD8WA
         wrWg==
X-Gm-Message-State: AC+VfDwdztF0k7mT8t3FIV3kGGqWmS1FMf9ASHFVh7OIlV/HZS78/+Kd
        KRgR1/mjKhVgq+kCaAIge2dmoI4vHvBrQ9ioHhOn
X-Google-Smtp-Source: ACHHUZ6B2v4aLKCjgQ2dxqcinJE8Xm897HtfU/2QOw+TKzWMvG8GHgRMmyi2OukQfaKuYnTGFmZT5zNw6gRSMIYRT87M
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:b7b:317e:b418:a6e5])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:bc9:0:b0:bc4:3e2f:7641 with SMTP
 id c9-20020a5b0bc9000000b00bc43e2f7641mr2569639ybr.4.1687472799788; Thu, 22
 Jun 2023 15:26:39 -0700 (PDT)
Date:   Thu, 22 Jun 2023 15:26:37 -0700
In-Reply-To: <ZJLoSDcETsPMyONL@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230622222637.2045705-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> > I wonder if we want to mention what the undesired misbehaviour the
> > "bug" causes and what we do to avoid getting affected by the bug
> > here.  If we can say something like "When querying for a pathname
> > with a byte with high-bit set, the buggy filter may produce false
> > negative, making the filter unusable, but asking for a pathname
> > without such a byte produces no false negatives (even though we may
> > get false positives).  When Git reads version 1 filter data, it
> > refrains from using it for processing paths with high-bit set to
> > avoid triggering the bug", then it would be ideal.
> 
> Your description of the bug matches my understanding of the issue, that
> a corrupt filter would produce false negatives and thus be unusable.
> 
> I skimmed through the rest of the series, and couldn't find a spot where
> we do the latter, i.e. still use v1 filters as long as we don't have any
> characters in the path with high-order bits set.
> 
> I think this would be as simple as modifying the Bloom filter query
> function to return "maybe" before even trying to hash a path with at
> least one character with its high-bit set.
> 
> Apologies if this functionality is implemented and I just missed it.
> 
> Thanks,
> Taylor

Thanks for the suggestion - yeah, this might work.
