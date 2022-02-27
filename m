Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25800C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiB0WGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 17:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiB0WGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 17:06:03 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB26C909
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:05:26 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id t22so11136935vsa.4
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LskwUhD5NRuOqvEdcxttyGZHwEgG7mFh45ITeP/HyU=;
        b=czm5os7xGdQuMhidyH9RiUJEznxpr7ikRTtpRqCeiBoxWUycPa3ehjWsV0lA0N7/mm
         LvyCV2eCxNMlFM3uVDV/W5lS32GJDVEL1xoxCB2bNfBIjNl+dyXy7jUmhvmVXuaQzWdZ
         9PKuVVU6+3j67nd29+3CGpPnvcCahUZR4lf5yTebTVrVks3H5zXM2f1Zyt9iftkvwZgJ
         vgwItI9bH4odfvuSGj4nB75bEsKR62VyTsBcRx9/XdPWMErsMTqsVFxJnKDnWnjWU68F
         xNkoF3TMfYCqpktKr+MLhKxN2xUvhlaTwZze9PWIIKcwjiATGFZaSKwoAqbbZqOa3Uly
         BoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LskwUhD5NRuOqvEdcxttyGZHwEgG7mFh45ITeP/HyU=;
        b=SHuRyf+9yrpbPqpHzR8c3xDseE2lp8qjyOmR9QvhyDZoCnI68anugDO9qhyL9txxpG
         mV68Ul5PiSqVmGQnDFAKGs5gzZayZRLzGn3cOKwqM27wrzKObzb3i12O1YkmgNbutxdd
         kFrSKzGyRdWtMOhH8MjkYFiDdcBNTWDHG9HVVZbPSwWFoN64Uk4aDqYZrmQqA4ARhlB0
         mMK66gdCqZIdogORzuQ+P1eIHFJFwOumrc00W8YwUTNV6UvV0XMDkT9LsbzHIbjcnZOs
         PIswk1KoUoNHyxC9CJA8RNRxjObKvIPCcizzf2FmnocCnOHxHTKlElu3T8sypAW4dhZ8
         Ax9Q==
X-Gm-Message-State: AOAM533LZ4l9zyPOLhfBoAfFJHWlfFASsDhF6H5d3cLgnPfL0nQpm74n
        0/UyIY4jZHA28QIirEsGEjJ8IVsztuniygxhOVw=
X-Google-Smtp-Source: ABdhPJyy8aIf9QCXJ76UXAmkiDr9sFSVbguaII2TYFV/qiiMXr+CZU8DUOXthlJrXubuF0PUF9TvLtbNV1OvyunYXzY=
X-Received: by 2002:a05:6102:5715:b0:31a:511d:886a with SMTP id
 dg21-20020a056102571500b0031a511d886amr6554923vsb.72.1645999525045; Sun, 27
 Feb 2022 14:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
 <xmqqr18515jr.fsf@gitster.g> <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
 <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com> <xmqq1r03zl9z.fsf@gitster.g>
In-Reply-To: <xmqq1r03zl9z.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 27 Feb 2022 14:05:15 -0800
Message-ID: <CA+P7+xoaHtHMxE_RVBRyhOqVfuP_1s+2NGpGDo_eKfb25_ty7g@mail.gmail.com>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic commit dates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 4:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> In "name-rev [--tags] C", we look for a tag to use in describing the
> given commit C as an ancestry path starting at the tag T (e.g. T~4,
> T~2^2).  There can be multiple such tags (e.g. it is likely that a
> commit that is v1.0~2 is also reachable from tag v2.0, even though
> it would require more hops).  We try to and find a tag that gives
> the "simplest" path.  For that purpose, it is no use to consider any
> tag that is not a descendant of the given commit, because doing an
> ancestry traversal starting from such a tag will never reach the
> commit.  In a world where everybody's clock is in sync, if commit
> was made at time X, any tag that was made before time X will not be
> a descendant of the commit, so we do not add such a tag to the
> candidate pool.
>
> I think the idea of "cutoff" heuristic is exactly what generation
> numbers can improve, in an imperfect world where there are imperfect
> clocks.

Yep. I have a patch that will implement this behavior based on
Derrick's suggestion.

Thanks,
Jake
