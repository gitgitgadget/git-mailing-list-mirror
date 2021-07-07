Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9EC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F9661C88
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGGRKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGGRKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 13:10:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBFC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 10:08:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so2750085pfa.13
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MVbzkUboe4vFrhlC0i2whO7Ga7hfKBRajsiiiO/oCHs=;
        b=B5deYE4RsYsD6+7epave5Cf2ewC9EpHYbGfEnmVdjgT1j5MqJrNKbv/ydjHPx09hW2
         Fe8RHJvZ+QWks0E+bsWqbofrw9zR3bVVVc3Zaw7a/mUJKTnWKAKB5A0t8fxbflyfPLz4
         gw1y1fWBVvSnnQoCbinXVUXUFo4PXq6CU7fMgrotrPK+asQHhJXC9D++0G46gF4TjuW4
         VMq6Oj46nbzPkni/5PDdqTEASMEHsyDVbw5RAK0Z3+HZzegatIBDjsp/lOOh+4lbYFV1
         vVsw358IGaONSPCfuAASQmGLO/A/4u68sH7Zo7eTTwAN400KOBX1UlHbTzBDl4EqjhZA
         Z4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MVbzkUboe4vFrhlC0i2whO7Ga7hfKBRajsiiiO/oCHs=;
        b=cPQalpsR3eejwdqdWE1b+IVK/+uBRAFJE6W0PlWHzuUHubzbHvT5uwJy4P+wi6Z9I+
         zzrUFgGy7QLjW7YKvN7jj7rWEusNXOL79YkauabJFzVsF9SRODf+sigEHur2z0UeolH1
         6ZGw9nDqePsIji1S+g+97xLGKok3aPgUFeEyt2sHs2QvpNi5jGz6A4EKT0MQXTsFZddU
         QU5tQfjnlS1ELeVNVf5ZM3py2PY4DtiMbDXgz++GCmlQ0hZdxKkopJBuEafIfbIxrYuJ
         ad4meRX+2Z5NEFXnbqamw19BGDeBLZyyeueYY/HYJ2Y64Q3vB6fZVsmzIOqg/C6oVMQX
         s8hw==
X-Gm-Message-State: AOAM530rau7QORlJ5yW+/Ay3KLxWDIVAJYwX7MtZ1kUz2P37CM+dx0Wi
        mFcT71uXDnamTkyK2Nlu/SY=
X-Google-Smtp-Source: ABdhPJxog1WEpSrk83cLiWkiSZTg4doC7bGejDMAabQeoHenETib+3Wz+YaQHSsY9RZ5pnNL8VLpmg==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr26229213pfz.58.1625677684688;
        Wed, 07 Jul 2021 10:08:04 -0700 (PDT)
Received: from localhost ([2402:800:63b8:9039:443b:57cf:40b5:f8d1])
        by smtp.gmail.com with ESMTPSA id ck22sm18770749pjb.26.2021.07.07.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:08:03 -0700 (PDT)
Date:   Thu, 8 Jul 2021 00:08:01 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Professor Bloodstone <prof.bloodstone@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-am changes author if its short
Message-ID: <YOXfcbxtE577xHLb@danh.dev>
References: <CABHhMZHEL=0sU8JqwMb5Va7mjA4ZxM_WMaLMabbKS085RVbDzQ@mail.gmail.com>
 <YOXesxUQW9zRX4uV@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YOXesxUQW9zRX4uV@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-08 00:04:51+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2021-07-07 18:46:53+0200, Professor Bloodstone <prof.bloodstone@gmail.com> wrote:
> > When applying a patch using git am test.patch, if author consists of 1
> > or 2 letters, then it is being replaced with author email instead.
> > 
> > For example take patch with such line:
> > 
> > From: AA <git@bloodstone.dev>
> > 
> > Upon applying such patch, the author is replaced with email:
> > 
> > Author: git@bloodstone.dev <git@bloodstone.dev>
> > 
> > I did try multiple different 1 or 2 letter names, they all seem to
> > have the same issue. 3 letter names work fine. This was tested by 3
> > people in our project, and happens in very different setups.
> > 
> > I'm having a hard time finding the exact cause of it. Tried searching
> > for issues, but didn't find anything. Maybe someone has an idea what
> > could it be caused by?
> 
> A patch for this problem has been merged [1]. Git 2.32.0 should have
> this problem fixed.

Sorry, I have this email sent too fast. It's being queued for 2.33.0

> 
> 1: https://lore.kernel.org/git/xmqq4kf25lso.fsf@gitster.g/
> 
> -- 
> Danh

-- 
Danh
