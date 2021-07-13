Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DCC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2033610A7
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhGMW0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhGMW0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:26:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1AC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:23:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h4so22779293pgp.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CMKWmgnwnY/3esvhzuPFJMIUTDpJI91i67PgHGkwmc4=;
        b=hQjyjqOeN0jsQVWNC5+zgUtGWaJcxR6PTv7kr2wRK4OkfGnszrmvIV+Fn8A3ecXVxE
         fbED+jr9ATq4LRYnXr7WCujwKP6JfneI1R5pesnaTB6lMnFJIMK41ntkKJUjXbSzWzex
         4ko+NhdY+6cuPWM7NAexJ32UnKSo2CGQHmUgKRluLUIScKx37vKH3c1MYWZkbfAvDJ3Y
         uh+EjWOq+6Vwanhhd64O0ZXwG/qMC9JF8PN6mTIJ3Ew75usQK95isMUlmoBkJCFqH2hY
         E/urxHditVoZWUtbuBlGGxm09bYge3e6F/WhW0HYiOU63VJt0MC8qzSI0/4r6Afu/Tpd
         OWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CMKWmgnwnY/3esvhzuPFJMIUTDpJI91i67PgHGkwmc4=;
        b=mn6Y1OmKvT31l/kh3VzB6pkFscj5y8bfNdyZXDAqEwD50rXMx+X6WOzT9KOyBWxE2w
         sr+XjAL3i2VaknLPxjHY67il6KAN4voi8ETCh5U5Tb6JBjAO49o4Wf+9snbJGNixpxPl
         USX/K2gHz0LLVvgmbNoLbzxLR6rQLF6xyds21vunNW8vTTwrPkvFv2CDqrmKjZudavXB
         02hQiNMjyruwTVt71za1xbIjHwtX/K/R1nZI/EGOxxNKyghkdVLG1JT7BrLJKllyVNA2
         RqqorFVuHgxopJ5V3D2O1bkwefrQ5ZMuI2bH9iByxj4xyTtLb4em7ZLYCorHcMABDbqW
         UrHg==
X-Gm-Message-State: AOAM532A4ZFXNVJiCjiIiGNVRjGX0zcfcBt6M9GdiZlGUPpUxjEVGiS9
        p0hHm4w5OAYjr8DKFKoMiQuDwQ==
X-Google-Smtp-Source: ABdhPJw5fhymaeCcHS/4QHLyS/Q9Z9d7lrS0Ynlxue64BwgJBzXnjszuC9NbfNgQKo9uNG9Qtdec3w==
X-Received: by 2002:a63:110c:: with SMTP id g12mr6213535pgl.139.1626215021269;
        Tue, 13 Jul 2021 15:23:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:df8b:593d:91b7:a693])
        by smtp.gmail.com with ESMTPSA id p38sm165465pfh.151.2021.07.13.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:23:40 -0700 (PDT)
Date:   Tue, 13 Jul 2021 15:23:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] send-pack: fix push.negotiate with remote helper
Message-ID: <YO4SZs40xzHEb6W7@google.com>
References: <cover.1624486920.git.jonathantanmy@google.com>
 <042612733181ef348a67edc736637c7cd13c7a6d.1624486920.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042612733181ef348a67edc736637c7cd13c7a6d.1624486920.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 03:30:51PM -0700, Jonathan Tan wrote:
> 
> Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> introduced the push.negotiate config variable and included a test. The
> test only covered pushing without a remote helper, so the fact that
> pushing with a remote helper doesn't work went unnoticed.
> 
> This is ultimately caused by the "url" field not being set in the args
> struct. This field being unset probably went unnoticed because besides
> push negotiation, this field is only used to generate a "pushee" line in
> a push cert (and if not given, no such line is generated). Therefore,
> set this field.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/send-pack.c   |  1 +
>  t/t5516-fetch-push.sh | 49 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index a7e01667b0..729dea1d25 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -230,6 +230,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	args.atomic = atomic;
>  	args.stateless_rpc = stateless_rpc;
>  	args.push_options = push_options.nr ? &push_options : NULL;
> +	args.url = dest;
Sure, the fix itself is small and inoffensive. And the rest of the patch
is regression testing.
>  
>  	if (from_stdin) {
>  		if (args.stateless_rpc) {
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 0916f76302..5ce32e531a 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1768,4 +1768,53 @@ test_expect_success 'denyCurrentBranch and worktrees' '
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
>  
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd

Ah, so fetch-push test wasn't doing any HTTP testing whatsoever. Does
that mean there is a better place for these to go? Or does it mean that
fetch-push test was under-testing?

> +
> +test_expect_success 'http push with negotiation' '
> +	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
> +	URI="$HTTPD_URL/smart/server" &&
> +
> +	rm -rf client &&
> +	git init client &&
> +	test_commit -C client first_commit &&
> +	test_commit -C client second_commit &&
> +
> +	# Without negotiation
> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" http.receivepack true &&
> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
Pushing a branch with just the first commit...
> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
transfer.hideRefs (referenced by receive.hideRefs) says this ref will be
omitted from advertisement, so we are forcing either an inefficient push
or a negotiation to occur, by having the server initially claim not to
know about it. But it's only omitted from the *initial* advertisement,
so it will be advertised in later rounds of negotiation, right?
> +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
And then from 'main' we push first_commit and second_commit?
> +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
Nice, I like the comment - this helps.
> +
> +	# Same commands, but with negotiation
> +	rm event &&
> +	rm -rf "$SERVER" &&
Ok, clean up the trace and the server so we can start over, but we don't
need to recreate the client commits because the server doesn't know
about them anyway. Fine.
> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" http.receivepack true &&
> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main &&
And then here's the same set of commands with push negotiation, ok.
> +	grep_wrote 3 event # 1 commit, 1 tree, 1 blob

Is there any reason the event counts would change or be
non-deterministic outside of negotiation? Or, in other words, is this
potentially flaky?

> +'
> +
> +test_expect_success 'http push with negotiation proceeds anyway even if negotiation fails' '
> +	rm event &&
> +	rm -rf "$SERVER" &&
> +	test_create_repo "$SERVER" &&
> +	test_config -C "$SERVER" http.receivepack true &&
> +	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
Hmm, this relies on 'client' being in the same state the above test left
it. Probably better to recreate it or at least leave a loud warning
about it in a comment above this test definition...

> +	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
> +	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c push.negotiate=1 \
> +		push "$URI" refs/heads/main:refs/remotes/origin/main 2>err &&

And we're pushing with protocol v0 so no negotiation can occur here,
right?

> +	grep_wrote 6 event && # 2 commits, 2 trees, 2 blobs
> +	test_i18ngrep "push negotiation failed" err
> +'
> +
> +# DO NOT add non-httpd-specific tests here, because the last part of this
> +# test script is only executed when httpd is available and enabled.
> +
>  test_done
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 

Thanks for answering novice questions :)

 - Emily
