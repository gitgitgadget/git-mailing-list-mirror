Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40D81F790
	for <e@80x24.org>; Tue,  2 May 2017 17:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdEBRUc (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:20:32 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32788 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdEBRUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:20:30 -0400
Received: by mail-pf0-f169.google.com with SMTP id q20so311132pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=in3XxDabqgGKDIRKYlKRrsT1bTLyT/Ixi1GSo0yxzUM=;
        b=fSDvFQEn0Yaac0RL6/+WNMrZSv46qnzUG392YQlSNng67wgQEC1UiPGlQCfq1QFMil
         Xe7prlgnycWBQ5ExDPiz3KAq8PXCWma/Nhqg6DdgvHnIizh4KJoCrnkDvDtq0MHRjuxA
         gy31St8AmGG4grk5ihIF5WUwLF4gxs454GQIyqzVo+kriNHnS+zJlzDCin+kiJvrzDVx
         7ZmPeTtfFRIZCbMcgGijQza1WFTJZ0GJi5gOZOaT0nMUZYcpuCTmi++1jN4b+mb/oCn8
         O7iL0kfaWBNkVF2cxy3WMUJNdxU33u9EpBXfmE70tD41jNvJ+jGHwsJ2ef8hw0i2I7XB
         3mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=in3XxDabqgGKDIRKYlKRrsT1bTLyT/Ixi1GSo0yxzUM=;
        b=M4u9pXvlCNTJJafLJ7S1UpudJJnr+sJomn/Ug2/GXJcOmrhqYM+alp9pulYiCmVFkC
         CdrFsY0c3Mxa1XiiJ/vfe5A0iEJcZHvsIFJMZG2KJY4nsNyF7p6x3aK+gQG3x5Aeuiu9
         gTGNiCiZNRPnHl5cWEfm1Q0lXsBXEDa9XZ9GSfedfLOuAXSxYK5nIg9R8QUSWSDtwtIy
         iSBnMKqeS3Us/HJlwN/naiD47WRhtGEvtddgax63LUDv7RvHsVRNJVz+bR+IRJEtl4H8
         nWyshAIe1CHaRE2eLce7j9rDXFRR8LATlX31sfRr+cgSXIpQEBYRA5ibEBTybBvTI59Q
         0HIg==
X-Gm-Message-State: AN3rC/5p4wRpklZZ7wAxCui546CzdbKlMgv+2Fglyqyf/b1IMLKgpUG4
        7gQsb+CirbZEEOcmO67LQ4XpKnLEETz/
X-Received: by 10.99.60.81 with SMTP id i17mr23950448pgn.183.1493745629732;
 Tue, 02 May 2017 10:20:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Tue, 2 May 2017 10:20:29 -0700 (PDT)
In-Reply-To: <ab131705c4383dc408860b516b1e18b0753b0cbf.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de>
 <cover.1493740497.git.johannes.schindelin@gmx.de> <ab131705c4383dc408860b516b1e18b0753b0cbf.1493740497.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 May 2017 10:20:29 -0700
Message-ID: <CAGZ79kbsy1qh02WjX0nt6ci4r+5DVxJcPzwburBf0TP0qaEMTA@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] setup_discovered_git_dir(): plug memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 9:02 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The setup_explicit_git_dir() function does not take custody of the string
> passed as first parameter; we have to release it if we turned the value of
> git_dir into an absolute path.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  setup.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 0320a9ad14c..e3f7699a902 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>
>         /* --work-tree is set without --git-dir; use discovered one */
>         if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> +               char *to_free = NULL;
> +               const char *ret;
> +
>                 if (offset != cwd->len && !is_absolute_path(gitdir))
> -                       gitdir = real_pathdup(gitdir, 1);
> +                       gitdir = to_free = real_pathdup(gitdir, 1);
>                 if (chdir(cwd->buf))
>                         die_errno("Could not come back to cwd");

As the original motivation was to shut up Coverity, this may not
accomplish that goal, as in the path of taking the die_errno, we do not
free `to_free`. But that is ok as the actual goal is to hav no memleaks
in the good case. A memleak just before a die is no big deal.

> -               return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
> +               ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
> +               free(to_free);
> +               return ret;

And we free our pathdup from above, makes sense.

Thanks,
Stefan
