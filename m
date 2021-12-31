Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EAC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 03:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhLaDGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 22:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbhLaDGe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 22:06:34 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9AC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:06:34 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h21so31441942ljh.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 19:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9a67kV6F8pRi2/dDotXq3Gbp0T8KW4UuVftGsTwxTw=;
        b=ZN/AuC71TZyd9gJWgCU6xPtVTiQrCyLYlaT10Iuq3cY23fvVc3NHv+2FSD6FqmK0PU
         nwxowKSrNhhHJijynoppHDEbllB72BkUo91Zf5h43bonZw/qxTmeZNK9w+6o/WUl9sl4
         j/PVsO4SX2XeYWQbtnkhKwjVjczdeOX14eEjlIDNVomY5c+jfeWCJ3gjvWmbDQdLlEym
         3oVIIaGmFxiHtjzWoanpln6pd4gi4qYKUbWRWgY64mLENYSI4awvazeFopfpmPlgwYiY
         YYkVNqVZ+bAqQSctgOa8EdhG2EYkFYnk8cmoRCqsCaM85+chICb1PwuYzEnMjCVCt/O2
         eksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9a67kV6F8pRi2/dDotXq3Gbp0T8KW4UuVftGsTwxTw=;
        b=dnK1of3qAIaqTp6V6m/qYBzTl+UA3IOZ1qxfNq3GHyCy0HQKpbqqVAcN1D4EhJxan5
         Jm4wV8BFcYp48M0p0qZoawjcY3wI2ZT5zb6Vdc9OFqAPQczk0FurNOdV3xww1jPuRslm
         S2pKY95m1GYVePip8M0+z7QYJj+A3P0jhCWdsTRDXqHD1PrYKe5gYDpW6pSdNXOCAMXq
         YvRbBBN05oK5cp2agAL1RYgeEvONKZAb8LJd6W3etYt8gNlOLPxV3KPRSmthWUG4EKdv
         9n9XC6UDWtaZr0D/p37XvI2mPSdDC43fyCWPSk5gV8Q/ClZRmOJEFbq8accfDbfzX2sq
         tH0Q==
X-Gm-Message-State: AOAM532B2JoVUX5ADRoeHkf37zYfPVTA4WE9TLlhUALj6pwAPwvEcIVK
        v33OZoID86GZcqYyf4/r2jaQS/PwlizxIFQBXFY=
X-Google-Smtp-Source: ABdhPJyG46TD4YH4JoeWgIrGl5TlQAX9De4UYx0HvRcq/G4BwRWpLsFDAcmHz14VsHrymNLdU+jST7apOF1Vi1n7km0=
X-Received: by 2002:a2e:361a:: with SMTP id d26mr26302191lja.56.1640919992604;
 Thu, 30 Dec 2021 19:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-2-chiyutianyi@gmail.com>
In-Reply-To: <20211221115201.12120-2-chiyutianyi@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 31 Dec 2021 11:06:21 +0800
Message-ID: <CANYiYbESw-hP8R+075uGb-H_uJpAcBftn1AcyCcDZ_UbD_S6-Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 2:33 AM Han Xin <chiyutianyi@gmail.com> wrote:
>
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> In dry_run mode, "get_data()" is used to verify the inflation of data,
> and the returned buffer will not be used at all and will be freed
> immediately. Even in dry_run mode, it is dangerous to allocate a
> full-size buffer for a large blob object. Therefore, only allocate a
> low memory footprint when calling "get_data()" in dry_run mode.
>
> Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  builtin/unpack-objects.c            | 23 +++++++++---
>  t/t5590-unpack-non-delta-objects.sh | 57 +++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100755 t/t5590-unpack-non-delta-objects.sh
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 4a9466295b..9104eb48da 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -96,15 +96,21 @@ static void use(int bytes)
>         display_throughput(progress, consumed_bytes);
>  }
>
> -static void *get_data(unsigned long size)
> +static void *get_data(size_t size, int dry_run)

After a offline talk with Han Xin, we feel it is not necessary to pass
"dry_run" as a argument, use the file-scope static variable directly
in "get_data()".

>  {
>         git_zstream stream;
> -       void *buf = xmallocz(size);
> +       size_t bufsize;
> +       void *buf;
>
>         memset(&stream, 0, sizeof(stream));
> +       if (dry_run && size > 8192)

Use the file-scope static variable "dry_run".
