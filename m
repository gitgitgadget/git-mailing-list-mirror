Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D507C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2225B6128D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1VG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1VG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:06:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2138C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:05:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id a13so134800oid.9
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAl7ksAqLL/6CNv9+wIAmdeEqNb3M9aP1lO3qmHHxcU=;
        b=owt40G0YYb0GKefJ6B+VuTCgfyZXSJ4YMo/vvOBENL0r3tYTfcyKoAW5K7pdBcxXga
         elhsJpAQeyaRkdDXUClNUUMy3+eYE2lxCqO0u1A8/UJsMFiT+o+HZoChf+rVXidbkjZX
         jSXfPSbe0dWM/LoNOymf7oMRUGglMrKq35aR+Hbrm9ERWHqOgT3r8I9gFPGj+yJNneGG
         /PLDqjLMlY9ihaNd8QG2O1N/4WMF0aUpupIBT0pQUX2jeOTVegusQXqbT/L0MWP6n9aM
         eNgSS3GPT+UaeeRBam59Qs/X9jGPv7R0tOGxUdTqqOC9ZWILzC2eRhI9E4DIPl+FPnCW
         5tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAl7ksAqLL/6CNv9+wIAmdeEqNb3M9aP1lO3qmHHxcU=;
        b=gGYGHwzd483ShF1K8MaeCSDEDpKuSS6RJfgewx7vKSrfWAy/nhHNS1KtGOrIIykQMi
         pw1PvVvrJN+RlyEDGH/9xTiVBMygUanBlTeuDmet89ck/2TXQPU9FrLGWj5CDjphS83e
         QDYYdffcRVIIoC/l1tOR7boAYb6OFUbfyyjDzsPyjmFW8/579nmOZPplARVCVSisTOWb
         wixa3dcIZ1A/VRRoi+i4GMCupt1OvSI9Pkt3aV/K01E2bckbjzIPKeRRP/L2lvuGsCtp
         KdyQ1ZZVAM1WJYEKMQGHPz1Il1VG5WYdnnsMKnxgV8Veo+8BPKkyjeBEw1dD3w/MGxGa
         WG9Q==
X-Gm-Message-State: AOAM531SooNI8qAFJd+engJkQdpuFOYtuJVV7MVVusgyiqTBUAtcP7xL
        vkvSoDNRKqlMZLM4BteD8ns8iAzH2VAtv9EcvRs=
X-Google-Smtp-Source: ABdhPJzIqpSyAIhpYkbfXaAQ7CTQ9zDnfZA8dZFL0h5CE7vgEa25ct9WqNCpxuZzrcgwLSF+xtn7uegFE2c1UDsitGM=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr7397284oiw.31.1622235920184;
 Fri, 28 May 2021 14:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com> <20210528201014.2175179-11-felipe.contreras@gmail.com>
In-Reply-To: <20210528201014.2175179-11-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 14:05:09 -0700
Message-ID: <CABPp-BHs_id3kOHgBWCK0QjviuRu7Dgbq5iB7z5=RZDOX-ontA@mail.gmail.com>
Subject: Re: [PATCH 10/11] push: flip !triangular for centralized
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Git is a *distributed* version control system, centralized workflows are
> the uncommon case, where we do need to do extra checks.

The commit message seemed slightly funny to me, though I'm not sure
why.  However...

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/push.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index 8ecfbe8d63..1856f62861 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
>            "    git push %s HEAD:<name-of-remote-branch>\n");
>
>  static void setup_push_upstream(struct remote *remote, struct branch *branch,
> -                               int triangular)
> +                               int centralized)
>  {
>         if (!branch)
>                 die(_(message_detached_head_die), remote->name);
> @@ -201,7 +201,7 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
>         if (branch->merge_nr != 1)
>                 die(_("The current branch %s has multiple upstream branches, "
>                     "refusing to push."), branch->name);
> -       if (triangular)
> +       if (!centralized)
>                 die(_("You are pushing to remote '%s', which is not the upstream of\n"
>                       "your current branch '%s', without telling me what to push\n"
>                       "to update which remote branch."),
> @@ -210,12 +210,12 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
>         refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
>  }
>
> -static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
> +static void setup_push_simple(struct remote *remote, struct branch *branch, int centralized)
>  {
>         if (!branch)
>                 die(_(message_detached_head_die), remote->name);
>
> -       if (!triangular) {
> +       if (centralized) {
>                 if (!branch->merge_nr || !branch->merge || !branch->remote_name)
>                         die(_("The current branch %s has no upstream branch.\n"
>                             "To push the current branch and set the remote as upstream, use\n"
> @@ -238,7 +238,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
>  static void setup_default_push_refspecs(struct remote *remote)
>  {
>         struct branch *branch = branch_get(NULL);
> -       int triangular = remote != remote_get(NULL);
> +       int centralized = remote == remote_get(NULL);
>
>         switch (push_default) {
>         default:
> @@ -248,15 +248,15 @@ static void setup_default_push_refspecs(struct remote *remote)
>
>         case PUSH_DEFAULT_UNSPECIFIED:
>         case PUSH_DEFAULT_SIMPLE:
> -               setup_push_simple(remote, branch, triangular);
> +               setup_push_simple(remote, branch, centralized);
>                 break;
>
>         case PUSH_DEFAULT_UPSTREAM:
> -               setup_push_upstream(remote, branch, triangular);
> +               setup_push_upstream(remote, branch, centralized);
>                 break;
>
>         case PUSH_DEFAULT_CURRENT:
> -               setup_push_simple(remote, branch, 1);
> +               setup_push_simple(remote, branch, 0);
>                 break;
>
>         case PUSH_DEFAULT_NOTHING:
> --
> 2.32.0.rc0

...I think the code is slightly easier to read and reason about since
it removes the double negative.  In particular, when someone reading
the code sees !triangular, and doesn't know or remember the meaning,
they have to translate that to !(remote != remote_get(NULL)).
centralized and !centralized do not have that same problem.  So, I
like the newer version.
