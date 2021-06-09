Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4651EC48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F146613B6
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 15:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhFIPCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:02:50 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45055 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbhFIPCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 11:02:50 -0400
Received: by mail-ed1-f46.google.com with SMTP id u24so28944092edy.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=/HWRkABeFQbZQnGcYmUa81D9LTNqAaKHy2GiOIWcauQ=;
        b=Z0pDmfGFw8dD+pYuQZ+EFf+ZOuh9Xn6IAqjge2mqa+sNFJQB49RuUIEvzKh7NOrnF7
         Gn2ZfOY5zZ59bCJgXQ1WWp0WGqD7z0LKkn5vcRVmnU7LWZqg76DvEX0bn2Vk6KTYiiMJ
         HUwKX7M6l2gO7f1KlN7JM+r8jZxy6CY00pMU5HaBQlOBu9RQQhz2NTs9Z59nXJHtNcxh
         55b9HbBTOGflGDC7jvjcTuZvmRMVhKNHBC6y3um1fV4vb2De6gMV7XFhDqp1joJgrV3b
         8/dZHxpk+5cqreD89g8UhRc61wMXh3F0MkcGxabo2QgYpRZwZQGKvEbco3/+rzXqcuXn
         k+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=/HWRkABeFQbZQnGcYmUa81D9LTNqAaKHy2GiOIWcauQ=;
        b=tZhxmBeL6IbBTNKDmEyodZnqhjQGBTxfjgoFD0TmEmw9CSVAUhuewIPh6pSXqczrN4
         sccKv6kpuercSZCaQjV9aACrly8XxvAkUY93irk5i86IGYGDuIdtuZ6VJL97t/KWl1uv
         YBMtrOkzGbfgVuYyTWTET4bENTYLKbvfHplNXasj6yPce9uYtfxK4ciZb6/Q/Xj8tY4p
         Oc8y8uwsOHpDZHBboONNnfyCzhyqgqKTt9HIgnf0ixQF7CdDqnMR9FB6YO9amg0twD1q
         fNJE17E9vXYTffWMJnqfWzqXKyHl958fn1cZn65Y9NiJHI7RrzReYZO84fiT5MJy2G3c
         MvhA==
X-Gm-Message-State: AOAM533Jeegxg87zbNn2pOlEKJ34QgQZnczseu/hRL3bPlILt25U+TXP
        lhlEkpZSIR62EaFwThFrN9BfM30rlfE=
X-Google-Smtp-Source: ABdhPJy/KLdN6ft20RRpDwdPO0PjAYCFPtVNsU1LDw0HdA87Ldtr1waUeGDT0CgUBB8Nfwb9sEriTg==
X-Received: by 2002:a05:6402:177a:: with SMTP id da26mr31259089edb.40.1623250794319;
        Wed, 09 Jun 2021 07:59:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d25sm1223705ejd.59.2021.06.09.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:59:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrzej Hunt <ajrhunt@google.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: UNLEAK(), leak checking in the default tests etc.
Date:   Wed, 09 Jun 2021 16:38:52 +0200
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
Message-ID: <87czsv2idy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[In-Reply-To
<a74bbcae7363df03bf8e93167d9274d16dc807f3.1615747662.git.gitgitgadget@gmail.com>,
but intentionally breaking threading for a new topic]

On Sun, Mar 14 2021, Andrzej Hunt via GitGitGadget wrote:

> Most of these pointers can safely be freed when cmd_clone() completes,
> therefore we make sure to free them. The one exception is that we
> have to UNLEAK(repo) because it can point either to argv[0], or a
> malloc'd string returned by absolute_pathdup().

I ran into this when manually checking with valgrind and discovered that
you need SANITIZERS for -DSUPPRESS_ANNOTATED_LEAKS to squash it.

I wonder if that shouldn't be in DEVOPTS (or even a default under
DEVELOPER=1). I.e. you don't need any other special compile flags, just
a compiled git that you then run under valgrind to spot this.

>  builtin/clone.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 51e844a2de0a..952fe3d8fc88 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -964,10 +964,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
> -	char *path, *dir, *display_repo = NULL;
> +	char *path = NULL, *dir, *display_repo = NULL;
>  	int dest_exists, real_dest_exists = 0;
>  	const struct ref *refs, *remote_head;
> -	const struct ref *remote_head_points_at;
> +	struct ref *remote_head_points_at = NULL;
>  	const struct ref *our_head_points_at;
>  	struct ref *mapped_refs;
>  	const struct ref *ref;
> @@ -1017,9 +1017,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	repo_name = argv[0];
>  
>  	path = get_repo_path(repo_name, &is_bundle);
> -	if (path)
> +	if (path) {
> +		FREE_AND_NULL(path);
>  		repo = absolute_pathdup(repo_name);
> -	else if (strchr(repo_name, ':')) {
> +	} else if (strchr(repo_name, ':')) {
>  		repo = repo_name;
>  		display_repo = transport_anonymize_url(repo);
>  	} else

In this case it seems better to just have a :

    int repo_heap = 0;

    Then set "repo_heap = 1" in that absolute_pathdup(repo_name) branch,
    and...

> @@ -1393,6 +1394,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&reflog_msg);
>  	strbuf_release(&branch_top);
>  	strbuf_release(&key);
> +	free_refs(mapped_refs);
> +	free_refs(remote_head_points_at);
> +	free(dir);
> +	free(path);
> +	UNLEAK(repo);

Here do:

    if (repo_heap)
        free(repo);

But maybe there's some other out of the box way to make leak checking
Just Work without special flags in this case. I'm just noting this one
because it ended up being the only one that leaked unless I compiled
with -DSUPPRESS_ANNOTATED_LEAKS. I was fixing some leaks in the bundle
code.

Anyway, getting to the "default tests" point. I fixed a memory leak, and
wanted to it tested that the specific command doesn't leak in git's
default tests.

Do we have such a thing, if not why not?

The closest I got to getting this was:

    GIT_VALGRIND_MODE=memcheck GIT_VALGRIND_OPTIONS="--leak-check=full --errors-for-leak-kinds=definite --error-exitcode=123" <SOME TEST> --valgrind

But as t/README notes it implies --verbose so we can't currently run it
under the test harness (although I have out-of-tree patches to fix that
in general).

It seems pretty straightforward to turn that specific thing into a test
with a prereq to detect if valgrind works in that mode at all, and then
do (in some dedicated test file):

	# Exit/skip if we can't setup valgrind, then setup relevant
        # valgrind options (maybe needing to re-source test-lib.sh, ew!)
	test_expect_successs 'ls-heads should not leak' '
		git bundle ls-heads a.bdl
	'

But from what I've found so far no such thing exists, and it seems to
the extent that this is checked it's run manually as a one-off (see git
log --grep=valgrind), but we don't explicitly test for this
anywhere. Have I missed something?
