Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C7C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 09:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiGLJw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiGLJw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 05:52:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81537AA820
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:52:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so12171284ejc.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=wnDw8Q9i4cEZUBXVCpqESvjW869k94U22Rtf/lX1gPw=;
        b=Uob8hX28ep9Iauo0ZKWZmyqWOTEmfvxGCw8sNeZOsKuGfpXt3BbwyOn2JzkVqH/XqX
         VS40FaNbHVdUeE+CYpiEKUh8XW/i1BJ2Dr10X4upF1c1WQVbmzYFfKPtmPBFVmqRChyH
         /ZORe/tR+uVzziQZ+FOWV10Q65iPnw3cqAecDbpkbZ8yQvq9Nv/HShShITZcOkU38cuw
         7om1WV4EXNUEJsVQWj/j4SNnPsV0mylqAruwe5pCUwER6yTilgV9C1KpdBMnkSK87bL4
         gwnsSYAU3pK5bfp0h/LH0L1FzXruESIg+N/CCfBr3x2G2OyfJmmNSEAI2pIqQH6COFiv
         MXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=wnDw8Q9i4cEZUBXVCpqESvjW869k94U22Rtf/lX1gPw=;
        b=uuwGmgTuENmGOVVIw3cUnhzseCaoP6KS18318R9US4yMY+kjoiRKwannX7PI/gQvRg
         9hcy85SpYz830JueKsONL4BbRaboIL7VlBz7HHmi8d11fqMMCbv8Q64k0TD6XsCr8enw
         i22rrGiS3gmmkzW2ZqxujgrdHQmCqoXEMvRm5H6bZoCGeBCc8vi3CdJOQLDlSiNl3Xh2
         VvSNm+LWkNjwrTTotf/jLC39ccm/aJ4/FtzqTJPfZJE4gjRMqJdrEpmRavRlyu5ANuGK
         NRkTp5P0f9FR3ISHUlAxdFJfjvnhxK9Rb+kRYlpTcH0pd8qB7aGBHnmyJIiP4XYVnz6k
         mnbw==
X-Gm-Message-State: AJIora/1rzaKI6oYaT2+3q4VyqZKpC7eEZHnHfrRd3pJx8MHO7BSZhBq
        CoT/1TaIcD3go0DFby+xpa4=
X-Google-Smtp-Source: AGRyM1sJnMbVwhwblI2iE85mCFjUc3kxWQd0jq6v0fBTKtLbO7EDoXMDHzggxeTI6xCBntd5lS1dCQ==
X-Received: by 2002:a17:907:1608:b0:726:a7b7:cd7a with SMTP id hb8-20020a170907160800b00726a7b7cd7amr22092029ejc.682.1657619541947;
        Tue, 12 Jul 2022 02:52:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k19-20020a05640212d300b0043a8f5ad272sm5767962edx.49.2022.07.12.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:52:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBCZ1-001ETx-GC;
        Tue, 12 Jul 2022 11:52:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, peff@peff.net, git@grubix.eu,
        me@ttaylorr.com, Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: Re: [PATCH v5 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Date:   Tue, 12 Jul 2022 11:50:49 +0200
References: <cover.1656593279.git.hanxin.hx@bytedance.com>
 <cover.1657604799.git.hanxin.hx@bytedance.com>
 <3ffeed50deb2d292cef0a518085d60d22c5dd79b.1657604799.git.hanxin.hx@bytedance.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3ffeed50deb2d292cef0a518085d60d22c5dd79b.1657604799.git.hanxin.hx@bytedance.com>
Message-ID: <220712.86zghe4q0c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 12 2022, Han Xin wrote:

> The commit-graph is used to opportunistically optimize accesses to
> certain pieces of information on commit objects, and
> lookup_commit_in_graph() tries to say "no" when the requested commit
> does not locally exist by returning NULL, in which case the caller
> can ask for (which may result in on-demand fetching from a promisor
> remote) and parse the commit object itself.
>
> However, it uses a wrong helper, repo_has_object_file(), to do so.
> This helper not only checks if an object is mmediately available in
> the local object store, but also tries to fetch from a promisor remote.
> But the fetch machinery calls lookup_commit_in_graph(), thus causing an
> infinite loop.
>
> We should make lookup_commit_in_graph() expect that a commit given to it
> can be legitimately missing from the local object store, by using the
> has_object_file() helper instead.
>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  commit-graph.c                             |  2 +-
>  t/t5330-no-lazy-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 92d4503336..2b04ef072d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -898,7 +898,7 @@ struct commit *lookup_commit_in_graph(struct repository *repo, const struct obje
>  		return NULL;
>  	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
>  		return NULL;
> -	if (!repo_has_object_file(repo, id))
> +	if (!has_object(repo, id, 0))
>  		return NULL;
>  
>  	commit = lookup_commit(repo, id);
> diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> new file mode 100755
> index 0000000000..2cc7fd7a47
> --- /dev/null
> +++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='test for no lazy fetch with the commit-graph'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup: prepare a repository with a commit' '
> +	git init with-commit &&
> +	test_commit -C with-commit the-commit &&
> +	oid=$(git -C with-commit rev-parse HEAD)
> +'
> +
> +test_expect_success 'setup: prepare a repository with commit-graph contains the commit' '
> +	git init with-commit-graph &&
> +	echo "$(pwd)/with-commit/.git/objects" \
> +		>with-commit-graph/.git/objects/info/alternates &&
> +	# create a ref that points to the commit in alternates
> +	git -C with-commit-graph update-ref refs/ref_to_the_commit "$oid" &&
> +	# prepare some other objects to commit-graph
> +	test_commit -C with-commit-graph something &&
> +	git -c gc.writeCommitGraph=true -C with-commit-graph gc &&
> +	test_path_is_file with-commit-graph/.git/objects/info/commit-graph
> +'
> +
> +test_expect_success 'setup: change the alternates to what without the commit' '
> +	git init --bare without-commit &&
> +	git -C with-commit-graph cat-file -e $oid &&
> +	echo "$(pwd)/without-commit/objects" \
> +		>with-commit-graph/.git/objects/info/alternates &&
> +	test_must_fail git -C with-commit-graph cat-file -e $oid
> +'
> +
> +test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
> +	# setup promisor and prepare any commit to fetch
> +	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
> +	git -C with-commit-graph config remote.origin.promisor true &&
> +	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
> +	test_commit -C with-commit any-commit &&
> +	anycommit=$(git -C with-commit rev-parse HEAD) &&
> +	GIT_TRACE="$(pwd)/trace.txt" \
> +		git -C with-commit-graph fetch origin $anycommit 2>err &&
> +	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&

This part seems quite odd, we tested the exit code, so here we're being
paranoid about not getting a specific "fatal" error message.

It seems more worthwhile to test the warnings we emit, which in this
case seem to be duplicated (but that's probably an existing issue...).


> +	grep "git fetch origin" trace.txt >actual &&
> +	test_line_count = 1 actual
> +'

I wondered if "test_subcomand" here would be better, i.e. fewer things
scraping GIT_TRACE, and using the machine-readable GIT_TRACE2_EVENT
instead...
