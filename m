Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A61C352A1
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 11:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCE821927
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGZlkYGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgBELmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:42:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52597 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgBELmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 06:42:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so2125519wmc.2
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 03:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hn2rmsARALnDyhUAoZ9hO5XgP+MjuJb8JZLDu1mwlB8=;
        b=EGZlkYGMv9uz7xFu+ahwzqYW3J4M3ylLrqntLGguLLTwsus/Jgt3fdX2cEmsHBJPmj
         UTjIlrMHzGdoHZ9mgs+2X6FyLF0PxZJTZkAzWJKxmRoDteXSvwCazqY3dCAvDBjIrmlS
         azDF5g8XVgqodfvupgfAELRYY1TfuhA20Dm01mp4izyn1Xy5LqeFQvL/pYge6Jb7zKjR
         mObYIREa21rGbgbQoCMcSUfF8QVWwYNPzdKKSBM83T9g6mJ1D//+gWBnSJOi8tqW8aeq
         ABxbRuCBwTPfcXNOU5aejH5CZ8mklE0vOMbjoV5aOj+0nRsB/ElYLjQ2N/0OrN6e13LF
         YCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hn2rmsARALnDyhUAoZ9hO5XgP+MjuJb8JZLDu1mwlB8=;
        b=YLTWJ4dCMNgjPCnBhZOj3m6xhBN1vZgV521CFuyvxCEaWvUvUXvitNAaqRV4VUK3I7
         CP4iFDilo+H7KME3GWlvWBfiXnZCrJcJQxScpSov7FKdwzXN2aJ98a+WK5fav9R52Z32
         8SpsvG4LoPn3LFx5PGynB8wg7+s/NVHSKJJ3KYpCHvedFN1ZZsvZv1Z+Dz3Vfz/d5O00
         HN9H/aicP/ncqiZHeZVfV/dX6VzxYB/q87A2aJqqInHLzwh+Lh2IWek47qLgd7+UITAA
         eV3r7v8o5FJAnJW6jvhOANeKUWGPQaEAOEmphmj4dAkigAf2TsPGBfH4nhVP8iIhexIV
         xSoQ==
X-Gm-Message-State: APjAAAX2jdfdSxC6qFhcluCnTNkvb1Ny6wQEgVd+gmsrjReECGMkdAWS
        WFBr0E23Xcn5AUdWO//HWlI=
X-Google-Smtp-Source: APXvYqxhOzO/Rl+ZW+4s9FThYG1yLTsJLa/MdsUW8J2eC0vqSbVpf9CoPEdsIwvAbtaGajll4hijTg==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr5244422wmi.75.1580902934139;
        Wed, 05 Feb 2020 03:42:14 -0800 (PST)
Received: from szeder.dev (x4dbd62a5.dyn.telefonica.de. [77.189.98.165])
        by smtp.gmail.com with ESMTPSA id s12sm17553994wrw.20.2020.02.05.03.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 03:42:13 -0800 (PST)
Date:   Wed, 5 Feb 2020 12:42:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 3/6] create .git/refs in files-backend.c
Message-ID: <20200205114210.GL10482@szeder.dev>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 08:27:37PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This prepares for supporting the reftable format, which will want
> create its own file system layout in .git

This breaks 'git init', and, consequently, the whole test suite:

  $ ./git init /tmp/foo
  /tmp/foo/.git/refs/tmp/foo/.git/refs/heads: No such file or directory


>  builtin/init-db.c    | 2 --
>  refs/files-backend.c | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 944ec77fe1..45bdea0589 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -226,8 +226,6 @@ static int create_default_files(const char *template_path,
>  	 * We need to create a "refs" dir in any case so that older
>  	 * versions of git can tell that this is a repository.
>  	 */
> -	safe_create_dir(git_path("refs"), 1);
> -	adjust_shared_perm(git_path("refs"));
>  
>  	if (refs_init_db(&err))
>  		die("failed to set up refs db: %s", err.buf);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0ea66a28b6..0c53b246e8 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3158,6 +3158,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	files_ref_path(refs, &sb, "refs");
> +	safe_create_dir(sb.buf, 1);
> +        /* adjust permissions even if directory already exists. */
> +	adjust_shared_perm(sb.buf);
> +
>  	/*
>  	 * Create .git/refs/{heads,tags}
>  	 */
> -- 
> gitgitgadget
> 
