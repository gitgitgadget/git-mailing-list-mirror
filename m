Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF067C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FCC20719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 19:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrtuVkRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbgJBTmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBTmv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 15:42:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B787C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 12:42:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gm14so1541736pjb.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3azY7XqW6ux5WqutMPcQQQGDSgJVCb+gjTXnEGrmizc=;
        b=qrtuVkROYiR8Bzgzg08AbDaCQS47elBjnV4cDtSwVhgwh+Z278fSDX2sRxAtpfGzXn
         lGxuo9m7Tefa7f5mKlh3ozMI3ZcGKHJsYHJKEEMnyI51cW+CyyD1G/SLai6WEOhDCd69
         IjjW1Js7pI215YwcUZONzt0CY3vWES8KsRuusxvdhEXL74OxLKCYln6ez8Gxfmso6BQE
         oZNhd8qNNsPLHehqx51bF0h6ZOtOzQQfC1+TMezcVAWtTwRfwSitVXk8uAaa5ehKG6sR
         TjEGZqG91nXXhd/frzx1/DiXc8ry27VWQhKLjOSyXKPHsN7bZKwb0MZLhTw0JNUKeWgh
         F4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3azY7XqW6ux5WqutMPcQQQGDSgJVCb+gjTXnEGrmizc=;
        b=S8A412Tmw4VVZvs41cilemja2bMJI022S81iiYLcaj4x6ROmJ/8ZQgZjAxnRac9ZVP
         LuWdgYXxSYZO+fnu2hUkNtLnaOT0JgPtrOuwmFSW7v9t/YmQyQ8NBHG9/ho8GkFZL+33
         xugfEt3236uFW+DF6l3BxkKYODIEmwZgC21rC72HWFVC3Yl7BQEmW3ObNjhPHM72dghX
         CNz9gaUFhiqjrV+ZHI4X9a32pHwT/iLZDiDDjJ86A6WjjK1sqUOe6LlI9SwigIN2YiLT
         MA7Q4vtaSfX+Ldu7o0oihUTIVw1t5kkZtPmJrJ+Fw2eY6YPqNLOyAWTrFC16Qd5RUHYg
         SrBQ==
X-Gm-Message-State: AOAM532uFmCni38LliDxwULe6Hoqho4l+qeElTKTns7CrHb7C9V83ewr
        0dI+D6EMQMJBH6ig1QXGDVg=
X-Google-Smtp-Source: ABdhPJyoThbMJUf2Pb29zqND/xYIwf8ft9HwdqfBZ0yViSGBivk0CwoYJbm1zpWYtVWeXF2pCkVo/w==
X-Received: by 2002:a17:90a:6984:: with SMTP id s4mr3043063pjj.206.1601667770747;
        Fri, 02 Oct 2020 12:42:50 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id h9sm2277681pfh.213.2020.10.02.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:42:49 -0700 (PDT)
Date:   Sat, 3 Oct 2020 01:12:44 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
Message-ID: <20201002194244.GB78209@mail.clickyotomy.dev>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
 <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
 <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
 <xmqq4knddg5v.fsf@gitster.c.googlers.com>
 <20201001175443.GA28444@mail.clickyotomy.dev>
 <xmqqblhka7wx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblhka7wx.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 10/02/2020 09:50, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > I didn't want want to cause a delay with this patch. Since the new
> > option was seemingly working without it,...
> 
> It is a good example to help other new contributors to understand an
> important point in how the development in common works, so let me
> say this.
> 
> I did very much wanted to keep the bug exposed at least to the test
> suite.  Since the broken helper were designed to be used in many
> other places in the code, and we had a simple reproduction recipe in
> this topic, using it as an opening to help debug and fix bugs in the
> broken helper had higher priority than adding the "--force-if-includes"
> feature.
> 
> We help the contributors who have been involved in the broken helper
> by delaying this topic a bit and leaving the reproduction readily
> available to them, so that they help us who are working on a piece
> of code that wants to see the broken helper fixed.  
> 
> That way everybody benefits.
> 
> It's not like a corporate development where your interest lies in
> shipping your piece regardless of the work done by other teams,
> where it might serve you better by using the second best tool for
> the task, to avoid the tool that ought to be best but does not work
> well *and* you do not want to help the team that manages that best
> tool, even if helping them may benefit the whole organization.
> 
> So, let's play well together.  Yield a bit to help others and let
> others also help you.
> 
> Thanks.

Thank you for pointing this out. You're right; I should not have
rushed to disabling the feature because it wasn't working with my
patch instead of waiting for the issue to be investigated. This is
valuable advice, and I will keep this in mind when making future
contributions.

Thanks.
-- 
Srinidhi Kaushik
