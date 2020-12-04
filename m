Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7BDC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA222D01
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgLDW4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgLDW4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 17:56:06 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD9C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 14:55:20 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id w9so1771618ooh.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZLcuo+In7mzBYmb6YgjFk1O+T8wJklvtREzqO+rj/Y=;
        b=ZVKGCmdWG1v6wZcDVKFkVGcd1j7URg37RXem43+xmUjYNpomkNdYWUVokMsTkDnku7
         PzcNL6+PQIuQ+tL9g8rowiQqGWHwdazzAqo9a5g2z5HuXyhzU4r7qMSFzIUSlzfawOqo
         zHWZwIwkI0bdOTa1X1wq3+C+3C21Xs6LfCd/XmMHKVQWbzej6xsuEA/KQmn4MloZOUhN
         tfZk7sjW9MHJh4nHUFBfwJrGx+OWa6GEUQXw95w/X8em5BJj9ckYStHROW6V4YW/kh2u
         xaPSkRwlVLOSeOJ6YmV2GvezGlU3LP8J1nF58Y+cfIrSAYrssMHVJrOtNv0LT+9EafGQ
         sx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZLcuo+In7mzBYmb6YgjFk1O+T8wJklvtREzqO+rj/Y=;
        b=pjHS5pnk9Q+x5UopovgTlD3ywKbYKBgRYg+Z0AL+FQi9kw63USZM8HDda5NzzRt1SF
         +gU6Ccl3W5JnAD5I3O9A2gIdYxkYoq2SxcKhiL+DC/HaN6MmNNLztQ73cM6xtM9kmvms
         IU1t34JTDCZu/srbOkTenm/KsCj+khCjtvJf2MjNbVQMSBYYoLo15cqORSp+dNpifqca
         o6lgokY8fZkI0bO6mDQZov5Hu/C5ncrsjCUpoONSFRTTuCUJbP5R9Ao/dIiEVrxc+rwM
         s38+ZuwEe9HA2wmDNM7E2WxhQW2I+rGsTwsK69vS/Pq5XBx9xzlvHBUZVixzGKEPuxNL
         9bpA==
X-Gm-Message-State: AOAM531trHo/HQsl+/UV3EOMdHcTC09wQXIWnn7kmjSpsWyYd/Dx0h++
        8OXHfaW5/KGSGSX0gsFDf4jFe1xG9KBmBYIBP8I=
X-Google-Smtp-Source: ABdhPJz2r2XboO5bJYV0HOy7qnUOgjShEAOz0ebHf8J+ithuERUoP1bMa7SyyY5+tGVkqmdMQ1xSkWMYdlYTCDlOy0Y=
X-Received: by 2002:a4a:8519:: with SMTP id k25mr5174437ooh.32.1607122519582;
 Fri, 04 Dec 2020 14:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-2-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-2-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 14:55:08 -0800
Message-ID: <CABPp-BEsmNv1=yKGZj8kH9EGjnLkeo0+hJvog_b1pYex-59ScQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> We want users to know what is a fast-forward in order to understand the
> default warning.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 5c3fb67c01..dc812139f4 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -38,6 +38,20 @@ as set by linkgit:git-branch[1] `--track`.
>  Assume the following history exists and the current branch is
>  "`master`":
>
> +------------
> +         A---B---C master on origin
> +        /
> +    D---E master
> +------------
> +
> +Then `git pull` will merge in a fast-foward way up to the new master.
> +
> +------------
> +    D---E---A---B---C master, origin/master
> +------------
> +
> +However, a non-fast-foward case looks very different.
> +
>  ------------
>           A---B---C master on origin
>          /
> --
> 2.29.2

Makes sense to me.
