Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640AC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5CB6101D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhDMOT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhDMOTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:19:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E7C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:18:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id r20so19531284ljk.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xi+LNqGJ7J9Hm59H+vHdSOiVNn8LmOHRsAwV3CqcbkE=;
        b=G7tgUUgLKELbN8mEzzor3gfYqb3BNX/VZysODipELSwp9owm5eQwlhte+CyHwhcIFd
         E0rnKCgAD2qypyjdkxDwcTeitjCh8zy/TLROmaUivDYmGGjBAic23Z4obqKRVWeguayg
         9bN+bLf5h1BvQiQsgEhvYFAlsbUmmwBHlNBAJaeXVGJTvc0DKawNy8U2DN46HT2F/Vql
         mI1EEcsgjdgQw/JmymhlSbDSLApEMXf8lm6gEeT+ilQjP3q6a42mJjnT97qvkwS9eK62
         j5lq36AVdUeKWyUYt4HLYVZPnZf3FSm0TWP+KNwDgeBwnTErakLqRDiv9Lm7mjBvpY8X
         ZVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xi+LNqGJ7J9Hm59H+vHdSOiVNn8LmOHRsAwV3CqcbkE=;
        b=cVpXxfkZOSTexyVvgpFGv59EYA0w/zzg26jUQnl1S7WOZWLiaZ59N+DJDyXiXYNq5h
         1xfPbT83JaZBGJongc3Xg3m84HvJ5qNo9BkFH5mWmYpvWN7dwBeEL4Qaa8oZ9o1re0xR
         aJnQaG2oq0stB57yTGZSLNoBhm+Fi9qhU/mTN9sKi12NjMI61v6xZEX7jAPLtCB7tO7g
         HYlwJu3OKfv6DUKSGcy4x+Ow6e+DBBcun0dpzxeWeYUnD4gMfTfuPrYAxQIO5cFEqng+
         jrX/oW+4M3l+Ue8IWV8M2NAPwrtvQeB9Q9TtW0UnKqlyONkkMI6ku2Oc6waUt69/9aiy
         VVIQ==
X-Gm-Message-State: AOAM532WSIupU+nq6bkZFSW6Am3Ynl6BdEjy0lONtIZWbmqXCfW6kFj1
        J9f/dpL2S3LA+OBKnz07vXxM1BAhC12pvW4x60XOsQ==
X-Google-Smtp-Source: ABdhPJyDSuzG2eNko8qro9ZG5rKHrR6UesDZWPPNJJN6dnsh4MRIzJdLYqbcx2+0unIGRJjkr1f/+IFeJg3Xhsc9R1Q=
X-Received: by 2002:a2e:9e56:: with SMTP id g22mr7327036ljk.113.1618323533970;
 Tue, 13 Apr 2021 07:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com> <patch-1.2-35e77153831-20210413T122645Z-avarab@gmail.com>
In-Reply-To: <patch-1.2-35e77153831-20210413T122645Z-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 13 Apr 2021 11:18:42 -0300
Message-ID: <CAHd-oW5nwzg4iiDheMPLe_M19SXO9hPhGeJK8dWfZ-yTKkPVmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] diff tests: remove redundant case statement
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 6cca8b84a6b..67f6411aff9 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -220,13 +220,7 @@ do
>                 then
>                         process_diffs "$actual" >actual &&
>                         process_diffs "$expect" >expect &&
> -                       case $cmd in
> -                       *format-patch* | *-stat*)
> -                               test_cmp expect actual;;
> -                       *)
> -                               test_cmp expect actual;;
> -                       esac &&
> -                       rm -f "$actual" actual expect

Was this line removed by accident? It doesn't seem related to the
described change. Shouldn't this line be left after...

> +                       test_cmp expect actual

...this one?

>                 else
>                         # this is to help developing new tests.
>                         cp "$actual" "$expect"
> --
> 2.31.1.646.g06d606cb9c7
>
