Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8591FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbcHZTHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:07:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752176AbcHZTHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:07:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A571338414;
        Fri, 26 Aug 2016 15:06:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNS3o4T6qUoAWZrXXyis7445Swo=; b=KJQ3Ou
        Ne9oygIaR1I9PLBGV/PMVwZWBrzcof9TsOvcBh6c5xKxNuLZK6R757Ey/YQ+pada
        /pKHYzdnJ0zo9+xeeWo3zgmcfSf5x5Drve/s5jTHCOEGFpt3R6SuM4x0fUTHl8mS
        jPBrSs/oUOnnpdF8hOEmrdFmruwSpsvaRrFvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ey/w6l4TciCswohZrVogE3AFr/WlAv2w
        CEDcGyMRmk79ze0hHIGn5BDYiXSmtbSANnyh+9zzBUKP8TNzGUDuAU5JgUVTOFnk
        hacXD1+3SMmBplhkF8J+tJacdHt8dOHjNOKkWSBTk0ZC8O4NIHiwqVWyhzxdbrTg
        9S0b8G9xvMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DB3B38411;
        Fri, 26 Aug 2016 15:06:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 106613840F;
        Fri, 26 Aug 2016 15:06:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 2/3] help: introduce option --exclude-guides
References: <20160818185719.4909-1-ralf.thielow@gmail.com>
        <20160826175836.14073-1-ralf.thielow@gmail.com>
        <20160826175836.14073-3-ralf.thielow@gmail.com>
Date:   Fri, 26 Aug 2016 12:06:45 -0700
In-Reply-To: <20160826175836.14073-3-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Fri, 26 Aug 2016 19:58:35 +0200")
Message-ID: <xmqq8tvjgxiy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C545470-6BC0-11E6-AF3E-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> Introduce option --exclude-guides to the help command.  With this option
> being passed, "git help" will open man pages only for actual commands.

Let's hide this option from command help of "git help" itself, drop
the short-and-sweet "-e", not command-line complete it, and leave it
not-mentioned here.

It is a different story if this option would really help the end
users, but I do not think that is the case.  If this were to face
the end users properly, we would need to worry about making sure
that "git help -g -e" would error out, and getting all the other
possible corner cases right.  I do not think the amount of effort
required to do so (even the "trying to enumerate what other possible
corner cases there may be" part) is worth it.

> In the test script we do two things I'd like to point out:
>
>> +       test_config help.htmlpath test://html &&
>
> As we pass a URL, Git won't check if the given path looks like
> a documentation directory.  Another solution would be to create
> a directory, add a file "git.html" to it and just use this path.

I think this is OK; with s|As we pass a URL|As we pass a string with
:// in it|, the first sentence can be a in-code comment in the test
that does this and will help readers of the code in the future.

>> +       test_config help.browser firefox
>
> Git checks if the browser is known, so the "test-browser" needs to
> pretend it is one of them.

Are you talking about the hardcoded list in valid_tool() helper
function in git-web--browse.sh?  If we use the established escape
hatch implemented by valid_custom_tool() helper there by setting
browser.*.cmd, would that be sufficient to work around the "Git
checks if the browser is known"?

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 40d328a..eeb1950 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -8,7 +8,7 @@ git-help - Display help information about Git
>  SYNOPSIS
>  --------
>  [verse]
> -'git help' [-a|--all] [-g|--guide]
> +'git help' [-a|--all] [-e|--exclude-guides] [-g|--guide]
>  	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]

So, let's not do this.

> diff --git a/builtin/help.c b/builtin/help.c
> index e8f79d7..40901a9 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -37,8 +37,10 @@ static int show_all = 0;
>  static int show_guides = 0;
>  static unsigned int colopts;
>  static enum help_format help_format = HELP_FORMAT_NONE;
> +static int exclude_guides;
>  static struct option builtin_help_options[] = {
>  	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
> +	OPT_BOOL('e', "exclude-guides", &exclude_guides, N_("exclude guides")),

So I'd suggest using PARSE_OPT_HIDDEN for this one and drop 'e' shorthand.
The only caller of this mode does not use it.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c1b2135..b148164 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1393,7 +1393,7 @@ _git_help ()
>  {
>  	case "$cur" in
>  	--*)
> -		__gitcomp "--all --guides --info --man --web"
> +		__gitcomp "--all --exclude-guides --guides --info --man --web"
>  		return
>  		;;
>  	esac

So, let's not do this.

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> new file mode 100755
> index 0000000..fb1abd7
> --- /dev/null
> +++ b/t/t0012-help.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='help'
> +
> +. ./test-lib.sh
> +
> +configure_help () {
> +	test_config help.format html &&
> +	test_config help.htmlpath test://html &&
> +	test_config help.browser firefox 
> +}

Would replacing the last line with:

	test_config browser.test.cmd ./test-browser &&
	test_config help.browser test

and then writing to test-browser work just as well?  If so, that
would be much cleaner and more preferrable.

> +
> +test_expect_success "setup" "
> +	write_script firefox <<-\EOF
> +	exit 0
> +	EOF
> +"

Unless there is a good reason you MUST do so, avoid quoting the test
body with double quotes, as it invites mistakes [*1*].

Also, how about using something like:

	write_script test-browser <<-\EOF
	i=0
	for arg
        do
		i=$(( $i + 1 ))
		echo "$i: $arg"
	done >test-browser.log
        EOF

instead?  That way, you can ensure that "git help status" attempts
to call git-status.html with the expected path, not gitstatus.html
or status.html, or somesuch, immediately after running "git help
status" in the next test by inspecting test-browser.log ...

> +test_expect_success "works for commands and guides by default" "
> +	configure_help &&
> +	git help status &&

... right here.

The output from the test-browser does not have to be multi-line;
just doing

	echo "$*"

might be sufficient.

> +	git help revisions
> +"

Thanks.

[Footnote]

*1* Can you immediately tell why this test is broken?

test_expect_success "two commits do not have the same ID" "
	git commit --allow-empty -m first &&
	one=$(git rev-parse --verify HEAD) &&
	test_tick &&
	git commit --allow-empty -m second &&
	two=$(git rev-parse --verify HEAD) &&
	test $one != $two
"

