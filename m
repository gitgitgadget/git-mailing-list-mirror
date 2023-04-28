Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D363C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 17:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbjD1RCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346436AbjD1RCL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 13:02:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4C5588
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:01:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5191796a483so27349a12.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682701318; x=1685293318;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85u91gTJfiSbfFp0huhfFFl4Zsqn7jCnNzHREwjBZ0U=;
        b=y+IkoBR9xrBEqPafkRsYlfsPuqJhL0/YMfZyMaQtwqaOhvPnwUOob43ILR3WK0FF30
         ZxIly0AE1i0J1HenHiLCqeS0itX/rRIpwcrLcTXO56fQtmSEBVzjYDq1XyFumBe/zhJR
         3Mh9DHSM14EMpWtAZ7S8gG1gSFqgqQfjDjaVJqv/8fwF9cP+fVIE0oG19it8yLgiNgik
         Y4zJ9GDk8qyoYbrw6LNdQHcWwV7xyc7rlLynzYR/pD/kvvXu6G+hCPpMx9d3K8lpRm0c
         Kg2HeYF/MNVHCD4N3nR1SVvwEXvXs9KTltixV9YWunOhoxUen6xvcSJEcZwsGswxOaM8
         vlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682701318; x=1685293318;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85u91gTJfiSbfFp0huhfFFl4Zsqn7jCnNzHREwjBZ0U=;
        b=JOAwVYnvViyAjxEuW5+2Xv9007BHP+BzO5esm1aADkOBD2yGGx5V48UfU4vj6f9RKZ
         TI0esT1GCDjzsKKzoUjoahbyCzzwBygZA9plJ9x6s7yb/x/2JT3fxhJrr11N8PHDIT+n
         pJTSRPbMadkKrgdUCPL6Q1DLwCmAsLcu+l+7y/ZJjrDBggCJ2Mzas6f+0OIJs7HKnmyj
         I1cTjKi/ulIhs7Gagh6wy3SkBZl0WfIFFLhtafhCTlOfH39PdJTPM2Ode71Xg+Fv3Bv6
         Iar0HspmaieOwV+86ADfhxt+42yh0QsRPIswqEjCyx5UCePLKa5rq2vmQ+c8+Jkn1/79
         rTRQ==
X-Gm-Message-State: AC+VfDxFrHgmpw0AgRj93DncTF06rNgEjhqk1Pe7JdZp+wGYg8PlHRcP
        sHri+a5ZI/wdqruO0ytDwLKautSsSIKdLa8VolWJ5w==
X-Google-Smtp-Source: ACHHUZ6Y7qOwjp0Xp7LjaqVWdymv5LsJm6TNQ4JnitJddsDtAuGQ0GjyDUY8a+hj8gbFjSUeC0WOgw==
X-Received: by 2002:a17:90a:8c03:b0:247:6eda:a2ae with SMTP id a3-20020a17090a8c0300b002476edaa2aemr5696744pjo.32.1682701318456;
        Fri, 28 Apr 2023 10:01:58 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:d2c3:4cc2:f9f7:57a9])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090b050500b0024749e7321bsm1692979pjz.6.2023.04.28.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:01:57 -0700 (PDT)
Date:   Fri, 28 Apr 2023 10:01:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
Message-ID: <ZEv8AcxQW7B2H8uJ@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <xmqqttx1gcmr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqttx1gcmr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.04.27 15:54, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > @@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
> >  '
> >  
> >  test_expect_success 'safe.bareRepository unset' '
> > -	expect_accepted -C outer-repo/bare-repo
> > +	expect_accepted_implicit -C outer-repo/bare-repo
> >  '
> 
> Perhaps futureproof this test piece by explicitly unsetting the
> variable before starting the test?  That way, this piece will not be
> broken even if earlier tests gets modified to set some value to
> safe.bareRepository in the future.

Actually, explicitly setting the variable here is equivalent to the
following test case, so I'll just remove this one.
