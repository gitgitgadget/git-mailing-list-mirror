Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F279C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA02613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJVQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJVQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 17:16:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045AC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 14:14:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso1110215otj.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOJucmytYnOnlogweMSlLu9vqyxB0lUyGEJraz04fGU=;
        b=DvzNUitIdEdiYwNg+7vkCI31Mb7eHxbYv+XiOKERHRpf+GN/jbqHEA+AXRaGhuqJv1
         dgrQFHz+15gKcOhZSR9x1i54nq3Br5W7pqUwCI82vFZwh5Lkf9M/qzPRFE+nH+AoWoN5
         SZj7NWSY9JLn7Ou9xuYQsIJniM6mECBxh5cGNqyKvQ3ElmQ9sKAND/zPqKMU78xYpd5/
         NpSL3vXDOY0487Q2OE5Fa7ZFFSSI0xHa04iluD0jsoIIOrffZ1BRypH+Hi5Vyp3GyA4R
         FjXTmrEn5IJR5es93+5/MPwkDQNNzfu+cURRip18s/+LwVdjl858rqNKfd5kMbfF2pPt
         pSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOJucmytYnOnlogweMSlLu9vqyxB0lUyGEJraz04fGU=;
        b=n4V7NW6H7aSHvUn5lP+8lhTlHJN1suZytSk3+tTKdtuORh2QW4yK7V9Me0NP93bZvh
         vJK1EWKRoPkB/Y5TMyiji2WKwIf6TYSxtpABI531sfGnHd7eeMWse419CkpcQ/soKkFm
         SHW56knirw4sy3sF5HwjZdBSONf1z7KkUC/r2H5Ess61tTKPUE0rbu8KAcaatWtsn4bf
         WPoLnLgzMX5UAjnoGFpYwtIpZl36pApz+h75OllFgQUoC1cvlKCbfE1vnm24nlnTsdir
         LkaH4tp9pZE/jkdFcPifKnaClThB98kiSDqQmP0x3UIEIkLWXOTIpTi9QTDyBVM+CCf+
         dBBQ==
X-Gm-Message-State: AOAM530V8dS9+iVen7w4xLIcG3Tl/6q+3G6Zo4BiMv/jyhk0Pjg9imIP
        CUwPhExDt0B2Zqb66Um6/Rcbtf7eEJf5AqJNqw4=
X-Google-Smtp-Source: ABdhPJwhRYOBqjLiQLVIFkxcwklAqbLW5jdhFFvmjCwrsHN+wDL0eQu6qwepz7sMqCX6VtW4O+xTZVwn2qaifcUGxrw=
X-Received: by 2002:a9d:426:: with SMTP id 35mr293814otc.162.1623359640348;
 Thu, 10 Jun 2021 14:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623345496.git.jonathantanmy@google.com> <e1a40108f42addf8a589c1d0ac4ed76fb525be9b.1623345496.git.jonathantanmy@google.com>
In-Reply-To: <e1a40108f42addf8a589c1d0ac4ed76fb525be9b.1623345496.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 14:13:49 -0700
Message-ID: <CABPp-BFpW7KLQGbe1kz5FNWABrTNaHOCZw3poXBMWQ9MP91GuQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] submodule: refrain from filtering GIT_CONFIG_COUNT
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding Peff to cc as per comments about 89044baa8b ("submodule: stop
sanitizing config options", 2016-05-04) below.

On Thu, Jun 10, 2021 at 10:35 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> 14111fc492 ("git: submodule honor -c credential.* from command line",
> 2016-03-01) taught Git to pass through the GIT_CONFIG_PARAMETERS
> environment variable when invoking a subprocess on behalf of a
> submodule. But when d8d77153ea ("config: allow specifying config entries
> via envvar pairs", 2021-01-15) introduced support for GIT_CONFIG_COUNT
> (and its associated GIT_CONFIG_KEY_? and GIT_CONFIG_VALUE_?), the
> subprocess mechanism wasn't updated to also pass through these
> variables.
>
> Since they are conceptually the same (d8d77153ea was written to address
> a shortcoming of GIT_CONFIG_PARAMETERS), update the submodule subprocess
> mechanism to also pass through GIT_CONFIG_COUNT.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  submodule.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 0b1d9c1dde..f09031e397 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -489,7 +489,8 @@ static void prepare_submodule_repo_env_no_git_dir(struct strvec *out)
>         const char * const *var;
>
>         for (var = local_repo_env; *var; var++) {
> -               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
> +               if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
> +                   strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
>                         strvec_push(out, *var);
>         }
>  }
> --
> 2.32.0.rc1.229.g3e70b5a671-goog

I'm super confused.  It appears that
prepare_submodule_repo_env_no_git_dir() is filtering out
"GIT_CONFIG_PARAMETERS" (CONFIG_DATA_ENVIRONMENT) and
"GIT_CONFIG_COUNT" (CONFIG_COUNT_ENVIRONMENT), using all environment
variables other than these ones.  But the commit message talks about
adding an extra environment variable, rather than filtering another
out.  I must be mis-reading something somewhere, but I'm struggling to
figure it out.

Digging around for a while led me to commit 89044baa8b ("submodule:
stop sanitizing config options", 2016-05-04), which suggests that the
passing of GIT_CONFIG_PARAMETERS is not done here but in
git-submodule.sh.  It still didn't make it clear to me why it's
stripped out here, but something makes me thing that git-submodule.sh
should be affected by your change as well.

Also, from looking at the other commit messages you reference, it
appears GIT_CONFIG_PARAMETERS was just one big environment variable,
whereas GIT_CONFIG_COUNT is closely associated with 2*N other
environment variables...so shouldn't your loop (and perhaps also
git-submodule.sh) also be checking GIT_CONFIG_KEY_\d+ and
GIT_CONFIG_VALUE_\d+ ?

I've been looking at this patch longer than I care to admit and I
still feel like I don't have a clue what's going on.
