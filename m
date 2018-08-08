Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76A31F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeHHVUs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:48 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37156 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeHHVUs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so2349929ywg.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUsx7oqX/uWdB1DE9vjjs6g/r3MSpfC/74niGVyA5S0=;
        b=Gfy89ongTfI77v33DohT3ZokC2j8RDICtxN8CFSCfjMFni752XnFVDxaLYsVXLbMPx
         IgkRL/Yp2U20eqzo3jBu68taGFgCQXKiblhCElt3hsamJAVrhZI/60H6SkuPJ/neWQTO
         FPZ2dFI4/gTdUHSbf8ElyRogqR5L9239MdzOTuhh4w0pf9FV/idmjVP4dSMgk8TFK/pq
         RRhWU/FyEiQfWO10MI7hk/Fiakxj73/bslVBkYWxjutXNANum6jnaOKLGm5Odb56iUop
         lf8jSyaQalXgQPY7ph/PqE/ELuAEn3wzBNABUDTyiCiC82snzt1TfTzqNYcs+EVQqz7f
         1f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUsx7oqX/uWdB1DE9vjjs6g/r3MSpfC/74niGVyA5S0=;
        b=uZ5r/5aH57aG78A7t8AO3fnuNpYY89XMfk0weuby5QJ7iAt255uZodFGJPKAimRmS7
         JWiqqJ9bc9fRj9rZL9E9q8LqV2PRyzpSMgpUzdsBVqQmZ07i5i+H6AYAa61qRdSSuaPb
         Da3var8xw/804tfkuCyTLdIwg8bwckQ4VvqLgzovYsSdbXCUpDOkV1EAh2zQD/h0kp4s
         NJpJB5/kCi+t9Xig3qaTf+h7SX8gFHXZrmGM9zRRXC7E+jpn9f0VEkk2TNNOUdEx3dsu
         4hah/APHmSWfdwQqlFgBHW91RP2ccRq6SUgPnakcYArnfZoanO9QlNRKlKJSyHNrWT+C
         QUDg==
X-Gm-Message-State: AOUpUlHOKpf5q/TmGEqpdei5Cyivkz3b8r7jbYl4+R70VAkh+NHwdvgn
        ODvXjolSrKgIdY9Ziq6zKHD2ty+4YsPDyTtjaJHhsQ==
X-Google-Smtp-Source: AA+uWPx+UJ4LxpPsavF8C+/nOenbYszoihhe5V5u4hyjqWNsJTQjUlKdrie13KbQGbNazpaP2M9e5NSI6H2wav7hknE=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr2161723ybm.307.1533754786608;
 Wed, 08 Aug 2018 11:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-10-predatoramigo@gmail.com>
In-Reply-To: <20180808134830.19949-10-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Aug 2018 11:59:35 -0700
Message-ID: <CAGZ79kafP=dVrwWopXW0WCWf199sU6uFSphjxtMTXDSix4Y81Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] builtin rebase: start a new rebase only if none is
 in progress
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 6:51 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> To run a new rebase, there needs to be a check to assure that no other
> rebase is in progress. New rebase operation cannot start until an
> ongoing rebase operation completes or is terminated.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---
>  builtin/rebase.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 8a7bf3d468..a261f552f1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -87,6 +87,7 @@ struct rebase_options {
>                 REBASE_VERBOSE = 1<<1,
>                 REBASE_DIFFSTAT = 1<<2,
>                 REBASE_FORCE = 1<<3,
> +               REBASE_INTERACTIVE_EXPLICIT = 1<<4,
>         } flags;
>         struct strbuf git_am_opt;
>  };
> @@ -392,10 +393,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 .git_am_opt = STRBUF_INIT,
>         };
>         const char *branch_name;
> -       int ret, flags;
> +       int ret, flags, in_progress = 0;
>         int ok_to_skip_pre_rebase = 0;
>         struct strbuf msg = STRBUF_INIT;
>         struct strbuf revisions = STRBUF_INIT;
> +       struct strbuf buf = STRBUF_INIT;
>         struct object_id merge_base;
>         struct option builtin_rebase_options[] = {
>                 OPT_STRING(0, "onto", &options.onto_name,
> @@ -447,6 +449,30 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>
>         git_config(rebase_config, &options);
>
> +       if (is_directory(apply_dir())) {
> +               options.type = REBASE_AM;
> +               options.state_dir = apply_dir();
> +       } else if (is_directory(merge_dir())) {
> +               strbuf_reset(&buf);
> +               strbuf_addf(&buf, "%s/rewritten", merge_dir());
> +               if (is_directory(buf.buf)) {
> +                       options.type = REBASE_PRESERVE_MERGES;
> +                       options.flags |= REBASE_INTERACTIVE_EXPLICIT;
> +               } else {
> +                       strbuf_reset(&buf);
> +                       strbuf_addf(&buf, "%s/interactive", merge_dir());
> +                       if(file_exists(buf.buf)) {
> +                               options.type = REBASE_INTERACTIVE;
> +                               options.flags |= REBASE_INTERACTIVE_EXPLICIT;
> +                       } else
> +                               options.type = REBASE_MERGE;
> +               }
> +               options.state_dir = merge_dir();
> +       }
> +
> +       if (options.type != REBASE_UNSPECIFIED)
> +               in_progress = 1;
> +
>         argc = parse_options(argc, argv, prefix,
>                              builtin_rebase_options,
>                              builtin_rebase_usage, 0);
> @@ -455,6 +481,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>                 usage_with_options(builtin_rebase_usage,
>                                    builtin_rebase_options);
>
> +       /* Make sure no rebase is in progress */

The faithful conversion doesn't even stop at the comments. ;-)
I shortly wondered if this is the best place for this comment,
but let's just keep it here to have the 1:1 rewrite.


> +       if (in_progress) {
[...]
> +                   state_dir_base, cmd_live_rebase,buf.buf);

In case a resend is needed, add a whitespace after the
comma and buf.buf, please.

So far I have not seen anything major that would warrant a resend.

Thanks,
Stefan
