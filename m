Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15F2C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A766112F
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhDZTRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhDZTRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 15:17:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520AC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:17:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k127so2061138qkc.6
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPoRTkpQL7evkJvQU5Edv2xFCNAJUvUlcRmOgaVB3AA=;
        b=pvFT154A+tqTAEyW121u5PAgGkrxdujSgWWOUZvHhjBZxuaWubLdeziFfUA47+1kyo
         pt0QbfysR4Zkmov898BbWLBMsWgoP3kTi5maDnNEzLxDdpBQDkPNfee/iWt7W8L1g6op
         eipl89eJnB1QOR5zSzFdR8mlX4cbd/iBW+Tpz0AShRlzCpWnXY88lfT4I/zYRzbGVQdf
         kBX8PaqVNU/sosaUzulhkdvWTdzltkEgK05HjKwx7fd6KmTGcG+IjUXfmInO4N6iVsdq
         9hJY1nlXKTQVJCFSPOWrW3o/3x2FRnE0DL6Ae/2N7z4FxGxWvZCqdkXyrJYuq3QdoIZO
         7RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPoRTkpQL7evkJvQU5Edv2xFCNAJUvUlcRmOgaVB3AA=;
        b=r+TRBm3Tt9U3a8UxLhTbWNUP+IPTzURV5xeCcJiUfXGAqgOY4CicjePcEDnZi9+yuU
         m2I2GoMdr8Yer9PZ2l4oZ3rp1Z0bETMxcQEMaOzUTSr46Ry2CeTOpSOBxIEq+1wR1kVN
         Rkfr5ruyessp+YaCgKcKJqujXnz4DNpaPo6IHslOoagUSDhDT4w6DrOhmnPOVlGDUgut
         aetgSAfhknNaxy8AFcs+1/Bl85CLG7j7KegDSm9Y/sPGRa7Ee3tp7k1sbvrvVC8Rx+vl
         0Ngo4idQDTXk+Qi7lQFRbFA9IzJ8aV/yuQCU6rcmNRrgFUNAl+vyl6RcNHL63bEyoBxT
         nWSw==
X-Gm-Message-State: AOAM531VvCUvNqvFk+UVsz679IS3mpglXFZ5WvXXdDlkcGrQwuxaW++3
        9lr6JxtEW2tdJAHRM0STwMw=
X-Google-Smtp-Source: ABdhPJwo/XHiKIo3pDvSpb/1/160tq483536tqK89lzaaYbTMMUKdSTeG2m5wfB/VoRHqFe3YH/Ugw==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr19945476qkc.182.1619464622132;
        Mon, 26 Apr 2021 12:17:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:65f6:360e:4aa8:3d0f? ([2600:1700:e72:80a0:65f6:360e:4aa8:3d0f])
        by smtp.gmail.com with ESMTPSA id m4sm861499qkh.131.2021.04.26.12.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 12:17:01 -0700 (PDT)
Subject: Re: [PATCH 10/23] fsmonitor--daemon: add pathname classification
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <451563314d84f9d6dee29a4899b5d18033aa227d.1617291666.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aca24c96-33ab-3b90-bf21-0da19283a3d7@gmail.com>
Date:   Mon, 26 Apr 2021 15:17:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <451563314d84f9d6dee29a4899b5d18033aa227d.1617291666.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
...
> +#define FSMONITOR_COOKIE_PREFIX ".fsmonitor-daemon-"
> +
> +enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
> +	const char *rel)
> +{
> +	if (fspathncmp(rel, ".git", 4))
> +		return IS_WORKDIR_PATH;
> +	rel += 4;
> +
> +	if (!*rel)
> +		return IS_DOT_GIT;
> +	if (*rel != '/')
> +		return IS_WORKDIR_PATH; /* e.g. .gitignore */
> +	rel++;
> +
> +	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
> +			strlen(FSMONITOR_COOKIE_PREFIX)))

Seems like this strlen() could be abstracted out. Is it
something the compiler can compute and set for us? Or,
should we create a macro for this constant?

> +		return IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX;
> +
> +	return IS_INSIDE_DOT_GIT;
> +}

Here is the reasoning I was missing for why we watch the .git
directory.

> +enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
> +	const char *rel)
> +{
> +	if (!fspathncmp(rel, FSMONITOR_COOKIE_PREFIX,
> +			strlen(FSMONITOR_COOKIE_PREFIX)))
> +		return IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX;
> +
> +	return IS_INSIDE_GITDIR;
> +}

