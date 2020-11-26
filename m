Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD04C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB2520DD4
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGL7OZ51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbgKZHNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732167AbgKZHNN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 02:13:13 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B742C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 23:13:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so1449290ejm.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 23:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vmDJ3SGsMgz05+ruZ7b4qE9QySlDyCiDdBOlmDRlnEA=;
        b=nGL7OZ51OfxMT8kH3xspbwINRxb3iNWIhceQxNITYFSTMjXrRtZCWTp/Xqckt7Uz2U
         +3deEGDXPOkMg/MpjxtP4xs6wy20GhyCqofWsx43TTYsqaGYe7ZvFro1+FnNkYE88fDo
         Dss7HSr0EKrHTaij2BZdF+r92SJc5w/Y87bkLN7DMurXQPyuCwF2HR8sGrzdi2NwSfTp
         08w5kZXi51zUJSwBcB/DoNSdhv6rynE43CvnmyALj9xiMtiSgMXgJ1DvC6RtI7vrIEqn
         6H8Z0UeQSjzU9d858jlbrkwBLd5OhiAgqKdjb6d0ik/dq+hHKkusQ5Z81Ibsy/HjDXqN
         zdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vmDJ3SGsMgz05+ruZ7b4qE9QySlDyCiDdBOlmDRlnEA=;
        b=pg3CjAOGi1RiYINOHXYxKmBlgW97JISRZ/LKdW7V2IMtXsqe/oL0jS6Urtmi3gX2/q
         AVp6QsEbyU3jFcBkQCKJM9Rn5kuijQRNegmwOdq3FGSrz8wm4P7Zl0g5NJRXTwhSw9fY
         ehIBstGBQh+XwIUOGbCbdn/cd+kppK5ECwx7UEtTAN1zEG2lminLrYtYYmsMyiQlt4Ko
         v2FulnO9riLCR+y8bmFvOujA/1OthZ0UcmO4d+u3HI4XiH/eYyP+yjNaVbmfF09uuFV4
         m8GA4LIpxzqN9A3UENLH4m2+rEkRdXBOPICrL+wEtiGA0ZJVwbNYkM9eFWLc8wPQselE
         5F6Q==
X-Gm-Message-State: AOAM531FgrlpLbADpYInP46qlxZEm9BP/M5Oes55zdsXO9avm3v7ls/i
        s0ypHGFysWe5J8XozNiIKi0=
X-Google-Smtp-Source: ABdhPJxgkBljBht8WND3SQMkLjAe1TixC9w1jVJ1DXk4GAax+sIsPeDZ+Y7FIz4ZN2p54fTHvRK/qA==
X-Received: by 2002:a17:906:b851:: with SMTP id ga17mr385506ejb.386.1606374790907;
        Wed, 25 Nov 2020 23:13:10 -0800 (PST)
Received: from contrib-buster.localdomain ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id o3sm2582011edj.41.2020.11.25.23.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:13:10 -0800 (PST)
Date:   Thu, 26 Nov 2020 07:13:08 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
Message-ID: <20201126071308.5237t54bxwueummg@contrib-buster.localdomain>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cQ-iWVz2Q1PtvbV0hk_HHRFqAFjxAF2DZ6doh2RxpZJhw@mail.gmail.com>
 <20201124191407.GC8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124191407.GC8396@szeder.dev>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 08:14:07PM +0100, SZEDER Gábor wrote:
> On Tue, Nov 24, 2020 at 12:24:57PM -0500, Eric Sunshine wrote:
> > On Tue, Nov 24, 2020 at 11:45 AM Rafael Silva
> > <rafaeloliveira.cs@gmail.com> wrote:
> > > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > > @@ -441,4 +441,9 @@ test_expect_success 'register preserves existing strategy' '
> > > +test_expect_success 'run and start command fails when no git repository' '
> > > +       test_must_fail git -C /tmp/ maintenance run &&
> > > +       test_must_fail git -C /tmp/ maintenance start
> > > +'
> > 
> > I wouldn't feel comfortable relying upon existence of /tmp/.
> 
> Indeed.
> 
> > It might
> > be sufficient to do this instead:
> > 
> >     mv .git save.git &&
> >     test_when_finished "mv save.git .git" &&
> >     test_must_fail git maintenance run &&
> >     test_must_fail git maintenance start
> 
> Our test library contains the 'nongit' helper function exactly for
> this purpose:
> 
>     nongit test_must_fail git maintenance run &&
>     nongit test_must_fail git maintenance start
> 

I did not know that we have such a test helper and will definitely
change on the next revision.

Thank you. 
