Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25F8C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B45160F91
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhHTAL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHTAL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:11:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33AC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:10:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w68so7049714pfd.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tvh/LuvKfV3NNf2GeZYHq2rweCHyAQrpi6w/X5ZpPQ4=;
        b=Pdf6yT2RnZvo5ZQKJe07KO0zzDHj/JjPfCUoRqaKPH3Qlt4DV27njH1psc8hcuQmtu
         mrJZ4vR8qSurIF5qan86OieO8206nI54wBNOzI0KStGf9M7ZAE1jMQbnzU/dRk7Bx+Z6
         wAbawZJUjgcJzPvAVghMDD3DYIBBjxA19qxJAqo3V1soP7ZSrgYsp0xa965gXzd0GTGK
         wVo5ml206UJWnII9gGxrN6vf/xOaRtxE9ADaY3u4+Gd30grcwlo2LRPDOlMGlL0Ojk6+
         uwjk6Y5RYckm9yuCSgvv+7AYJ1/Tu09wgnqI3+5Vj3415z4zUBDTE7n2gvG+cCXDDbpE
         EnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tvh/LuvKfV3NNf2GeZYHq2rweCHyAQrpi6w/X5ZpPQ4=;
        b=EGXEWXALIPEAi/K3tvWi+fksi4kt81zPE4LVTu2m45F8rS+3gLhlKFZv7hB+Sy1HUQ
         XXuwW4+8V/O4jPNfCU40EV8tp7R5+eg0+h0Ju8TvupiQkPB9qMkBHfAs6n94yMfR/VsZ
         aQFj7D7eWE+om0ViZfVGF9iKiuuhppKfUPlE4+GmQkAZ2FRhbwRE4BJpCeYoaK7jIswN
         29ZPLu/ZFp/uvTr01aKzHdS76zUfwYVxqfLI3WfAIaNR9/0tbkmv5f7TCwrer16NfW08
         q5YhaBMcQsIIIAgMB8z3n1ws8eCGo081oENyHcXvi0CFNWLOfK8g06yTr1bS7rX+8Wnb
         yaGw==
X-Gm-Message-State: AOAM531Z0Npc7znogrg+NNYh93Kkdt0dRemfWNEC38mQWq3KobpOB0mt
        mGjRSLG0FhwBSvgTCmtWWV+aRA==
X-Google-Smtp-Source: ABdhPJwbkiMObZI3bZGw5y39GCIe4DS/z90uiC4Idd9iqz2KO6QDN95UrA0oou8r7aixERx2Mf5ELQ==
X-Received: by 2002:a63:790b:: with SMTP id u11mr16044359pgc.71.1629418251622;
        Thu, 19 Aug 2021 17:10:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
        by smtp.gmail.com with ESMTPSA id s46sm4751002pfw.89.2021.08.19.17.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:10:50 -0700 (PDT)
Date:   Thu, 19 Aug 2021 17:10:43 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 06/36] hook.c users: use "hook_exists()" insted of
 "find_hook()"
Message-ID: <YR7zAyUOgCTQquuK@google.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
 <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <patch-v4-06.36-d5ef40f77dc-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v4-06.36-d5ef40f77dc-20210803T191505Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 03, 2021 at 09:38:32PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Use the new hook_exists() function instead of find_hook() where the
> latter was called in boolean contexts. This make subsequent changes in
> a series where we further refactor the hook API clearer, as we won't
> conflate wanting to get the path of the hook with checking for its
> existence.
> 

None of these callsites capture the return string from find_hook(), so
this looks fine.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  builtin/commit.c       | 2 +-
>  builtin/merge.c        | 2 +-
>  builtin/receive-pack.c | 2 +-
>  sequencer.c            | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 51b07ee02ea..aa3c741efa9 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1052,7 +1052,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	if (!no_verify && find_hook("pre-commit")) {
> +	if (!no_verify && hook_exists("pre-commit")) {
>  		/*
>  		 * Re-read the index as pre-commit hook could have updated it,
>  		 * and write it out as a tree.  We must do this before we invoke
> diff --git a/builtin/merge.c b/builtin/merge.c
> index be98d66b0a8..03f244dd5a0 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -849,7 +849,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	 * and write it out as a tree.  We must do this before we invoke
>  	 * the editor and after we invoke run_status above.
>  	 */
> -	if (find_hook("pre-merge-commit"))
> +	if (hook_exists("pre-merge-commit"))
>  		discard_cache();
>  	read_cache_from(index_file);
>  	strbuf_addbuf(&msg, &merge_msg);
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 97aebdc15bd..91fa799b66e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1464,7 +1464,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
>  
>  	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
>  
> -	if (!find_hook(push_to_checkout_hook))
> +	if (!hook_exists(push_to_checkout_hook))
>  		retval = push_to_deploy(sha1, &env, work_tree);
>  	else
>  		retval = push_to_checkout(sha1, &env, work_tree);
> diff --git a/sequencer.c b/sequencer.c
> index ea4199d65a4..9aac08c1545 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1446,7 +1446,7 @@ static int try_to_commit(struct repository *r,
>  		}
>  	}
>  
> -	if (find_hook("prepare-commit-msg")) {
> +	if (hook_exists("prepare-commit-msg")) {
>  		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
>  		if (res)
>  			goto out;
> -- 
> 2.33.0.rc0.595.ge31e012651d
> 
