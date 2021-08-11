Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB3EC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02D160E97
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhHKKqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhHKKqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:46:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB22C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:45:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so4048874pjl.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=j8+ufrH4/VGCCpAKa6/reop+GDQ9ub3vyChoPJQY1UI=;
        b=bCTgsgtcxueIgz6m6o0AvV1ob1LczbCIPLLDgIlCmvY9ss1nMH6WCNYzXA8a49R80f
         nwMrY2GBnCFXFA5EJgzrBF6n69HocxxDSIknhSKSL5ZFKUQGMWi0nxBjF9Z5AM1bDdvt
         Fz6I+Epfv7K71Sy+MTnO0Dc+flF8g6gY+2e9Qg1Q98L9EocwO8I0qyDWyPMutGYSDHo1
         jSsVAPKNhZHMqHkPvFz8xyTVEy57zlSQQsD9b1a7GtNoio53+MBQJUJemw5vWQdaYvvT
         brBKYc0OU9vNIbuHmfnXcrdH+Dde+2f5Dc4wgoqxi3w8iQhuWyiVhL95GIkQ1Ht+G0Gw
         9lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=j8+ufrH4/VGCCpAKa6/reop+GDQ9ub3vyChoPJQY1UI=;
        b=j5btVFxifgKdiyjzl+7QbrWNCnouIMRmaPDv6giYBN27vDMixmHjinyQnIQQsI2oaa
         yalepQfKZO/KMV9CHJUjEOI9+XPTtK2JYyOuWumfgR8Xh7zOk61hfmnSSqoC1kBUUkKh
         Ykb5RWFs/6P2UbJPDVqAA8eNn6OEhYc0poHczIYUwIi824I8Nnm9pdKXDhF1ifRRhRiX
         1H++XN8AObJjMYtGiITE99N+D3fQB0bF6PKvoyqYE5jFvDifihztBL7KbiNOyuIJ76mk
         NEXPx4lmnwVj2yZNmx7ogMa+QIoGcDd/7M0JAPNQXT5Zz7V5Xi7Nmd8ucr+KM8nM6Xm7
         fYzg==
X-Gm-Message-State: AOAM533kfBfGBORFex9WhYGlL83Jtt1KmlK0JcYj72PzG/74ofVGo1gn
        Ezb1TmylkBOU0Ec+yO5PvOc=
X-Google-Smtp-Source: ABdhPJzQAkOQVVqnVu5R55zjQA2/9adb6ejfznMUyszMaGm5rtOd4P1Y00BEobFe2dR25ztoo8vZqg==
X-Received: by 2002:a63:4f51:: with SMTP id p17mr730828pgl.29.1628678758753;
        Wed, 11 Aug 2021 03:45:58 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id f5sm25758582pjo.23.2021.08.11.03.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 03:45:58 -0700 (PDT)
References: <xmqqh7fwbx86.fsf@gitster.g>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #04; Tue, 10)
In-reply-to: <xmqqh7fwbx86.fsf@gitster.g>
Message-ID: <m2mtpo9s4e.fsf@gmail.com>
Date:   Wed, 11 Aug 2021 16:15:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen',
> which means nothing more than that I have found them of interest for
> some reason (like "it may have hard-to-resolve conflicts with
> another topic already in flight" or "this may turn out to be
> useful").  Do not read too much into a topic being in (or not in)
> 'seen'.  The ones marked with '.' do not appear in any of the
> integration branches, but I am still holding onto them.
>
> [...]
>
> --------------------------------------------------
> [New Topics]

Kaartic Sivaraam had sent a patch to fix a cosmetic bug introduced by my
add-clone conversion series which has already been merged to master:

https://lore.kernel.org/git/20210805192803.679948-1-kaartic.sivaraam@gmail.com/

I think it will be re-rolled soon. Just wanted to ensure this did not
get lost among the other topics.
