Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8181F404
	for <e@80x24.org>; Wed, 11 Apr 2018 02:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDKCNF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 22:13:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35824 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeDKCNE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 22:13:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id o3so200340wri.2
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 19:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ql4CEoOjSKGzsKRAEz4lxwrihv4yM1bCMC9hgPVD2/c=;
        b=WvAXNUVFwjXCovZhrS59gaW3+5guvjWvWo0pJzT2CuV1RhcD9mqkHtdhLiR2nmYIdW
         csNymOvxJCnzrrupVwUFWFhnCZyp2LRq6so3wT/jLp/QCtPp1vA4PFNvu8kRo+S3rc7P
         JPlGbAf+IngFSqbS6CYqn7q0s98COSSUFZyXNHSQNPaMRkeGb2hV6+DybbrUPQS7JfZ9
         1a09JSjiWjfwqLZujNmk/l4jTEhBzEAOQFpRahRjxe/RpCSvRdMyTxPTyUhQAY15hmtD
         +mJutJcOwY3WQ47w4m25aOdqEj6DKsKylw4RCw+BkK8ezLYyrS/4AcaGaA0McKM0x+KK
         zv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ql4CEoOjSKGzsKRAEz4lxwrihv4yM1bCMC9hgPVD2/c=;
        b=IvR+kK8RvHv3J8a6ftGnExOLsSaZimPQaPOkcz0nLUY8hKCLTRcU2mIQ73/NswXeBz
         lu7zEgtxjBn4rQ4qW/ORKBn4tTqG4NkF2oLkZatiC+hKzoVQvur4zclHGpafQ8gOCK8g
         hhAfNO0zYifZAw6AI1ZVyJ7t4MbY1qsXdsdLWM7wPLygwNN/kvr1ejscoO30x0zoTcHT
         2AB72Vj0eo1bXZzw/Tz2Ji8zs2Gigige13sfX7eaenvl4ICxCUjUWfn3MAtQ4IL4s1nC
         31nfFuIYV3+PpLAhm29L36HdRZYimOENBCpy6sKwRRxYhawy0Dxy2FSnTRuBVxxDEuLq
         pvkg==
X-Gm-Message-State: ALQs6tDV5sKcEUIuDHXvJFfBO1rTd+xILj6w78/74/Gl6DNv8aCYbkXM
        s7yqqTqhyHInTYu2ATZV5w8=
X-Google-Smtp-Source: AIpwx4/OHJN/ileixDGYb6f/4hcVberz6A0nzvtPmeh1C5t3k84vm2Ez2yI2LX3jhJzMFxdEAOhFGg==
X-Received: by 10.223.151.156 with SMTP id s28mr1806429wrb.16.1523412782498;
        Tue, 10 Apr 2018 19:13:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g38sm162055wra.77.2018.04.10.19.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 19:13:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 02/10] merge: check config before loading commits
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-3-dstolee@microsoft.com>
Date:   Wed, 11 Apr 2018 11:12:59 +0900
In-Reply-To: <20180409164131.37312-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 9 Apr 2018 16:41:57 +0000")
Message-ID: <xmqqo9iqze1g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/builtin/merge.c b/builtin/merge.c
> index ee050a47f3..20897f8223 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1183,13 +1183,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, NULL);
>  	if (branch)
>  		skip_prefix(branch, "refs/heads/", &branch);
> +	init_diff_ui_defaults();
> +	git_config(git_merge_config, NULL);
> +
>  	if (!branch || is_null_oid(&head_oid))
>  		head_commit = NULL;
>  	else
>  		head_commit = lookup_commit_or_die(&head_oid, "HEAD");
>  
> -	init_diff_ui_defaults();
> -	git_config(git_merge_config, NULL);

Wow, that's tricky.  git_merge_config() wants to know which "branch"
we are on, and this place is as early as we can move the call to
without breaking things.  Is this to allow parse_object() called
in lookup_commit_reference_gently() to know if we can rely on the
data cached in the commit-graph data?

> Move the config load to be between the initialization of 'branch'
> and the commit lookup. Also add a test to t5318-commit-graph.sh
> that exercises this code path to prevent a regression.

It is not clear to me how a successful merge of commits/8
demonstrates that reading the config earlier than before is
regression free.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index a380419b65..77d85aefe7 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -221,4 +221,13 @@ test_expect_success 'write graph in bare repo' '
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare commits/8 merge/1
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare commits/8 merge/2
>  
> +test_expect_success 'perform fast-forward merge in full repo' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git checkout -b merge-5-to-8 commits/5 &&
> +	git merge commits/8 &&
> +	git show-ref -s merge-5-to-8 >output &&
> +	git show-ref -s commits/8 >expect &&
> +	test_cmp expect output
> +'
> +
>  test_done
