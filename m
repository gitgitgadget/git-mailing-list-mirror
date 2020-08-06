Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21E9C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCFA20748
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHFU02 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 6 Aug 2020 16:26:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38029 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFU02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:26:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id t14so10884694wmi.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fy/w9iTkP0R123Ze5+ISs2YvR3hW8SYDatTXh0UonyM=;
        b=QF3HcS34qmdC1AeLor7spSWtlpUsoqydcadz8sCLHi6Vb3oEZbNDp6jtuHZX/GW4v9
         WRV2T46kJprSmWcCeNE0y4o0wxpKWiTUmgCJMpMQUetiTTzlaa5G54mGDvNgiJ0sELHS
         1QFC1rnAPhqk80PEPUqlHKpacpD/6eg0jKGbYlzvHCgLsKe9xJqloEQiZ9meUxJNro/+
         bKDLDG1Zjqbn8sXR/8vamzpaWvvqitFAglQR+tZXcDFTCC01Hrwd/4JienxDMKnG/xwu
         5n0ZIO/z+CZmEIv4zPq+nlQsA6aMvJWSNn8hfkJGBLh+H8gZaUomjO1egDZn38HBtORc
         Rg/w==
X-Gm-Message-State: AOAM532oHTcJO3S7+qIbYrMVgzxvcasfgxzLCy0pJc0VwMyQ+SuaFUL4
        DjDqKQ5zEBms1GA/ho7Q0GO5vygapfQhhjwfqGc=
X-Google-Smtp-Source: ABdhPJxyHSNx8kG0RJyHzIp9PqGk8lMtkvlpjPG8QcNv+PJiIEFjvs5ah5Ml37ATUMSnUfc3c57W+QW3+6tYABm4rsg=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr9403379wmh.11.1596745586045;
 Thu, 06 Aug 2020 13:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200802143018.5501-1-martin.agren@gmail.com> <cover.1596742823.git.martin.agren@gmail.com>
 <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
In-Reply-To: <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Aug 2020 16:26:15 -0400
Message-ID: <CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: don't spuriously close and reopen quotes
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 6, 2020 at 4:09 PM Martin Ågren <martin.agren@gmail.com> wrote:
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> @@ -364,7 +364,7 @@ test_expect_success 'set up an unresolved merge' '
>         fifth=$(git rev-parse fifth) &&
> -       echo "$fifth            branch 'fifth' of ." |
> +       echo "$fifth            branch fifth of ." |
>         git fmt-merge-msg >msg &&

This one is a bit weird. It really seems as if the intent was to quote
the word "fifth" in the merge message, so dropping the quotes
altogether seems wrong. However, the file 'msg' is never even
consulted in this test (or any other test), so is this just "dead
code" (including the leading 'fifth=' assignment which also is
otherwise unused outside the 'echo')?

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -213,7 +213,7 @@ test_expect_success 'fetch tags when there is no tags' '
>  test_expect_success 'fetch following tags' '
>         cd "$D" &&
> -       git tag -a -m 'annotated' anno HEAD &&
> +       git tag -a -m "annotated" anno HEAD &&

There are a fair number of these quoted single-token arguments
containing no special characters which don't actually need to be
quoted at all, so an alternative would be simply to drop the quotes
altogether, making the commands less syntactically noisy. However,
that might be outside the intended scope of this change.
