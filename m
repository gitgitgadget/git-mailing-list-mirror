Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C6A1F461
	for <e@80x24.org>; Sun, 19 May 2019 16:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfESQ6K (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 12:58:10 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:56368 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfESQ6K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 12:58:10 -0400
Received: from bsmtp7.bon.at (unknown [192.168.181.104])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 456CYt1FQvz5tr5
        for <git@vger.kernel.org>; Sun, 19 May 2019 08:59:14 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 456CYq5gf1z5tlB;
        Sun, 19 May 2019 08:59:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 17F0520BA;
        Sun, 19 May 2019 08:59:11 +0200 (CEST)
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
References: <20190518141337.14919-1-admin@in-ici.net>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b98df9fc-384d-1d73-170c-691630454287@kdbg.org>
Date:   Sun, 19 May 2019 08:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518141337.14919-1-admin@in-ici.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.05.19 um 16:13 schrieb Dr. Adam Nielsen:
> - - If the pattern ends with a slash, it is removed for the
> -   purpose of the following description, but it would only find
> + - A slash `/` is used as a directory separator. A leading and trailing
> +   slash have special meaning and are explained in the following.
> +
> + - If the pattern ends with a slash, it would only find
>     a match with a directory.  In other words, `foo/` will match a
> -   directory `foo` and paths underneath it, but will not match a
> -   regular file or a symbolic link `foo` (this is consistent
> -   with the way how pathspec works in general in Git).
> -
> - - If the pattern does not contain a slash '/', Git treats it as
> -   a shell glob pattern and checks for a match against the
> -   pathname relative to the location of the `.gitignore` file
> -   (relative to the toplevel of the work tree if not from a
> -   `.gitignore` file).
> -
> - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> -   anything except "`/`", "`?`" matches any one character except "`/`"
> -   and "`[]`" matches one character in a selected range. See
> -   fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> -   description.
> -
> - - A leading slash matches the beginning of the pathname.
> -   For example, "/{asterisk}.c" matches "cat-file.c" but not
> -   "mozilla-sha1/sha1.c".
> +   directory `foo`, but will not match a regular file or a
> +   symbolic link `foo` (this is consistent with the way how
> +   pathspec works in general in Git).
> +
> + - If the pattern does not end with a slash, it would find a match
> +   with a file or directory.
> +
> + - If the pattern contains no slash or only a trailing slash,
> +   the pattern is matched against all files and folders (recursively)
> +   from the location of the `.gitignore` file.
> +   For example, `frotz/` matches `frotz` and `a/frotz` that
> +   is a directory (relative from the `.gitignore` file).
> +   Otherwise the pattern is matched relative to the
> +   location of the `.gitignore` file.
> +   For example, `doc/frotz/` matches `doc/frotz` directory, but not
> +   `a/doc/frotz` (relative from the `.gitignore` file).
> +
> + - The above pargraph also includes the case of a leading slash.
> +   For example, the pattern `/bar` only matches the file or
> +   folder `bar` that is at the same location as the `gitignore`
> +   file. Whereas the pattern `bar` would also match in folders
> +   below the `gitignore`  file.
> +
> + - An asterisk "`*`" matches anything except a slash.
> +   A pattern "foo/*", for example, matches "foo/test.json"
> +   (a regular file), "foo/bar" (a diretory), but it does not match
> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
> +   patter does not match "bar/hello.c" which has a slash in it.
> +   The character "`?`" matches any one character except "`/`".
> +   The range notation, e.g. `[a-zA-Z]`, can be used to match
> +   one of the characters in a range. See fnmatch(3) and the
> +   FNM_PATHNAME flag for a more detailed description.
>  
>  Two consecutive asterisks ("`**`") in patterns matched against
>  full pathname may have special meaning:

All those examples unterrupt the flow of thought in a way that makes it
diffcult to follow the reasoning. May I suggest a different approach to
upate this text? Provide two patches:

- Patch 1/2 updates the Examples section such that it contains all
  examples that you provide in the text above, with explanation.
  Perhaps refer to the Examples section early above the rules.

- Patch 2/2 updates the rules section without giving examples.

Let's see how that works out.

The examples in the Examples section are overly technical by saying

   $ cat .gitignore
   vmlinux*
   $ ls arch/foo/kernel/vm*
   arch/foo/kernel/vmlinux.lds.S
   $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore

I think that this could be made more pleasent to read if one would not
have to use a mental shell interpreter. ;)

-- Hannes
