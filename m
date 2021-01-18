Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F89C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551322222F
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 05:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbhARFeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 00:34:23 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:35284 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbhARFeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 00:34:14 -0500
Received: by mail-ej1-f47.google.com with SMTP id q22so21945011eja.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 21:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW1Z5+tOrI+TQoEmbMqUpbqJ9Nsfd5n4Ley+M9z4G9U=;
        b=rTbFffbPXfBnpidGtyS2ig03lEJfWfkwLqKc+18Apc2IIZtFNCh15GIfjsNm6uGnsj
         c2dVFTbnpM7A0T/Uw6MXmQWnKJqk+8CqEIHq/UIwXaKDdoYtvi4mX2T1SGvNVBu6xa1K
         gTbNan/oFqDpdChPSbIs3w3gzwGBu0PJdjnVQD/y9MDCwQmmJeVNohqy+1E2Pf7RXRIQ
         JFiidE22itBJP3ydnw4TPe6U2NC/JAISZHUKC601ECJZLVVShlB0oq80msQeeDztIku4
         5h5/ycXyqv+hiebcfUVG2ELzpgDoErpVR0JLhEnHtq3YNT8o1N2Bdo8NSEHwfr9HkYn+
         YtIA==
X-Gm-Message-State: AOAM533AE+dxpYKoeNGK2+Vm7u8/MFMqwy41TQswkJiktyuQ5w129s/T
        Fhm8JwBraCSkXyQFG0H79YtAuhO9SVbc+i8KsOnStzhbO5C32Q==
X-Google-Smtp-Source: ABdhPJw4amMNfxlpNCOea0FRAS90pTX6lDsK8b7mibNwWs+VCGh6WKUmjuh4gZp6qYcvSjyu+L7UDSg25pbzkmQb7lo=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr15863658ejb.202.1610948012371;
 Sun, 17 Jan 2021 21:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Jan 2021 00:33:21 -0500
Message-ID: <CAPig+cTGxOwUN20JmeR0bBwVMM78eA3Bnaqei5GEAs2XFM2_gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] teach `worktree list` verbose mode and prunable annotations
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> This patch series addresses some of these changes by teaching
> `worktree list` to show "prunable" annotation, adding verbose mode and
> extending the --porcelain format with prunable and locked annotation as
> follow up from [1]. Additionally, it addresses one shortcoming for porcelain
> format to escape any newline characters (LF or CRLF) for the lock reason
> to prevent breaking the format that is mentioned in [4] and [1] during the
> review cycle.

Thanks for continuing to work on this. I'm pleased to see these
enhancements coming together so nicely.

> The patch series is organizes as:

The new organization is a nice improvement over v1.

As mentioned in my review of [5/6], there may be some value in
swapping [5/6] and [6/6] to make it easier for readers to digest the
changes, but it's not a hard requirement.

To avoid being mysterious, there's also a change in [5/6] which
probably belongs in [3/6], as explained in my review of [5/6].

My review of patch [4/6] suggests optionally splitting out a bug fix
into its own patch, but that's a very minor issue. Use your best
judgment whether or not to do so.

> 4. The fourth patch adds the "locked" attribute for the porcelain format
>    in order to make both default and --porcelain format consistent.

This patch does need a re-roll, and it's entirely my fault. In my
review of the previous round, I said that if the lock reason contained
special characters, we'd want to escape those characters and quote the
string, but then I gave you a code suggestion which did the opposite
of that. My [4/6] review goes into more detail.

Aside from the one important fix in [4/6], and the possible minor
re-organizations suggested above, all my other review comments were
very minor and probably subjective, thus nothing to sweat over.

Nicely done.

[1]: https://lore.kernel.org/git/CAPig+cSH6PKt8YvDJhMBvzvePYLqbf70uVV8TERoMj+kfxJRHQ@mail.gmail.com/
