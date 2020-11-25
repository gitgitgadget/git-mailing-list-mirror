Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C679C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A9C206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgKYWuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:50:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45564 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbgKYWuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:50:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id q3so136828edr.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOshihl+ggA8QWAo5dYf/LC1LkTdA2Y/ulQeVdHMXi4=;
        b=SXUTUK4qKNpQK32NVWfU/zGo/ZjegGGP8kvmzsmjsnb0XM/tBiWjFDdv8utU6oThAv
         cDyR3k4Vm+UCTN/JhEGDqrd7Ja0p9ihIyrhHS0vdAy0WOB9P3Ro18+nIfvbnPFtfJ7sd
         G6oVaGW7lQVJJIF1h5B6ikpSgyTDK5LX7hOAxDeVzpzaGp6btIpvLQR2p4bMKlJ4RcWP
         vWzxqXtttWkkpZJYXsMvA+c31L5HSShDFpvRp1w+0JVenZyrPICVHh1gRl3pfm6FZLRi
         LXtDAfRBvGcUzh0cjgJk6kLeg0KTlWKe56fkUnG00luvqgbVvpClqX16u/4pYViXoUWS
         kdkg==
X-Gm-Message-State: AOAM532/gbUfctI27CDF8ULk+/8YeA7iCiuzuvq1oRK291dbfmi3tTQO
        F+FyWqo0rSifFQoJGn7d4fgihGKsivTmoLc7qUT9SEAu
X-Google-Smtp-Source: ABdhPJy6byABtCgB6AYrxlqHHHGyOt3/da4de4FNUmSeS+FmZOKXGVsOpu3EjNX4x/2mxxWj5wGWpgFw6Gzc2/LBjUU=
X-Received: by 2002:a05:6402:1644:: with SMTP id s4mr5556260edx.221.1606344653318;
 Wed, 25 Nov 2020 14:50:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <pull.796.v3.git.1606342376.gitgitgadget@gmail.com> <f135b001ad911c079b0754c61e2179277ce37e0f.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <f135b001ad911c079b0754c61e2179277ce37e0f.1606342377.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Nov 2020 17:50:42 -0500
Message-ID: <CAPig+cRL1FksVbS7jN5s=BDm-Wyx7ABo+h=EC2-3bw7Lkp2WHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] config: replace 'value_regex' with 'value_pattern'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 5:13 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> For documentation, use 'value-pattern' which is better punctuation. This
> affects Documentation/git-config.txt and the usage in builtin/config.c,
> which was already mixed between 'value_regex' and 'value-regex'.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value-pattern]
>  'git config' [<file-option>] --rename-section old_name new_name

A mini-project for someone to tackle some day would be to replace the
remaining underscores with hyphens in the documentation, such as the
above "name_regex", "old_name", "new_name". That's outside the scope
of this series, though, and can easily be done at any time.
