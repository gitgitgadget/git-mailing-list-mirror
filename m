Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A135C54EBD
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbjALKP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbjALKPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 05:15:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8821A8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:15:34 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so43576075ejc.4
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nq3rbik4jSNJohVn09rBmBHZua/bzWM4F3K+bBJrx98=;
        b=fVkkE3+B1OVAAgNN8MUr6IZ+IVN3Jmm3GXmQLWeC47wn7rbsi/IoCO1gKtKkze+BG8
         SRnz/bBo/yf8M/Ml1Q1QypbeQTQTsbUPqNI/3Q8MkElCSFxabPc9cnCHudWucNqtKpGg
         9YuWqiY4nYade6a0pnK3DC3g+Bb2+yZdS33uSFSybh2lToOyK4mj6BF6fe/eyYxCSVvi
         aWOkwu9XrXDffuEJ4e0+LDY/lrXzQvtwF3dXQCymWt9MubPEKi5lUTjHFIXFfRyWjolr
         IWEb7z0o8oI6DdF79biH0Z3NFJMELjV2EE8o/MlthL7mCQLz/yyy+Z5yRdqt8kOHebir
         HtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq3rbik4jSNJohVn09rBmBHZua/bzWM4F3K+bBJrx98=;
        b=Yad0HZh5zHeH9rpeUyIwOM7BIoi3tWYnlOb0Ehiz2wR6wx0Cy+732xC6AMpPgnjpX1
         QpT8Ikc7pPeK0VdXLyQzURc0ZiBhtLTD1owGTTJWx/I/5gzc7iKkUWTc5I+HUWrxvTOc
         zH772rolA+dGhWJfk8a9z2I2BILTP3PUD6jp+haVfncAoBx7IoQtTPmbtdyDr5qeM2n3
         s2Qz2ewRcSuD7XL9rU67mBfUtc9im76v+E6ChYJDvPwDIOHtBXGMApJaYKczLfN4UfiR
         2wT8zlSZTeXaeS/uLXnWmIXKSAebvUhYe3CQi1IizB1hlX2uAeyoPYVssWK0IRgVYoJt
         XFvg==
X-Gm-Message-State: AFqh2ko9A9yDZQflIyHF40qUB8VJ0DYUnak6uI0rVHxQCayA8oiEIf/v
        r0zwOzC5q5J8BYn7HdgO67HnwLL4RxI=
X-Google-Smtp-Source: AMrXdXv3UUXVk8QTfaosdksudCc1nD8g5Jx+Wqzp/WbZaWoZ/EAUNLXDmsV4nNm/i6E6WgRnEi6qLg==
X-Received: by 2002:a17:907:c712:b0:7bd:6372:fdb4 with SMTP id ty18-20020a170907c71200b007bd6372fdb4mr87772584ejc.41.1673518532182;
        Thu, 12 Jan 2023 02:15:32 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0077077c62cadsm7261968ejd.31.2023.01.12.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:15:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFucN-0007lL-0X;
        Thu, 12 Jan 2023 11:15:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
Date:   Thu, 12 Jan 2023 11:07:59 +0100
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
Message-ID: <230112.86tu0w12kc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 11 2023, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Because sometimes we want to check if the files in the
> index match the sparse specification by using
> `git ls-files -t`, but `-t` option have semi-deprecated,
>
> So introduce "%(skipworktree)" atom to git ls-files
> `--format` option. When we use this option, if the file
> match the sparse specification and removed from working
> tree, it will output "yes", othewise, output "no".

Your code says "true" and "false", not "yes" or "no". Which is it ?:)

More generally it's unfortanute that we don't support the ref-filter.c
formats more generally, then we could just make this 1 or the empty
string, and you'd do:

	%(if)%(skipworktree)%(then)true%(else)false%(end)

Now, I don't think your change needs to be blocked by generalizing that
if/else stuff in ref-filter, that would probably be some thousand-line
series if we're lucky, even though it's a good eventual goal.

But I feel strongly that you should not pick "true", or "false", or
"yes" or "no", but rather "1" or "", here, as doing so will be
future-proof when it comes to this format being compatible with using
the ref-filter.c conditional support.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     ls-files: add %(skipworktree) atom to format option
>     
>     git ls-files -t is semi-deprecated, but in face we need to use -t option
>     to check if a file in the index match the sparse specification.
>     
>     So I think this feature can be migrated to git ls-files --format, add a
>     %(skipworktree) atom to indicate whether the file in the index match the
>     sparse specification and is removed from the working tree.
>     
>     v1: add %(skipworktree) atom to git ls-files format option.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1458%2Fadlternative%2Fzh%2Fls-file-format-skipworktree-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1458/adlternative/zh/ls-file-format-skipworktree-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1458
>
>  Documentation/git-ls-files.txt |  6 ++++++
>  builtin/ls-files.c             |  3 +++
>  t/t3013-ls-files-format.sh     | 22 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 440043cdb8e..0e50307121d 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -260,6 +260,12 @@ eolattr::
>  	that applies to the path.
>  path::
>  	The pathname of the file which is recorded in the index.
> +skipworktree::
> +	If the file in the index marked with SKIP_WORKTREE bit.
> +	It means the file do not match the sparse specification
> +	and removed from working tree.
> +	See link:technical/sparse-checkout.txt[sparse-checkout]
> +	for more information.

I likewise think this won't need to be blocked, but this is a sign that
we should probably move these to the main doc namespace. See 1e2320161d2
(docs: move http-protocol docs to man section 5, 2022-08-04) (and
commits before that) for prior art.

But what we should fix here is that this ling is wrong, as you can see
in that commit we need to link to the HTML docs for these (confusing as
that is).

Or (and I didn't check) if we never generate the *.html either for this
particular one this link will always be broken. I.e. we won't install
this, nor the HTML docs.
