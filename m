Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E72C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0849523340
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbhATOJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbhATMuG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 07:50:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79D9C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:49:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hs11so31023247ejc.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 04:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rAH46SNyYSWI0Vwhy9/LhkcWjQugP3+5L6BNGmnofz0=;
        b=GTxW4AS++olfu4hqlwBLDuryAFndgG8sv38AtXyefSdkO5BQbb837nRawcvuNiDmSG
         vLpU5GZagzWPdEv63FtGCdZBYnar5mXEGdX4AkYuoudQH0/IUqlmqvorFyLO8R10u+FB
         UBXWBTN7P6RJrk/CP9ZTzey1+kxJ4PzC7RisDzGsO1zRdPcLOzyT6nWyMNp0r2wuQZ3Q
         Wc0hN3osVzYPUUgB6PIWs3nhwm8YUtXEupL8DXfGhmp4pVhjieQpaxrTv6YfEkqlXVRH
         1fjdQdRcUU5mLW+GalrxR2HdO8jTbpuTJKs2oOgXFUDglKBStk6W4AyNejMwSJitmaIb
         lAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rAH46SNyYSWI0Vwhy9/LhkcWjQugP3+5L6BNGmnofz0=;
        b=hk+MtznYWLhmlfJPYQoiW9jpB3h5T0LgXKTo2RZmjjwSPsBBIfopC9q+bS1DMeq5sh
         +QlQjRmjk1lKlnHXDg0nHWEVu8ht+IV9hQtERLcQlzrJwy6x7LNW54HUSj3kH1ataYXo
         fyfUNSOD/rExspDM9AekegLb/6Zy8IeqY9v4S6TlTTQdjYW6whUf12bnf/I1LjzJunT9
         5iNiaDml0VbA5FTFP2VmRFYJ2H27tpZ5natsps1Ax2fZPc5EXpQQbigc48Awe5PdhWqI
         saBUY2C0G5gNfcqAX4NIroLn/vXjmC5FZ9kCOmtRRiZ/8vrVi7kCdcd+xGa0p0PX50gG
         QoVQ==
X-Gm-Message-State: AOAM531GsZGESLijmjaz10HJHxuxRQXoO45rqzjYYhO+LI62vuzwIAvD
        fqbgVcATCjltUqkh3tGtSo8=
X-Google-Smtp-Source: ABdhPJwt7rCK5MHlzaotHJg3vv93JGCjmzz3PAkJM3VFKV9GqAht5Tb4JQlivJuY58fNb13BcTjMEg==
X-Received: by 2002:a17:906:8611:: with SMTP id o17mr6022305ejx.145.1611146948568;
        Wed, 20 Jan 2021 04:49:08 -0800 (PST)
Received: from szeder.dev (92-249-246-25.pool.digikabel.hu. [92.249.246.25])
        by smtp.gmail.com with ESMTPSA id h19sm861177ejl.26.2021.01.20.04.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 04:49:08 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:49:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/2] t5411: use different out file to prevent
 overwriting
Message-ID: <20210120124906.GA8396@szeder.dev>
References: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
 <20210119102459.28986-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210119102459.28986-2-worldhello.net@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 05:24:58AM -0500, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> SZEDER reported that t5411 failed in Travis CI's s390x environment a
