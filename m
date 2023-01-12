Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EFC61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbjALI7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 03:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjALI5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 03:57:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DF1C930
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 00:55:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v10so24650506edi.8
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 00:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1suKQ4lbfKfRvdSJgprzymOgLq7niPhHK0WgfzYf0v4=;
        b=PGk22QEYeuXhXdHrJsqDOXqyP6tf3o9KQ0dVUevE5Y2NCo3SqAIrLofGJAakSUTSe1
         NZ8v6/7ToolJcwUmoKTrMg/2yG1R/NHeasD9e4uHd6VJa5vtsRYp2Y8DhsvPCGkGX0CR
         JqsJIMtV39846LHZzcH9H0cmxCOH7sdXhzOCpGceJNUg3s7EJGTNii95cjUri6kJnXVn
         OA8N84tW//ivTdnaHrcaNk6t0Vfr7QwcHb3b6BofzHJG+9Qg07nZd8kK3Z7bmD2k6V70
         /26UdTYA0EM0oQx/lN/CK/W3KmtxpXTNAQj9DmkxsOR8OEHNkFf7WqPrkH5ChoxANlXt
         oogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1suKQ4lbfKfRvdSJgprzymOgLq7niPhHK0WgfzYf0v4=;
        b=WQ7eAs6MayhxyamwZ1KT56j8FfozUlaT/RuXshfQz57ksfX4LDGzXL3N0fRat3VEbJ
         90gjl4MDGaIMbunTGr3U+YU0VA4xKWU1KCwbX1zICqfqaLR+2oLbfFvOpIWlcO3GwW8U
         x5nRvjNontezj5sA6ZDMRjCLaQSP2zSs6N4g3gKcg8CbgYN3dvhXHdtAsVEM7KauYC97
         I3yaLQkJoWVODMOBzIiZFqVl/0f3BjWAxWTCEFp8FLHlY+9N8YES9EHH0maR2qYZBZxG
         kFTsCCg4D+9jtexjFNXD7qtKjlUB+oArR1h8HJslSvnztlNN7xq30zlVXaObhInjt5AZ
         tq/w==
X-Gm-Message-State: AFqh2kqguw+cojOjdalEinxDKZ72gXyfeYIS1Ap8uKFvsEJdkGtqjDIn
        sQAvax0okBhdSCBuqx4/Lx8DsXSNKTY=
X-Google-Smtp-Source: AMrXdXvFo9qSYTwEjrYLkRYpyZcEZ8prNZA4ZC4lA3vMKDk3dQJ6128D/arz1HC7UxlnPf5yvg2s5Q==
X-Received: by 2002:a05:6402:f0b:b0:499:b48b:2c3 with SMTP id i11-20020a0564020f0b00b00499b48b02c3mr13579330eda.25.1673513717635;
        Thu, 12 Jan 2023 00:55:17 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402184f00b0046c5baa1f58sm6866381edy.97.2023.01.12.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 00:55:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFtMi-0004mx-1l;
        Thu, 12 Jan 2023 09:55:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v5 10/10] credential: add WWW-Authenticate header to
 cred requests
Date:   Thu, 12 Jan 2023 09:48:43 +0100
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <af66d2d2ede2a502f32d74c86f302598c68d1476.1673475190.git.gitgitgadget@gmail.com>
Message-ID: <230112.86sfgg2kuj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 11 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> [...]
> +static void credential_write_strvec(FILE *fp, const char *key,
> +				    const struct strvec *vec)
> +{
> +	int i = 0;
> +	const char *full_key = xstrfmt("%s[]", key);
> +	for (; i < vec->nr; i++) {
> +		credential_write_item(fp, full_key, vec->v[i], 0);

Style: Don't mismatch types if there's no good reason. Use "size_t i" here, also let's do:

	for (size_t i = 0; ....

I.e. no reason to declare it earlier.

> +	}
> +	free((void*)full_key);

Just don't add a "const" to that "full_key" and skip the cast with
free() here.

> +++ b/t/helper/test-credential-helper-replay.sh

I see to my surprise that we have one existing *.sh helper in that
directory, but in any case...

> @@ -0,0 +1,14 @@
> +cmd=$1
> +teefile=$cmd-actual.cred
> +catfile=$cmd-response.cred
> +rm -f $teefile
> +while read line;
> +do
> +	if test -z "$line"; then
> +		break;
> +	fi
> +	echo "$line" >> $teefile
> +done

It looks like you're re-inventing "sed" here, isn't this whole loop just

	sed -n -e '/^$/q' -n 'p'

And then you can skip the "rm" before, as you could just clobber the
thing.

> +if test "$cmd" = "get"; then
> +	cat $catfile
> +fi
> diff --git a/t/t5556-http-auth.sh b/t/t5556-http-auth.sh
> index 65105a5a6a9..a8dbee6ca40 100755
> --- a/t/t5556-http-auth.sh
> +++ b/t/t5556-http-auth.sh
> @@ -27,6 +27,8 @@ PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
>  SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
>  
>  PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
> +CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
> +	&& export CREDENTIAL_HELPER

...(continued from above): Let's just use write_script() here or
whatever, i.e. no reason to make this a global script, it's just used in
this one test, so it can set it up.
>  
>  test_expect_success 'setup repos' '
>  	test_create_repo "$REPO_DIR" &&
> @@ -92,15 +94,279 @@ start_http_server () {
>  
>  per_test_cleanup () {
>  	stop_http_server &&
> -	rm -f OUT.*
> +	rm -f OUT.* &&
> +	rm -f *.cred &&
> +	rm -f auth.config
>  }
>  
>  test_expect_success 'http auth anonymous no challenge' '
>  	test_when_finished "per_test_cleanup" &&
> -	start_http_server &&
> +
> +	cat >auth.config <<-EOF &&
> +	[auth]
> +	    allowAnonymous = true

Mixed tab/space. Use "\t" not 4x " " (ditto below).
