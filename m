Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7202C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C6420857
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekdMVrRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404216AbgKXTOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbgKXTON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:14:13 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE786C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:14:10 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id k9so15284671ejc.11
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uabUEFHMRsSHzaaDR/e4sRuFk8m3FAGDTinSeCcfVn0=;
        b=ekdMVrRyp0JgjPUyrHvDb9geqrgneI5jCsvBUaPsk9S7KynsnMdAZAg4U4eNnJrlYx
         8jwDEV5EIPxTDIJxyHR1tX0t+quzaVgYoMMAnYrpfywp4G+mMO9TdSlavET7C0O4Rvse
         bjtGFMkWazIN+/BGpVks379Y+1O+FQTKUpM0zZXh4mmOM5mPcpe+TmKG60H2YycUvwt1
         +UIfXWi6Rlskc7H4nBkX3V0OdMRKFY7uTWcB340rT3gicB4DxHxe9Zcx57Os4XZhsmPb
         8VQgoRHquracCdjlQUFeFde8DHKHFPfhZIrmPpDlOEZDXvFae8QB+Gt3VR5ZmrXv1FnE
         hLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uabUEFHMRsSHzaaDR/e4sRuFk8m3FAGDTinSeCcfVn0=;
        b=DYFSv9IEnpNTmm/yCn5ODM2zaDvnJrR2T2bGA+sYg/F1yFK+Ukt2lSEHNZi3DIfD0s
         B7dqzzI4gS+64eW57gcAmbh3QcU3EkE9+Kls7XqwiyUHd6OgXdwEO3mzvVXGhtQB+jr9
         LmXw9gF+2OXcvdDqc1at78H6BI2LvqahMniVeKsB2je7fL3mq2japhL/UQ2xHyTvtd6J
         n4sQWLVzdDeF2MT9DuuY8u3zWQg4+xwtGJV5sIt1sdFKJY0N7esMblmtYIbYYS+1W05R
         5ThPvMjO7hcNjrzi3u1/PBbcR72NdKpOmHd5wYRF8Gfh5X6+NTLoW/JCvN8KkEksdtBL
         EssQ==
X-Gm-Message-State: AOAM5338plvtVzY7gWGwT786aUjD98hFOjnPUI9rKZPwmH43vJT9uNOA
        WdaGHwu5STmsnVqfeQ0YxCA=
X-Google-Smtp-Source: ABdhPJyVE80AYVkIPvcXLNKFqWEnM+VkGrQmh/fVMA/eob7B5xGrvJ/FVuaFs2wbkL2UhDm1qf0KWA==
X-Received: by 2002:a17:906:68c4:: with SMTP id y4mr4665473ejr.332.1606245249496;
        Tue, 24 Nov 2020 11:14:09 -0800 (PST)
Received: from szeder.dev (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id b2sm7560440edr.25.2020.11.24.11.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:14:08 -0800 (PST)
Date:   Tue, 24 Nov 2020 20:14:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
Message-ID: <20201124191407.GC8396@szeder.dev>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cQ-iWVz2Q1PtvbV0hk_HHRFqAFjxAF2DZ6doh2RxpZJhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ-iWVz2Q1PtvbV0hk_HHRFqAFjxAF2DZ6doh2RxpZJhw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 12:24:57PM -0500, Eric Sunshine wrote:
> On Tue, Nov 24, 2020 at 11:45 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > @@ -441,4 +441,9 @@ test_expect_success 'register preserves existing strategy' '
> > +test_expect_success 'run and start command fails when no git repository' '
> > +       test_must_fail git -C /tmp/ maintenance run &&
> > +       test_must_fail git -C /tmp/ maintenance start
> > +'
> 
> I wouldn't feel comfortable relying upon existence of /tmp/.

Indeed.

> It might
> be sufficient to do this instead:
> 
>     mv .git save.git &&
>     test_when_finished "mv save.git .git" &&
>     test_must_fail git maintenance run &&
>     test_must_fail git maintenance start

Our test library contains the 'nongit' helper function exactly for
this purpose:

    nongit test_must_fail git maintenance run &&
    nongit test_must_fail git maintenance start

