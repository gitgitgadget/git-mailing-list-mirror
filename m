Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53AEC2BB1D
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FF52074F
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 13:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/njQMWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgDGN4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:56:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38326 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbgDGN4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 09:56:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id 13so796274qtt.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EawYT+L94iQ3aHvJ7r8ogDLh/jiDkpqLP7TkfQp54lo=;
        b=m/njQMWA5NJsJS/6tYVDp8FGjdtqmT3eApORSe4zJ+jdATBYUUy0lZf/5PzsMSSn6A
         QV745ld4mPyf2Fvlk5bHmN1U4c2pjfkUPbsislMjqgJTqwWdaFEsAm8FXh80fUhwAvGp
         qQC29q7Q5Be0EV1ZQBJ4HElFbo8YYz0FWq8hQGGX87tqzVouiZCby5p/FqYdD1fya9zg
         +/e9Inp4vfLNmOazUx5iBA02kmi0DSgJk2rouyZDhK11ig9RoosLg6ul4ylEeexq/8kH
         /n0lexVL2RK5DyOhU8nQdU/AFJyhWuGb2a384NFcAXfATmk3VfcohBM/kv5S3GIckctd
         e63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EawYT+L94iQ3aHvJ7r8ogDLh/jiDkpqLP7TkfQp54lo=;
        b=GcohgLmlk+5w974T1q5bjGWaQKrZQr/cggor21ExKgM/IOZswCkVBP6KoXTt5jNrwv
         ORaqhsbqyC2dnYL0FvX8RxMBsB13m6m0F+Ez0uwHEZ/GTz6hczYBn/SyHSkaudNArWpD
         T3oIOZOKRisctY3G/VKpFFp7i+8IjZF5OnrujWslcKDwoDfb7VFRIK6aALDR1v4epy8C
         2F4e0r0k21oEtQbpa6VVqI9t5xF8UIHgzaBx0WObca0L6lH4q55hvZtXBehWwWsqXPL4
         pWU1sViqOywDjhD5NO3dz1WrERP9hKVrdmcgnau0fZ9tcdR/JZBUWOaJJ3/Ygpv5dV40
         48aA==
X-Gm-Message-State: AGi0PuZVCSmnQABprGWchLp2nr9ZOIdwjrjvXtyBIVPKUaPnlmCEU/cs
        nJYDNKoJZ4i+Q3uypLPW+FE=
X-Google-Smtp-Source: APiQypLaG+8BrRV2r/r+MvZMIKxzMxFhnoZKj9CZsZ00FwgjJUJudzjKwIgWnk7/7kY+J5hoDeGjUA==
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr2353630qtu.336.1586267775764;
        Tue, 07 Apr 2020 06:56:15 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j2sm10373440qth.57.2020.04.07.06.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 06:56:14 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:56:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 04/23] sequencer: reuse strbuf_trim() in
 read_oneliner()
Message-ID: <20200407135611.GB2503067@generichostname>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <c7a3cfa20005aeeedc27d2eb4af1e2c4470ad73d.1585962672.git.liu.denton@gmail.com>
 <4e04fd90-bb71-0d7e-e611-5c408161d3e5@gmail.com>
 <1c382358-08ca-8bf8-cbd6-d00406472bcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c382358-08ca-8bf8-cbd6-d00406472bcd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, Apr 06, 2020 at 03:42:59PM +0100, Phillip Wood wrote:
> Hi Denton
> 
> On 06/04/2020 15:03, Phillip Wood wrote:
> > Hi Denton
> > 
> > On 04/04/2020 02:11, Denton Liu wrote:
> > > In the original read_oneliner() logic, we duplicated the logic for
> > > strbuf_trim_trailing_newline() with one exception: instead of preventing
> > > buffer accesses below index 0, it would prevent buffer accesses below
> > > index `orig_len`. Although this is correct, it isn't worth having the
> > > duplicated logic around.
> > > 
> > > Reset `buf` before using it then replace the trimming logic with
> > > strbuf_trim().
> > 
> > I should have picked up on this before but this changes the semantics of
> > the function as it strips all whitespace from the start and end of the
> > strbuf. Above you talked about using strbuf_trim_trailing_newline()
> > instead which would not change the semantics of this function. You could
> > test to see if we've read anything and only call
> > strbuf_trim_trailing_newline() in that case without messing with
> > strbuf_reset(). (there is a corner case where if the buffer ends with
> > '\r' when the function is called and it reads a single '\n' then the
> > '\r' would be stripped as well but I think that is unlikely to happen in
> > the wild)
> 
> I'd also be fine with dropping this patch and leaving the trimming code as
> is

Yeah, I'll just drop this patch. I don't think it's worth holding up the
rest of the series on this small detail. I'll probably try to resurrect
this at a later time.

Thanks,

Denton

> Best Wishes
> 
> Phillip
