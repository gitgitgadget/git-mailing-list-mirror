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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA1AC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796BF61284
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhGMWd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhGMWdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:33:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C900C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:31:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id n11so16391pjo.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8X7w7E801N/9TCySKeEs3r1B8O/5WGaCIZk5V485FjM=;
        b=vijGkHxKs4/b96D1TMo5ymxo2o+i9Mvc+e+tDhtommeQBo0h6jia4otsUNKyEhwOgV
         eStYw6JjHykyhE100JSoxnJDVJkWy2ZiKmHO1eU6l/HRTu2NUYToodo7ykVzDnUIwPFZ
         i3CE4lj5OvREyzbVimpuxpiYkwXQT9hPboMfdHetC1eDSZdj7fDqSAhsOvvSYtc1qQFN
         PADRMQ4fWsOInkh4jo3EAHW1mnpl4erPLueT7BGLhH1XZCsUdjZXChJDuPwY0j72lyWa
         /MfZ+zMd+dHGSn5OenaP16OdbrVKw+mF2biua79S/LJHBPydK0tSg1h47cWcRsKa84GO
         XH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8X7w7E801N/9TCySKeEs3r1B8O/5WGaCIZk5V485FjM=;
        b=JcnUCC2Mkc+oLeXXYW0rBzZ5Q7yOB1i7BwCVTnNyO5cKNzFajkvM66QybtX87LItG/
         3vpzelFrygKkJNh7X6s3ZFVUf/fy1vLHMNd0m7/AGGCOGsLZE90mr5K/wy89+J0Dztr9
         +ac3/NBfJe8FHpFJGm/Kl+npV2NBIVio+2t2yBpM/UHM6cyWEF5oqUs0I+mFBpcYUQBV
         oIfuPupzUHtwczYoQnMPFCVp1cue/h+b4/QGo6ijNAsKrNC65RfqSHOACwQWCAlpZ/vB
         0zrH6I49643Q6cqV9MMKnuIA4pwsM02HQydSkd6GUYIXV2zOzeGScu2t+Ao+yO8i5YdF
         35ww==
X-Gm-Message-State: AOAM531QN/OH8hEWMAQqBTF1UWpz16F8B6j9HoCwLjfq730PNMOt9L00
        Wv+GjqUifRNjQf7HZIGF1icngQ==
X-Google-Smtp-Source: ABdhPJyDptmXoE1i92aeasMWzg0BpYtz4UTKm2rRDHU0orQNWWnH3wUhsErqBJEIUw3lHCcTjdyQwA==
X-Received: by 2002:a17:90a:6391:: with SMTP id f17mr467738pjj.27.1626215462567;
        Tue, 13 Jul 2021 15:31:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:df8b:593d:91b7:a693])
        by smtp.gmail.com with ESMTPSA id l6sm126082pgh.34.2021.07.13.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:31:01 -0700 (PDT)
Date:   Tue, 13 Jul 2021 15:30:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] send-pack: fix push nego. when remote has refs
Message-ID: <YO4UIGQPugvHcYrw@google.com>
References: <cover.1624486920.git.jonathantanmy@google.com>
 <175da5f02b319bb637700e4f6665ee346674e1b0.1624486920.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175da5f02b319bb637700e4f6665ee346674e1b0.1624486920.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 03:30:52PM -0700, Jonathan Tan wrote:
> 
> Commit 477673d6f3 ("send-pack: support push negotiation", 2021-05-05)
> did not test the case in which a remote advertises at least one ref. In
> such a case, "remote_refs" in get_commons_through_negotiation() in
> send-pack.c would also contain those refs with a zero ref->new_oid (in
> addition to the refs being pushed with a nonzero ref->new_oid). Passing
> them as negotiation tips to "git fetch" causes an error, so filter them
> out.

So here we are filtering those redundant refs on the client side?

> 
> (The exact error that would happen in "git fetch" in this case is a
> segmentation fault, which is unwanted. This will be fixed in the
> subsequent commit.)
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  send-pack.c           | 6 ++++--
>  t/t5516-fetch-push.sh | 5 +++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/send-pack.c b/send-pack.c
> index 9cb9f71650..85945becf0 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -425,8 +425,10 @@ static void get_commons_through_negotiation(const char *url,
>  	child.no_stdin = 1;
>  	child.out = -1;
>  	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> -	for (ref = remote_refs; ref; ref = ref->next)
> -		strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +	for (ref = remote_refs; ref; ref = ref->next) {
> +		if (!is_null_oid(&ref->new_oid))
> +			strvec_pushf(&child.args, "--negotiation-tip=%s", oid_to_hex(&ref->new_oid));
> +	}
>  	strvec_push(&child.args, url);
>  
>  	if (start_command(&child))
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 5ce32e531a..e383ba662f 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -201,6 +201,7 @@ test_expect_success 'push with negotiation' '
>  	# Without negotiation
>  	mk_empty testrepo &&
>  	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C testrepo unrelated_commit &&
>  	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
>  	echo now pushing without negotiation &&
>  	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 push testrepo refs/heads/main:refs/remotes/origin/main &&
> @@ -210,6 +211,7 @@ test_expect_success 'push with negotiation' '
>  	rm event &&
>  	mk_empty testrepo &&
>  	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C testrepo unrelated_commit &&

So now we are asking 'testrepo' to initially advertise that it also has
unrelated_commit, which we don't care about, and expect to work fine
anyway. Ok.

>  	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
>  	GIT_TRACE2_EVENT="$(pwd)/event" git -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main &&
>  	grep_wrote 2 event # 1 commit, 1 tree
> @@ -219,6 +221,7 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>  	rm event &&
>  	mk_empty testrepo &&
>  	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C testrepo unrelated_commit &&
>  	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
>  	GIT_TEST_PROTOCOL_VERSION=0 GIT_TRACE2_EVENT="$(pwd)/event" \
>  		git -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
> @@ -1783,6 +1786,7 @@ test_expect_success 'http push with negotiation' '
>  	# Without negotiation
>  	test_create_repo "$SERVER" &&
>  	test_config -C "$SERVER" http.receivepack true &&
> +	test_commit -C "$SERVER" unrelated_commit &&
>  	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
>  	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
>  	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 \
> @@ -1794,6 +1798,7 @@ test_expect_success 'http push with negotiation' '
>  	rm -rf "$SERVER" &&
>  	test_create_repo "$SERVER" &&
>  	test_config -C "$SERVER" http.receivepack true &&
> +	test_commit -C "$SERVER" unrelated_commit &&
>  	git -C client push "$URI" first_commit:refs/remotes/origin/first_commit &&
>  	git -C "$SERVER" config receive.hideRefs refs/remotes/origin/first_commit &&
>  	GIT_TRACE2_EVENT="$(pwd)/event" git -C client -c protocol.version=2 -c push.negotiate=1 \
> -- 
> 2.32.0.288.g62a8d224e6-goog


Seems reasonable enough to me.
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