And I was about to ask "what happens if we are watching the .git
directory of a worktree?" but here we have a different classifier.

> +static enum fsmonitor_path_type try_classify_workdir_abs_path(
> +	struct fsmonitor_daemon_state *state,
> +	const char *path)
> +{
> +	const char *rel;
> +
> +	if (fspathncmp(path, state->path_worktree_watch.buf,
> +		       state->path_worktree_watch.len))
> +		return IS_OUTSIDE_CONE;
> +
> +	rel = path + state->path_worktree_watch.len;
> +
> +	if (!*rel)
> +		return IS_WORKDIR_PATH; /* it is the root dir exactly */
> +	if (*rel != '/')
> +		return IS_OUTSIDE_CONE;
> +	rel++;
> +
> +	return fsmonitor_classify_path_workdir_relative(rel);
> +}
> +
> +enum fsmonitor_path_type fsmonitor_classify_path_absolute(
> +	struct fsmonitor_daemon_state *state,
> +	const char *path)
> +{
> +	const char *rel;
> +	enum fsmonitor_path_type t;
> +
> +	t = try_classify_workdir_abs_path(state, path);
> +	if (state->nr_paths_watching == 1)
> +		return t;
> +	if (t != IS_OUTSIDE_CONE)
> +		return t;
> +
> +	if (fspathncmp(path, state->path_gitdir_watch.buf,
> +		       state->path_gitdir_watch.len))
> +		return IS_OUTSIDE_CONE;
> +
> +	rel = path + state->path_gitdir_watch.len;
> +
> +	if (!*rel)
> +		return IS_GITDIR; /* it is the <gitdir> exactly */
> +	if (*rel != '/')
> +		return IS_OUTSIDE_CONE;
> +	rel++;
> +
> +	return fsmonitor_classify_path_gitdir_relative(rel);
> +}

And here is where you differentiate the event across the two
cases. OK.

> +/*
> + * Pathname classifications.
> + *
> + * The daemon classifies the pathnames that it receives from file
> + * system notification events into the following categories and uses
> + * that to decide whether clients are told about them.  (And to watch
> + * for file system synchronization events.)
> + *
> + * The client should only care about paths within the working
> + * directory proper (inside the working directory and not ".git" nor
> + * inside of ".git/").  That is, the client has read the index and is
> + * asking for a list of any paths in the working directory that have
> + * been modified since the last token.  The client does not care about
> + * file system changes within the .git directory (such as new loose
> + * objects or packfiles).  So the client will only receive paths that
> + * are classified as IS_WORKDIR_PATH.
> + *
> + * The daemon uses the IS_DOT_GIT and IS_GITDIR internally to mean the
> + * exact ".git" directory or GITDIR.  If the daemon receives a delete
> + * event for either of these directories, it will automatically
> + * shutdown, for example.
> + *
> + * Note that the daemon DOES NOT explicitly watch nor special case the
> + * ".git/index" file.  The daemon does not read the index and does not
> + * have any internal index-relative state.  The daemon only collects
> + * the set of modified paths within the working directory.
> + */
> +enum fsmonitor_path_type {
> +	IS_WORKDIR_PATH = 0,
> +
> +	IS_DOT_GIT,
> +	IS_INSIDE_DOT_GIT,
> +	IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX,
> +
> +	IS_GITDIR,
> +	IS_INSIDE_GITDIR,
> +	IS_INSIDE_GITDIR_WITH_COOKIE_PREFIX,
> +
> +	IS_OUTSIDE_CONE,
> +};
> +
> +/*
> + * Classify a pathname relative to the root of the working directory.
> + */
> +enum fsmonitor_path_type fsmonitor_classify_path_workdir_relative(
> +	const char *relative_path);
> +
> +/*
> + * Classify a pathname relative to a <gitdir> that is external to the
> + * worktree directory.
> + */
> +enum fsmonitor_path_type fsmonitor_classify_path_gitdir_relative(
> +	const char *relative_path);
> +
> +/*
> + * Classify an absolute pathname received from a filesystem event.
> + */
> +enum fsmonitor_path_type fsmonitor_classify_path_absolute(
> +	struct fsmonitor_daemon_state *state,
> +	const char *path);
> +
>  #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
>  #endif /* FSMONITOR_DAEMON_H */

Had I looked ahead and read these comments beforehand, then I would
have had an easier time determining the intended behavior from the
implementations. Oops.

Thanks,
-Stolee
