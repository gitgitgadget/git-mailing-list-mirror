Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4453C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 10:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbiBJKLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:11:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiBJKLB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 05:11:01 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA1FD5
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 02:11:02 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v47so13888833ybi.4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uX7KNhnq+J4xWZYQtS196kD2EVMEuF6HXnEBRhaXfI=;
        b=GrGyzXW0OJ2drVVa3/lpyYJtGB4YAdY/0u2J+FJFvxOpVdE3EFYXgYeCK1J6F424UC
         Yi2iRSCciUAVLu6QXmulYd1a8W9FJEqTr0Nk0TkuKq3ofrFPdo7jik/XXm+/CjOr508o
         Ss7qn9CAo/lZveQY/dALqsVpYaM35v5dplJyp55Gb++p8OfWgqYV9iW8yy7lDwYcx/aF
         UjaeRC/InCRb+tvLrZP4nfk6gJa6lqJXtnWzs5ciB7EPrc5JitixUMuT+L2aAJ2gXPfi
         5Gx7CoI1AyyCXylvBY9EriUmuRMUIONDnrX+jVfv2sHjFYGeRPFhoZcMm1GToHFcCmjm
         4jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uX7KNhnq+J4xWZYQtS196kD2EVMEuF6HXnEBRhaXfI=;
        b=Wq5/T58Uc/72vVlBKTuq/Z9jccn1x14IzukdSjY2sdOo/bHPMz8AON3bVTIde1NLTD
         cudCtHfIR6GTwczxf+vj2uB7BF3QmL05dLCnprJuouaWEfZY8+fW0rThmyPMBgmjLp4B
         8K6yQDsJ7rH+30L30mL0eXCMXtxA6ou7yVu3Rym9dCHeN4CIsLKywzl4AfadKF8ZYl0X
         5k+Y85Orck3kLeGegOFXfRhmqzhGbF9dJnkGaww8xyDwt2ikwdIU1fNmzqQj1IFWkk/e
         otHabMfwTSNV5+fmOhGuTuz5degwSiUABABQvWbJa3wJXsP4dVNrsSbPeR3chSQqb/LD
         lJQw==
X-Gm-Message-State: AOAM530j6FAuX88Ut6XN0wiGxqz/bIuD0JjKlgQMEK5LOwV0UA85PgpK
        aZfaL6Wc6PLBYBZC1Cnr0CDMH984xwyQRQpc9z8=
X-Google-Smtp-Source: ABdhPJwPfTQyNWmnp06wrrAgaVN3RkKMGR9Cm2thaCga1xxOZ+klT2uTAXesCZmxeCeOU6w6xveuH/jN+z1lnHijOlk=
X-Received: by 2002:a25:9e08:: with SMTP id m8mr5992744ybq.629.1644487861347;
 Thu, 10 Feb 2022 02:11:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com> <81bc5ae1fc1415b9bd751d93ba1ad305e31af4d6.1644465706.git.gitgitgadget@gmail.com>
In-Reply-To: <81bc5ae1fc1415b9bd751d93ba1ad305e31af4d6.1644465706.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 10 Feb 2022 11:10:50 +0100
Message-ID: <CAP8UFD1axq6x624pLFMZNT5H5nUdwWFZ0Eb8MQy8eYd3+6qthA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] cat-file: introduce batch_mode enum to replace print_contents
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 9:46 AM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: John Cai <johncai86@gmail.com>
>
> The next patch introduces a new --batch-command flag. Including --batch
> and --batch-check, we will have a total of three batch modes. Currently,
> from the batch_options struct's perspective, print_options is the only

Here you talk about "print_options"...

> member used to distinguish between the different modes. This makes the
> code harder to read.
>
> To reduce potential confusion, replace print_contents with an enum to

...but here it's "print_contents".

Also it would perhaps be a bit clearer if you introduced it saying
something like "the print_contents flag (or boolean?) is the only
member..."

> help readability and clarity.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: John Cai <johncai86@gmail.com>

> @@ -635,7 +640,15 @@ static int batch_option_callback(const struct option *opt,
>         }
>
>         bo->enabled = 1;
> -       bo->print_contents = !strcmp(opt->long_name, "batch");
> +
> +       if (!strcmp(opt->long_name, "batch")) {
> +               bo->batch_mode = BATCH_MODE_CONTENTS;
> +       } else if (!strcmp(opt->long_name, "batch-check")) {
> +               bo->batch_mode = BATCH_MODE_INFO;
> +       } else {
> +               BUG("%s given to batch-option-callback", opt->long_name);
> +       }

I think we prefer to remove braces when there is only one instruction.
So the above could be just:

       if (!strcmp(opt->long_name, "batch"))
               bo->batch_mode = BATCH_MODE_CONTENTS;
       else if (!strcmp(opt->long_name, "batch-check"))
               bo->batch_mode = BATCH_MODE_INFO;
       else
               BUG("%s given to batch-option-callback", opt->long_name);
