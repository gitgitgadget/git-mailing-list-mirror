Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AACEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 23:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGTXoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTXoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 19:44:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9302733
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 16:44:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so1165038276.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 16:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689896692; x=1690501492;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFX5T1weNxgLCbtKlIyxMWcgJ6sZ+g0+zctJ/pW4Ngw=;
        b=iRE6Xk5Y32m4tOMyV/xSQeVIWYTSCR19tpfrTjiTgjzB7/G8MgCCgcz6c73AsE9EjL
         ATeMkJx5PwG7GiM+Qf+IVUzIQQwiiPojtWI09RinUDpZFGNPpG7A7/m0u7u+4B+ZIDds
         BWI/CoehmBgA9E/A3hpV0T91O7IaetAWhYZA/eicKHCzXChKVxuENt4T61rb9bdIRB3U
         +CQc9uG0fndXVEgbjqKZVE18WPp11C/y+AuqQB+Ao/4CEsW3ohL+Z5OJFb2086fYVR0E
         mTMU7MZYag6oaTSYX1iLs/NySyUqs+0Vh4LdRuBLkMlJ+KWvfwBSoKpMFbUFVQFHE5+H
         wedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689896692; x=1690501492;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFX5T1weNxgLCbtKlIyxMWcgJ6sZ+g0+zctJ/pW4Ngw=;
        b=gcQld4j9Ssn+N3EaiHA0sbif9yUF1pPqa9+PfiVZHRQYyrJnBDyLsnirXfryUNZH2Y
         7x7X5rR25CHSRNMP2n7Rl0WR5pWbAhuW4J/i4ULQSlt0VR/QVt6B9syeLy2JNRvn82Pk
         gaUax7BzWzS+3EGkF7NM8dcoKQfu3rwIzotJ9nhzye3EjmbyGCLMq8ndAe8DsybmfrVb
         aMmViFQlxMuaLN8HK8yABkA1uv7I3qDzH2HeNsiqCyZaaiP2R+3gv2Nh2tWbLGvR/xa8
         NnmMsP+rKULFEWnuhN4MMIMQohInE4m3m2OnsnmN0pcb9EEvTYsEOZE1gseMY/Vz948f
         7J/Q==
X-Gm-Message-State: ABy/qLYWYSN0SHoeAahJPpsvypwQ3hTpt4qS9RukjGgNT34nrZbV6o4y
        zFoJhceUbgJtaGjqMbYswWhNfEt5kak/rQ/Yisz6
X-Google-Smtp-Source: APBJJlHUfnkIyPEOYBlC/N4d0ON3ZobkYHJNjaUOJH+bO8Qyqk+96dLzw/80CtCzwi41DpGOjWl7hWkB/+8xz5g6fPpz
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:d142:b4af:6ea8:6b8b])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:90a:0:b0:c1e:f91c:2691 with SMTP
 id a10-20020a5b090a000000b00c1ef91c2691mr3261ybq.10.1689896692123; Thu, 20
 Jul 2023 16:44:52 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:44:49 -0700
In-Reply-To: <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720234450.3087841-1-jonathantanmy@google.com>
Subject: Re: [PATCH 1/2] config: return positive from git_config_parse_key()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> git_config_parse_key() returns #define-d error codes, but negated. This
> negation is merely a convenience to other parts of config.c that don't
> bother inspecting the return value before passing it along. But:
> 
> a) There's no good reason why those callers couldn't negate the value
>    themselves.
> 
> b) In other callers, this value eventually gets fed to exit(3), and
>    those callers need to sanitize the negative value (and they sometimes
>    do so lossily, by overriding the return value with
>    CONFIG_INVALID_KEY).
> 
> c) We want to move that into a separate library, and returning only
>    negative values no longer makes as much sense.

I'm not sure if we ever concluded that functions returning errors should
return positive integers, but in this case I think it makes sense. We
can document what's returned as being the same as what's documented in
the config manpage.

The negative return was as early as when the function was first
introduced in b09c53a3e3 (Sanity-check config variable names, 2011-01-
30), but there's no indication there as to why the author chose negative
values.

> Change git_config_parse_key() to return positive values instead, and
> adjust callers accordingly. Callers that sanitize the negative sign for
> exit(3) now pass the return value opaquely, fixing a bug where "git
> config <key with no section or name>" results in a different exit code
> depending on whether we are setting or getting config.

Can you be more precise as to which bug is being fixed? (I think
somewhere, a 1 is returned when it should be a 2.)

> Callers that
> wanted to pass along a negative value now negate the return value
> themselves.

OK.

> diff --git a/builtin/config.c b/builtin/config.c
> index 1c75cbc43df..8a2840f0a8c 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -362,8 +362,7 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
>  			goto free_strings;
>  		}
>  	} else {
> -		if (git_config_parse_key(key_, &key, NULL)) {
> -			ret = CONFIG_INVALID_KEY;
> +		if ((ret = git_config_parse_key(key_, &key, NULL))) {
>  			goto free_strings;
>  		}
>  	}

Ah, here, the return value was sanitized in such a way that it lost
information. The change makes sense.

Besides the callers modified in this patch, there is another caller
config_parse_pair() in config.c, but that just checks whether the return
value is 0, so it remaining unmodified is fine.

> diff --git a/config.h b/config.h
> index 6332d749047..40966cb6828 100644
> --- a/config.h
> +++ b/config.h
> @@ -23,7 +23,7 @@
>  
>  struct object_id;
>  
> -/* git_config_parse_key() returns these negated: */
> +/* git_config_parse_key() returns these: */
>  #define CONFIG_INVALID_KEY 1
>  #define CONFIG_NO_SECTION_OR_NAME 2

Should these be turned into an enum? Also, it might be worth adding that
these match the return values as documented in the manpage.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 387d336c91f..3202b0f8843 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2590,4 +2590,20 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
>  	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
>  '
>  
> +# Exit codes
> +test_expect_success '--get with bad key' '

Rather than put an "exit codes" title, maybe embed that in the test
description.

> +	# Also exits with 1 if the value is not found

I don't understand this comment - what's the difference between a bad
key and a value not being found? And if there's a difference, could we
test both?

> +	test_expect_code 1 git config --get "bad.name\n" 2>err &&
> +	grep "error: invalid key" err &&
> +	test_expect_code 2 git config --get "bad." 2>err &&
> +	grep "error: key does not contain variable name" err
> +'
> +
> +test_expect_success 'set with bad key' '
> +	test_expect_code 1 git config "bad.name\n" var 2>err &&
> +	grep "error: invalid key" err &&
> +	test_expect_code 2 git config "bad." var 2>err &&
> +	grep "error: key does not contain variable name" err
> +'

Makes sense.

From a libification perspective, I'm not sure that using positive values
to indicate error is an advantage over negative values, but it makes
sense in this particular context to have the return values match the
manpage exactly, since that is part of the benefit of this function. So
I think this patch is worth getting in by itself.
