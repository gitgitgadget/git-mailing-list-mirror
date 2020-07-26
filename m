Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C552C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8A22070B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGZXmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:42:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54050 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZXmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:42:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id g8so1336529wmk.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nv2aDeJNIsAuqYNlPaxnujTf7nli6DbN+kN/ekqVXV4=;
        b=T/uHyAA5kE0W9Y3R07ZbCwqsm3TruaoAnphil9gaYbPtCcOcnDhJwKEZyvwc9XT4jP
         NvAwSnx234cjfrEmI+Tdj7OvEHNbFX2BEDqsdcD3u58ZZZXrPXaETHh7ooG9zEX6riL1
         zhP5DRhjh+CbGPl67pwbi/JFhABD9MgceNyCDh2dPkeY7fOH6jTXdjYAKZEOcQKBC+Gf
         LE6eAmeGCGwDXojEzV5V5zOdc527y+CefEIR4mfyuiNM28BmqV1POf3OZ15T/FSg0Uj/
         CNWZDvzDxcfJ4jfhUWXUBlLqXgHIVqQlC0I0CgV4VW79sFVrKBIasHm8QG4qfXzhyb1a
         IDaQ==
X-Gm-Message-State: AOAM533olmsC75wtCjj91Do+IoQVHYsW78GxcslK3UuVUkEG8kE/EU7A
        5tQaqGTOoJvPUpEicrgaHAT9ai54ryIRykDHrMN3dsT5tbA=
X-Google-Smtp-Source: ABdhPJxKCKVeYrR+ak0OkbCpBCFR/Rhc0ho6TmvgK644/4GAUggt08zj3NayIR+k9oe7akXJkwVc5Zaz7j0/bR1Xzgk=
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr17854434wmb.107.1595806923498;
 Sun, 26 Jul 2020 16:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-34-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-34-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:41:52 -0400
Message-ID: <CAPig+cSbpb_eySzumaCYRzHhLOJQa_950QDEBzRNjhS5w+HZMw@mail.gmail.com>
Subject: Re: [PATCH v4 33/39] Enable SHA-256 support by default
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Now that the we have a complete SHA-256 implementation in Git, let's

Reader trips over "Now that the we".

> enable it so people can use it.  Remove the ENABLE_SHA256 define
> constant everywhere it's used.  Add tests for initializing a repository
> with SHA-256.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> @@ -441,6 +441,35 @@ test_expect_success 're-init from a linked worktree' '
> +test_expect_success 'init honors GIT_DEFAULT_HASH' '
> +       GIT_DEFAULT_HASH=sha1 git init sha1 &&
> +       git -C sha1 rev-parse --show-object-format >actual &&
> +       echo sha1 >expected &&
> +       test_cmp expected actual &&
> +       GIT_DEFAULT_HASH=sha256 git init sha256 &&
> +       git -C sha256 rev-parse --show-object-format >actual &&
> +       echo sha256 >expected &&
> +       test_cmp expected actual
> +'

By testing GIT_DEFAULT_HASH with two different values, this test does
a reasonable job of convincing readers that GIT_DEFAULT_HASH is indeed
respected.

> +test_expect_success 'init honors --object-format' '
> +       git init --object-format=sha256 explicit &&
> +       git -C explicit rev-parse --show-object-format >actual &&
> +       echo sha256 >expected &&
> +       test_cmp expected actual
> +'

However, by testing only --object-format=sha256, neither the reader
nor the test can be sure that the reported object format came from
--object-format= or from the default value used by git-init.
