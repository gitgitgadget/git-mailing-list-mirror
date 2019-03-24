Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC9220248
	for <e@80x24.org>; Sun, 24 Mar 2019 03:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCXDqT (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 23:46:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38308 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfCXDqT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 23:46:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so5652298wmf.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 20:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXOnFL4oTfdt3opn8B/JahlB1o6Y8alshRD6YrDZymI=;
        b=mxTt035x1jKO6dj7pbMH/nzGGNZQwMrid6dvUlyzNlwzbP5BB5oCADEh2m0qa/pjAS
         Lb1xzan9IMdShaL1++zbqyTsU272bFsj58vTgjD/Om5q6WvvcDWezfKL4Lf79hHyMHMD
         OY5822CmVGF+6xRJ9NgOlBFuXOfp4egn1Z3AgQGCluUC5m62L4tdE9X3Nmw840AzozFN
         OfqX3U6ZhRyegIUyBqfaxR61oTJYEs3uXmgbunw2HrFNfWAkWwzFzIbIdrexdLE9JBDi
         X1SWof/pXmPpQIiToaNz/C/oH3TVtXZ3kOTRPxVr9/86r0wHgD1uFOP2fUE614SXphpB
         mt7A==
X-Gm-Message-State: APjAAAXyklNQgwxDMDfw0n5YvOqWHzUWhKKB3axguoXy9DKr0PAsv5d9
        CKlF9P8eRS/13oPcbTYBslu1insIhLnHFVIze2k=
X-Google-Smtp-Source: APXvYqzx+WQ5RBhQVw7oQ4EgxqbgmWdd/ylfcHqkemSwkxBISJNBar7p28OJ7czFeqh7g0zk+weIRMUbAKCdWs/5PVA=
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr1494587wmj.31.1553399178023;
 Sat, 23 Mar 2019 20:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553354374.git.liu.denton@gmail.com> <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
In-Reply-To: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 23 Mar 2019 23:46:09 -0400
Message-ID: <CAPig+cT=jW0w==1ipD4Pem6Y+7orSH5q39j0rBhF87C8AT6Zjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 11:25 AM Denton Liu <liu.denton@gmail.com> wrote:>
> [...]
> Since rebasing onto the merge base of the branch and the upstream is
> such a common case, introduce the --keep-base option as a shortcut.
> [...]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> @@ -1541,10 +1551,19 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>         /* Make sure the branch to rebase onto is valid. */
> -       if (!options.onto_name)
> +       if (keep_base) {
> +           strbuf_reset(&buf);
> +           strbuf_addstr(&buf, options.upstream_name);
> +           strbuf_addstr(&buf, "...");
> +           options.onto_name = xstrdup(buf.buf);
> +       } else if (!options.onto_name)
>                 options.onto_name = options.upstream_name;
>         if (strstr(options.onto_name, "...")) {
>                 if (get_oid_mb(options.onto_name, &merge_base) < 0)
> +                   if (keep_base)
> +                       die(_("'%s': need exactly one merge base with branch"),
> +                               options.upstream_name);
> +                   else

Style: Indent with tabs, not spaces.
