Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F54C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA17206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfL3V4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:56:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43427 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3V4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:56:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so33836920wre.10
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 13:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slzVo2GqwA2ELGujWLwfw6SWmA8y1lIwnXMRJg6Iy58=;
        b=D6ptv1/BVmDpVOg21dWUqn5ldUQNZ7OQKINTfWR+v0YBc6gBRca2dXQs+zI2BTqZKt
         Dthp66Vo2z+5bH0WK6zyiHyzA+bEcwjhIR71jrOjK/KTVdbM1Lh4vu2It4f/5OiakdyN
         S85uSxt5+s/l/IeiJQsum2OTk+0ytx8NJ9EV3jXwHBzRLpmAZnfw4mXu654YnZ4Ng0GY
         DAJFhH+m/QTsNwHFxpuJO4qQLekprb3w+xgvIi7wULgN93FfXdRzbbhlCQWPhQrfTMac
         /T0YpNmwsmY5wZxc6h79naBdkr9//NRpayZtm3nqsO5uRdt+ID3j7da8ecKNjULs4qkJ
         ntRw==
X-Gm-Message-State: APjAAAVraKHn67obKl6Q/smbUw49BKfFcZzm5TIR3zvp7/JRKuQ3+y0f
        mBtXfpNlaX2eIKG3j4kHiuUXJ4DODF3vcz+Ezlrl6vKP
X-Google-Smtp-Source: APXvYqxv1ZZfHn0Wm5P0U3pszOukHHKbC99IxTELQXR8Goqm0jjpxuchEC656xJlMIm3jRidbiVMgiwXBIEAcYxGaqw=
X-Received: by 2002:adf:f382:: with SMTP id m2mr69157268wro.163.1577742969724;
 Mon, 30 Dec 2019 13:56:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.503.git.1577727747.gitgitgadget@gmail.com>
 <pull.503.v2.git.1577733329.gitgitgadget@gmail.com> <6193dc7396b9cc6cb78f382c1b1679d6bb455fe4.1577733329.git.gitgitgadget@gmail.com>
In-Reply-To: <6193dc7396b9cc6cb78f382c1b1679d6bb455fe4.1577733329.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Dec 2019 16:55:58 -0500
Message-ID: <CAPig+cSSqAxuHYg9DxuJzC7m2HAt8F2YPNxT0x5+SksCGic4MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] t: fix quotes tests for --pathspec-from-file
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 30, 2019 at 2:15 PM Alexandr Miloslavskiy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> While working on the next patch, I also noticed that quotes testing via
> `"\"file\\101.t\""` was somewhat incorrect: I escaped `\` one time while
> I had to escape it two times! Tests still worked due to `"` being
> preserved which in turn prevented pathspec from matching files.
>
> Fix this by properly escaping one more time.
>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
> diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
> @@ -109,7 +109,10 @@ test_expect_success 'CRLF delimiters' '
> -       printf "\"file\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
> +       # shell  takes \\\\101 and spits \\101
> +       # printf takes   \\101 and spits  \101
> +       # git    takes    \101 and spits     A
> +       printf "\"file\\\\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&

So, you want git-checkout to receive the following, quotes, backslash,
and no newline, on its standard input?

    "file\101.t"

If so, another way to achieve the same without taxing the brain of the
reader or the next person who works on this code would be:

    tr -d "\012" | git checkout --pathspec-from-file=- HEAD^1 <<-\EOF &&
    "file\101.t"
    EOF

Although it's three lines long, the body of the here-doc is the
literal text you want sent to the Git command, so no counting
backslashes, and no need for a lengthy in-code comment.

But is the "no newline" bit indeed intentional? If not, then a simple
echo would be even easier (though with a bit more escaping):

    echo "\"file\101.t\"" | git checkout --pathspec-from-file=- HEAD^1 &&
