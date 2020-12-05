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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557CC4167B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978F223100
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLEBWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:22:20 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B88C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:21:34 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id g3so2504783uae.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EzbVRljln6ORdWmYxghXbLOqIcgFhsnCJNFciNnPADo=;
        b=TbucMet3ruyd8wrI55L6sCQot8+enxYqPWzEURYsLyUSq7ZlCfGleEqTh/I5pg0Snz
         vvshzzYFQ7YU556KefEBhxvgJTjgQrNpo0L4vVLbAMKT9SQqpaefCG0zcTh2GnlaQTVZ
         tzMPbhoo+zGD93n9cXO3HpST0VkL0UmiRcLWz3cC58T/KZYMQ4W1gIenYSndbL83BAD6
         UpG8Btl2afGfJuKuGmHmeCC0LKpubavgjwlyozW5Gw9c9PJJLvF4PNJBk/JEsx64mCkd
         7brncVkdKUDs7XfMf//ziN7i5ypHkvkCEKhJtq73Q4sAoG9U2+RQ1W5+tSwHViwWSkAT
         /5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EzbVRljln6ORdWmYxghXbLOqIcgFhsnCJNFciNnPADo=;
        b=bwfUlPU9NoaUBSVK5ROlWEz9C0iF+gQmyu8Xq8y0+2l+nfudiu3qVYHYcV0H8bF3Kb
         hOUK0dbhiHCwApQMJF05EylbGl/opQASP1HFhi7aT9JcpKVMfCoYTaJmvP9eWAdKIwwk
         5CKdNBHlb2rOygRF2kh2EIe4efxBje7hs1DDSIIQlmkGGrR1i0kT7AoxyWBpbLXcXboK
         IiFNL/TIZydfjJ6tQ1zh2Qo/PYjJZJGbdvENwqeBKtGRK+9LZtHJcXJkvZKqJi87S6wu
         UPJsP3QYIbGrtIuFIpNPQd1+ZqBKNjWnJ0v9jj7joLc/u7sP8EkzyigtjaFoOEBb8fRE
         L2QA==
X-Gm-Message-State: AOAM530u2tKwuJlm2a1hj8VT0WD7zRWTPpDMgbGlauhN43tUrvr58hMt
        cMFGMuXVdmMeKTJGwAs8z9a64gP1/wo3RXNUOyI=
X-Google-Smtp-Source: ABdhPJyxIZcCbz7RaZHFlOclrhvc9Z5Enm8nOX+ETKL5YsgPkupa5WG1qh/dHCqfHqkDF68X2b0ikzjBItePXK3sfo8=
X-Received: by 2002:ab0:648:: with SMTP id f66mr6207757uaf.126.1607131293620;
 Fri, 04 Dec 2020 17:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com> <20201204061623.1170745-2-felipe.contreras@gmail.com>
In-Reply-To: <20201204061623.1170745-2-felipe.contreras@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 4 Dec 2020 17:21:24 -0800
Message-ID: <CA+P7+xo+op4F+hbeDM8NG4jSGL=4UiCwxkxG2E8BSdfDh1LGZw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] doc: pull: explain what is a fast-forward
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Elijah Newren <newren@gmail.com>,
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

When displayed in a regular font, this looks like it is pointing at D,
but I checked the text using a proper monospaced font (on lore) and it
is correctly pointing at E.

Makes sense.

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
>
