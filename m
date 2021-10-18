Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A9BC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 23:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0022B60F02
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 23:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJRXUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRXUe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 19:20:34 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E6C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 16:18:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso9867135pfh.18
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EUi6pC4u86HNVvx7wQYNv9Yr+mn2vHj3LOUBhudNuC8=;
        b=DTJlBok2H72TTUjZYjEBVX57Pjt9z0FV3w/aSHa8BCy8D+2zUkPeDkrtkiGN0ShGKa
         lRF7V8H02dvIJsAoiKJ1bsO13qim6T2WCk138xqSa4ZDRfrYJ0V44bSm8ir6oOF7dr29
         Fm/nTYgGtitRgxKBWBA/c93Js5rW+p0oPGIJfOoIzVjukHvEaFljrpZavZr/WUXODB/E
         R1sifhQN+/brShVph+SwX5wOoq7EIxWjQ6gYSwasaL/okNd8KE9M/ku30Sb7I3flr/HD
         yYS+ZLJChkKgRQss4fLru7cnamDtCPdw7IKDPl2XRHopisWF43PywQdIpz9ehpLtkRsz
         mAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EUi6pC4u86HNVvx7wQYNv9Yr+mn2vHj3LOUBhudNuC8=;
        b=UCS1RrqfjMScDi277o6tVsVLmWhVebo8Zc9L7BtOPkzYf3zuXgLigm65DYeWGjf4ya
         4qgkcOtVtxBMLxwXyqwyOFyqmcpKadrb3KMtTeeOa4vlonI8jk0vLP9Z12o9TyWm21nR
         jF/TFZisPEc9xDdBAdXJ8fkz+ne0MfA2XidNu0VSyh1NZmciY+J6J2XgtOLFYyXvLen8
         u+ezjGvxFL0pstVfHwt3hhAwDwclBhFKclendg4cFpSVHMV50wge6OyAPgIhy/WVYU1N
         NBI1WPsasBa3VjbGlMsNAbgniY0iv0FkPQj0WWs073N8BQQ0gfVsWKMgAwLdTA/mcjTZ
         88jg==
X-Gm-Message-State: AOAM531DkabwvTXC4FGu19g+A3keUKFzkc5eUfYX+JeoUbTA5G5D8bEm
        n5SkIUbD19017XFhFimrxvHcv9BWA1p3YsEJYa/o
X-Google-Smtp-Source: ABdhPJx4E/s/5/JP6qlEboMaDcGQZEb5b/u942p6k24dRcYVLPGkQ8SiZaG4dQOX2hB5JqmFtXSPUEl0chCW9EyMpmAo
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:7f4a:0:b0:44d:292f:cc24 with
 SMTP id a71-20020a627f4a000000b0044d292fcc24mr31749804pfd.58.1634599101751;
 Mon, 18 Oct 2021 16:18:21 -0700 (PDT)
Date:   Mon, 18 Oct 2021 16:18:18 -0700
In-Reply-To: <20211014203416.2802639-4-emilyshaffer@google.com>
Message-Id: <20211018231818.89219-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211014203416.2802639-4-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [PATCH v4 3/4] submodule: record superproject gitdir during absorbgitdirs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Already during 'git submodule add' we record a pointer to the
> superproject's gitdir. However, this doesn't help brand-new
> submodules created with 'git init' and later absorbed with 'git
> submodule absorbgitdir'. Let's start adding that pointer during 'git
> submodule absorbgitdir' too.

s/absorbgitdir/absorbgitdirs/ (note the "s" at the end)

> @@ -2114,6 +2115,15 @@ static void relocate_single_git_dir_into_superproject(const char *path)
>  
>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
>  
> +	/* cache pointer to superproject's gitdir */
> +	/* NEEDSWORK: this may differ if experimental.worktreeConfig is enabled */
> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> +	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
> +			       relative_path(absolute_path(get_git_dir()),
> +					     real_new_git_dir, &sb));
> +
> +	strbuf_release(&config_path);
> +	strbuf_release(&sb);
>  	free(old_git_dir);
>  	free(real_old_git_dir);
>  	free(real_new_git_dir);

Here [1] you mention that you'll delete the NEEDSWORK, but it's still
there.

Having said that, it might be better to make a test in which we call
this command while in a worktree of a superproject. The test might
reveal that (as pointed out to me internally) you might need to use the
common dir functions instead of the git dir functions to point to the
directory that you want (git-worktree.txt distinguishes the 2 if you
search for GIT_COMMON_DIR).

Besides that, all 4 patches look good (including the description of the
new config variable).

[1] https://lore.kernel.org/git/YWc2iJ7FQJYCnQ7w@google.com/
