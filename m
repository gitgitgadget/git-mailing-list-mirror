Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9ADC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B309520644
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqb1C9O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgFOPAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgFOPAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 11:00:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95EC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:00:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so14986155wmj.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ulz/OtmO4l1QvbGDzBa9q3d6rTx3y4c6vNvEfZQ8K6Y=;
        b=dqb1C9O+Oa/bSUByDE3WgJB4WxArNjkSNJ1HgyLNLr9b1LsA3Lbs/bdUETYIFB8WYg
         Uvt4gK5JMBrmpBBJLIHqqreAOS/CVOHZKbc51l5vcWQpK67lz/1tQdPq6OR51Au00r39
         dAKV+nYyDpDEGptA/vVqZ0JBvBD2kjaftm6nM/IMMbZTYtJXjN5yp4iC99+RqvTMo9YA
         KVhThcyAU7ytSmvNfZv+D1Rf4euQTEKR2PKR7P5knNVGTS0G8TfD38mpevrfYKzxRVGw
         PCqvJCz3KmtDUkFNBgaLP5dMhk0AcfMlOg/wPdN0/lLHp5hn5ilnTv2I9Lzq33ZbAySB
         EVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ulz/OtmO4l1QvbGDzBa9q3d6rTx3y4c6vNvEfZQ8K6Y=;
        b=ZspA+lVdb++iTg1A8z0mbyz3R36VlTe0JbiijMGg122+TIq14VXxcFlTTztZ2QvYWT
         8i85xG2S5cohnfMb3vo1wwKwW/Q6mSJ6bqmEcuxf2Ff6ypzeQ1FkxoJMIfU4LJFLS0kH
         sl+vqTDtKWCOdedOLGcmVaobXAewO2+BimkUO5bYjIup4neXk8MO56G4z4Uarw07zgnS
         af/W+qPx6yaaRH7glZaGXL57pXClgz3x4XmrUgDWZomF+FR954ahfTzNld8tc63+Iuqp
         0KeExOuZ9yKKwITr6Jp9gOKcXW8CXzamyN5fYF9XRrSTkZgBLjBkSm4HhqFVjljmF3Yr
         XN4g==
X-Gm-Message-State: AOAM530STbX9IAVp6/9Sarnv4szKaAKok/GbNYs1iR64BNUwIpS+g7zN
        GcS+QYHqXfPGTKawJAjj884=
X-Google-Smtp-Source: ABdhPJwDlJ5B3/VP4uh9ZnR5ETOYhEg5SuMrJuCCq0DVHFxH/7dXtAEbkvGuY5vuqUh/Rvr7k4oveg==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr13107804wmd.169.1592233206856;
        Mon, 15 Jun 2020 08:00:06 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id v28sm27510992wra.77.2020.06.15.08.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:00:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b530fe66-9cf6-ea63-e9e6-123448e2d978@gmail.com>
Date:   Mon, 15 Jun 2020 16:00:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

On 15/06/2020 13:50, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> There is a growing number of projects and companies desiring to change
> the main branch name of their repositories (see e.g.
> https://twitter.com/mislav/status/1270388510684598272 for background on
> this).

I think this is a good way of phrasing the rationale for the change

> However, there are a couple of hard-coded spots in Git's source code
> that make this endeavor harder than necessary. For example, when
> formatting the commit message for merge commits, Git appends "into
> <branch-name>" unless the current branch is the `master` branch.
> 
> Clearly, this is not what one wants when already having gone through all
> the steps to manually rename the main branch

This didn't quite scan for me maybe s/already having/one has already/ ?

