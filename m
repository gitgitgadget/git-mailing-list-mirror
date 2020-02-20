Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48761C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174CE20801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="rzdpbDZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgBTXaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:30:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35982 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:30:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so99897lfh.3
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pc2L0/dC1/Dv+tECKVDK7R28mN3TEOurWY/6k1nuTOA=;
        b=rzdpbDZtq/AmxNXQNci5sy2AnchL1nELr4AmqZ9ft1aEX/XBsU8lUxKEQ7zNJw0TID
         V/Eu+B+2hI2qh2cLDDcvdyEtPJqI+K/5y76mF6l9DJJ+dfP9wr6CinaWLm1wj7QLGxt6
         9vTyqfF4scE/LBlpUkmiNvYWDQTVyXANLyb16+saSQumBnharRrgh5NnUJRlHx2uHCa4
         qmF4U9By6jtKqAu9zrY2A/+UAzlglnrCuuAcY8A6INkxSGAoJQVhKOs9SDJlpWXhySzc
         334XXdEB07RwUxDQ2/GKnZcuE2NS0A5bTzCDO7Fn2fQw5oaK/QS870bfBeU+WQFx4RW1
         gUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pc2L0/dC1/Dv+tECKVDK7R28mN3TEOurWY/6k1nuTOA=;
        b=ARx6plGUMVvkaylkhqtqiBlvuZ5SkbiXHO7Wo5DKLJnfBYip7NCNFTcRxSjw5lL0w6
         eOO2iT9o1eccf4atnk1smZZhVOGCzRXqYMcyLu3fBetLEDbdj85d7bzTQYeyDIWTKjTS
         tVN1Gp0bTy61iEFqAJf2Z2fRtV9yoF7om6BBjBP0qBkZzKstYECLXdkCZc1AQGpuuMop
         U2tBVhz/ML6/HuvwJaktfV2BnJ12FvLetN8Bbzi1Fo5RUA5t165rXwXbD9M4JUE2V9t0
         seQfC9XEVuM7EMABON35oItBxN2ycplFj/9XJpEMWnGPCIiaH1T7uXHChkDKj3WP3zEe
         hV6Q==
X-Gm-Message-State: APjAAAWHRR+x4aoe5Zjvk6aZ2pSFWd8JzZHWIqA5FHqhsQYyX1dugubX
        faGTRR1/ASBXRTVYuLCt423guk+w5GiT3DracOVbCA==
X-Google-Smtp-Source: APXvYqyeeHLtVFO+GdzQzIFZGWYXmeEdiUoaxCVW0O85upI/prZKvJd37X3wq4g1OwfA/2UdtT249FlTb+WAbYUx6QM=
X-Received: by 2002:a19:550d:: with SMTP id n13mr18313294lfe.48.1582241419667;
 Thu, 20 Feb 2020 15:30:19 -0800 (PST)
MIME-Version: 1.0
References: <20200220214647.451064-1-kolyshkin@gmail.com>
In-Reply-To: <20200220214647.451064-1-kolyshkin@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 20 Feb 2020 20:30:08 -0300
Message-ID: <CAHd-oW61vuuvs25iOkLJ--Wv39ZXFF87_-pV=vX=oTibRinn5Q@mail.gmail.com>
Subject: Re: [PATCH] completion: add diff --color-moved[-ws]
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 6:47 PM Kir Kolyshkin <kolyshkin@gmail.com> wrote:
>
> These options are available since git v2.15, but somehow
> eluded from the completion script.
>
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1aac5a56c0..43cb6a312d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1487,9 +1487,16 @@ __git_diff_algorithms="myers minimal patience histogram"
>
>  __git_diff_submodule_formats="diff log short"
>
> +__git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
> +
> +__git_color_moved_ws_opts="no ignore-space-at-eol ignore-all-space
> +                       allow-indentation-change"

I think "ignore-space-change" is missing in the above list. Besides
that, the patch LGTM.

As a side-note: when we have an option with an already filled value,
e.g. `--color-moved-ws=allow-identation-change,`, although it accepts
more values as a comma separated list, pressing <tab><tab> won't
suggest others. But I think the helper functions in
git-completion.bash don't provide an easy way to do that right now
(and there might even be a bug in bash-completion involving this [1]).
So, I think the patch is good as it is (just adding the missing item
to that list) :)

[1]: https://github.com/scop/bash-completion/issues/240
