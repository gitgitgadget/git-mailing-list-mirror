Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD22C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3720748
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aO1Dbixa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgAQVVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:21:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61228 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:21:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08152A84B4;
        Fri, 17 Jan 2020 16:21:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ia6tRnfrbMy4tXLxfxkIbgR+fWQ=; b=aO1Dbi
        xapGzeS7kkUeDAOSrBGcvSVIpCq3BDKivn6uhiIfQRHeg1GCbsWNUso7Mx8A2RYA
        LWUgODTpBxygYJlO7DKnVO8Z2xf40puQPJkT3Gu1FvLY7rCDjyW36JA7hRS0SWxB
        cqc9o414hnPT5MmGtsJDqlaPwjBbLygFA4huw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hhgaiIVui7d6uCGn3dvewdOkhitGJk6U
        TwF70h9FpZpI9DJM/OHg+lzUrkFnCzDJ2ig22Pgk8XeoPQbzmiU637sHVHB04KKv
        KtAdOC0U7fzKLc3Z/aySCJeAacjAa3VwfnmuhGILrU3bQPMNC8nnkxGgpn6Im6jL
        NbUaVnVPwfs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F4069A84B2;
        Fri, 17 Jan 2020 16:21:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0321FA84B1;
        Fri, 17 Jan 2020 16:21:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v3 4/4] config: add '--show-scope' to print the scope of a config value
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <61ff3c64b5bdec4aaca71caa63efc23888713315.1579275102.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 13:21:04 -0800
In-Reply-To: <61ff3c64b5bdec4aaca71caa63efc23888713315.1579275102.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 17 Jan 2020
        15:31:42 +0000")
Message-ID: <xmqqsgkddbjz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4635D72C-396F-11EA-9917-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--show-scope::
> +	Similar to `--show-origin` in that it augments the output of
> +	all queried config options with the scope of that value 
> +	(local, global, system, command).
> +
>  --get-colorbool name [stdout-is-tty]::
>  
>  	Find the color setting for `name` (e.g. `color.diff`) and output
> diff --git a/builtin/config.c b/builtin/config.c
> index 52a904cfb1..d5931061e8 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -33,6 +33,7 @@ static int end_nul;
>  static int respect_includes_opt = -1;
>  static struct config_options config_options;
>  static int show_origin;
> +static int show_scope;
>  
>  #define ACTION_GET (1<<0)
>  #define ACTION_GET_ALL (1<<1)
> @@ -155,6 +156,7 @@ static struct option builtin_config_options[] = {
>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
>  	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
>  	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> +	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree, local, global, system, command)")),
>  	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
>  	OPT_END(),
>  };
> @@ -189,11 +191,43 @@ static void show_config_origin(struct strbuf *buf)
>  	strbuf_addch(buf, term);
>  }
>  
> +static const char *scope_to_string(enum config_scope scope)
> +{
> +	switch (scope) {
> +	case CONFIG_SCOPE_LOCAL:
> +		return "local";
> +	case CONFIG_SCOPE_GLOBAL:
> +		return "global";
> +	case CONFIG_SCOPE_SYSTEM:
> +		return "system";
> +	case CONFIG_SCOPE_WORKTREE:
> +		return "worktree";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";
> +	case CONFIG_SCOPE_SUBMODULE:
> +		return "submodule";
> +	default:
> +		return "unknown";
> +	}
> +}

It is a shame that with this defined in the main part of the system
test-tool still needs to carry its own private copy.

I wonder if it results in a better system if we rename this to

	const char *config_scope_name(enum config_scope scope)

made it externally visible, and use it in t/helper/test-config.c
and get rid of the private copy scope_name() there?

> diff --git a/config.h b/config.h
> index f383a71404..91f851e925 100644
> --- a/config.h
> +++ b/config.h
> @@ -35,10 +35,21 @@ struct object_id;
>  
>  #define CONFIG_REGEX_NONE ((void *)1)
>  
> +enum config_scope {
> +	CONFIG_SCOPE_UNKNOWN = 0,
> +	CONFIG_SCOPE_SYSTEM,
> +	CONFIG_SCOPE_GLOBAL,
> +	CONFIG_SCOPE_LOCAL,
> +	CONFIG_SCOPE_WORKTREE,
> +	CONFIG_SCOPE_COMMAND,
> +	CONFIG_SCOPE_SUBMODULE,
> +};
> +

And this is the logical place to make an external definition, if we
were to go that route.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 983a0a1583..b654a6d2f9 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1766,6 +1766,64 @@ test_expect_success !MINGW '--show-origin blob ref' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success '--show-scope with --list' '
> +	cat >expect <<-EOF &&
> +		global	user.global=true
> +		global	user.override=global
> +		global	include.path=$INCLUDE_DIR/absolute.include
> +		global	user.absolute=include
> +		local	user.local=true
> +		local	user.override=local
> +		local	include.path=../include/relative.include
> +		local	user.relative=include
> +		command	user.cmdline=true
> +	EOF

The HERE-DOC is over-indented.  All the body lines should align with
cat and EOF.  The same comment applies to many "<<-" added by this
patch---mimick the "<<-" that appear in earlier part of the same
file.

> +test_expect_success !MINGW '--show-scope with --blob' '
> +	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
> +	cat >expect <<-EOF &&
> +		command	user.custom=true
> +	EOF
> +	git config --blob=$blob --show-scope --list >output &&
> +	test_cmp expect output
> +'

Missing blank line between two tests.

I wonder if we want to revamp the tests for --show-origin that wants
to make sure a funny filename is quoted properly.  For that purpose,
CUSTOM_CONFIG_FILE is given a funny pathname, and it would have been
OK to use that only for a single "do we quote properly?" test, but
instead we use that same funnily-named file as the source in many
places where we do not *care* how --show-origin quotes the pathname
at all, and end up having to skip with !MINGW.

It's a bad tradition that started at 45bf3297 ("t1300: fix the new
--show-origin tests on Windows", 2016-03-23), I guess, and is not a
new problem introduced by this patch, but it should stop so that we
can have a better test coverage everywhere.

Other than that, I think that the new feature added by this series
is a sensible one.  Thanks for working on it.