> (and taking care of all the
> fall-out such as re-targeting existing Pull Requests).
> 
> Let's introduce a way to override Git's hard-coded default:
> `core.mainBranch`.
> 
> We will start supporting this config option in the `git fmt-merge-msg`
> command and successively adjust all other places where the main branch
> name is hard-coded.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Documentation/config/core.txt |  5 +++++
>   fmt-merge-msg.c               |  6 ++++--
>   refs.c                        | 27 +++++++++++++++++++++++++++
>   refs.h                        |  7 +++++++
>   t/t6200-fmt-merge-msg.sh      |  7 +++++++
>   5 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index 74619a9c03b..32bb5368ebb 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -626,3 +626,8 @@ core.abbrev::
>   	in your repository, which hopefully is enough for
>   	abbreviated object names to stay unique for some time.
>   	The minimum length is 4.
> +
> +core.mainBranch::
> +	The name of the main (or: primary) branch in the current repository.
> +	For historical reasons, `master` is used as the fall-back for this
> +	setting.
> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 72d32bd73b1..43f4f829242 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
>   				const char *current_branch)
>   {
>   	int i = 0;
> -	char *sep = "";
> +	char *sep = "", *main_branch;
>   
>   	strbuf_addstr(out, "Merge ");
>   	for (i = 0; i < srcs.nr; i++) {
> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *out,
>   			strbuf_addf(out, " of %s", srcs.items[i].string);
>   	}
>   
> -	if (!strcmp("master", current_branch))
> +	main_branch = git_main_branch_name();
> +	if (!strcmp(main_branch, current_branch))
>   		strbuf_addch(out, '\n');
>   	else
>   		strbuf_addf(out, " into %s\n", current_branch);
> +	free(main_branch);
>   }
>   
>   static void fmt_tag_signature(struct strbuf *tagbuf,
> diff --git a/refs.c b/refs.c
> index 224ff66c7bb..f1854cffa2f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -560,6 +560,33 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
>   		argv_array_pushf(prefixes, *p, len, prefix);
>   }
>   
> +char *repo_main_branch_name(struct repository *r)
> +{
> +	const char *config_key = "core.mainbranch";
> +	const char *config_display_key = "core.mainBranch";
> +	const char *fall_back = "master";
> +	char *name = NULL, *ret;
> +
> +	if (repo_config_get_string(r, config_key, &name) < 0)
> +		die(_("could not retrieve `%s`"), config_display_key);
> +
> +	ret = name ? name : xstrdup(fall_back);
> +
> +	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
> +		die(_("invalid branch name: %s = %s"),
> +		    config_display_key, name);
> +
> +	if (name != ret)
> +		free(name);

I'm struggling to come up with a scenario where name != NULL && name != 
ret here, however once we get to patch 4 that scenario definitely does 
exist.

> +
> +	return ret;
> +}
> +
> +char *git_main_branch_name(void)
> +{
> +	return repo_main_branch_name(the_repository);
> +}
> +
>   /*
>    * *string and *len will only be substituted, and *string returned (for
>    * later free()ing) if the string passed in is a magic short-hand form
> diff --git a/refs.h b/refs.h
> index a92d2c74c83..a207ef01348 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -154,6 +154,13 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
>   int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
>   int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
>   
> +/*
> + * Retrieves the name of the main (or: primary) branch of the given

nit pick, I'm confused by the ':'

Best Wishes

Phillip

> + * repository.
> + */
> +char *git_main_branch_name(void);
> +char *repo_main_branch_name(struct repository *r);
> +
>   /*
>    * A ref_transaction represents a collection of reference updates that
>    * should succeed or fail together.
> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index e4c2a6eca43..7a873f4a05c 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -158,6 +158,13 @@ test_expect_success 'setup FETCH_HEAD' '
>   	git fetch . left
>   '
>   
> +test_expect_success 'with overridden default branch name' '
> +	test_when_finished "git switch master" &&
> +	git switch -c default &&
> +	git -c core.mainBranch=default fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	! grep "into default" actual
> +'
> +
>   test_expect_success 'merge.log=3 limits shortlog length' '
>   	cat >expected <<-EOF &&
>   	Merge branch ${apos}left${apos}
> 
