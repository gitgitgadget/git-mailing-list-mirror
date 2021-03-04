Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE87C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C726507A
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhCDBnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhCDBnP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:43:15 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E32C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 17:42:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x29so9521787pgk.6
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 17:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cm7FHeBTOOw+bexiTtA2SvlQcWmAvLMm6YlaP1T8UzU=;
        b=Bq2CUEj6ecT9wZSpKvquqJQ9qOnUmxHDCYj8HlQEuBJILEBFFlh/Az29KLE/c1GA5l
         Pyep1vBXC8P3q/HFabv3hQZYLK0LpICcp6LX3EFA0e48mOPjhlkApDpInpXBlqdDtjCR
         RrRtNUdgy1s+49CvOJbiltdOmaivWMduJN+sBV46EQw+1wzv/u4za3+ArDQVquPrEO9k
         AdyZbKJBKXKIEglJanj73vjp98t8cBhL+CEod7dSRLhiwcC4CHsy3Rvr0PiidyFLiF9Z
         o+Y5syZHKnhZCGVo3ZOTD9xYhQIFEKwKnJSk7lmyU3b7+Aq9gJAhBF9y1O4YZbH2UFYJ
         +oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cm7FHeBTOOw+bexiTtA2SvlQcWmAvLMm6YlaP1T8UzU=;
        b=Z/CWzgdgTiqzhQ2gh987MAe09kOCy31KgqfG9vmsDDCaTVcCkY9jVNUK7Hy3/IZAup
         CczcwPNGYxbQQBbvVCp0/HbGYDMVH+ucmdMxVTGO+gb4gUVtR1HwGUH8ibt0Q+7hhPDC
         uaEe6CM9AYolPL4CYxnb3iRE5IN4nwazFjsZfQy7EDTXZhD/8KuA/Hh2VMjlRC+wwNWt
         sGQ4mIa2EUICqkZtHvZXuMmkR7zpWaUKfnshUFqeYcdo9e9dqybdGn3BzI3iXZePOgmZ
         RvXzqO7PRx6fUnt9ckITt0W5me67KNpa2uSGvOuUHl1JuIhRWAQRdHsTmIJWqMyJIYM8
         o3ZA==
X-Gm-Message-State: AOAM531FpGLWu58/CTPZUuDR9uyvkwCwqW1uUtjkHlsyw0RDfrY4PiHW
        m+kArLVEKvHObn+dml+hSxDUxSoZOX0=
X-Google-Smtp-Source: ABdhPJwHN/Y0eeMzwe9LP4pitu3hX2RuDt2II2kBmCKprn7aeH3OqCPpbN9vufkOdHd9cPM9vMSyMQ==
X-Received: by 2002:a62:e413:0:b029:1ee:2b3:488a with SMTP id r19-20020a62e4130000b02901ee02b3488amr1524662pfh.58.1614822154084;
        Wed, 03 Mar 2021 17:42:34 -0800 (PST)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id 21sm6978357pfo.167.2021.03.03.17.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:42:33 -0800 (PST)
Date:   Wed, 3 Mar 2021 17:42:31 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/2] stash show: learn --include-untracked and
 --only-untracked
Message-ID: <YEA7B2TKb6hgizZ4@generichostname>
References: <cover.1613459474.git.liu.denton@gmail.com>
 <cover.1614770171.git.liu.denton@gmail.com>
 <xmqq4khrhhx4.fsf@gitster.c.googlers.com>
 <YEA43VRbgdA36MV1@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEA43VRbgdA36MV1@generichostname>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 03, 2021 at 05:33:17PM -0800, Denton Liu wrote:
> Hi Junio,
> 
> On Wed, Mar 03, 2021 at 04:38:31PM -0800, Junio C Hamano wrote:
> > Denton Liu <liu.denton@gmail.com> writes:
> > 
> > > A blindspot that I've noticed in git is that it's not possible to
> > > properly view a stash entry that has untracked files via `git stash
> > > show`. Teach `git stash show --include-untracked` which should do this.
> > > In addition, this series also teaches `--only-untracked` and the
> > > `stash.showIncludeUntracked` config option.
> > >
> > > This series is based on 'dl/stash-cleanup'.
> > >
> > > Changes since v3:
> > >
> > > * Incorporate Junio's SQUASH??? commits
> > >
> > > * Implement a custom unpack_trees() callback to detect the case where
> > >   there are duplicate entries in worktree and untracked commits
> > 
> > I actually expected the latter enhancement to be done outside the
> > scope of this series.

I decided to squash it into the current series because we have a lot of
time until it will be merged (since it's definitely not going in now
during the rc-period). If you'd like, though, I can reroll this series
with the callback as a commit on top.

> > I briefly looked at the callback but I am not
> > convinced that it is correct (e.g. how do you notice and barf when
> > the untracked tree records foo/bar.txt and the index or the working
> > tree records foo as a file?).
> 
> From my testing, the conflict is detected just fine. The following
> test-case should confirm it:
> 
> -- >8 --
> From: Denton Liu <liu.denton@gmail.com>
> Subject: [PATCH] fixup! stash show: teach --include-untracked and --only-untracked
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3905-stash-include-untracked.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index b470db7ef7..470aa65b44 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -405,4 +405,27 @@ test_expect_success 'stash show --include-untracked errors on duplicate files' '
>  	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
>  '
>  
> +test_expect_success 'stash show --include-untracked errors on directory/file conflict' '
> +	git reset --hard &&
> +	git clean -xf &&
> +	>tracked &&
> +	git add tracked &&
> +	tree=$(git write-tree) &&
> +	i_commit=$(git commit-tree -p HEAD -m "index on any-branch" "$tree") &&
> +	test_when_finished "rm -f untracked_index" &&
> +	u_commit=$(
> +		GIT_INDEX_FILE="untracked_index" &&
> +		export GIT_INDEX_FILE &&
> +		rm tracked &&
> +		mkdir tracked &&
> +		>tracked/file &&
> +		git update-index --add tracked/file &&
> +		u_tree=$(git write-tree) &&
> +		git commit-tree -m "untracked files on any-branch" "$u_tree"
> +	) &&
> +	w_commit=$(git commit-tree -p HEAD -p "$i_commit" -p "$u_commit" -m "WIP on any-branch" "$tree") &&
> +	test_must_fail git stash show --include-untracked "$w_commit" 2>err &&
> +	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
> +'
> +
>  test_done
> -- 
> 2.31.0.rc1.228.gb75b4e4ce2
> 
