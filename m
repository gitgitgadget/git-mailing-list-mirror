Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587731F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbcJTXvI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 19:51:08 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35617 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbcJTXvH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 19:51:07 -0400
Received: by mail-qt0-f181.google.com with SMTP id f6so74015838qtd.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=53HGEzPJlndHwjvjODlrVAvtB1nrPyomh7+xgDWJOXI=;
        b=Aau3qskRUPRZeowvLAdqgfuxqEHKv5pExvI+g9tOUWLH44/Vc937aLnMvEgGcwO4sW
         20W95wHlFdk4uWPcAwO9BJbkX3gwOPLfZpo1xZje9U9fyq8r6MPEX18rqeYXJqNE0PUf
         LFkErF4Q8NX3nHPw6SvwTcxOcGVn/D6TsqXdksJJx0sYw/2tmZN7livw3nj72Z6LlrBG
         RV2gkfpiMkebcuOV3bqBZZzmCaOjYJ/TKWaccz3QQZtGV5jW1AUs7P0gq7Ii03oWl0WZ
         OzsL8RMsOeD1D6Cv4cB0mwhNscw81cl8O/FXY4e3YTn11+OamYQufA7yIIwKz3mTl/0V
         L6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=53HGEzPJlndHwjvjODlrVAvtB1nrPyomh7+xgDWJOXI=;
        b=MkPoiyf19xOjG0wa/OiJYwxKJZmW7RIk38WAbvanu/kZiv9lJPvbh1HvzUyVczh2sh
         HpXrxzRoEt2+0mJP4llC+kamPx1+PbqMjLuE/8XJmSllfsBuzFLDlSzQcriBXu168pEK
         KRz2NoYW716Czv7FjWLNUuuo9f3uaZVkZrau/ZnPDl8virbegsk+df4/wNlXnWfxBZvE
         Orv7bfIVYFLRBf7YvH0CJWwpQeSby9h+YQj5kAZebcVJz/LGifnq9UpLW+TWv10gstIo
         JWI/rNtdzM1OmokFIV50obORAJtBZ5q5Yu6kwPVfuGZrJRGFEkLLow+H+WY7WVoyvoVT
         Ap/A==
X-Gm-Message-State: ABUngvfDYnMisZkCDkCDjgTso49M68osbikl7N8CtHM1B211BPTZZrE5j8B7mJe1bl/oK4CClUzwepDTC3Eh+wee
X-Received: by 10.200.51.240 with SMTP id d45mr3135156qtb.18.1477007466637;
 Thu, 20 Oct 2016 16:51:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 16:51:06 -0700 (PDT)
In-Reply-To: <20161020232915.GB3667@pug.qqx.org>
References: <20161020232915.GB3667@pug.qqx.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 16:51:06 -0700
Message-ID: <CAGZ79kY69xtmPrwXWk6O6iSAYnViaO_R6_QY4KaX+qF51ouD6Q@mail.gmail.com>
Subject: Re: A couple errors dealing with uninitialized submodules
To:     Aaron Schrab <aaron@schrab.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 4:29 PM, Aaron Schrab <aaron@schrab.com> wrote:
> I was working with a fresh clone of a repository where I'd forgotten that
> one of the directories was setup as a submodule, so I hadn't initialized it.
>
> I tried to add a symlink to a location outside the repository and this
> failed with an assertion (exact text in comment below). When looking into
> that I realized that the directory was meant to be a submodule and decided
> to try to change that.  So I tried to remove the submodule, and got an error
> (misleadingly) saying that couldn't be done because it uses a .git
> directory.
>
> I first noticed this with git 2.9.3 from Debian unstable, but I also see it
> building from v2.10.1-502-g6598894 fetched from master recently.
>
> The following script replicates both of these issues. These could both be
> classified as "don't do that", although at lease the assertion is quite
> ugly.
>
> --- >8 ----
> #!/bin/sh -e
>
> directory=$(mktemp -d)
> echo "Using directory '$directory'"
> cd $directory
> git init --quiet orig
> (
>  cd orig
>  # Using a random, small repository for the submodule.
>  git submodule --quiet add https://github.com/diepm/vim-rest-console.git sub
>  git commit -m init >/dev/null
> )
> git clone --quiet orig dup
> cd dup
>
> (
>  cd sub
>  ln -s /tmp/dont_care
>  # Next command aborts with
>  # git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <=
> item->len && item->prefix <= item->len' failed.`

For this bug see
https://public-inbox.org/git/CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com/
Specifically try this patch
https://public-inbox.org/git/CAGZ79kZaZCwZ-cesB_voq0s0Qt+ipcgb6TkdzLE+EWSF_qRj7A@mail.gmail.com/

>  git add . || : expected to fail
> )
>
> rm -f .git/index.lock
> # Next command fails with error wrongly saying that the submodule uses a
> .git
> # directory.  I believe that the real problem is that the uninitialized
> # submodule has content.
> git rm sub
