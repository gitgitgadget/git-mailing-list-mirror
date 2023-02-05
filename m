Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA19C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 18:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBESKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBESKa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 13:10:30 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9764B17178
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 10:10:29 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id mi9so9627150pjb.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 10:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9KNm4Q9tk2ZT+3A4VCcRY2wHU3zmzYnqmgovW3t144=;
        b=yUtOmPVS8B3311OpzzlD32adl5/n/q8gQdyB0L9G9b1+of2xlz4UcSkJrBGivdUBKs
         aEM4a5E/O1QA8c+jAIBjAByQHTypm9pnUVRv9ypSRYXPIkCmUrO45u/m0lsN6Pl4p57R
         oNQRW/HzTAHvrEYbx7hFUvyxJUvNrHhalFOuV8NoIDxvQiXuZ8iAIayoaRwRBWMIkveG
         cs0VwaNcxl07KZgfrJalTa6Iohp2MkRHBK5mvidDMDXEEUa571dzyTHSkMMo5OvRJrZs
         aDmjz30vJMtLwQK6ekWSBd5RXynrq+Xjq3ujbL+lhSlNgeBlzYXwJstVhsOK3cm3sxA9
         ttyg==
X-Gm-Message-State: AO0yUKWEifkdey7db0TroXS4n3Rq8zOPWO8u+QzvcFVhur119aj/VYOQ
        PYB7b7EHwuvjWvj9uQXA0n/DGRuRyzYTtsnm6gZnU1A42rM=
X-Google-Smtp-Source: AK7set8n+da/gK5s0va9Ms0VMojd8kFKU8uUlJZ+c066kTN++uwPGJFMSogUPXMV90aSkspi4pd5yx9hal/Q/LgiBkg=
X-Received: by 2002:a17:903:243:b0:196:4e61:b6b5 with SMTP id
 j3-20020a170903024300b001964e61b6b5mr4473743plh.2.1675620628916; Sun, 05 Feb
 2023 10:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20230204204124.80741-1-kostya.farber@gmail.com>
In-Reply-To: <20230204204124.80741-1-kostya.farber@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Feb 2023 13:10:17 -0500
Message-ID: <CAPig+cQrGHuqmmWvqBNs2PKEp_KPrVKVcZyJ3u7akS4BrpA4dw@mail.gmail.com>
Subject: Re: [PATCH] t5000: modernise archive and :(glob) test
To:     Kostya Farber <kostya.farber@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2023 at 3:54 PM Kostya Farber <kostya.farber@gmail.com> wrote:
> To match present day coding guiding codelines let's:

We can probably just say "coding guidelines" rather than "coding
guiding codelines".

> - use <<-EOF, so we can indent all lines to the
>   the same level for this test
>
> - use <<\EOF to notify the reader that no interpolation
>   is exepected in the body

s/exepected/expected/

> Signed-off-by: Kostya Farber <kostya.farber@gmail.com>
> ---

For other reviewers who may not have been following along, this is a
suggested replacement[1] to a rejected (by me[2]) GSoC
microproject[3].

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> @@ -402,11 +402,11 @@ test_expect_success GZIP 'extract tgz file (external gzip)' '
>  test_expect_success 'archive and :(glob)' '
>         git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
> -       cat >expect <<EOF &&
> -a/
> -a/bin/
> -a/bin/sh
> -EOF
> +       cat >expect <<-\EOF &&
> +       a/
> +       a/bin/
> +       a/bin/sh
> +       EOF
>         test_cmp expect actual
>  '

Thanks, these changes look fine.

[1]: https://lore.kernel.org/git/CAPig+cR+1bxgitSmJ47PxD=CPxJjMh5Vm+zRdVU8iEo9pvtutw@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cTC4TUK2NXFmP6ymEYYjYAmCSd53dzFhKn0ido8x6uh1Q@mail.gmail.com/
[3]: https://lore.kernel.org/git/20230202202557.19297-1-kostya.farber@gmail.com/
