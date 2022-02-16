Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA44C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 04:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbiBPEKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:10:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiBPEKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 23:10:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76704FCB66
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:10:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gb39so1728384ejc.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 20:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfgmZSRzBuseivifQQH5BaB6/b7I8LvsIEiZHkwjIdo=;
        b=kuPINUy2avw5vselE34zYP3CxujtHsDu7IR19Dvr+NqcvEJmb9qMOPLXU2o+ZebX8R
         8k3b6MMP4GRDPrUd6LkQdaDDthaOgD8satY+xIvlXZgrT/BkoxV2G8YqvXZZf3SBmdUY
         2a4/cuM+AIOj6BKdwWCOR4xH6CAjMzrNU8o3OCr2tYq0wkwfDQ9TkrUFeatv4fKXUmYy
         WibPLVuda+3WjavaMai1fNhqHC4X/kIp3MSVZmD/pvlEha6xDL1lzReFHV9EiUnY3YdC
         F8Ylz9lFurQgqUohP/QlC4Vcuze0R62AJS1rjEm+PWjIlTXh3DckIp7knxrj6nRgMBUx
         2IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfgmZSRzBuseivifQQH5BaB6/b7I8LvsIEiZHkwjIdo=;
        b=WWm+zfrfLBHEkFFRk6/mFa1Gq583QCw5u8hn/Z1tVIeYE/b/fGI1x6NZbPcJJyzQBd
         ziW/budOS90Y2Bew19fIfk4C9ChFOxVNf8Q7v2aPZAcu/gfeKjNJos2d5UYQcqvBov+G
         3f6ep5gXuGUIe2Q7lLPBP8dkT9+SnLNtnxW2X7iWx/7HrOEv53/g1qoEDpxE1Ivp0Dqt
         QtLezRxiXmLVzP7Ij/+qghhZVyGK0VR9axg5r/UQLHRXyj/WrtW4xkwBomumi/2HagHs
         OO/NZQ8uCj/4RrIma5qpyLmEex/Qe1wo0JTbGeyDOGMEVS33APOMjFC/UJ1Qmehyxy6e
         wM/A==
X-Gm-Message-State: AOAM531VbOyclsjIXVQnJimSqSwOr85j/feL4J1aNd/s5IsCCIlm3Uax
        VQKTifgByYQF86RnI7ees6+3XE3IdA9Pdk06HnY=
X-Google-Smtp-Source: ABdhPJyzoT2Ir7f9BX2uTF4i85hUD6BwHgdq8B2etnXufKlsxOgVaVaGmt6deaexZSIgxdr0q+zMa+ZPF+Ohby5e/kI=
X-Received: by 2002:a17:906:64e:b0:6ce:36ae:7ab5 with SMTP id
 t14-20020a170906064e00b006ce36ae7ab5mr856862ejb.192.1644984603940; Tue, 15
 Feb 2022 20:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20220215221615.20683-1-patrick.marlier@gmail.com>
In-Reply-To: <20220215221615.20683-1-patrick.marlier@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Feb 2022 20:09:52 -0800
Message-ID: <CABPp-BEimfkjKugBGkUkbcfCnsvgBEXdPq_wSVCNk-O7-nOV=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] clean: avoid looking for nested repository when appropriate
To:     Patrick Marlier <patrick.marlier@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 15, 2022 at 2:16 PM Patrick Marlier
<patrick.marlier@gmail.com> wrote:
>
> avoiding the unnecessary checks for is_nonbare_repository_dir() via setting DIR_NO_GITLINKS

Looks great, but a few details about commit messages that we like to see:

  * Please wrap commit messages at 72 characters
  * Describe your changes in imperative mood (i.e. "Avoid the
unnecessary" rather than "avoiding the unnecessary")
  * Use complete sentences for everything other than the subject.

So, perhaps:

"""
clean: avoid looking for nested repositories when unnecessary

With `git clean --ff` we will be deleting nested untracked repositories,
so there is no need to differentiate them from other untracked files.
Use the DIR_NO_GITLINKS flag in dir.flags to signify this and avoid the
is_nonbare_repository_dir() checks.
"""

> ---
>  builtin/clean.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 3ff02bbbff..18b37e3fd9 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -955,9 +955,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>                                   " refusing to clean"));
>         }
>
> -       if (force > 1)
> +       if (force > 1) {
>                 rm_flags = 0;
> -       else
> +               dir.flags |= DIR_NO_GITLINKS;
> +       } else
>                 dir.flags |= DIR_SKIP_NESTED_GIT;
>
>         dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
> --
> 2.35.1
