Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33ED21F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdGYXoF (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:44:05 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35003 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdGYXoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:44:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id h29so28910182pfd.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dz/T07fG5M3fbX4US/iwBuzvx9OBOeCKosW9uHD6buc=;
        b=fY6Zj5UCF8o2O+p3goblCoO6KkXhm3+l7wlifa3ES+UKYr+n77IHq4hkqC8tHSoEtg
         SwdBouyxQiMq4W3wHwQqViKOPdXw5VYtELY72KY+Y3/SYmNQTaNCLp85ZL3z38SXtPvz
         qg8XUClo9fu3LT9SIM8NVwoCO2EiH5L3uJptgG71CGad8H7BHjqyrIRgSnfa68o3ewyp
         RJrSZxYhP3qhGSXXUd6SOCaFMKuFVAITZaV4XIbXn0BSJ9SncyV7PBcOUPDAn3d9oOpn
         O3OdDySvh/JhuBZqhPSh29GnbU1mYXpb4Q2SKVIksv1XvGLhxSac6ZCEfZWk0D70ali4
         0WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dz/T07fG5M3fbX4US/iwBuzvx9OBOeCKosW9uHD6buc=;
        b=FCum8T9IhHKnRu1LYK3UIKhB3NtrKESEQxJWboarOfydUatwzOSfe6Jy6tzFuenvyc
         pE+QavWxKybR9REvahqJz7qsOej7PfmbZOCdaFcUXNwtiPJAeVcuEOPoPhLTPqTA0d1n
         1NXhNU5mRCU7bzDCsT9nEVsDWIqS4114SpERPwN4ykvygzSgBVgK6UAOQv5J7iBGCcgs
         qDjztb2DhbSWJ8Dt/WOwcWwm+VFuX6kB4gn4L6Knujcxeim7CD8ZKGpJpzVLlAwc1Td3
         HcBvf36+bfY79okakMayB7eTufqbyYvqGglEs4feA2Qy6gZKbzP2eJVODUHOoL7yEm32
         bwRA==
X-Gm-Message-State: AIVw112TIlZzj46KvfxW/IExJoRaJaxLKjJDZL3ksuGTchKoAwMLsAy2
        SblaO4QwZeBo7Ogh8fJBaCjtih/rj79f
X-Received: by 10.99.97.12 with SMTP id v12mr18376501pgb.97.1501026244645;
 Tue, 25 Jul 2017 16:44:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:44:04 -0700 (PDT)
In-Reply-To: <20170725213928.125998-7-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:44:04 -0700
Message-ID: <CAGZ79kZGFhiNAYqJ9hZqDLEZt-9jYQ=o0ej2VmO0E=pZg85Fsg@mail.gmail.com>
Subject: Re: [PATCH 06/15] fetch: don't overlay config with submodule-config
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> Don't rely on overlaying the repository's config on top of the
> submodule-config, instead query the repository's config directly for the
> fetch_recurse field.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/fetch.c |  1 -
>  submodule.c     | 24 +++++++++++++++++-------
>  2 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index d84c26391..3fe99073d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1362,7 +1362,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>
>         if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
>                 gitmodules_config();
> -               git_config(submodule_config, NULL);
>         }
>
>         if (all) {
> diff --git a/submodule.c b/submodule.c
> index 8b9e48a61..c5058a4b8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1210,14 +1210,24 @@ static int get_next_submodule(struct child_process *cp,
>
>                 default_argv = "yes";
>                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> -                       if (submodule &&
> -                           submodule->fetch_recurse !=
> -                                               RECURSE_SUBMODULES_NONE) {
> -                               if (submodule->fetch_recurse ==
> -                                               RECURSE_SUBMODULES_OFF)
> +                       int fetch_recurse = RECURSE_SUBMODULES_NONE;
> +
> +                       if (submodule) {
> +                               char *key;
> +                               const char *value;
> +
> +                               fetch_recurse = submodule->fetch_recurse;
> +                               key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> +                               if (!repo_config_get_string_const(the_repository, key, &value)) {
> +                                       fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> +                               }
> +                               free(key);
> +                       }

I wonder if it would be better to parse this in builtin/fetch.c#git_fetch_config
and then pass it in here as a parameter, instead of looking it up directly here?
That way it is easier to keep track of what a builtin pays attention to.


> +
> +                       if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> +                               if (fetch_recurse == RECURSE_SUBMODULES_OFF)
>                                         continue;
> -                               if (submodule->fetch_recurse ==
> -                                               RECURSE_SUBMODULES_ON_DEMAND) {
> +                               if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
>                                         if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
>                                                 continue;
>                                         default_argv = "on-demand";
> --
> 2.14.0.rc0.400.g1c36432dff-goog
>
