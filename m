Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAAAC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA725357
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 17:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Bw3k/2n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgJMR2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 13:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgJMR2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 13:28:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D9C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:28:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w17so897530ilg.8
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtJFrk1uTWoLaC9UxZSr9tnibIY1x9JAnWWxUpdq1zI=;
        b=Bw3k/2n3MYCSIxjZrqrg+jKtyqBz7At6ybSyShE0NhQ4Fej+95cTuPacg1ErmEyuv8
         XBKxJFo68hkonbCITTs6PDFV732rMhsCoGVb9S11/OW4lMKRYW6LinQK/J7okp36c4LV
         KE97qr6eUP9Izgwv+gNl83F8akwyh0Z+pCxAPJsusNpPxQEA2nFFw07VKr25ggtQF6gb
         cJvt5HIRyLekBOJ+U5KdiYidntJdsFw4gVWV6jXRcpyX7vUz3op1dLFLinD8lACgHXbN
         3gt264iEOmgO2O3O1Y7q2XZ6ia5A9Bz/gKC4q39jS3juKuk53ZnZ6F8dxBiwQl7PGXMU
         f26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtJFrk1uTWoLaC9UxZSr9tnibIY1x9JAnWWxUpdq1zI=;
        b=rr1uzYD6xNDQETRnS2fA/TQB/WTsBRFRdj/IqmL4tKKxFZbZpTwMNlpdPN45+vHkJT
         mh3cMznbUOd+ElwomQFY2IIXcnTqH4gBVJ+CRP99FINM4Ur6s5JW9aIzilMj77O5AWJn
         QiJErwh4kc9vNrawIBen4V6usOjkqE1mBAu59gYdi1Bpe9FJ8XLxhmkREzOMzAotwtUK
         475dFYoZ5xtLW/WH2A++Nf6Vk3j7fuA43+x1rx3TwQooSSwIIWvZbDUWJiYHFTp7Odwn
         JuFr3LAW6vmFr+uR+EuZCz+gIir9PkBciYTlDaDHsi6sSAfi8pJBt3QafRMFyD1FMSj6
         AiNg==
X-Gm-Message-State: AOAM5315ID2EwhC6IxXjN731PMy6ZVTEoFd8dwitP1EqRGkqi6+mcX/B
        JemIh5xg/T2ht0Sq/cUmx+cz2w==
X-Google-Smtp-Source: ABdhPJwcdjdSoO5ioxX3amWFixAQLRfAQOkDcNPwqUWHpaL7Izxp3nxVcf2AasHQ+xMIKoI9g4MUBw==
X-Received: by 2002:a05:6e02:962:: with SMTP id q2mr881029ilt.290.1602610118271;
        Tue, 13 Oct 2020 10:28:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a4a8:cfa:3aeb:51fa])
        by smtp.gmail.com with ESMTPSA id r4sm492604ilc.32.2020.10.13.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:28:37 -0700 (PDT)
Date:   Tue, 13 Oct 2020 13:28:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] test-lib: allow selecting tests by substring/regex
 with --run
Message-ID: <20201013172835.GA1917721@nand.local>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <46fce3a844c90b4078578f5aa2058bd6825af1d6.1602545164.git.gitgitgadget@gmail.com>
 <20201013153901.GA1913367@nand.local>
 <CABPp-BF4bqNXGusoUgzKUTecaR9bzXJbVODGVB2kqX5qTp2Fug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF4bqNXGusoUgzKUTecaR9bzXJbVODGVB2kqX5qTp2Fug@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 10:23:32AM -0700, Elijah Newren wrote:
> On Tue, Oct 13, 2020 at 8:39 AM Taylor Blau <me@ttaylorr.com> wrote:
> > This piece of documentation looks to be now out of date; it mentions a
> > "test or range of tests", but that only covers a two of the now four
> > ways to describe a test.
>
> Personally, I had read "test or range of tests" as general enough to
> cover all the cases (I would have agreed that "test *number* or range
> of tests" would sound out of date), and just left it.  However, if
> there's something clearer, I'm happy to adopt it.  Do you have an
> alternate wording suggestion?

Maybe "test selectors"? You could even say something like "test
selectors (e.g., the test number, a range, a substring/regular
expression)". I don't know, though; I don't feel strongly about it.

Thanks,
Taylor
