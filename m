Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9371F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 19:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbdAZT2d (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 14:28:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752303AbdAZT2c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 14:28:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13B5C6357A;
        Thu, 26 Jan 2017 14:27:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6vJvrqVfF+jWOqsU5Me6nPaIu0=; b=PH/NxQ
        3rAZSZaBasiq9Hy0Jdq0oU28m33h+nXtrDw6dE5yECGFaKuh3WLUPFRp/Zgvbwck
        sSkrxtr8DW6nwsv85PnVM9qsDcWauFVCBAGCKFe2JfVfalt+ZttThM9Po2eTBhy0
        hZSKkzm4w0pa+tZfBj970uLfSXtHaeJ0VSkaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=brLVMJt3E5qiaYq/J48ZQbUijGGHAjDG
        ejCHAs/Am2uWljsJ4182EzTxV9YyylkT/j5UUY7nMFB1Z3Ta5yN2MUwl599hhwbj
        qvk7CuFBMxmXIqdyDZU1GXQT5piimpH3JbThnvecoXiK1bqL6I673cvXaYv9jg+A
        XF8WAlp2HMc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AA8063579;
        Thu, 26 Jan 2017 14:27:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5381C63578;
        Thu, 26 Jan 2017 14:27:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <cover.1485442231.git.johannes.schindelin@gmx.de>
        <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
Date:   Thu, 26 Jan 2017 11:27:52 -0800
In-Reply-To: <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 26 Jan 2017 15:52:20 +0100
        (CET)")
Message-ID: <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88D9CC70-E3FD-11E6-B32E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index af2ae4cc02..f2c210f0a0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1949,6 +1949,13 @@ Environment variable settings always override any matches.  The URLs that are
>  matched against are those given directly to Git commands.  This means any URLs
>  visited as a result of a redirection do not participate in matching.
>  
> +ssh.variant::
> +	Override the autodetection of plink/tortoiseplink in the SSH
> +	command that 'git fetch' and 'git push' use. It can be set to
> +	either `ssh`, `plink`, `putty` or `tortoiseplink`. Any other
> +	value will be treated as normal ssh. This is useful in case
> +	that Git gets this wrong.
> +

I do like the fact that this now sits under ssh.* hierarchy (not core.*).

It should mention core.sshCommand, GIT_SSH_COMMAND, etc., because
reading this alone would mislead users to set only this one and expect
that their plink will be used without setting core.sshCommand etc.

It also should say that GIT_SSH_VARIANT environment variable will
override this variable.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 4f208fab92..c322558aa7 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1020,6 +1020,13 @@ Usually it is easier to configure any desired options through your
>  personal `.ssh/config` file.  Please consult your ssh documentation
>  for further details.
>  
> +`GIT_SSH_VARIANT`::
> +	If this environment variable is set, it overrides the autodetection
> +	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
> +	push' use. It can be set to either `ssh`, `plink`, `putty` or
> +	`tortoiseplink`. Any other value will be treated as normal ssh. This
> +	is useful in case that Git gets this wrong.

Similarly this should mention GIT_SSH_COMMAND at least.  It is crazy
to set something that will cause misdetection to core.sshCommand and
use this environment variable to fix it (instead of using ssh.variant),
so I think it is OK not to mention core.sshCommand (but it would not
hurt to do so).

> diff --git a/connect.c b/connect.c
> index 9f750eacb6..7b4437578b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -691,6 +691,24 @@ static const char *get_ssh_command(void)
>  	return NULL;
>  }
>  
> +static int handle_ssh_variant(int *port_option, int *needs_batch)
> +{
> +	const char *variant;
> +
> +	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
> +		git_config_get_string_const("ssh.variant", &variant))
> +		return 0;
> +
> +	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
> +		*port_option = 'P';
> +	else if (!strcmp(variant, "tortoiseplink")) {
> +		*port_option = 'P';
> +		*needs_batch = 1;
> +	}
> +
> +	return 1;
> +}

Between handle and get I do not think there is strong reason to
favor one over the other.  Unlike the one I sent yesterday, this is
not overriding but is getting, so we should keep the original name
Segev gave it, which is shorter, I would think, rather than renaming
it to "handle".

The string that came from the configuration must be freed, no?  That
is what I recall in Peff's comment yesterday.

> @@ -817,7 +835,8 @@ struct child_process *git_connect(int fd[2], const char *url,
>  				ssh_argv0 = xstrdup(ssh);
>  			}
>  
> -			if (ssh_argv0) {
> +			if (!handle_ssh_variant(&port_option, &needs_batch) &&
> +			    ssh_argv0) {

I like the placement of this "if the user explicitly told us" much
better.

My patch yesterday was deliberately being lazy, because the next
thought that will come to us after comparing the two is "this way,
we avoid having to do the auto-detection altogether, which is way
better than wasting the effort to auto-detect, only to override".

And that reasoning will lead to a realization "there is no reason to
even do the split_cmdline() if the user explicitly told us".  While
that reasoning is correct and we _should_ further refactor, I didn't
want to spend braincycles on that myself.
