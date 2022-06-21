Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B2C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiFUSXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFUSX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 14:23:28 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408F17E06
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:23:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e9-20020a17090a630900b001ec7da73dbdso3230521pjj.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Y4jNBEb/VjY6w3RbxmIZz4k1NMtOj8ecAiuAjMLnRyA=;
        b=GZE5ozWNNlF7g81YvVbl9cgNZ+PlKMsXfH2jpASN6oI2GFr0Ig2i0pt8R158xTryyW
         0rLxZDOjHOo7WoLEdyPRteqOoJ+qZDtX9/FFyDK+GDEvKYQwdKxNErdGSgwkivOjER7e
         jvPz34q/giYKVJKUnlj05z1zolyy+CbqdCYwi/mM2QzCvdc3arfj/k001frle9YSLYTs
         77pCJi6V8JzTLUVo/X4mDoFF0Zcuq0+O51FvfH7RQ2PkpLRVF5Nfh3QR5XhoGYMhkUSM
         ZUIneXRlgbOyx3TJBClYOqmXFfaVn7nvD8iPZZaEfuU+UIvgrG+gb4NAJac92HsBT3SX
         V3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Y4jNBEb/VjY6w3RbxmIZz4k1NMtOj8ecAiuAjMLnRyA=;
        b=Vh2hUV9nanL0cmKl0uS8IrLi/5P3pZGrwulVGkSspcfCv4nS4qqatoG7EqsEWkKiOh
         dgB7CevwQCJlBzicshP+fsqxgZpIqPntSozORKjGzTFhe62h0IOPioza1OVnHgnex0z7
         RBe5nfQL9mH/jE2E4NH86mMP3RiLu+26DkU0cE5Ft5EetxxDkcgJ5xiNTMYHWKYE6Yp4
         0fcec10tFnroIDuQYkRSL4CRU3UEZpSvuJd7fpDt8soaJ6IPPjcgRbw3KCGm1oprcmmz
         pb3ogNnh1GnKbxY4NzPbwdowSwKNrZiilFX+/AWXGJWfkY5Rj3gINUg8WYoSlKN1gF7B
         AHHA==
X-Gm-Message-State: AJIora/ial7eu4qiKm3KKdymi0wqx0gD4cPNVqSSjZA181CII8s7d+T0
        TlxzfgFARur8o3W4vEYtVa19lpCwD/98lOPoTj27
X-Google-Smtp-Source: AGRyM1vUtiVLeEa72aEcyYXNVjuRokXob24KSMsMqty4EVPxdft47WZkkiKWjNYT5qVJY2NHaBDXI2a7SqUjx9LF7DL3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8488:b0:167:9151:a8db with
 SMTP id c8-20020a170902848800b001679151a8dbmr30095712plo.2.1655835806034;
 Tue, 21 Jun 2022 11:23:26 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:23:21 -0700
In-Reply-To: <20220618030130.36419-1-hanxin.hx@bytedance.com>
Message-Id: <20220621182322.3444926-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
Subject: Re: [PATCH v1] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:
> If a commit is in the commit graph, we would expect the commit to also
> be present. So we should use has_object() instead of
> repo_has_object_file(), which will help us avoid getting into an endless
> loop of lazy fetch.
> 
> We can see the endless loop issue via this[1].
> 
> 1. https://lore.kernel.org/git/20220612161707.21807-1-chiyutianyi@gmail.com/

As described in SubmittingPatches:

  Try to make sure your explanation can be understood   
  without external resources. Instead of giving a URL to a mailing list
  archive, summarize the relevant points of the discussion.

> +test_expect_success 'setup' '
> +	git init --bare dest.git &&
> +	test_commit one &&
> +	git checkout -b tmp &&
> +	test_commit two &&
> +	git push dest.git --all
> +'

You can commit directly to the repo by using "test_commit -C dest.git".
Also, can the repositories be better named? I see a "dest.git" (which
seems to contain all the objects), "alternates" (which seems to contain
everything except refs/heads/tmp), "source" (which only contains the
commit graph), and the current directory. It would probably be better to
name them e.g. "with-commit", "without-commit", "only-commit-graph", and
omit using the current directory altogether.

> +test_expect_success 'prepare a alternates repository without commit two' '
> +	git clone --bare dest.git alternates &&
> +	oid=$(git -C alternates rev-parse refs/heads/tmp) &&
> +	git -C alternates update-ref -d refs/heads/tmp &&
> +	git -C alternates gc --prune=now &&
> +	pack=$(echo alternates/objects/pack/*.pack) &&
> +	git verify-pack -v "$pack" >have &&
> +	! grep "$oid" have
> +'

OK, except refs/heads/tmp could probably have a better name.

> +test_expect_success 'prepare a repository with a commit-graph contains commit two' '
> +	git init source &&
> +	echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
> +	git -C source remote add origin "$(pwd)/dest.git" &&
> +	git -C source config remote.origin.promisor true &&
> +	git -C source config remote.origin.partialclonefilter blob:none &&
> +	# the source repository has the whole refs contains refs/heads/tmp
> +	git -C source fetch origin &&
> +	(
> +		cd source &&
> +		test_commit three &&
> +		git -c gc.writeCommitGraph=true gc
> +	)
> +'

Is the purpose of the fetch only to add a ref? If yes, it's clearer just
to create that branch instead of fetching.

> +test_expect_success 'change the alternates of source to that without commit two' '
> +	# now we have a commit-graph in the source repository but without the commit two
> +	echo "$(pwd)/alternates/objects" >source/.git/objects/info/alternates
> +'

OK.

> +test_expect_success 'fetch the missing commit' '
> +	git -C source fetch origin $oid 2>fetch.out &&
> +	grep "$oid" fetch.out
> +'

Is the bug triggered by fetching the missing commit or by fetching any
commit (which triggers the usage of the commit graph)? If any commit,
then it's clearer to create an arbitrary commit and then fetch it.

Also, I thought that the issue was an infinite loop, and the thing being
tested here looks different from that. If you want to ensure that
nothing is being fetched, you can use GIT_TRACE="$(pwd)/trace" to
observe a fetch-pack command being invoked or
GIT_TRACE_PACKET="$(pwd)/trace" to observe the packet being sent. If
you're worried about an infinite loop, you can set origin to a directory
that does not exist (so that the fetch immediately fails).
