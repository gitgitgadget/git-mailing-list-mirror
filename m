Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6EB1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 02:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfJ3CCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 22:02:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64985 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ3CCB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 22:02:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ED671CC33;
        Tue, 29 Oct 2019 22:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZCLgyk6w7S/fGX5btkmz9mTil1g=; b=c1+4ZW
        JUwkhMjCQeWUktmiMOTDQtapcc7F6ho0CwEFxOufj/dC7hgIeXgJFAO7eEfCd/TH
        dLN7P/Y6AWv5OaBdm4gG7yAvit1qVk/YSuC/TSTrrfL/gFOOtCU33t2KLzhg0USf
        YQQLnjYd3MlDaE8ifnokvf76fUx1E3iC1S3qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sTMO0a/EZeSn+6EY4fGdapxYox0IrrQO
        6zPXvTlnwQqJSYcXq4dr75zQ31qkIRUsUQ39KdDMMPp9R8frFsPSktriS1XpbB91
        XSZfDeBz8KeDnRPGroO99CKOdyeNIqVgX/PUMc3wT2weBjxDxvyR3Kk35Z9m+VkV
        yXTx4JLHi/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 349BE1CC32;
        Tue, 29 Oct 2019 22:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94C481CC31;
        Tue, 29 Oct 2019 22:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
        <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
        <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 11:01:57 +0900
In-Reply-To: <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 29 Oct 2019
        20:01:20 +0000")
Message-ID: <xmqqo8xz3sa2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 417F43B6-FAB9-11E9-B62F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering

perfect ;-)

> Let's avoid this predicament altogether by rendering the entire message,
> including the prefix and the trailing newline, into the buffer we
> already have (and which is still fixed size) and then write it out via
> `write_in_full()`.
>
> We still clip the message to at most 4095 characters.

Good.

> Also please note that we `fflush(stderr)` here to help when running in a
> Git Bash on Windows: in this case, `stderr` is not actually truly
> unbuffered, and needs the extra help.

I do not think you have to single out Windows in this case; if we
are writing directly to file descriptor #2, as long as there have
been something written by the process to the standard error stream
before our caller called us, we must flush it to make sure what
we are going to write out will come after, no matter what platform
we are on.

    The process may have written to the standard error stream and
    there may be something left in the buffer kept in the stdio
    layer.  Call fflush(stderr) before writing the message we
    prepare in this function.

or something along that line would be sufficient.

> diff --git a/usage.c b/usage.c
> index 2fdb20086b..471efb2de9 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -9,14 +9,21 @@
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
> -	char *p;
> +	size_t off = strlcpy(msg, prefix, sizeof(msg));
> +	char *p, *pend = msg + sizeof(msg);
>  
> -	vsnprintf(msg, sizeof(msg), err, params);
> -	for (p = msg; *p; p++) {
> +	p = off < pend - msg ? msg + off : pend - 1;
> +	if (vsnprintf(p, pend - p, err, params) < 0)
> +		*p = '\0'; /* vsnprintf() failed, clip at prefix */
> +
> +	for (; p != pend - 1 && *p; p++) {

It may make the result much simpler to start with something like:

	size_t prefix_len = strlen(prefix);

	if (sizeof(msg) <= prefix_len) {
 		fprintf(stderr, "BUG!!! too long a prefix '%s'\n", prefix);
		abort();
	}
	memcpy(msg, prefix, prefix_len);
	p = msg + prefix_len;

as we agreed that we won't have prefix that will fill or overflow
msg[] based on your earlier reading of the callers like BUG-fl.
That way, we probably may be able to even lose the pend pointer and
arithmetic around it.

>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}

Thanks.  With this flow it is crystal clear that the prefix is shown
as-is, while the payload is sanitized.

> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +
> +	*(p++) = '\n'; /* we no longer need a NUL */
> +	fflush(stderr);
> +	write_in_full(2, msg, p - msg);
>  }
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
