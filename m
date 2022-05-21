Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B6C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 00:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbiEUAO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiEUAOz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 20:14:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709D0674FD
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:14:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j4so8167254edq.6
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xI7eaAQzcSsXk0zqo0gTkzQxrwqBy0Y+12l8WZ5OplE=;
        b=gbpQDieiSaUXAhFS0YHDU1vFbJRLjQYOKXhaCn1VVeVUTj+AOkUSNJbz3vE2G0tW2m
         MSO67328dERYTongCTEFpONHInuuGW98nGDDSF9jENY9SltLUOWPNyz4OMienXbQefvT
         dmoO3Tgeq2EX4uZsIx4n/IeyxtmUYLEPgCItfOQCg5SYvpAtXTfR1bQ3RMF9HE6j1LOb
         hYLsWCwrOB58WVH/u+luEYlnhZKUeDVd7soY+7EInnFopX8LTBP/h7I0DNzy9IVQm9Wd
         jdS+q/qjhA0hexgEU1+JA1ll8xycP4C7RLk2yof05fhklwgQln89ctfB/RaeRCoUvxW3
         s+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xI7eaAQzcSsXk0zqo0gTkzQxrwqBy0Y+12l8WZ5OplE=;
        b=c07NS2YXximiJC0fSSckNCDJmPvtsshHdNXADpfkmFc6ys56gRwHGXyGLmXAqCELLx
         TKlC5E/6+AxE5avBP0aLnfI1bFZfK5c8PclSyZERKo6TWGNeuQ1vONbAaPvNDMWHxD95
         T+Lwa9UNzT2wuEDZSMXycDS1LIirPpQm3P3eJpMUNZ9r7bt9d0SQh3fv4WN2WnGEJdGB
         74wCMpjdA7CZmQ9kVAbgFZqsYP/EbxTjNI0oxaPp3CZi0OU2OYTzbbyAo3PxJp7cM7y2
         3pXbH3MJR7kH1RUEg7cqbRxoLHhghYZMjuyRL9HoL1frP86TpAAMnUSsoipK/5KOimW6
         lXfQ==
X-Gm-Message-State: AOAM532r7JQdFJW2WnWykPiNnFtvu9F++ulvjjVR+ntWNun+nU9UBCPX
        uZ3QAbEWkekWe6xCyAF872aWK+8E1UsHGTdz8sb03hXW
X-Google-Smtp-Source: ABdhPJzWcAtl4gbA/CKGgcKoq3i4EXerj5mTCYqkPG25zMbUB8rLR82Mb4+suRYXzbRh6ChKb1GUVk0Q/u3sebvyyhM=
X-Received: by 2002:aa7:cac8:0:b0:42b:258d:1cc1 with SMTP id
 l8-20020aa7cac8000000b0042b258d1cc1mr6902204edt.22.1653092092899; Fri, 20 May
 2022 17:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
In-Reply-To: <80eeba2b2a58af2a5497f398beb5c03447c41f61.1653003552.git.kevin@kevinlocke.name>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 May 2022 17:14:41 -0700
Message-ID: <CABPp-BH+=zd_ZpPMy=S5Q-ygTW85ZXD9-RLOk9Apt_Q1_SgzzA@mail.gmail.com>
Subject: Re: [PATCH] setup: don't die if realpath(3) fails on getcwd(3)
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for sending along a fix!

On Thu, May 19, 2022 at 4:39 PM Kevin Locke <kevin@kevinlocke.name> wrote:
>
> Prior to Git 2.35.0, git could be run from an inaccessible working
> directory so long as the git repository specified by options and/or
> environment variables was accessible.  For example:

Ah, good point.

>     git init repo
>     mkdir -p a/b
>     cd a/b
>     chmod u-x ..
>     git -C "${PWD%/a/b}/repo" status
>
> If this example seems a bit contrived, consider running with the
> repository owner as a substitute UID (e.g. with runuser(1) or sudo(8))
> without ensuring the working directory is accessible by that user.
>
> The code added by e6f8861bd4 to preserve the working directory attempts

When referencing commits in commit messages, this project prefers that the first
reference in the commit message use the output from `git log --no-walk
--pretty=reference $HASH` rather than just $HASH.
So, here, it'd be

    The code added by e6f8861bd4 (setup: introduce
startup_info->original_cwd, 2021-12-09) to preserve the ...

> to normalize the path using strbuf_realpath().  If that fails, as in the
> case above, it is treated as a fatal error.  To avoid this, we can
> continue after the error.  At worst, git will fail to detect that the
> working directory is inside the worktree, resulting in the pre-2.35.0
> behavior of not preserving the working directory.
>
> Fixes: e6f8861bd4 ("setup: introduce startup_info->original_cwd")

I was slightly surprised to see this tag, but it appears others in
git.git have used it, so it must just be me that's not familiar with
it.

> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>

Nicely explained commit message.

> ---
>  setup.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index a7b36f3ffb..fb68caaae0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -458,11 +458,13 @@ static void setup_original_cwd(void)
>          *     not startup_info->original_cwd.
>          */
>
> -       /* Normalize the directory */
> -       strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -       free((char*)tmp_original_cwd);
> +       /* Try to normalize the directory.  Fails if ancestor not readable. */

Is that the only reason it fails?  I'm unsure if the second half of
the comment helps there.

> +       if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +               free((char*)tmp_original_cwd);
> +               startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +       } else

git.git coding style: if either of the if/else blocks use braces, use
braces for both

> +               startup_info->original_cwd = tmp_original_cwd;

tmp_original_cwd is not required to be normalized, and there are very
strong normalization assumptions on startup_info->original_cwd.  While
a non-normalized value would work to get pre-2.35.0 behavior, it's by
accident rather than design, and might be confusing for others to
later reason about.  Also, I think it might be possible for
tmp_original_cwd to still be NULL, and some of the immediately
following code I believe will assume it's operating with a non-NULL
value, so you'd need to skip that stuff.  I think the else block here
should use "goto no_prevention_needed", as the no_prevention_needed
block will handle setting startup_info->original_cwd to NULL for you,
and get you the pre-2.35.0 behavior.

>         tmp_original_cwd = NULL;

After changing the above else block to a goto, you may also want to
copy this to the no_prevention_needed block or else copy it to the
else portion of the block above (just before the goto you add).

> -       startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>
>         /*
>          * Get our worktree; we only protect the current working directory
> --
> 2.35.1

Again, thanks for sending in a bug fix!  Looking forward to seeing
your revised patch.
