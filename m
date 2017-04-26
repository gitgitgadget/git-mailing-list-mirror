Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3065C207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 21:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030452AbdDZVUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 17:20:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36794 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030449AbdDZVUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 17:20:18 -0400
Received: by mail-pf0-f182.google.com with SMTP id 194so6257783pfv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mojGHibEd85Y5pZHz44XicuMCgABVhK4rudT3UmJia0=;
        b=tEamPTXfIC6AVlrB/TYlHQYvrFfpaqYMI9+8z7IFfsmF+K/4/waSEJSS/HYdVEDSFs
         ve6wG3zRR3018hf03xcSy7YkJ9Mj2K8wOOOaPHFGgmh249oNmlfftGqjoVdwUTxxy72F
         ZX4oBKlm6y0/mGeOf8i63Z0YeBAFMzHsE9vKtaDldeyetiIcreppmhzDvjB1/mFDt4kp
         fKjQePFaK1B+M2JpZJz8S6/ZyHD9WYk5cXoXflvHHej101cyQiw1Q5Soobv1zMuydHUW
         0iErEtQQnJ7eOzRAbBozAgT8RyupbgwZttugzrEErnJCIaAy3dT/soaWN/ZdJmVET+Nn
         t2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mojGHibEd85Y5pZHz44XicuMCgABVhK4rudT3UmJia0=;
        b=Hz0EScYTzqrscCGqdZxqb1JtWr53MBeY8hxGLFdNNCWMIUCzrl7dwNmFKlEJcBTOXe
         czpT85jd2BtfoKEdS/FDKv3aDWx0V/SzLQV+u7C4RUkTA9kmLo1kmk1+Lx1Ab2iaDbnD
         QM36i7+Viu/so3tUBP+5+sOmLZHy56A0mdNAuFsBTTVlCcXcJsJNq3fILeoELJcQ7J53
         61/191A6GIJn8Viz6BuP2x3vmEKRNGnDdz+TkVT4t6NRVnpkjgf0QZWrQnA5giuU89z4
         nCToTawbEZrixRgWYI5RvtUhv5LTICU3QsWQE/HQSzpyypppEh5XnbW9gGz81NXWtYFB
         /iFg==
X-Gm-Message-State: AN3rC/4ayMCBIQDi+BKw7X+2kPcOLweTauBgSkw5UbNof0PctV2H8S8W
        seqmhTxCzHMlF5uIT7vXTuZCedGLxltA
X-Received: by 10.98.90.6 with SMTP id o6mr2046813pfb.101.1493241617396; Wed,
 26 Apr 2017 14:20:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 26 Apr 2017 14:20:16 -0700 (PDT)
In-Reply-To: <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Apr 2017 14:20:16 -0700
Message-ID: <CAGZ79kaJGLQjg09WMuK6v9yPpwmFnNkDq+4Tg0O7JUYEPaCjOw@mail.gmail.com>
Subject: Re: [PATCH 14/26] setup_bare_git_dir(): fix memory leak
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 1:20 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 0309c278218..0320a9ad14c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
>
>         /* --work-tree is set without --git-dir; use discovered one */
>         if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> -               const char *gitdir;
> +               static const char *gitdir;

This alone doesn't fix the memleak if the code were called multiple times.
As by having it static it will be init'd to NULL, we could introduce a

    static const char *gitdir; /* must live until the end of time because ... */
    if (!gitdir)
        die("BUG: called setup_bare_git_dir twice?");

I tried looking into setup_explicit_git_dir that is called with gitdir here
and it looks like it duplicates the memory in most cases, so maybe we
can even get away with no static variable here and instead either inline
the gitdir computation in the arguments of setup_explicit_git_dir
or have a variable here that holds the returns of setup_explicit_git_dir
such that we can free after?

Thanks,
Stefan
