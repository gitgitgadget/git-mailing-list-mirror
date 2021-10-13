Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05F1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9495E61151
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhJMSUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbhJMST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B8C06177B
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:17:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l10-20020a17090ac58a00b001a04b92a5d4so2025981pjt.8
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TmXh7UVL7pnkUWXnO/i0oD0WE5NTGbqHcRKmzljO4is=;
        b=DwN96ons6AYHYF0mIW8PzhPYHdhrP9+2kUvqcZfygwVxiy3g+YFKZBEWGWCkVwvpEJ
         hUiVC//OgneEw7fo+Pg1S75c8cbiO17w5VU/qlzjgBwz2G6qwpgPhgKGP1GPMzBikTYR
         KvAfO8caYA+KQRWX/mBVfAYHt4FeZLKCHyde2Us9Hzn3q6zFVvXYUzcy2jJlxMh2h0kR
         PiS9siOo+r+Fmko++3WjbiV9L0Nmz+2dVZdmHwksF1/7qJlMGqCYwITxstZaweLyzcmm
         hJkUrawGl20DeiWybIst7DEHOn31Vk9ZdB1rRzzDrClQgboPjsc+Ht9ePlLvShkhEjgx
         A/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TmXh7UVL7pnkUWXnO/i0oD0WE5NTGbqHcRKmzljO4is=;
        b=M0Wl0MdehMk/lwUMwinILaIl/iZAxjeWZIP59vlnbRVt3VxAKtoen3TTLM1ogf4+Ys
         3kJ00lwZW7Syl28Gs6gNUFW0zwHqN2pmwg9rzQPtubWW19WFTU+YBEJJE/PUsrxk9EtK
         4zx7RTqp1JXqylL+EVOJhXUHW51eGxx9zEHbR7LrBZSzO193E7mMaQAREwgF5rLt1yI5
         a4zhuUZjWAD7T5qN9tOEPr9SthNbmFcs596QytPhpCjkkYlQFnA6LFBX+zC3y/qAHFyE
         o/TWQylCx6OOfVx8aDa3FgxIB0C8VAP2M6lUQcC/SwNI17RoxaAjlO86hLGaQSbuyhaP
         9zAw==
X-Gm-Message-State: AOAM531LTxETDkeQ07CwOVm3rTfbA/kpT9ujyYQHGRGcS4de3yqVTrKz
        bgPjHrM6xXUcNRgayPd0AvwrhMjkWluUPa/2DlrG
X-Google-Smtp-Source: ABdhPJxMDshQp5qqx9jTRs0ud65Ekn59SwxFdy53ZhIpV786HeqMyAXibsmWjgwag78kaa/H4ifvL93bUmja1dhosp0C
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:bf45:: with SMTP id
 i5mr553985pgo.161.1634149069470; Wed, 13 Oct 2021 11:17:49 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:17:43 -0700
In-Reply-To: <YWYsbGHwQZbEuTCa@camp.crustytoothpaste.net>
Message-Id: <20211013181743.84126-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YWYsbGHwQZbEuTCa@camp.crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sandals@crustytoothpaste.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I won't go into the details of the patches, since I'm a little low on
> time at the moment, but I think from what I've seen of the cover letter
> and the commit messages, this approach is much better from a security
> perspective and, provided we can get the kinks mentioned downthread
> ironed out, I'd be happy to see this merged.

Thanks - I really appreciate this note. Thanks also for all your
thoughts up to now about the security perspective.
