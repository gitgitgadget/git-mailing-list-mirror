Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D541C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiIMR0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiIMR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 13:26:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3B760C2
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 09:13:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j12so12208192pfi.11
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=CorMA3AKIUQG3ICRhdrVVpHn3Kjco7gZU6gBcW3+njI=;
        b=ahvLLfeARisZZUCPFY1/15iwOFJVhGBKRcpiBhneUmCGMlNWmzt0DOcaZ6rc1lcfIw
         qKsD1QVDniLYhakmHoaS4Y9sxv2MiM2dZjFss/p3WevHWC9kLHJLKB9Tg9O0sItaWyZa
         gqyh10vTPiUqrso+A6Hi12Ojbmnetohklk8jhEMe3+lOgYqCtHbOvUUjQfJPKuCPnCnt
         UUI291Kiw3XC/dAttpfvPnC4HcSI6Hl4UDpn0kLROGMUuS8G0CYvdrCyZXVfOp3R6LhF
         uR3BOSiOu0VedNvBgc2K4wTg0LldIRDyWONMdlS5Pl7xNpM86kMIGz62hQCNXf+OQwVu
         iG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=CorMA3AKIUQG3ICRhdrVVpHn3Kjco7gZU6gBcW3+njI=;
        b=ty0s2zUJ4dhNe3nEeBO5KOm7QhbqEEuO+5c8qRqCEkkL6OX7wYOuk1JPeDsGt1Fly4
         wdl4Ns8r/1KRX0HMq2vgm1+tX8/0ZDOgEBfhxkeojIKhhH9kF46M0btalnAZ9ImQRu9m
         DN00Urf3DXav5i5l6FJZ8osagFodIDMcSHBRJfZuz+HZsLEyhn6SOe3VraMxClwLOtYA
         TspCT82W0vIRWOvuJNDyVqaoqsPFtqRsLOVemhNsjPeN4CqfIK/2yqmSHHZK1flsSJp8
         IoxQYQdrFlGj9oQNwqphPSjtdQBF+MG5+9f6mxP/pyH03w2bLjUksLln4eulfq/XbXQa
         dNkQ==
X-Gm-Message-State: ACgBeo30wEi4uXl8nm5ACaddDsh4xDGcML+qAF6NWO79x3tSeX0pbuXb
        tMjb201t+tqlXq+YJ63cx1+lo7DKpN0=
X-Google-Smtp-Source: AA6agR61yzehHMW2WbAHf1m1lj9p/x1PZ4f1FEBQ3dY8ENmmnpWb/Iei07JvmqNMxg8eF14Iu+rmWQ==
X-Received: by 2002:a05:6a00:16d6:b0:53b:3e58:1c6f with SMTP id l22-20020a056a0016d600b0053b3e581c6fmr33582888pfc.7.1663085613289;
        Tue, 13 Sep 2022 09:13:33 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o187-20020a625ac4000000b00537e40747adsm8037699pfb.36.2022.09.13.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:13:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH] fuzz: add basic fuzz testing for git command
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 09:13:32 -0700
In-Reply-To: <pull.1351.git.1663078962231.gitgitgadget@gmail.com> (Arthur Chan
        via GitGitGadget's message of "Tue, 13 Sep 2022 14:22:42 +0000")
Message-ID: <xmqqv8pr9rrn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  .gitignore        |   2 +
>  Makefile          |   2 +
>  fuzz-cmd-base.c   | 117 ++++++++++++++++++++++++++++++++++++++++++++++
>  fuzz-cmd-base.h   |  13 ++++++
>  fuzz-cmd-status.c |  68 +++++++++++++++++++++++++++
>  5 files changed, 202 insertions(+)
>  create mode 100644 fuzz-cmd-base.c
>  create mode 100644 fuzz-cmd-base.h
>  create mode 100644 fuzz-cmd-status.c

Just like we have t/ hierarchy for testing, if we plan to add more
fuzz-* related things on top of what we already have (like those
that can be seen in the context of this patch), I would prefer to
see a creation of fuzz/ hierarchy and move existing stuff there as
the first step before adding more.

And more fuzzing is good, if we can afford it ;-)

Thanks.

Even though I am not taking this patch as-is, let's give a cursory
look to make sure the future iteration can be more reviewable by
pointing out various CodingGuidelines issues.

> diff --git a/fuzz-cmd-base.c b/fuzz-cmd-base.c
> new file mode 100644
> index 00000000000..98f05c78372
> --- /dev/null
> +++ b/fuzz-cmd-base.c
> @@ -0,0 +1,117 @@
> +#include "cache.h"

Good to have this as the first thing.

> +#include "fuzz-cmd-base.h"
> +
> +
> +/*
> + * This function is used to randomize the content of a file with the
> + * random data. The random data normally come from the fuzzing engine
> + * LibFuzzer in order to create randomization of the git file worktree
> + * and possibly messing up of certain git config file to fuzz different
> + * git command execution logic.
> + */
> +void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size) {

Unlike other control structure with multiple statements in a block,
the surrounding braces {} around function block sit on their own
lines.  I.e.

    void randomize_git_file(char *dir, char *name, char *data_chunk, int data_size)
    {


> +   char fname[256];

In our codebase, tab-width is 8 and we indent with tabs.

Use <strbuf.h> and avoid snprintf(), e.g.

	struct strbuf fname = STRBUF_INIT;
	strbuf_addf(&fname, "%s/%s", dir, name);
	... use fname.buf ...
	strbuf_release(&fname);

> +   FILE *fp;
> +

Good that you leave a blank between the end of decl and the
beginning of the statements.

> +   snprintf(fname, 255, "%s/%s", dir, name);
> +
> +   fp = fopen(fname, "wb");
> +   if (fp) {
> +      fwrite(data_chunk, 1, data_size, fp);
> +      fclose(fp);
> +   }
> +}

Why doesn't this care about errors at all?  Not even fopen errors?

> +/*
> + * This function is the variants of the above functions which takes
> + * in a set of target files to be processed. These target file are

"... is a variant of the above function, which takes a set of ..."

> + * passing to the above function one by one for content rewrite.
> + */
> +void randomize_git_files(char *dir, char *name_set[], int files_count, char *data, int size) {
> +   int data_size = size / files_count;
> +
> +   for(int i=0; i<files_count; i++) {

We do not yet officially allow variable decl for for() statement
like this.  We'll start allowing it later this year but we are
waiting for oddball platform/compiler folks to scream right now.

IOW, we write the above more like so:

	int data_size = size / files_count;
	int i;

        for (i = 0; i < files_count; i++) {

Take also notice how we use whitespaces around non-unary operators.

> +      char *data_chunk = malloc(data_size);
> +      memcpy(data_chunk, data + (i * data_size), data_size);
> +      randomize_git_file(dir, name_set[i], data_chunk, data_size);
> +
> +      free(data_chunk);
> +   }

As data_size does not change in this loop and the contents of
data_chunk from each round is discardable, allocating once outside
may make more sense.  Actually, as the called function makes only
read-only accesses of data_chunk, I do not quite see why you need to
make a copy in the first place.

We do not use malloc() etc. directly out of the system; study wrapper.c
and find xmalloc() and friends.

What if size is not a multiple of files_count, by the way?

I'll stop here as we already have plenty above (read: it is not "I
didn't spot any problems in the patch after this point").

Thanks.
