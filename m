Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0284EC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF05E64F48
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 06:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBEGSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 01:18:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57052 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBEGSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 01:18:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F9DD11F35C;
        Fri,  5 Feb 2021 01:17:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=roMLY78zZTSBIbAUpfdKwrZ/q3U=; b=HzrmsP
        vb8tjRBIa0rYWgj86l6/+VUBK4ZYIoE6VzWilzE/5g5EtL/DfFue/DivpyVMH5Av
        pTIBV9OkvhYLJ7j9PlPY64Q6+t6vYb2ObdOasGbcb/bLJ0g7e+JSdCusGPe3Li4G
        zopGfqbiGg+fsJ/V/mYIUpJr4ARtSGHLq3D0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DQJ5qDVaZ+P6OKHAYdnN9DyT2yClm38I
        W33+SbSQeCZyn8ACJ6cJbTiLMdygZdClPa8kAgDaQizGZRDUO8z83xEMC0HOlL6N
        cm05kSiBabFxGjUAObfKMvd66Hxx4kurGwzGoO3PPPrDiUSnOFLhF66v5fOR7jeJ
        BqHn0/eyIv8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BB2411F35B;
        Fri,  5 Feb 2021 01:17:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60E4C11F359;
        Fri,  5 Feb 2021 01:17:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] usage: trace2 BUG() invocations
References: <20210205054914.104640-1-jonathantanmy@google.com>
Date:   Thu, 04 Feb 2021 22:17:29 -0800
In-Reply-To: <20210205054914.104640-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 4 Feb 2021 21:49:14 -0800")
Message-ID: <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D438AC8C-6779-11EB-A6D0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> die() messages are traced in trace2, but BUG() messages are not. Anyone
> tracking die() messages would have even more reason to track BUG().
> Therefore, write to trace2 when BUG() is invoked.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was noticed when we observed at $DAYJOB that a certain BUG()
> invocation [1] wasn't written to traces.
>
> [1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/
> ---
>  t/helper/test-trace2.c   |  9 +++++++++
>  t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
>  usage.c                  |  6 ++++++
>  3 files changed, 34 insertions(+)

Sounds like a good idea.  Expert opinions?

> diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
> index 823f33ceff..f93633f895 100644
> --- a/t/helper/test-trace2.c
> +++ b/t/helper/test-trace2.c
> @@ -198,6 +198,14 @@ static int ut_006data(int argc, const char **argv)
>  	return 0;
>  }
>  
> +static int ut_007bug(int argc, const char **argv)
> +{
> +	/*
> +	 * Exercise BUG() to ensure that the message is printed to trace2.
> +	 */
> +	BUG("the bug message");
> +}
> +
>  /*
>   * Usage:
>   *     test-tool trace2 <ut_name_1> <ut_usage_1>
> @@ -214,6 +222,7 @@ static struct unit_test ut_table[] = {
>  	{ ut_004child,    "004child",  "[<child_command_line>]" },
>  	{ ut_005exec,     "005exec",   "<git_command_args>" },
>  	{ ut_006data,     "006data",   "[<category> <key> <value>]+" },
> +	{ ut_007bug,      "007bug",    "" },
>  };
>  /* clang-format on */
>  
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index ce7574edb1..81af180c4c 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -147,6 +147,25 @@ test_expect_success 'normal stream, error event' '
>  	test_cmp expect actual
>  '
>  
> +# Verb 007bug
> +#
> +# Check that BUG writes to trace2
> +
> +test_expect_success 'normal stream, exit code 1' '
> +	test_when_finished "rm trace.normal actual expect" &&
> +	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
> +	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
> +	cat >expect <<-EOF &&
> +		version $V
> +		start _EXE_ trace2 007bug
> +		cmd_name trace2 (trace2)
> +		error the bug message
> +		exit elapsed:_TIME_ code:99
> +		atexit elapsed:_TIME_ code:99
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  sane_unset GIT_TRACE2_BRIEF
>  
>  # Now test without environment variables and get all Trace2 settings
> diff --git a/usage.c b/usage.c
> index 1868a24f7a..16272c5348 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -273,6 +273,12 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>  	else
>  		snprintf(prefix, sizeof(prefix), "BUG: ");
>  
> +	/*
> +	 * We call this trace2 function first and expect it to va_copy 'params'
> +	 * before using it (because an 'ap' can only be walked once).
> +	 */
> +	trace2_cmd_error_va(fmt, params);
> +
>  	vreportf(prefix, fmt, params);
>  	if (BUG_exit_code)
>  		exit(BUG_exit_code);
