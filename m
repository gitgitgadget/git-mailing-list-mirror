Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE5C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C1761008
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhHKWpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhHKWpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 18:45:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57909C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:45:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e11so1823636ljq.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9oi1FSGqrtOoXbZXL7FzuaLvQPeX0fvwXwk4VCgsy4=;
        b=GWU52GQabd1EGGgiIVMoxROcNcR1kLCH0sJJP83E/2ZVf5XgJmml4lPqoq7ZUIQcRy
         oktieCbPkf8e37DG0cNgCPqNFB0swaoXTs+dgNWwugLFRNocTmvxsrpKIrswUNInwfOP
         PI9DS+ZyRmrhiNlI6z1CkMGMfmrzKdZOuuQXF/71oo+WOMHV24eWo/AEQtkNIcuo+ks/
         xvbVSM9rdwNdWTLsJ0rMzpDyiz9PCm614YDI2cvzr14yYlz1vrcgZzV/wWM3GBdOA/h2
         GZw2F4YY0/wOwkHqEDnK3La3yuCcxNzz79Y688YKO5I72syJE0S1ZG+GyCcGpvp7Gwtm
         2/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9oi1FSGqrtOoXbZXL7FzuaLvQPeX0fvwXwk4VCgsy4=;
        b=dULtqJ0YBI7J+M7tzJeVkgRsGFmcRPVKewzQ1d3i1T1Mha9l3oRo1dqRJ5vQ4NIgBK
         DYF5YhJOlvS0lmeaoXtdAyMSnPTmCSwngkNo9Sy+yNzfmpOlpIa3yNxi80Q3QQlGKdqf
         dYVpxBIoXadmDL6nLFu4EXrtmAtKWJnLAwT0e3cGRyOGF7pT/RRKpeLfuNCNhjim7xqx
         Mo7IOMpaNDgt7kk0pqD0zC/bQqSOH/rlE2KroToxznCEf0KhNiOJc0eW13BiEpyKEPgh
         AVL+9VTump3xQqrehIZPeEBwbFqllWBMOh6e3tn7rDzjE7Hrr/+/O0ln7wrC6DVyyIY5
         m/wg==
X-Gm-Message-State: AOAM532fdGOsayl25OBCrjS0jjc1vDkROK9I7prM1tYuNPCA+K6ZtNiv
        S7jI621JDhaEsTeE8IyqKTWmYJ+idzgqwrt6DeW4ZA==
X-Google-Smtp-Source: ABdhPJzPIkumg46bxYVxTKarxwSSYidzx0kAZvAsWNfyy4250PwFvAbJzD87j12oR8WpnqLcKQipr9DQR7DIvfDRx5E=
X-Received: by 2002:a2e:9907:: with SMTP id v7mr648124lji.113.1628721915609;
 Wed, 11 Aug 2021 15:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
In-Reply-To: <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 11 Aug 2021 19:45:04 -0300
Message-ID: <CAHd-oW4tLJf1VxWDOkzKtJCV9X_rqfWPg_yOONYo7S8O1kCjGQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 3:29 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> diff --git a/grep.c b/grep.c
> index 424a39591b..ba3711dc56 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1830,7 +1830,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
>         struct grep_source gs;
>         int r;
>
> -       grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
> +       grep_source_init_buf(&gs);
>         gs.buf = buf;
>         gs.size = size;

Small nit: perhaps `grep_source_init_buf()` could take `buf` and
`size` too, so that all the fields get initialized by the same
function.
