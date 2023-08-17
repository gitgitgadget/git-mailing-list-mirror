Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B92C3DA6F
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 18:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354447AbjHQSev (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 14:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354434AbjHQSeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 14:34:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685022D7D
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:34:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bc73a2b0easo1043405ad.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692297259; x=1692902059;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7k4KlEYbpc6S0tHyov7rlgIXxHKXO8wioyOsVFOEq5Q=;
        b=JcEsQ/Fyw8Mom8Rl9fNVrD1aBHK5UpAmaVal5kejcrBodAUiMWqFA0uINMtoUgY2+5
         8lOPz4E8YK5plYiHk69QOJoqJGS/IhvsuVt7zlc6TFvhc1gJntF4iB68vVfDUDnTDdMU
         dYqPB8DUEGtLFKlBeR47NIhvOFQ/MF6m9gdF90jSYdYnzbKNqc1x+SynRbqEo9BsfjYP
         hDnZsEmPxb9QFODtwNqKugljRpIUrLcb86xeyQOyy5m7gFAtjVFYX5Y+vN8PjkdquJZv
         Lt/aMJGv1Wh8yX3iJQd2xuMZrHyWJJNITuZ0csfkFCfG+PBD3BRYs4OKpr/UbXtNjTye
         E+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297259; x=1692902059;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k4KlEYbpc6S0tHyov7rlgIXxHKXO8wioyOsVFOEq5Q=;
        b=Q0Akr3VFprpa32SWwmoaDPvHX/dWaAQKRb8z4s3JTy+Spf7WKwF9an5tXmW1I8jDcM
         MjbtVPUhWH+QHTRZowvUHZsLv25l/gRQJvzV70IOo/7Rl+b8dtnlxyyTaRwl697cO3MG
         5x7Uy00hqBTqjl/78z7Ee6smrsIryypFOylT88MP5GIm7lOCjwu8V0uGOaoiN/LHQBqE
         nvJxV4T7gGlyWLn2yKyk3CxIK4ivTmQO6RbnGZyZsfUIoIFwLgHITTrNkK0UrHz9cljF
         i4KA6E3ernWq/rhY4Ul4Rvy4v5s/nOPpIQByslcX2LoEc/tgHgU1706vuqp/3rvJj4E6
         BRxw==
X-Gm-Message-State: AOJu0Yyn82R0r+sIhmZBCwb8VZCpvzCr6dFKUoOZ5WhiDqs13B7u0NoQ
        L9JHCy2of2uecMKOfUkwc1wVm3T8rgPKE19smQH9FA==
X-Google-Smtp-Source: AGHT+IFQV9KLK+2v0kwiBoHvF4Z3rsn/v1JUmtkqw3j+0kQsSo1tYTyhCmnq1XkxTNav/CMnQ1z+mQ==
X-Received: by 2002:a17:902:e88f:b0:1b9:f7dc:b4f6 with SMTP id w15-20020a170902e88f00b001b9f7dcb4f6mr227633plg.44.1692297258727;
        Thu, 17 Aug 2023 11:34:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e60a:f80e:4b7a:6509])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b89a6164desm92454pld.118.2023.08.17.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:34:18 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:34:12 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        phillip.wood123@gmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/3] unit tests: add TAP unit test framework
Message-ID: <ZN5oJM0B0DWohw64@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692229626.git.steadmon@google.com>
 <ca284c575ece0aee7149641d5fb1977ccd7e7873.1692229626.git.steadmon@google.com>
 <xmqqpm3mcyrc.fsf@gitster.g>
 <xmqqleeacxfj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqleeacxfj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.16 17:41, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >> diff --git a/Makefile b/Makefile
> >> index e440728c24..4016da6e39 100644
> >>
> >> --- a/Makefile
> >> +++ b/Makefile
> >
> > With that blank line, I seem to be getting
> >
> >     Applying: unit tests: add TAP unit test framework
> >     error: patch with only garbage at line 3
> >     Patch failed at 0002 unit tests: add TAP unit test framework	
> >
> > And with that blank line removed, I seem to then get
> >
> >     Applying: unit tests: add TAP unit test framework
> >     error: patch failed: Makefile:682
> >     error: Makefile: patch does not apply
> >     error: patch failed: t/Makefile:41
> >     error: t/Makefile: patch does not apply
> >
> > This is on top of "The fifth batch", the commit your cover letter
> > refers to as the base of the series, so I am puzzled...
> 
> Well, I suspected that 2/3 comes from
> https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/
> which itself is whitespace damaged but has a reference to the
> unit-tests branch of https://github.com/phillipwood/git repository.
> 
> But it seems to be different in subtle ways.
> 
> Please send a set of patches that can be applied cleanly (especially
> when it is not an RFC series).
> 
> Thanks.

Sorry about the noise; I'm not sure how but the patch 2 commit message
got a partial diff pasted in. I've fixed this in v7 which I'll send
shortly.
