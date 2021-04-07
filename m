Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9081AC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DDB61182
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhDGXJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGXJT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:09:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B5C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:09:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so291166pjg.5
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=deczpVCjBw9f0iTQqop8sAf6y6X7AZM8uiJ5xmbt1q8=;
        b=uMty7eJaUAVMnzohtGlLNe6rXlA7UYa1OnXg6Z5XWD5l0y5V9s6AOSvZW27GiC8hD8
         hGQupJVWIOw+qs1VCasIpNLvh0hDlUbsf6SHGjgms6JBEBBCcIZLaB1rW+BvCd6K0IPs
         rTpeNLLxtJRhTpABjh8jmK5hMiiYCkFsdzD/vGvqg5Fkn7gYdSKWNIsNF5HuHTEtLhZk
         X3+oBQlViZrVwXlINcu97hAmqm3tSzBlQbgUASzxPiUGVhA78bkUZ7mRHmW/uYJMOno0
         YYJ7EPMIvkvni0QnG3mMlkV51qs84GxonSngXEchHi8PC0t4gu8IZ9fdC0zVMFv8ipSG
         fQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=deczpVCjBw9f0iTQqop8sAf6y6X7AZM8uiJ5xmbt1q8=;
        b=iKqVnNSZ3wCxHPQESJIaz31i4eGnmfY/5uhkJuikUP2KGdSmIlDOPX66A9oq3tMe50
         /Z46dpr1vzMtCEfBM0ow2Ek/8ZE/eiSj28v4dswGsIo2WGFtEZALW6CvBL6ZnUo8gnAL
         BnZYHqu2dXptQtwVYjYcu1MbEMUIERWkUVewtkwHyO1ea0OqVrIhfjeYKW7LTfL8yfjm
         qTJoqZvK7R659mvB/5sXqBwf1bDBMVhSuqlZnpXtlptKWKc41Dq87pmqLwXcwYmymG3W
         qbabR/zzlRu8+plRRSZwLu5X/XL3xHZfJ3RDPOV/4PQS0OJXoYLG6eeTuDLU+lS5cGWD
         3qcw==
X-Gm-Message-State: AOAM531dnwxBOvmD8kCAh7pwnZaMoe9ZaKKbdUqyVPCEOCR0Hgbhfj5b
        iLKWuH/e84arQYFcW1ZoBFOs6TYhVVT1ZA==
X-Google-Smtp-Source: ABdhPJx9adj2Ruc534Hx8JXjQ2oU1OffQ7e24v0l1HVS7gGl+l8qCXQ5gcspca7jVm0B93EaOVyB0w==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr5700100pjh.50.1617836948772;
        Wed, 07 Apr 2021 16:09:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:11e7:4d1:298c:c7bd])
        by smtp.gmail.com with ESMTPSA id z192sm22498565pgz.94.2021.04.07.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:09:07 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:09:01 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
