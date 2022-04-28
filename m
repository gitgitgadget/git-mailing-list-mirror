Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3F9C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 23:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353282AbiD1XfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiD1XfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 19:35:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC73819F
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 16:31:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so5829695pjf.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wdCGI98exzYv8TKTzPRge3ebzriGPZ6eqhHyQ+UmsJQ=;
        b=WNQucxjoK6keLZ8ykB3aiJbwki9iNxiC5n9G4IVsLLyro9Sm2tA7GCj3OIz7cNP4jC
         1iKz7MB68v1O8uzgn1j/LTnDwtohK1SCjMgQdIqH5KovgjuVnHCCAIS6Ofxrddso/KXU
         96DnJU6VVJid0dxgdaG7KYXnM+FpwFG3gumnqDpa3ywZkQVZSon7p7/O0VDw+81CgIsO
         ccFssMIJU1C6U3Yv4yUGqltyYCXy/A/ubjjH1kZN79Os0D38U4II63Ga4EBE/HbKaaOk
         N02d8oOFKLK1ts83I+SU4fgDNAIcB9A0C2Tyb5s8f6qtcv6K1mdlsJHHN8DxJkejI4f/
         2Z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wdCGI98exzYv8TKTzPRge3ebzriGPZ6eqhHyQ+UmsJQ=;
        b=1lFt3JpxDYl52XwcTLFTpLnNSRLfcqTXihHPjKL9hMcEeBVSP4goctTF+rK8HQme6+
         qObOlJm6G/E5MrFmqfI1mdby3+X5OVjud0GopR4XMZSKlTk97lMiPS67ygjYKXtZzo3p
         QYqOiArmgQoTpW1DIM50l8rQK7JhKSFtu7uG7Jfs9Kw0ch3CybEvUjDvAENN6yOPI2xW
         lcBKnui3sOhH/VQZcbvG7uDGmAlGInRUZS/P7Bt7mIQEHNhY+DAPBPjF1iC0QyK14SjO
         Wq/tDkEVcvvxO+sY7XKJYmvlLSshbwFJKllccwEqROj/XOVx86Je2YHjV+sI8D8rupxN
         jlxA==
X-Gm-Message-State: AOAM530dxoDifygOvLqXY6YRh3VUHW/H+Vl673j6IvDexFDfjgMea3nz
        t0bToIfP2qmjD5Ems0gI2j+y2wMG6Za7vw==
X-Google-Smtp-Source: ABdhPJx6DVAK4UTU+DAVFN7Y89HO85yCqymLM34pXGrcxouCvIR2u1ofJNwPKuu6I23XKAidVAyl+w==
X-Received: by 2002:a17:902:e5d2:b0:15d:9e66:b3f7 with SMTP id u18-20020a170902e5d200b0015d9e66b3f7mr7934522plf.141.1651188714632;
        Thu, 28 Apr 2022 16:31:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:e691:b08d:17b1:1270])
        by smtp.gmail.com with ESMTPSA id c138-20020a624e90000000b005081f92826dsm869119pfb.99.2022.04.28.16.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 16:31:53 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:31:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 6/6] hook API: fix v2.36.0 regression: hooks should be
 connected to a TTY
