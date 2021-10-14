Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48493C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A89661027
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhJNUJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhJNUJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:09:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9728BC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:07:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so581155wmg.3
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4OJZm+pP/CuCL4Yy1knc2a9XP/+3ZJI6GeFxw9Z+yVM=;
        b=X3bgNmrTlu7SuX/8b59TFp02aCFpm3WZwcvF9FEt9theE9LPpKPJfK2E7xLwkI1flc
         Lm0HhVrcfEhTrVIolekEeLVtEX4Te7dvTFDLGrN5NVuS8/ID2LORIKr/hhHKKsvXJx4p
         hreiWpMZkpTsUyVDshMm2Hw0e+V8ggxZY6b0O7A1VPWr1ROww1/pryTATDRT8711w9ka
         Aa2zZDA9fO0niF7NP525KuxFZfggsqE+XEv5nmfxa8imUhnqgMUj58unBP8Y+iaEq8iE
         iuY9sLXZSjN2jvq5bG3HiQuk+liU6fBPgUFhrublraxsxiLpAPgWrsgjLHlYOoZlnM0n
         9+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4OJZm+pP/CuCL4Yy1knc2a9XP/+3ZJI6GeFxw9Z+yVM=;
        b=zCUhD5tZ7QYxeQ3C5ULq6TxqAPJcBCZ6UnRgI7fFPTNzzxyf0O9Kpmz981O2w5/MCw
         04QCD9NBEWHfo1w4t7uUdY730vAwrMjS4em2Uf+kSPaSkw03yLADGriF5oJZTxBWuUA4
         yOnR44JirW5VmCsGQAo3ayDnVxdJzH9gIxHI/YeJvPEGgietcHGuYYc3Zy61Q/aH6IV3
         5vi8Cn7ujKgAFrquUzZOmhV3r5lvOVHEHHvFOJfjBRtqOn7YdwGWlojV4xWeO+odY600
         n3/OZr94vzHteLZouOSa4FeR4g+RiKq08o5GdQ4G3xw8oeG3/1qfm0l3qdnxokRphxFR
         3Fmg==
X-Gm-Message-State: AOAM5327t/BjJKkM6JeXXJPaMycLMEbNWwLTobpfXv5c/rdG3jWE6kvr
        uKeezUMHylOEK0KMYVFZ0wmBtnTu0+FGFw==
X-Google-Smtp-Source: ABdhPJy7aLnK6K9FFJVSR2BAesNHgAFCoB/Ca3cZaLvAxVRKFnAullBSozpL6f3Yzb1ynbn6RhqU+w==
X-Received: by 2002:a05:600c:2104:: with SMTP id u4mr18926320wml.195.1634242032004;
        Thu, 14 Oct 2021 13:07:12 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 10sm5513136wme.27.2021.10.14.13.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 13:07:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: To "const char *" and cast on free(), or "char *" and no cast...
Date:   Thu, 14 Oct 2021 21:54:19 +0200
References: <patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com>
 <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8f87cdb9-b52b-8d1a-545d-ed3055c536c0@gmail.com>
Message-ID: <87mtnbfk0g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 14 2021, Phillip Wood wrote:

[Changed $subject]

> On 14/10/2021 01:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The "checkout" command is one of the main sources of leaks in the test
>> suite, let's fix the common ones by not leaking from the "struct
>> branch_info".
>> Doing this is rather straightforward, albeit verbose, we need to
>> xstrdup() constant strings going into the struct, and free() the ones
>> we clobber as we go along.
>
> It's great to see these leaks being fixed. I wonder though if it would
> be better to change the structure definition so that 'name' and 'path'=20
> are no longer 'const'. That would be a better reflection of the new
> regime.[...]

I think this is the right thing to do, but I'm not quite sure. There was
a thread at it here:

    https://lore.kernel.org/git/YUZG0D5ayEWd7MLP@carlos-mbp.lan/

Where I chimed in and suggested exactly what you're saying here, but the
consensus seemed to go the other way, and if you grep:

    git grep -F 'free((char *)'

You can see that we use this pattern pretty widely.

> It would also mean we could lose all the casts when freeing
> and there would be a compiler warning if a string literal is assigned
> to one of those fields.

What compiler/set of warnings gives you a warning when you do that? I
don't get warned on e.g.:

    diff --git a/builtin/checkout.c b/builtin/checkout.c
    index a32af16d5e4..d7053579bdf 100644
    --- a/builtin/checkout.c
    +++ b/builtin/checkout.c
    @@ -94 +94 @@ struct branch_info {
    -       const char *name; /* The short name used */
    +       char *name; /* The short name used */
    @@ -110 +110 @@ static void branch_info_release(struct branch_info *inf=
o)
    -       free((char *)info->name);
    +       free(info->name);
    @@ -1107 +1107 @@ static int switch_branches(const struct checkout_opts=
 *opts,
    -               new_branch_info->name =3D xstrdup("(empty)");
    +               new_branch_info->name =3D "(empty)";

Now, what is really useful is making it a "char * const", especially
when hacking up these changes as you'll find all the assignments, but I
haven't found the general use in having that make it to a submitted
patch, since you need to assign somewhere, and those then need to be a
str[n]cpy() (except we banned.h it) or memcpy() with a cast...
