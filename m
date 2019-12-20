Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A7C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 02:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0472465E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 02:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRYmh7Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLTCbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:31:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33175 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTCbd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 21:31:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so4169575pgk.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 18:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oiRiZ5Cj5GEgGDbBi9KJH9BVuKkDuRgNWWUwIYZS04U=;
        b=MRYmh7HujepccGR1hCww9zSLiPuyb0vsz3SbKUBqrQ7qn/DA3qc7iD+ECLnlqnPkeV
         LkcJWlMojXD07v0EvM7ZWdNKkVBCPS2Qj7+GL4CJB8Semk4qBMkX/g0aHDw9XJg6vNsN
         YXzqfpwvf7nqi2KgB2/p/i2MkjSnN7GlD746dNNOaZqmZC35+cMLOi1k9vCoI28E1f4d
         D4wkYLR1qLmUVCCok1jlAo5wX5yeg8RGsDul992cC/Yb63/KnLyKBsfK7Y2FZMX82EPM
         fR2OPUWEyhsCpN3mbMPpprem7fHur7zjymXtoJsDrraxLOvaDGRDFF2bBXfDgvYNgEl/
         qf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oiRiZ5Cj5GEgGDbBi9KJH9BVuKkDuRgNWWUwIYZS04U=;
        b=J9VuE76oILXE7y+tA0Xhn2Yeq1on0UqnMRa9wnhhFSKjU22DTl0HgiHDRsfcn+jYN2
         /cwuBKxpNAL/bbfSnRTMpbLsSX3ZCW8baUd7TPgQ+g820OXNmOMwH+K+pE5cehzoWez7
         XjI/NGNY2SQx695lYGoO/DBWPzVCFfMyMx0aJKi//Av/btoDvgnK4EkzD0EvQsRj9D+N
         PpFAGzsrLCZ5Rg34+O6yJYlO39ogjw6BVbZzWgABiOowMEQKosd1BHczq8MmJvtzaKPN
         M+dgMvW7uBxtkQ4IvM+JuBfGkXlCcisW9JNQQHZZ0CsRH+dQG4xUab6ChgbS0z2NG32e
         4Qew==
X-Gm-Message-State: APjAAAXtOSWL9FdqIaFiQy2HRPMNYmjj/usKtFaJYF5suOd9mAkGRibo
        YXVeelOoKxZsfTkW17+y2Mcm2A==
X-Google-Smtp-Source: APXvYqzJkZb3hMY1O7SZgVpQ9upmUQWPYIM8/kO3hk8UVAeZYhGntLgchk+/ZUq+/5zHABE0MMu2Qg==
X-Received: by 2002:a63:770c:: with SMTP id s12mr12844470pgc.25.1576809091129;
        Thu, 19 Dec 2019 18:31:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id f8sm10070574pfn.2.2019.12.19.18.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:31:30 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:31:25 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
Message-ID: <20191220023125.GD227872@google.com>
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
 <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
 <ebec2379207681152c6e5196a1418aca03da113a.1576746982.git.gitgitgadget@gmail.com>
 <xmqqfthgb01m.fsf@gitster-ct.c.googlers.com>
 <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 11:22:38AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > This fix was about "we do not want to unconditionally drop the
> > advice messages when we reject the attempt to commit and show the
> > output like 'git status'", wasn't it?  The earlier single-liner fix
> > in v1 that flips s->hints just before calling run_status() before
> > rejecting the attempt to commit was a lot easier to reason about, as
> > the fix was very focused and to the point.  Why are we seeing this
> > many (seemingly unrelated) changes?
> 
> In any case, here is what I tentatively have in my tree (with heavy
> rewrite to the proposed log message).

Hm. I'm surprised to see this feedback come in the form of a local
change when making the topic branch, rather than in a reply to the v1
patch. What's the reasoning? (Or is this scissors patch intended to be
the feedback?)

I ask because out of all of us, it seems the Outreachy interns can
benefit the most from advice on how and why to write their commit
messages - that is, part of the point of an internship is to learn best
practices and cultural norms in addition to coding practice. (Plus, I
find being asked to rewrite a commit message tends to force me to
understand my own change even better than before.)

I'll go ahead and look through the changes to the commit message so I
can learn what you're looking for too :)

> 
> -- >8 --
> From: Heba Waly <heba.waly@gmail.com>
> Date: Tue, 17 Dec 2019 09:17:22 +0000
> Subject: [PATCH] commit: honor advice.statusHints when rejecting an empty
>  commit
> 
> In ea9882bfc4 (commit: disable status hints when writing to
> COMMIT_EDITMSG, 2013-09-12) the intent was to disable status hints
> when writing to COMMIT_EDITMSG, because giving the hints in the "git
> status" like output in the commit message template are too late to
> be useful (they say things like "'git add' to stage", but that is
> only possible after aborting the current "git commit" session).

More context on why the previous change was made - "by the time the
editor was open, it was too late to apply hints anyways". Sure.

> 
> But there is one case that the hints can be useful: When the current
> attempt to commit is rejected because no change is recorded in the
> index.  The message is given and "git commit" errors out, so the
> hints can immediately be followed by the user.  Teach the codepath
> to honor the configuration variable.

Expanding the "but" to supply the specific story this commit touches,
including "what happens instead" and "how are we gonna fix it".

And the copy-paste of the output before and the output now is different.
For me, I don't particularly see why we'd want to be rid of it - it sort
of feels like "a picture is worth a thousand words" to include the
actual use case in the commit message. Is there style guidance
suggesting not to do that that I missed?

 - Emily

> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/commit.c                          | 1 +
>  t/t7500-commit-template-squash-signoff.sh | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e588bc6ad3..0078faf117 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -944,6 +944,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	 */
>  	if (!committable && whence != FROM_MERGE && !allow_empty &&
>  	    !(amend && is_a_merge(current_head))) {
> +		s->hints = advice_status_hints;
>  		s->display_comment_prefix = old_display_comment_prefix;
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)
> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 46a5cd4b73..a8179e4074 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
>  	)
>  '
>  
> +test_expect_success 'commit without staging files fails and displays hints' '
> +	echo "initial" >>file &&
> +	git add file &&
> +	git commit -m initial &&
> +	echo "changes" >>file &&
> +	test_must_fail git commit -m update >actual &&
> +	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
> +'
> +
>  test_done
> -- 
> 2.24.1-732-ga9f9d4909c
> 