Message-ID: <Ymsj5Lv89xqLqZxD@google.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 <patch-6.6-de3664f6d2b-20220421T122108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-6.6-de3664f6d2b-20220421T122108Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 02:25:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Fix a regression reported[1] in f443246b9f2 (commit: convert
> {pre-commit,prepare-commit-msg} hook to hook.h, 2021-12-22): Due to
> using the run_process_parallel() API in the earlier 96e7225b310 (hook:
> add 'run' subcommand, 2021-12-22) we'd capture the hook's stderr and
> stdout, and thus lose the connection to the TTY in the case of
> e.g. the "pre-commit" hook.
> 
> As a preceding commit notes GNU parallel's similar --ungroup option
> also has it emit output faster. While we're unlikely to have hooks
> that emit truly massive amounts of output (or where the performance
> thereof matters) it's still informative to measure the overhead. In a
> similar "seq" test we're now ~30% faster:
> 
> 	$ cat .git/hooks/seq-hook; git hyperfine -L rev origin/master,HEAD~0 -s 'make CFLAGS=-O3' './git hook run seq-hook'
> 	#!/bin/sh
> 
> 	seq 100000000
> 	Benchmark 1: ./git hook run seq-hook' in 'origin/master
> 	  Time (mean ± σ):     787.1 ms ±  13.6 ms    [User: 701.6 ms, System: 534.4 ms]
> 	  Range (min … max):   773.2 ms … 806.3 ms    10 runs
> 
> 	Benchmark 2: ./git hook run seq-hook' in 'HEAD~0
> 	  Time (mean ± σ):     603.4 ms ±   1.6 ms    [User: 573.1 ms, System: 30.3 ms]
> 	  Range (min … max):   601.0 ms … 606.2 ms    10 runs
> 
> 	Summary
> 	  './git hook run seq-hook' in 'HEAD~0' ran
> 	    1.30 ± 0.02 times faster than './git hook run seq-hook' in 'origin/master'
> 
> In the preceding commit we removed the "no_stdin=1" and
> "stdout_to_stderr=1" assignments. This change brings them back as with
> ".ungroup=1" the run_process_parallel() function doesn't provide them
> for us implicitly.
> 
> As an aside omitting the stdout_to_stderr=1 here would have all tests
> pass, except those that test "git hook run" itself in
> t1800-hook.sh. But our tests passing is the result of another test
> blind spot, as was the case with the regression being fixed here. The
> "stdout_to_stderr=1" for hooks is long-standing behavior, see
> e.g. 1d9e8b56fe3 (Split back out update_hook handling in receive-pack,
> 2007-03-10) and other follow-up commits (running "git log" with
> "--reverse -p -Gstdout_to_stderr" is a good start).
> 
> 1. https://lore.kernel.org/git/CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com/
> 
> Reported-by: Anthony Sottile <asottile@umich.edu>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  hook.c          |  8 +++++++-
>  t/t1800-hook.sh | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/hook.c b/hook.c
> index 68ee4030551..f5eef1d561b 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -53,7 +53,9 @@ static int pick_next_hook(struct child_process *cp,
>  	if (!hook_path)
>  		return 0;
>  
> +	cp->no_stdin = 1;
>  	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
> +	cp->stdout_to_stderr = 1;
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> @@ -119,16 +121,20 @@ int run_hooks_opt(const char *hook_name, struct run_hooks_opt *options)
>  		.options = options,
>  	};
>  	const char *const hook_path = find_hook(hook_name);
> -	int jobs = 1;
> +	const int jobs = 1;
>  	int ret = 0;
>  	struct run_process_parallel_opts run_opts = {
>  		.tr2_category = "hook",
>  		.tr2_label = hook_name,
> +		.ungroup = jobs == 1,

So here we do set .ungroup based only on the job count - but we do that
only for hooks, which means someone else could conceivably come across
similar bug in their later use of run_processes_parallel. Is the reason
for doing this in the context of the hook library instead of in the
context of run_processes_parallel library just because we are not sure
if it will break other parallel callers? Or some other reason?

 - Emily

>  	};
>  
>  	if (!options)
>  		BUG("a struct run_hooks_opt must be provided to run_hooks");
>  
> +	if (jobs != 1 || !run_opts.ungroup)
> +		BUG("TODO: think about & document order & interleaving of parallel hook output");
> +
>  	if (options->invoked_hook)
>  		*options->invoked_hook = 0;
>  
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 1e4adc3d53e..f22754deccc 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -4,6 +4,7 @@ test_description='git-hook command'
>  
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-terminal.sh
>  
>  test_expect_success 'git hook usage' '
>  	test_expect_code 129 git hook &&
> @@ -120,4 +121,40 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
>  	test_cmp expect actual
>  '
>  
> +test_hook_tty() {
> +	local fd="$1" &&
> +
> +	cat >expect &&
> +
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	test_hook -C repo pre-commit <<-EOF &&
> +	{
> +		test -t 1 && echo >&$fd STDOUT TTY || echo >&$fd STDOUT NO TTY &&
> +		test -t 2 && echo >&$fd STDERR TTY || echo >&$fd STDERR NO TTY
> +	} $fd>actual
> +	EOF
> +
> +	test_commit -C repo A &&
> +	test_commit -C repo B &&
> +	git -C repo reset --soft HEAD^ &&
> +	test_terminal git -C repo commit -m"B.new" &&
> +	test_cmp expect repo/actual
> +}
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDOUT redirect' '
> +	test_hook_tty 1 <<-\EOF
> +	STDOUT NO TTY
> +	STDERR TTY
> +	EOF
> +'
> +
> +test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY: STDERR redirect' '
> +	test_hook_tty 2 <<-\EOF
> +	STDOUT TTY
> +	STDERR NO TTY
> +	EOF
> +'
> +
>  test_done
> -- 
> 2.36.0.893.g80a51c675f6
> 
