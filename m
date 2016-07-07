Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5D920705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcGGUVB (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:21:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbcGGUVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:21:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 111B52A379;
	Thu,  7 Jul 2016 16:20:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tQFv64eFTsxSAWEJtW5NNQFtSKI=; b=VYbGP6
	XmKUgjiylt68yGTcPaA4bZgVX3NfAABoq9GCGn2FKkubfymv0ESdGAm82VYElhif
	FE6jm3TgX19KFFj+thW/xK8dn2KLdlawCPShY0+4M60Zvu1UhrryWQDdfhDcU0GG
	fLF37JU4g012ZOKxghY4Sz6FUNgJnt77vq7jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ho2+4CAx5IeGRJF+77nXJvjWAbqh3eG/
	F55463VreBsr6gkPd4yuxN0ekliKmX6YcqKUB5Sb7/6uinbmhDhjuYVDqsAST99Y
	lCHmz4cLAI6VDavhPo62wqAibvJGkH63DcHjwDBV5MtRvBZV24QNG1ntAttPi3X1
	ujS+9EYid8Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 096592A378;
	Thu,  7 Jul 2016 16:20:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 864EF2A377;
	Thu,  7 Jul 2016 16:20:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-2-sbeller@google.com>
Date:	Thu, 07 Jul 2016 13:20:56 -0700
In-Reply-To: <20160707011218.3690-2-sbeller@google.com> (Stefan Beller's
	message of "Wed, 6 Jul 2016 18:12:15 -0700")
Message-ID: <xmqqeg75p5cn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50ED5010-4480-11E6-BE56-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As we first want to focus on getting simple strings to work
> reliably, we go with the last option for now.

OK.

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index d82e912..c875cde 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -247,6 +247,9 @@ Both standard output and standard error output are forwarded to
>  'git send-pack' on the other end, so you can simply `echo` messages
>  for the user.
>  
> +The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
> +and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
> +
>  [[update]]
>  update
>  ~~~~~~
> @@ -322,6 +325,9 @@ a sample script `post-receive-email` provided in the `contrib/hooks`
>  directory in Git distribution, which implements sending commit
>  emails.
>  
> +The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
> +and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
> +

The mention of "push options" in these two entries sounded a bit too
abrupt, at least to me.  Perhaps add a short phrase before the
sentence, e.g.

    When 'git push --push-option=...' is used, the number of push
    options are avaiable ...

or

    The number of push options given on the command line of "git
    push --push-option=..." can be read from the environment
    variable GIT_PUSH_OPTION_COUNT, and the options themselves are
    found in GIT_PUSH_OPTION_0, GIT_PUSH_OPTION_1,...

We can read any of the above variants in two ways to describe what
should happen when "git push" is run without "--push-option=...".
Is GIT_PUSH_OPTION_COUNT unset, or set to 0?  Either way, it may be
better to be a bit more explicit.

The hook driver code does not explicitly clear these environment
variables; it is safe to assume that these won't seep in from the
environment, I think, but I am not sure.

> @@ -1756,6 +1771,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  
>  	if ((commands = read_head_info(&shallow)) != NULL) {
>  		const char *unpack_status = NULL;
> +		struct string_list *push_options = NULL;
>  
>  		prepare_shallow_info(&si, &shallow);
>  		if (!si.nr_ours && !si.nr_theirs)
> @@ -1764,13 +1780,19 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  			unpack_status = unpack_with_sideband(&si);
>  			update_shallow_info(commands, &si, &ref);
>  		}
> -		execute_commands(commands, unpack_status, &si);
> +		execute_commands(commands, unpack_status, &si,
> +				 push_options);
>  		if (pack_lockfile)
>  			unlink_or_warn(pack_lockfile);
>  		if (report_status)
>  			report(commands, unpack_status);
> -		run_receive_hook(commands, "post-receive", 1);
> +		run_receive_hook(commands, "post-receive", 1,
> +				 push_options);
>  		run_update_post_hook(commands);
> +		if (push_options) {
> +			string_list_clear(push_options, 0);
> +			free(push_options);
> +		}
>  		if (auto_gc) {
>  			const char *argv_gc_auto[] = {
>  				"gc", "--auto", "--quiet", NULL,
> diff --git a/templates/hooks--pre-receive.sample b/templates/hooks--pre-receive.sample
> new file mode 100644
> index 0000000..e4d3edc
> --- /dev/null
> +++ b/templates/hooks--pre-receive.sample
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +#
> +# An example hook script to make use of push options.
> +# The example simply echoes all push options that start with 'echoback='
> +# and rejects all pushes when the "reject" push option is used.
> +#
> +# To enable this hook, rename this file to "pre-receive".
> +
> +if test -n "$GIT_PUSH_OPTION_COUNT"; then
> +	i=0
> +	while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do


Style:

        if test -n "$GIT_PUSH_OPTION_COUNT"
        then
		...

	while test ...
        do
		...

> +		eval "value=\$GIT_PUSH_OPTION_$i"
> +		case "$value" in
> +		echoback=*)
> +			echo "echo from the pre-receive-hook ${value#*=}" >&2
> +			;;
> +		reject)
> +			exit 1
> +		esac
> +		i=$((i + 1))
> +	done
> +fi

What is suboptimal about the structure of the series is that we
won't bisect down to any of the potential bugs in the above code
even if we ever see any bug in the future.  It also does not hint
where push_options is expected to be read in the code in the
subsequent patches in the series.  If I were doing this series, I
would probably have done 2/4 first without plumbing it through
(i.e. it is sent and accumulated in a string list at the receiver,
and then cleared and freed without being used), and then added the
processing (i.e. this step) as the second patch.
