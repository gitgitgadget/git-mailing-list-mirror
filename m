Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7302C433FE
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 06:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiACGia (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 01:38:30 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:55234 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACGi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 01:38:28 -0500
Received: by mail-pj1-f52.google.com with SMTP id jw3so28092677pjb.4
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 22:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzQsHo87M5maurdaZkyp4Ov0uQp3Klw9IToVaJ3EkXM=;
        b=wA0Ct6vONZU+kuRJB/ti4FVS/9Nm97A65zmZIp8vrDdO8h4LiQWHzA9E3hhitO7QKL
         7mIhRBIO07h0gy8Ajtv3kS/Ok6vfYtikfcZdGTLQSoOJh55eFFI3u62PXbxT7GPXrOxL
         k29dm3CjQPHmuGqzg8/pU/M3sms/0/aT5pBSPeulKSVOgVkKyStBIaEQrR48bMi5HnWQ
         4UPqFnMkuW8DBHXv3VxOVpUJP57Hzwf1FJ4igSVUNsa04sW+uhqh5TuLijvt1NGQO9YK
         zCqQ+e3NDPhP1BYnnp6ibQP4LLcCidT7PxmOmWtadrgxBgQlCjbnvGBia3mYuQqGJoQ9
         /VHQ==
X-Gm-Message-State: AOAM532SN3cApncB2cgal8Tg4pj+WDzMWt4tvY+qUp0wlRyZBjpulFPk
        b6ephIJZ2ErlNKVBf80v8/+YFNo/b/EQKi46ctc=
X-Google-Smtp-Source: ABdhPJzYkANdqiCR2hFwTZFtXM1uFkSQPCuwx9m5MiKyAKSG9ryXzHZpOqtFIvq4Rt2WAalvuH3BczmKmYnsXnHTzMk=
X-Received: by 2002:a17:902:e211:b0:149:8bd6:583b with SMTP id
 u17-20020a170902e21100b001498bd6583bmr27936304plb.35.1641191908304; Sun, 02
 Jan 2022 22:38:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <e2a0a458115a26cfb855f7040f15e5198072b3a5.1640727143.git.gitgitgadget@gmail.com>
 <CAPig+cTn1049oZQwcLk82LPoOZ9N3mYQifSDObejdcvZwo6ZJg@mail.gmail.com> <940635e7-ff92-d87d-5dfb-a61b6320c30b@gmail.com>
In-Reply-To: <940635e7-ff92-d87d-5dfb-a61b6320c30b@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 01:38:17 -0500
Message-ID: <CAPig+cSZ_F7KAZcCs-zOq5knGzqnTkeCvnktm3QLz6-kBSjNng@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] worktree: add 'init-worktree-config' subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 30, 2021 at 12:29 PM Derrick Stolee <stolee@gmail.com> wrote:
> On 12/30/2021 3:41 AM, Eric Sunshine wrote:
> > On Tue, Dec 28, 2021 at 4:32 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> +static int init_worktree_config(int ac, const char **av, const char *prefix)
> >> +{
> >> +       struct repository *r = the_repository;
> >> +       char *common_config_file = xstrfmt("%s/config", r->commondir);
> >> +       char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> >
> > Specifically, in [1], I said that `common_config_file` should be using
> > `r->gitdir` (and that the use of `r->commondir` was correct for
> > `main_worktree_file`).
>
> Since you agree that "{r->commondir}/config.worktree" is the main
> worktree's config file, then "{r->commondir}/config" should be the
> repo-wide config file. If r->commondir and r->gitdir are different,
> then using r->gitdir would be wrong, as far as I understand it.
>
> Indeed, tracing these two values when run in a worktree, I see:
>
>   gitdir: /home/stolee/_git/git/.git/worktrees/git-upstream
>   commondir: /home/stolee/_git/git/.git
>
> So we definitely want commondir here.

Okay, it looks like I was misinterpreting how
path.c:strbuf_worktree_gitdir() worked and how it was called, and was
perhaps a bit confused by the minimal `struct repository` comments.

> >> +       if (repository_format_worktree_config)
> >> +               return 0;
> >
> > Rather than `return 0`, should this be `goto cleanup`...
>
> Right, or move the 'if' to before the configset is initialized. The
> goto is simple enough.

Moving the `if` -- in fact, all three `if`s -- earlier is enticing,
but you need to be careful not to leak `common_config_file` and
`main_worktree_file`, as well. Something like this should work, I
think:

   if (repository_format_worktree_config)
       return 0;
   if (upgrade_repository_format(r, 1) < 0)
       return error(...);
   if (git_config_set_gently(...))
       return error(...);

   common_config_file = xstrfmt(...);
   main_worktree_file = xstrfmt(...);
   git_configset_init(&cs);
   git_configset_add_file(&cs, common_config_file);
