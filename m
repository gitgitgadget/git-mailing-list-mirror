Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D49AEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 16:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjF1QpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF1QpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 12:45:13 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A802682
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:45:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401d1d967beso6841cf.0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687970711; x=1690562711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9HESIWgN8tXy2CH+t0k+fg/w9PzxIQF7z9RPDx5K6LM=;
        b=aZHQw5kdXvBvkZMykpeJgs+dA1xpCRdT4Ujr4lMMhn/hpxDMF/79nrKJUrcuWES3BN
         OywHT/0rsIG1yCqlS93hxIJxj1Bgu1iKWrsl8XrnSi72xldvKL6OYo2//Wuzt/EF5kpe
         rY5KCfz4iBfOQTgHqo/m+xCDsb8VlGW25uhyHrb6RLDvgwK0Yp11VQC0i5834MjwVzZr
         xKUeXypEV/1QIAv4h6rMLrqZfCsAt9njmyhzfmVYuQDwwpdkdSdS6VjBuWaC7xpPVYrO
         2vQtvrYhvA6arU3EmFxCiDnxgdL7G2/3ApAtp74c1epYw0bHTMJa+Gr3NhRKlxXSvUoO
         zvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970711; x=1690562711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HESIWgN8tXy2CH+t0k+fg/w9PzxIQF7z9RPDx5K6LM=;
        b=M/2hghE2/hyNcWMxhJTVPE+Gdcpi+jc2HV9AKV6jWLhFdTfQirhGwyOm4NJgu4vCHc
         0IjyBJ6iLja3R+5Z15F3MLTv5U70VEOjO9Sq2iVOqmB4dwsYm6AkXEqXB7FoyZdW3Aeu
         EKRYWHLfaE6Ol5/0JvU/KpUMgvGHOhqPirAWx4nL5eVBfsItPJUhUeUttWbdE7TtKs3t
         iynMX1PQV68cEpyfHGLHgiqfYwQMPurkvsSeR4ZiE+iZKSZKaDDmctUCNUm/YiZg3Tpb
         iEcU9mPs/Y12288Jb+Qg1s4xF60GKx2UvVqYobQuw5KrX/4WEPRkxGIllxNNc241auoq
         vIgA==
X-Gm-Message-State: AC+VfDxe5+5ZMXObWp7QBPyum8eaDUUcP0Jcr58ySW0DoW0w+ZUN0rnP
        lIvg+5wa3R1s5vE4yTke6i1SfcHLlT2D2vH5laHyVw==
X-Google-Smtp-Source: ACHHUZ6x03hkEj6i+h2Ylc67uRAAYGACDc2K1GWtG77My7TZa+8KHWzKC2s5ZCPAKJs3bJPhJXkyL1sJbqnlv+k7DY8=
X-Received: by 2002:a05:622a:185:b0:3ef:3083:a437 with SMTP id
 s5-20020a05622a018500b003ef3083a437mr302325qtw.18.1687970711077; Wed, 28 Jun
 2023 09:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-7-calvinwan@google.com> <xmqq1qhwfr46.fsf@gitster.g>
 <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com> <kl6lpm5fr19f.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lpm5fr19f.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 28 Jun 2023 09:44:59 -0700
Message-ID: <CAFySSZBBAatvBmfwn9vc=v2hdWX_0Q4g4txqLOwtqiFZFW7uiA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        nasamuffin@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Glen Choo <chooglen@google.com> writes:
>
> >                      Could we add a is_pager/pager_in_use to that
> > function and push the pager.h dependency upwards?
>
> Bleh, I meant "Could we add a new is_pager/pager_in_use parameter to
> that function?"

Refactoring the function signature to:

parse_date_format(const char *format, struct date_mode *mode, int pager_in_use)

as you suggested is a much better solution, thanks! I'll make that
change in the next reroll.
