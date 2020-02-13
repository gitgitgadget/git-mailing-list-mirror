Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE6C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D8A218AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sldIrMFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBMR6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:58:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34197 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBMR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:58:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so3456753pfc.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G6IGiijBZN12xqv4vIAU3hlvMygNehEI/rCXELWm9BQ=;
        b=sldIrMFBol6yRoVzHQYeQspx0YbFea9OpSSWwarAasIthxeJsGB9Lnq8fedShiWikV
         yunypFYo3wJHxDezg6HyE8HczDQINRaGPWItwfcgX923DN+30q6FqNVgOzWPjTAnk6QB
         q1Fh7Gx0BKCe1UksU2T51vYl1g+x1d9No/KqsJpdRidHU3+YWeWTRrRYYPGxIo0M+/vb
         ABYH28oCDqYE0051Skn5Pml6Kk7D1xaKAb1faf5dRVn9uVzcYW4EmNUSsWH+GT9fwSCN
         kzIxhfHIH4zWq1JbY6YNSrFSPmBUTXLZXRMv3nlbdY1Qz9/dvHhcZT7Ol8rUWwXTxbHq
         y/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G6IGiijBZN12xqv4vIAU3hlvMygNehEI/rCXELWm9BQ=;
        b=dZl1Ic7I4uB2sScDpTrVEOWrdlPp5UxkgkoBtnaE5p0OQmgBMEoGL5FuhlwRdp+/jq
         0pkhzT10BTADMspaVWOAXUzwsWXJItEPoLQPcqWz0s1mN1DFLvXwT1jW+u5gBe16YmrQ
         OL7Tfqqh4sYppGlMojzl/kdYNrhBOP85j6d1hUnzqp+eRRhfgZ/sFj3Zuwxlk3Ws2L3Q
         tYupjtwhUaHFOqmk7CHyKnXwbfR3ZdEX3FVdrGqDwRdvkPPpga/Wv8srvynhdEZQxtBg
         UEt8BH7spG4lIcTeRvJJLhLsAwwhOgxo5kWLH2Tbu3J4KdQD5qMiE5EHAuUd5ugb/CJP
         iDKw==
X-Gm-Message-State: APjAAAU3suZPGveZGN0a+Z5MRuMcI3ofWJQnSuvwhHr92yAgyAUE2LyH
        rV4+mhtrwZhCBsT2EuRVmazeGg==
X-Google-Smtp-Source: APXvYqyQRIIe5ta+Uwbs4FmDLUK45haPW2Co5COjiPZ5y6Kj6pnl+2GbtiN6hstR4vs6Z0N2gyIUYg==
X-Received: by 2002:a63:7b5a:: with SMTP id k26mr16254675pgn.406.1581616724636;
        Thu, 13 Feb 2020 09:58:44 -0800 (PST)
Received: from localhost ([205.175.106.72])
        by smtp.gmail.com with ESMTPSA id o17sm3482160pjq.1.2020.02.13.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:58:44 -0800 (PST)
Date:   Thu, 13 Feb 2020 09:58:42 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200213175842.GE45518@syl.local>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
 <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
 <20200213123129.GQ10482@szeder.dev>
 <xmqqzhdmsc5s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhdmsc5s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 08:08:15AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
> > On Tue, Feb 11, 2020 at 09:47:57PM -0800, Taylor Blau wrote:
> >> In the previous commit, we introduced '--split=<no-merge|merge-all>',
> >> and alluded to the fact that '--split=merge-all' would be useful for
> >> callers who wish to always trigger a merge of an incremental chain.
> >>
> >> There is a problem with the above approach, which is that there is no
> >> way to specify to the commit-graph builtin that a caller only wants to
> >> include commits already in the graph.
> >
> > I'd like clarification on a detail here.  Is it only about not adding
> > any new commits, or about keeping all existing commits as well?  IOW,
> > do you want to:
> >
> >   - include only commits already existing in the commit-graph, without
> >     adding any new commits, but remove any commits that do not exist
> >     in the object database anymore.
> >
> > or:
> >
> >   - include _all_ commits already existing in the commit-graph, even
> >     those that don't exist anymore in the object database, without
> >     adding any new commits.
>
> FWIW, I read it as the former, but now you brought it up, it can be
> read either way.

It was intended as the former, but I share both of your feelings that it
could be read either way. I amended the commit message to clarify by
adding:

  (and haven't since been deleted from the object store)

as a parenthetical after "already in the graph...".

> Thanks for good review comments, as always.

Yes, indeed: thank very much for your thoughtful feedback.

Thanks,
Taylor
