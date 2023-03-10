Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDBC6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 20:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjCJUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjCJUc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 15:32:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA960139D07
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 12:32:08 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p6so6932453plf.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678480259;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X52x4H/Ic8abFdAd1mv3xpGGLxB4yL1B0i3l/mrB8A=;
        b=aTK+ujdj+92RnVypIHePTbJfxzLhT6qBdNH7I3qiK9cqm9KZUhK7aQgn7j1jLsRle2
         kPjoC4RsSKn5vKZnasR1dPNq+G0+D9UtpL42+6/qrNb13hLbsZvwrX7I7I/5gRa+K95j
         htwNpT9k3PN51IJlQRkwNFpa/HbbMel32zVOzcTdJb8EcB5ZLWVBWXrSfLfrATr9fZIo
         TcOCTemzzCLZsraxJHvIQVratSEhfCgGKuFwCIwY33VjYG6xmUuA3K1cQSeuV4JBDw1G
         fAGw40yfqnC2Pa8vP/kopYN0KwTB4UykzV7gY2Y3un3b9wqt9aetg1SyTp31L8Mq0y2T
         3eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678480259;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1X52x4H/Ic8abFdAd1mv3xpGGLxB4yL1B0i3l/mrB8A=;
        b=jfqVCqXWRG66tcpZaP5PLKLPfD+AimR8+wITpKuXEAqpaISy8u09gereR3hy6hF8zi
         jvzXtOJGI3xQ+S3Pm3ypr75OynIlY7scg1krEVa27kSrsRdO/VJI2nwSpS2FBjTjiBmI
         lzCOYSzjBl01ZKso+qUqgFoLBHjOEWsdDHqb2KSQESrHG2TN6IQ7TGyB/Mr0FEvPVucw
         //DExdEQu07EQa7UcG8jPYfzQYxJZGyhxWOJPipC3+Ofu1f31UCpKAt7GzgBiMEU6yX4
         o+uY/hGzLhpQHoBUxykffIBfia1PffGPbkzv4mDh6YV6hYNoeYqJ36i9oTag7iKf17s4
         Eutw==
X-Gm-Message-State: AO0yUKVPInfsqSq/SIGt6Nm0hOyqEq1Nst5yq6zXzusjRm6CCi/V7hve
        NUKKDpmkS4YQ7NNtLEKXncc=
X-Google-Smtp-Source: AK7set9ml9CyspFlGSgDh+a2eTpddi543ZjxPW78BWGbOkIeMDhDzBHp9BW706pqoTfQPcJqIsIjoQ==
X-Received: by 2002:a17:90b:1b12:b0:237:6b9a:50e3 with SMTP id nu18-20020a17090b1b1200b002376b9a50e3mr27319623pjb.2.1678480259245;
        Fri, 10 Mar 2023 12:30:59 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id gg5-20020a17090b0a0500b00233afe09177sm144847pjb.8.2023.03.10.12.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 12:30:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v2] index-pack: remove fetch_if_missing=0
References: <20230225052439.27096-1-five231003@gmail.com>
        <20230310183029.19429-1-five231003@gmail.com>
Date:   Fri, 10 Mar 2023 12:30:58 -0800
In-Reply-To: <20230310183029.19429-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Sat, 11 Mar 2023 00:00:29 +0530")
Message-ID: <xmqqzg8k4ad9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> This global was added as a temporary measure to suppress the fetching
> of missing objects and can be removed once the commandshave been taught
> to handle these cases.

Two requests.

 * Could you substantiate this claim for future readers of "git
   log"?  A reference to an old mailing list discussion or a log
   message of the commit that added the temporary measure that says
   the above plan would be perfect.

 * What exactly does "once the commands have been taught"?  Which
   commands?  Could you clarify?

> Hence, use has_object() to check for the existence of an object, which
> has the default behavior of not lazy-fetching in a partial clone. It is
> worth mentioning that this is the only place where there is potential for
> lazy-fetching and all other cases are properly handled, making it safe to
> remove this global here.

This paragraph is very well explained.

> @@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	int report_end_of_input = 0;
>  	int hash_algo = 0;
>  
> -	/*
> -	 * index-pack never needs to fetch missing objects except when
> -	 * REF_DELTA bases are missing (which are explicitly handled). It only
> -	 * accesses the repo to do hash collision checks and to check which
> -	 * REF_DELTA bases need to be fetched.
> -	 */

OK.  The comment describes the design choice we made to flip the
fetch_if_missing flag off.  The old world-view was that we would
notice a breakage by non-functioning index-pack when a lazy clone is
missing objects that we need by disabling auto-fetching, and we
instead explicitly handle any missing and necessary objects by lazy
fetching (like "when we lack REF_DELTA bases").  It does sound like
a conservative thing to do, compared to the opposite approach we are
taking with this patch, i.e. we would not fail if we tried to access
objects we do not need to, because we have lazy fetching enabled,
and we just ended up with bloated object store nobody may notice.

To protect us from future breakage that can come from the new
approach, it is a very good thing that you added new tests to ensure
no unnecessary lazy fetching is done (I am not offhand sure if that
test is sufficient, though).

> -	fetch_if_missing = 0;

Looking good to me.  Jonathan, who reviewed the previous round, do
you have any comments?

Thanks, all.  Will queue.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index f519d2a87a..46af8698ce 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -644,6 +644,41 @@ test_expect_success 'repack does not loosen promisor objects' '
>  	grep "loosen_unused_packed_objects/loosened:0" trace
>  '
>  
> +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collsions' '
> +	rm -rf server promisor-remote client repo trace &&
> +
> +	# setup
> +	git init server &&
> +	for i in 1 2 3 4
> +	do
> +		echo $i >server/file$i &&
> +		git -C server add file$i &&
> +		git -C server commit -am "Commit $i" || return 1
> +	done &&
> +	git -C server config --local uploadpack.allowFilter 1 &&
> +	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> +	HASH=$(git -C server hash-object file3) &&
> +
> +	git init promisor-remote &&
> +	git -C promisor-remote fetch --keep "file://$(pwd)/server" &&
> +
> +	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> +	git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> +	git -C client config extensions.partialClone 1 &&
> +	git -C client config remote.origin.promisor 1 &&
> +
> +	git init repo &&
> +	echo "5" >repo/file5 &&
> +	git -C repo config --local uploadpack.allowFilter 1 &&
> +	git -C repo config --local uploadpack.allowAnySha1InWant 1 &&
> +
> +	# verify that no lazy-fetching is done when fetching from another repo
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> +					fetch --keep "file://$(pwd)/repo" main &&
> +
> +	! grep "want $HASH" trace
> +'
> +
>  test_expect_success 'lazy-fetch in submodule succeeds' '
>  	# setup
>  	test_config_global protocol.file.allow always &&
