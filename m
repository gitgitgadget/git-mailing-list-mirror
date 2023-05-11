Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D2C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbjEKXx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKXx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:53:26 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3681BEA
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:53:25 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a8e9e2c53so90907267b3.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683849205; x=1686441205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou201ydEblEntZjKpZYEVelcmZNG6V65xEs7BAnFiHs=;
        b=Ku96BPeEEFSqs0AE9L8O8/VDVRBBAThFnPS3kI/KFYcCeEvxVBO6GVyAWOxtyMKaUM
         eS3NU+saUkcQarS7X1F7F9iMJR0p0VX24A54AvKozgjqRUzaRxTv8l1trzSuq7XjCFz/
         bWnNmqZwzPBkWQ1KByo7Ye5TDbihs2NMpspZxzQ1J1gp0JY8XhCzwLWuBfGvIQNMvKCl
         OHMx7dxEyPKlD3MTqulXXN3NjyCgwZuVoEv++FGATNsfT9d+ht9fSs14Q9zXUF5+7Q7i
         xFa3zTc58IIfs/6OJRdr1xzIek2RueGGjNbts3eld3rEOYEFk/GoABBNNtTTzhjfrNDs
         0k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849205; x=1686441205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou201ydEblEntZjKpZYEVelcmZNG6V65xEs7BAnFiHs=;
        b=VyDZOgssaks4HGxGxLxFM7eG3FGSngikqrh4goa+hXTNYrZQPsULHItXxlL5jjvpZl
         ovZvNBErwCXcZGyB4t/E8lPlG2ye9zaZSnYzkXojggR4PtlKz7C+yMq5qoJAIAJZgFFb
         U1ZNwC1U5QLVUHmtKaNbTUyhmklKNgaUuOjK9DzEaPcy7UEm5Hps/PzVTloM++rcfiSY
         /RGQayIyQsuM/sHWJNDNAeI3tmwyNYmp4yitVfPwN5rgH/bSchAdWTvWq3V7r1LjCCBw
         EK5LSD3+2yBX/7n+WcF8NCe+cLly5Lga+WqOJKlJq6PrpdyQVhxYp+Oc2atV0MMvWY8k
         Qu6A==
X-Gm-Message-State: AC+VfDzicBKi90gdKwg2HffLJes3Q6mzT3LESVXdXWLz+jz6n+vWWR5B
        opyqB8zArdTVBnClefgz1WjW/g==
X-Google-Smtp-Source: ACHHUZ6DHd7IYIGJvcTCQqdPTRbcP+K09m6BGuK3WdbkdFpqn1Kvh6M4yJzm9UxKBT8vCQFTdctzQw==
X-Received: by 2002:a05:6902:18cb:b0:b99:8359:b485 with SMTP id ck11-20020a05690218cb00b00b998359b485mr24202365ybb.18.1683849204955;
        Thu, 11 May 2023 16:53:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b4-20020a256704000000b00ba2da98431fsm2862599ybc.56.2023.05.11.16.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:53:24 -0700 (PDT)
Date:   Thu, 11 May 2023 19:53:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/4] docs: clarify git-pack-refs --all will pack all
 refs
Message-ID: <ZF1/8w9DBNNrghPN@nand.local>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
 <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
 <0d462010b798f834fef55cc7aa767f3f2a177f91.1683828635.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d462010b798f834fef55cc7aa767f3f2a177f91.1683828635.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 06:10:31PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>
> --all packs not just branch tips but anything under refs/ with the
> exception of hidden refs and broken refs. Clarify this in the
> documentation.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/git-pack-refs.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
> index 154081f2de2..e011e5fead3 100644
> --- a/Documentation/git-pack-refs.txt
> +++ b/Documentation/git-pack-refs.txt
> @@ -49,10 +49,11 @@ OPTIONS
>
>  The command by default packs all tags and refs that are already
>  packed, and leaves other refs
> -alone.  This is because branches are expected to be actively
> +alone. This is because branches are expected to be actively

This looks like a stray change.

>  developed and packing their tips does not help performance.
> -This option causes branch tips to be packed as well.  Useful for
> -a repository with many branches of historical interests.
> +This option causes all refs to be packed as well, with the exception of hidden
> +and broken refs. Useful for a repository with many branches of historical
> +interests.

The new wording looks good, though you may want to mention that `--all`
does not pack symrefs, either. That's not the fault of your patch,
though, since it was the case in the pre-image, as well.

The wrapping on the new text looks a little off, though.

Thanks,
Taylor
