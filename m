Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082EEC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD25461354
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhENA7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbhENA73 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 20:59:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F9C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 17:58:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h20so15278071plr.4
        for <git@vger.kernel.org>; Thu, 13 May 2021 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjbGsZuMz/cMUGROFfLQZmUJ3OXk7aAnwBcXGG+64iM=;
        b=eci0wYJlKHuPDeoxWsN+qJoQ7S7qYTsCptEBOX8dIxKFxInq7JvOdSJe3KztJHBpQH
         FMKy0PdEMvX/Yl6KFTJyjJYzHVdfhgo7Pf6P1615Kh7olfUrYZjWMVkIE4joAT0nMv1q
         ZTBD9uOgQcqxHLee2osYF0r34x2Fr4gQxF5/ocC7mkSEUmXMkzlJAy1AGykCqjZwBPDv
         Qn8StNZ4M2laCwi7/gu/Sp3JW/7/BHsQ6Wy7uHfwsf1xuiIPUFhU5RXr0a29LFykoMkr
         GlQu24hTEmrOs9rRiO589ICD1jiogFUEdbxUQq8mejkfQQbmpWfDKyOiErkj0Qqn7WkG
         9B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjbGsZuMz/cMUGROFfLQZmUJ3OXk7aAnwBcXGG+64iM=;
        b=szQPVXSjJgI1zgOCgS3NzHte55m+rX+b9W2MMdCBnovHS/JzVgpGEpP3t1AqwPJyuY
         XA7FtqXKTiw6SbKXmxYc9JhS8Pc09L0Fyj39llvpotEvJo5wpb5iWMes0UeK6qKy5qbX
         NHcJVeHM/EqLxVJfVSMqD9gZXv1oFOqJO0SrpMGEzqJ1S9lkSe8QNpXmlfoO+WRSxY17
         Y7lQqPPjS0HNMX9vcN/WTW9TnsJ2eTm/oH8Er5iBr9mRpR0oEYgWuk0hCjysCgh8XzXm
         t8SdTOeEOaMbM0329EkDUMP6TuB4RJONKCJTy4sjNKYzZ7y6r9VE/4dS11LZXdsiNWkk
         beFw==
X-Gm-Message-State: AOAM531kN05YSftR7cwMXmHF0OAJTEM+pCe+mzArZv7NG1zB33d3iV+H
        dxDZmaXtKLDwFnOhTaC8vEEt/TDv0RIvaQ==
X-Google-Smtp-Source: ABdhPJwxfJo5hCTGNGCzw+xk5uGY0IEl6klvhYzD30zHH2okRyaXoJkoRI1wVkIDCjRumpmtAvprHw==
X-Received: by 2002:a17:902:8c91:b029:ef:aa9a:af35 with SMTP id t17-20020a1709028c91b02900efaa9aaf35mr3147833plo.24.1620953898860;
        Thu, 13 May 2021 17:58:18 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id x10sm2958641pfp.177.2021.05.13.17.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 17:58:18 -0700 (PDT)
Date:   Fri, 14 May 2021 07:58:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
Message-ID: <YJ3LJ++lsAuSkCUJ@danh.dev>
References: <87r1iakbyn.fsf@osv.gnss.ru>
 <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-13 18:49:03-0600, Alex Henrie <alexhenrie24@gmail.com> wrote:
> On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wrote:
> >
> > Hello,
> >
> > Is there a way to specify additional options for "git rebase" when it's
> > invoked via:
> >
> >   git pull --rebase
> >
> > ? What if rebase is used implicitly due to "pull.rebase" being set
> > accordingly?
> >
> > In particular, I'd like to be able to:
> >
> >   git pull --rebase --no-fork-point
> >
> > but it doesn't work.
> 
> It would be cumbersome, but you could run `git config rebase.forkPoint
> false` before pulling and `git config rebase.forkPoint true` after.

Or, for this *specific* case:

	git -c rebase.forkpoint=false pull --rebase

-- 
Danh
