Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAABC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3802077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="isgkgiEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLDWYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:24:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfLDWYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:24:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4685E34AEC;
        Wed,  4 Dec 2019 17:24:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gEOrXC5/pQRaOSCrFvqNDpbPG68=; b=isgkgi
        EAC76rx5Oe614xJWc6JFTZ1tllflos0hpOpnwGsU8lWyeWS9dT2FwUQpv1skIy3/
        ICXPG9Drt80wsSXmdIPTTLDTdOnosQZ/aFNz1zoajoLCZqGtkpOpBm8f6fMGwTIc
        L/SXUUGjGp1uEu7OewgEfxMBxokyDKHgTugYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kiWFzaFuxK6CiM5bI2e6+nyNfINEhzZK
        SnSxV/+SS08ZclbjYT18cPfqBzikJHdz41t4QD36LncyycHox9hsH3HER9+Qc9U0
        /hn96gVKXn4Y/g9Zi9blW31nDe/RJUlUi58w2eOLydDLsykawrntvFtf4mK1pCdW
        nSspMB1L1bM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C88234AEA;
        Wed,  4 Dec 2019 17:24:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D90C34AE9;
        Wed,  4 Dec 2019 17:24:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
References: <20191204203911.237056-1-emilyshaffer@google.com>
Date:   Wed, 04 Dec 2019 14:24:07 -0800
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 4 Dec 2019 12:39:11 -0800")
Message-ID: <xmqq5ziv3f20.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA104CE2-16E4-11EA-A24C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach 'git grep' to use OPT_PATHSPEC_FROM_FILE and update the
> documentation accordingly.
>
> This changes enables 'git grep' to receive the pathspec from a file by
> specifying the path, or from stdin by specifying '-' as the path. This
> matches the previous functionality of '-f', so the documentation of '-f'
> has been expanded to describe this functionality. To let '-f' match the
> new '--pathspec-from-file' option, also teach a '--patterns-from-file'
> long name to '-f'.
>
> Since there are now two arguments which can attempt to read from stdin,
> add a safeguard to check whether the user specified '-' for both of
> them. It is still possible for a user to pass '/dev/stdin' to one or
> both arguments at present; we do not explicitly check.

OK.  I guess this is good enough at least for now and possibly
forever as that falls into the "doctor, it hurts when I do this"
category.

> Refactored to use am/pathspec-from-file. This changes the implementation
> significantly since v1, but the testcases mostly remain the same.

I am hoping that this topic, and Alexandr's "add" and "checkout"
stuff, would help establishing a good pattern for other commands to
follow.

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index c89fb569e3..56b1c5a302 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -24,7 +24,8 @@ SYNOPSIS
>  	   [-A <post-context>] [-B <pre-context>] [-C <context>]
>  	   [-W | --function-context]
>  	   [--threads <num>]
> -	   [-f <file>] [-e] <pattern>
> +	   [-f | --patterns-from-file <file>] [-e] <pattern>

OK.

> +	   [--pathspec-from-file=<file> [--pathspec-file-nul]]

OK.

> @@ -270,7 +271,10 @@ providing this option will cause it to die.
>  	See `grep.threads` in 'CONFIGURATION' for more information.
>  
>  -f <file>::
> -	Read patterns from <file>, one per line.
> +--patterns-from-file <file>::
> +	Read patterns from <file>, one per line. If `<file>` is exactly `-` then
> +	standard input is used; standard input cannot be used for both
> +	--patterns-from-file and --pathspec-from-file.

Makes sense---otherwise they would compete and we cannot know which
kind each line in the standard input is ;-)

> @@ -289,6 +293,20 @@ In future versions we may learn to support patterns containing \0 for
>  more search backends, until then we'll die when the pattern type in
>  question doesn't support them.
>  
> +--pathspec-from-file <file>::
> +	Read pathspec from <file> instead of the command line. If `<file>` is
> +	exactly `-` then standard input is used; standard input cannot be used
> +	for both --patterns-from-file and --pathspec-from-file. Pathspec elements
> +	are separated by LF or CR/LF. Pathspec elements can be quoted as
> +	explained for the configuration variable `core.quotePath` (see
> +	linkgit:git-config[1]). See also `--pathspec-file-nul` and global
> +	`--literal-pathspecs`.
> +
> +--pathspec-file-nul::
> +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
> +	separated with NUL character and all other characters are taken
> +	literally (including newlines and quotes).
> +

I think these matches the ones in git-reset.txt from the earlier
work by Alexandr's, which is good.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50ce8d9461..54ba991c42 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -31,6 +31,7 @@ static char const * const grep_usage[] = {
>  };
>  
>  static int recurse_submodules;
> +static int patterns_from_stdin, pathspec_from_stdin;
>  
>  #define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
> @@ -723,15 +724,18 @@ static int context_callback(const struct option *opt, const char *arg,
>  static int file_callback(const struct option *opt, const char *arg, int unset)
>  {

Shouldn't this be renamed?  Earlier, the only thing that can be
taken from a file was the patterns, but now a file can be given
to specify a set of pathspec elements.  "patterns_file_callback()"
or something like taht?

>  	struct grep_opt *grep_opt = opt->value;
> -	int from_stdin;
>  	FILE *patterns;
>  	int lno = 0;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	from_stdin = !strcmp(arg, "-");
> -	patterns = from_stdin ? stdin : fopen(arg, "r");
> +	patterns_from_stdin = !strcmp(arg, "-");

Totally outside the scope of this patch, but we may want to
introduce

	int is_stdin_cmdline_marker(const char *arg)
	{
		return !strcmp(arg, "-");
	}

which later can be taught also about "/dev/stdin".  Even outside the
pathspec-from-file option, I think "diff --no-index" also has some
special-case provision for treating "-" as "input coming from the
standard input string", which would benefit from such a helper.

> +	if (patterns_from_stdin && pathspec_from_stdin)
> +		die(_("cannot specify both patterns and pathspec via stdin"));

It's kind of sad that we need to check this in this callback and
also inside cmd_grep() top-level we will see further down...

> +	if (pathspec_from_file) {
> +		if (pathspec.nr)
> +			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
> +
> +		pathspec_from_stdin = !strcmp(pathspec_from_file, "-");
> +
> +		if (patterns_from_stdin && pathspec_from_stdin)
> +			die(_("cannot specify both patterns and pathspec via stdin"));

... here.

Thanks.