> couple of times, and could be reproduced with '--stress' test on this
> specific environment.  The test failure messages might look like this:
> 
>     + test_cmp expect actual
>     --- expect      2021-01-17 21:55:23.430750004 +0000
>     +++ actual      2021-01-17 21:55:23.430750004 +0000
>     @@ -1 +1 @@
>     -<COMMIT-A> refs/heads/main
>     +<COMMIT-A> refs/heads/maifatal: the remote end hung up unexpectedly
>     error: last command exited with $?=1
>     not ok 86 - proc-receive: not support push options (builtin protocol)
> 
> The file 'actual' is filtered from the file 'out' which contains result
> of 'git show-ref' command.  Due to the error messages from other process
> is written into the file 'out' accidentally, t5411 failed.  SZEDER finds
> the root cause of this issue:
> 
>  - 'git push' is executed with its standard output and error redirected
>    to the file 'out'.
> 
>  - 'git push' executes 'git receive-pack' internally, which inherits
>    the open file descriptors, so its output and error goes into that
>    same 'out' file.
> 
>  - 'git push' ends without waiting for the close of 'git-receive-pack'
>    for some cases, and the file 'out' is reused for test of
>    'git show-ref' afterwards.
> 
>  - A mixture of the output of 'git show-ref' abd 'git receive-pack'
>    leads to this issue.
> 
> The first intuitive reaction to resolve this issue is to remove the
> file 'out' after use, so that the newly created file 'out' will have a
> different file descriptor and will not be overwritten by the
> 'git receive-pack' process.  But Johannes pointed out that removing an
> open file is not possible on Windows.  So we use different temporary
> file names to store the output of 'git push' to solve this issue.
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t5411/test-0000-standard-git-push.sh        |  8 +--
>  .../test-0001-standard-git-push--porcelain.sh |  8 +--
>  t/t5411/test-0002-pre-receive-declined.sh     |  4 +-
>  ...st-0003-pre-receive-declined--porcelain.sh |  4 +-
>  t/t5411/test-0011-no-hook-error.sh            |  8 +--
>  t/t5411/test-0012-no-hook-error--porcelain.sh |  8 +--
>  t/t5411/test-0013-bad-protocol.sh             | 50 +++++++++----------
>  t/t5411/test-0014-bad-protocol--porcelain.sh  | 50 +++++++++----------
>  t/t5411/test-0020-report-ng.sh                |  8 +--
>  t/t5411/test-0021-report-ng--porcelain.sh     |  8 +--
>  t/t5411/test-0022-report-unexpect-ref.sh      |  4 +-
>  ...est-0023-report-unexpect-ref--porcelain.sh |  4 +-
>  t/t5411/test-0024-report-unknown-ref.sh       |  4 +-
>  ...test-0025-report-unknown-ref--porcelain.sh |  4 +-
>  t/t5411/test-0026-push-options.sh             |  4 +-
>  t/t5411/test-0027-push-options--porcelain.sh  |  4 +-
>  t/t5411/test-0032-report-with-options.sh      |  4 +-
>  ...est-0033-report-with-options--porcelain.sh |  4 +-
>  t/t5411/test-0038-report-mixed-refs.sh        |  4 +-
>  .../test-0039-report-mixed-refs--porcelain.sh |  4 +-
>  20 files changed, 98 insertions(+), 98 deletions(-)

Wow, this is a lot of churn.

Would it be possible/desirable to die gracefully when the receiving
end doesn't support push options?

> diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000-standard-git-push.sh
> index 47b058af7e..b074417d4b 100644
> --- a/t/t5411/test-0000-standard-git-push.sh
> +++ b/t/t5411/test-0000-standard-git-push.sh
> @@ -35,11 +35,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)" '
>  	test_must_fail git -C workbench push --atomic origin \
>  		main \
>  		$B:refs/heads/next \
> -		>out 2>&1 &&
> +		>out-0000-1 2>&1 &&
>  	filter_out_user_friendly_and_stable_output \
>  		-e "/^To / { p; }" \
>  		-e "/^ ! / { p; }" \
> -		<out >actual &&
> +		<out-0000-1 >actual &&
>  	cat >expect <<-EOF &&
>  	To <URL/of/upstream.git>
>  	 ! [rejected] main -> main (non-fast-forward)
> @@ -65,8 +65,8 @@ test_expect_success "non-fast-forward git-push ($PROTOCOL)" '
>  		push origin \
>  		main \
>  		$B:refs/heads/next \
> -		>out 2>&1 &&
> -	make_user_friendly_and_stable_output <out >actual &&
> +		>out-0000-2 2>&1 &&
> +	make_user_friendly_and_stable_output <out-0000-2 >actual &&

There will be a lot of sequential numbers this way, which might lead
to additional churn in the future, if we ever were to add more tests
somewhere in the middle.  However, our test framework does already
have a counter for test cases, so we could perhaps use that, i.e.
'out-$test_count', to make sure that each test case has its own output
file.

