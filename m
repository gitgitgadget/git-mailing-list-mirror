Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11612203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 00:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbcHSAuU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:50:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754138AbcHSAuR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 378CF35976;
        Thu, 18 Aug 2016 15:51:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RQVbKC3zEh3bPAfpe27Ju0y4wx8=; b=C4vMFV
        6zDfbjsUz/zlRoGF6tIk/Oj4jiVTD1Mbiz4lzYuybtO9Cqeta9z39jlXJABpGwou
        HA9L7PF8W7TZw9BnX4mm/WKFy6nWRy8rg5MeVrxrV44/fDpOI4d3yXqj27I5mqVG
        CpxyUD7NDujW2+q7bA+Y/iqEKu8/2ol+zIteA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZWbXYRtJ/SfjfsX/qR2r2hurX2ZtLmeu
        daoQOVNMv5NyiL7TVnIW9F/Gx1Ayyt7CMHPtfhu7Zd57FhEMcVbD0d7I1HHsilfx
        ZWXbG7q5bB5xX91WtunSN+yIpH1Vlb6U+x3ujzr/c5yoYN/OGGD/nGApGT2h/RYN
        SjR4FM5j5f8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E09435975;
        Thu, 18 Aug 2016 15:51:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FF2935973;
        Thu, 18 Aug 2016 15:51:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, me@jnm2.com,
        philipoakley@iee.org, john@keeping.me.uk
Subject: Re: [PATCH 2/2] help: make option --help open man pages only for Git commands
References: <20160816162030.27754-1-ralf.thielow@gmail.com>
        <20160818185719.4909-1-ralf.thielow@gmail.com>
        <20160818185719.4909-2-ralf.thielow@gmail.com>
        <20160818185719.4909-3-ralf.thielow@gmail.com>
Date:   Thu, 18 Aug 2016 12:51:35 -0700
In-Reply-To: <20160818185719.4909-3-ralf.thielow@gmail.com> (Ralf Thielow's
        message of "Thu, 18 Aug 2016 20:57:19 +0200")
Message-ID: <xmqqy43t6ek8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CBD9B82-657D-11E6-8FCF-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow <ralf.thielow@gmail.com> writes:

> If option --help is passed to a Git command, we try to open
> the man page of that command.  However, we do it even for commands
> we don't know.  Make sure it is a Git command.

What the patch does is correct, I think, but the explanation may
invite a false alarm.  If you added a custom command git-who in your
$PATH, with an appropriate documentation for git-who(1), we would
still show its documentation, no?

The same comment applies to 1/2, too, in that the word "command"
will be interpreted differently by different people.  For example,
"git co --help" and "git help co" would work, with or without 1/2 in
place when you have "[alias] co = checkout", so we are calling "Git
subcommands that we ship, custom commands 'git-$foo' the users have
in their $PATH, and aliases the users create" collectively "command".

As long as the reader understands that definition, both the log
messages of 1/2 and 2/2 _and_ the updated description for "git help"
we have in 1/2 are all very clear.  I do not care too much about the
commit log message, but we may want to think about the documentation
a bit more.

Here is what 1/2 adds to "git help" documentation:

    +Note that `git --help ...` is almost identical to `git help ...` because
    +the former is internally converted into the latter with option --command-only
    +being added.

     To display the linkgit:git[1] man page, use `git help git`.

    @@ -43,6 +44,10 @@ OPTIONS
            Prints all the available commands on the standard output. This
            option overrides any given command or guide name.

    +-c::
    +--command-only::
    +	Display help information only for commands.
    +

First, I do not think a short form is unnecessary; the users are not
expected to use that form, once they started typing "git help...".
If we flip the polarity and call it --exclude-guides or something,
would it make it less ambiguous?

> This breaks "git <concept> --help" while "git help <concept>" still works.

I wouldn't call that a breakage; "git everyday --help" shouldn't
have worked in the first place.  It did something useful merely by
accident ;-).

> diff --git a/git.c b/git.c
> index 0f1937f..2cd2e06 100644
> --- a/git.c
> +++ b/git.c
> @@ -528,10 +528,23 @@ static void handle_builtin(int argc, const char **argv)
>  	strip_extension(argv);
>  	cmd = argv[0];
>  
> -	/* Turn "git cmd --help" into "git help cmd" */
> +	/* Turn "git cmd --help" into "git help --command-only cmd" */
>  	if (argc > 1 && !strcmp(argv[1], "--help")) {
> +		struct argv_array args;
> +		int i;
> +
>  		argv[1] = argv[0];
>  		argv[0] = cmd = "help";
> +
> +		argv_array_init(&args);
> +		for (i = 0; i < argc; i++) {
> +			argv_array_push(&args, argv[i]);
> +			if (!i)
> +				argv_array_push(&args, "--command-only");
> +		}
> +
> +		argc++;
> +		argv = argv_array_detach(&args);
>  	}
>  
>  	builtin = get_builtin(cmd);

The code does this after it:

    if (builtin)
                exit(run_builtin(...));

and returns.  If we didn't get builtin, we risk leaking args.argv
here, but we assume argv[0] = cmd = "help" is always a builtin,
which I think is a safe assumption, so the code is OK.  Static
checkers that are only half intelligent may yell at you for not
releasing the resources, though.  I wonder if it is worth doing

    static void handle_builtin(int argc, const char **argv)
    {
            struct argv_array args = ARGV_ARRAY_INIT;
            ...
            if (argc > 1 && !strcmp(argv[1], "--help")) {
                    ...
                    argv = args.argv;
            }
            builtin = get_builtin(cmd);
            if (builtin)
                    exit(run_builtin(...));
            argv_array_clear(&args);
    }   

to help unconfuse them.

By the way, I do not see these patches on gmane, public-inbox or
usual suspects.  Perhaps vger is having a bad day or something?