Message-ID: <YG47jV2+qcRVwY5N@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.04.06 18:47, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The prefetch task previously used the default refspec source plus a
> custom refspec destination to avoid colliding with remote refs:
> 
> 	+refs/heads/*:refs/prefetch/<remote>/*
> 
> However, some users customize their refspec to reduce how much data they
> download from specific remotes. This can involve restrictive patterns
> for fetching or negative patterns to avoid downloading some refs.
> 
> Modify fetch_remote() to iterate over the remote's refspec list and
> translate that into the appropriate prefetch scenario. Specifically,
> re-parse the raw form of the refspec into a new 'struct refspec' and
> modify the 'dst' member to replace a leading "refs/" substring with
> "refs/prefetch/", or prepend "refs/prefetch/" to 'dst' otherwise.
> Negative refspecs do not have a 'dst' so they can be transferred to the
> 'git fetch' command unmodified.
> 
> This prefix change provides the benefit of keeping whatever collisions
> may exist in the custom refspecs, if that is a desirable outcome.
> 
> This changes the names of the refs that would be fetched by the default
> refspec. Instead of "refs/prefetch/<remote>/<branch>" they will now go
> to "refs/prefetch/remotes/<remote>/<branch>". While this is a change, it
> is not a seriously breaking one: these refs are intended to be hidden
> and not used.
> 
> Update the documentation to be more generic about the destination refs.
> Do not mention custom refpecs explicitly, as that does not need to be

Typo here: s/refpecs/refspecs/


> highlighted in this documentation. The important part of placing refs in
> refs/prefetch remains.
> 
> Reported-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-maintenance.txt |  3 +--
>  builtin/gc.c                      | 37 +++++++++++++++++++++++++-
>  t/t7900-maintenance.sh            | 43 ++++++++++++++++++++++++++-----
>  3 files changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceba0..95a24264eb10 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -94,8 +94,7 @@ prefetch::
>  	objects from all registered remotes. For each remote, a `git fetch`
>  	command is run. The refmap is custom to avoid updating local or remote
>  	branches (those in `refs/heads` or `refs/remotes`). Instead, the
> -	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
> -	not updated.
> +	refs are stored in `refs/prefetch/`. Also, tags are not updated.
>  +
>  This is done to avoid disrupting the remote-tracking branches. The end users
>  expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
> diff --git a/builtin/gc.c b/builtin/gc.c
> index fa8128de9ae1..76f347dd6b11 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -32,6 +32,7 @@
>  #include "remote.h"
>  #include "object-store.h"
>  #include "exec-cmd.h"
> +#include "refspec.h"
>  
>  #define FAILED_RUN "failed to run %s"
>  
> @@ -877,6 +878,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  {
>  	struct maintenance_run_opts *opts = cbdata;
>  	struct child_process child = CHILD_PROCESS_INIT;
> +	int i;
>  
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
> @@ -886,7 +888,40 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	if (opts->quiet)
>  		strvec_push(&child.args, "--quiet");
>  
> -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
> +	for (i = 0; i < remote->fetch.nr; i++) {
> +		struct refspec_item replace;
> +		struct refspec_item *rsi = &remote->fetch.items[i];
> +		struct strbuf new_dst = STRBUF_INIT;
> +		size_t ignore_len = 0;
> +		char *replace_string;
> +
> +		if (rsi->negative) {
> +			strvec_push(&child.args, remote->fetch.raw[i]);
> +			continue;
> +		}
> +
> +		refspec_item_init(&replace, remote->fetch.raw[i], 1);
> +
> +		/*
> +		 * If a refspec dst starts with "refs/" at the start,
> +		 * then we will replace "refs/" with "refs/prefetch/".
> +		 * Otherwise, we will prepend the dst string with
> +		 * "refs/prefetch/".
> +		 */
> +		if (!strncmp(replace.dst, "refs/", 5))
> +			ignore_len = 5;
> +
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +		strbuf_addstr(&new_dst, replace.dst + ignore_len);
> +		free(replace.dst);
> +		replace.dst = strbuf_detach(&new_dst, NULL);
> +
> +		replace_string = refspec_item_format(&replace);
> +		strvec_push(&child.args, replace_string);
> +		free(replace_string);
> +
> +		refspec_item_clear(&replace);
> +	}
>  
>  	return !!run_command(&child);
>  }
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 37eed6ed3aa3..03487be3af38 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
>  	test_commit -C clone2 two &&
>  	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>  	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> -	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remote1/*" <run-prefetch.txt &&
> -	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remote2/*" <run-prefetch.txt &&
> +	test_subcommand git fetch remote1 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote1/*" <run-prefetch.txt &&
> +	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <run-prefetch.txt &&
>  	test_path_is_missing .git/refs/remotes &&
> -	git log prefetch/remote1/one &&
> -	git log prefetch/remote2/two &&
> +	git log prefetch/remotes/remote1/one &&
> +	git log prefetch/remotes/remote2/two &&
>  	git fetch --all &&
> -	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
> -	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
> +	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
> +	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
>  
>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>  	git log --oneline --decorate --all >log &&
>  	! grep "prefetch" log
>  '
>  
> +test_expect_success 'prefetch custom refspecs' '
> +	git -C clone1 branch -f special/fetched HEAD &&
> +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
> +
> +	# create multiple refspecs for remote1
> +	git config --add remote.remote1.fetch "+refs/heads/special/fetched:refs/heads/fetched" &&
> +	git config --add remote.remote1.fetch "^refs/heads/special/secret/not-fetched" &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +
> +	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> +
> +	# skips second refspec because it is not a pattern type
> +	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
> +	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
> +	rs3="^refs/heads/special/secret/not-fetched" &&
> +
> +	test_subcommand git fetch remote1 $fetchargs "$rs1" "$rs2" "$rs3" <prefetch-refspec.txt &&
> +	test_subcommand git fetch remote2 $fetchargs "+refs/heads/*:refs/prefetch/remotes/remote2/*" <prefetch-refspec.txt &&
> +
> +	# first refspec is overridden by second
> +	test_must_fail git rev-parse refs/prefetch/special/fetched &&
> +	git rev-parse refs/prefetch/heads/fetched &&
> +
> +	# possible incorrect places for the non-fetched ref
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/not-fetched
> +'
> +
>  test_expect_success 'prefetch and existing log.excludeDecoration values' '
>  	git config --unset-all log.excludeDecoration &&
>  	git config log.excludeDecoration refs/remotes/remote1/ &&
> -- 
> gitgitgadget
