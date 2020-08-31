Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EA5C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA30320866
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 18:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jo1DqsXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHaSFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHaSFo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 14:05:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B56C061573
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 11:05:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f18so1003382pfa.10
        for <git@vger.kernel.org>; Mon, 31 Aug 2020 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rznkEpMMLUi3Z+NFiIvRWKUZyxh1dllZSPrbCGZoFzs=;
        b=jo1DqsXxGa7nzJmV0KVR68KRT49TjI0bPH1YnrcSVtOjO7FvTx4JHccHtaCqGZCqZl
         89JhfONe9KHyP5SXft2ueEvBfbiNQury/aV8p9a/q4xlGSuIQ9krnAenb6p509sDoRG4
         qh3zZiI8nMmyRWY7E6cY1U3V7mEAb7h41NOr6MMsrLIaZBIMgDDwjjtJ45EEZTuXLJwh
         a969wMBQmTZ6Wbdylx20wbAEs6IY2eRMCZnw/UcjwJ1GOeCpQ4NkzDgAlDyAddItSTKb
         4AM86hhjGuLvhM+Q+TrfPTplUJ3f+Pe0PYgZJKzYwituEkWDPvwKdIN+DxCd9i8CrRK+
         Fp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rznkEpMMLUi3Z+NFiIvRWKUZyxh1dllZSPrbCGZoFzs=;
        b=HZlH6oJ28yYV4OfO/3WryyPLHGUtYWF3+PsfEzG4W2ElJ9Ud+dEZFBsFv0eF7kjANs
         q3D2P8GscIiCqit5al3kVYwqR98JaRHRq+uwrPFnIzoK3csPIujLDw2bIy/LW+7VQ7R7
         HT/i5p5AwKJAfKAz3QAXFp+KKeYkmCZA5r3n4J/OTuUk/iyAjr9N0c6rTWYWzmRVv9aQ
         Jd+RRYl+dihEANLrOoH3b/f6QVq9Jnx1I3e/qa/9G7LfHwGOrdIoqxoTM7LJACqwA7sE
         wQeqsqa1iJ6Ip5/KDIKn5yJpsfJHSHhAXEmcU8+mXrTZ3VTvv9oGTDOBhdOO62pRYQ89
         ox6g==
X-Gm-Message-State: AOAM531B7OVrpXMje/XZzj7Zz8nXkk2ztdxH3diEdOMSnCRCduNOFSMR
        vu8ZpODlIpd+/OSCHlwBr4CwZO9xK6h22g==
X-Google-Smtp-Source: ABdhPJyGJMEqz3skrn3KrPGphnXs8UG3kxjPH2Tmwu3rSE1b1l1aA9Mg2qb1CTdNiVzrAd5UXP9B+A==
X-Received: by 2002:a65:52c5:: with SMTP id z5mr2175896pgp.105.1598897142379;
        Mon, 31 Aug 2020 11:05:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id m190sm8439799pfm.184.2020.08.31.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:05:41 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:05:37 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200831180537.GC331156@google.com>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828065609.GA2105118@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 02:56:09AM -0400, Jeff King wrote:
> 
> Are we interested in participating in the December 2020 round of
> Outreachy? The community application period is now open.
> 
> I can look into lining up funding, but we'd also need:
> 
>   - volunteers to act as mentors

I'm interested in mentoring or co-mentoring this term. (I'm not working
this week but I didn't want to miss a deadline to volunteer.)

> 
>   - updates to our applicant materials (proposed projects, but also
>     microproject / patch suggestions)

One thought I had was whether it might be cool to shop for another
co-mentor from Wireshark and have an intern teach Wireshark how to
decipher Git protocol. But it seems large, and maybe last-minute for
this term.

 - Emily
