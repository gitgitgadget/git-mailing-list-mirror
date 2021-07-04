Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C18C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2034061474
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 08:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhGDI6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDI6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 04:58:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4EBC061762
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 01:56:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w13so19678240edc.0
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hJoGcPNVnWC2h6IGhAFMjI3ohUuP2yzhTJQXL8RM5KQ=;
        b=g6Lemnk0Anofyn3aSp8jRpf7/2G3xgi5foNOTNGwL/q4Pf+p+bMY2E7m6iLfrdIkdP
         dxLdBAZOGIYOWpdDskFvIq3fqlgKIRYfKuQpQblwGWCkUPl6FiOWojva9m6Hx3ct7Z1S
         sj5qSq7+Dus8ZKUO6MkUGNXpNqbptp8jzVuEdt6/VokitZxvqv+77VXwqotkMPFBEsDB
         MHlEw8GuLleDCGwHBL12iZFQtqarM4gsZioHpFZh/KE8yG+CSjYDZjmNHukfCEskZFGb
         96ohTf5e2yTWvVwseI6kCXuMNtjbkl48aeSQC1txz96MznC3jPRBIbKTqrh3iwJcolTJ
         YuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hJoGcPNVnWC2h6IGhAFMjI3ohUuP2yzhTJQXL8RM5KQ=;
        b=r0Ufz49bICCg/+ckL+DYacFccOseLB6vLEX4BZyEUWEvj0OqlE8vClssb2YR/Ha0Qu
         EA2//LNqpNFxzfhLTybgLmDIGxY5HobO78/XbbdGIpMZRcTBWNXk+/n2SQTXqYARN2Ob
         frJYnk0DpGFOAfB2t98Arg9OYIDQzjsitO20IQrelDOxFH8QYZelk8suhyzqYKcEuJik
         EoUo6uY3NpUBrlrAtYZvlwhKaPJS31i1VBfVsQUFfkiffzPmKkZB8l6CStHsUkNJondI
         8HNZo/TDpGdVYg3DZPMtgv7Su7paRnibh0pZypa0EBfwTlev63kY1k0IWNfGVSni2bNo
         S13g==
X-Gm-Message-State: AOAM530kEe78Ozu/3vmY4V+Php0qPUZ98q35sXipqjH8HvjiEccQE0qM
        FcCQsY50DU27jAioggJSt8s=
X-Google-Smtp-Source: ABdhPJyb0Pd4KEfZosbtaNJUOX17TV6DXA8Xm6sjENhe58bjvc49jrV4ATMRuwyG2KS9rNR5PTOUwQ==
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr9484539edd.219.1625388972464;
        Sun, 04 Jul 2021 01:56:12 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id br4sm2802358ejb.110.2021.07.04.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 01:56:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 7/7] ci: accelerate the checkout
Date:   Sun, 04 Jul 2021 10:54:48 +0200
References: <pull.878.git.1624461857.gitgitgadget@gmail.com>
 <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
 <88a44863cd013fc9c152ff91cf109fd7b1073257.1625347592.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <88a44863cd013fc9c152ff91cf109fd7b1073257.1625347592.git.gitgitgadget@gmail.com>
Message-ID: <8735su8nkk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 03 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> By upgrading from v1 to v2 of `actions/checkout`, we avoid fetching all
> the tags and the complete history: v2 only fetches one revision by
> default. This should make things a lot faster.
>
> Note that `actions/checkout@v2` seems to be incompatible with running in
> containers: https://github.com/actions/checkout/issues/151. Therefore,
> we stick with v1 there.

I'd suggest that we shouldn't link to a "closed" issue here and instead
to what seems to be the successor issue:
https://github.com/actions/checkout/issues/334

But looking at #151 most of the issue is a bazillion commit references
to this commit being rebased again and again, seems like github isn't
especially well set up for the "spam" our perpetual rebasing of the same
commits causes :)
