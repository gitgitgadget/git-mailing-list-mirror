Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE27C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CBD61413
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEMD7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 23:59:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63478 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhEMD7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 23:59:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B4E2CF29A;
        Wed, 12 May 2021 23:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xFFNbCvz1yfzIXu/qtUc5kIVMNF7mawK2hIR6l
        G6zII=; b=VK3BzWozDs6KNOFEpU5mR4ut5t7xxrWcyKSErlKmPptLk9uHp8YGG7
        SaAWMqzRfnssByfntpR+biVrJB7732dyGCX3+PC3OmydYYVK8qNmuHcYIi1/+7Vc
        9w1nkg4RQWaDRvDVXuOpbudI7ejomP6n9yfEVyv+mdu+xFZ7dO2QM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61FE7CF299;
        Wed, 12 May 2021 23:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF0F0CF298;
        Wed, 12 May 2021 23:58:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] git-send-email: add option to specify sendmail command
References: <20210512033039.4022-1-greg@gpanders.com>
        <20210513023212.72221-1-greg@gpanders.com>
Date:   Thu, 13 May 2021 12:58:36 +0900
In-Reply-To: <20210513023212.72221-1-greg@gpanders.com> (Gregory Anders's
        message of "Wed, 12 May 2021 20:32:11 -0600")
Message-ID: <xmqq8s4jcmj7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E8D7372-B39F-11EB-BCC3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders <greg@gpanders.com> writes:

> The sendemail.smtpServer configuration option and --smtp-server command
> line option both support using a sendmail-like program to send emails by
> specifying an absolute file path. However, this is not ideal for the
> following reasons:
>
> 1. It overloads the meaning of smtpServer (now a program is being used
>    for the server?)
> 2. It doesn't allow for non-absolute paths, arguments, or arbitrary
>    scripting
>
> Requiring an absolute path is bad for portability, as the same program
> may be in different locations on different systems. If a user wishes to
> pass arguments to their program, they have to use the smtpServerOption
> option, which is cumbersome (as it must be repeated for each option) and
> doesn't adhere to normal git conventions.
>
> Introduce a new configuration option sendemail.sendmailCmd as well as a
> command line option --sendmail-cmd that can be used to specify a command
> (with or without arguments) or shell expression to run to send email.
> The name of this option is consistent with --to-cmd and --cc-cmd. This
> invocation honors the user's $PATH so that absolute paths are not
> necessary. Arbitrary shell expressions are also supported, allowing
> users to do basic scripting.
>
> Give this option a higher precedence over --smtp-server and
> sendemail.smtpServer, as the new interface is more flexible. For
> backward compatibility, continue to support absolute paths in
> --smtp-server and sendemail.smtpServer.
>
> Signed-off-by: Gregory Anders <greg@gpanders.com>
> ---

Quite well explained.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..f1e685a52c 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -167,6 +167,15 @@ Sending
>  	`sendemail.envelopeSender` configuration variable; if that is
>  	unspecified, choosing the envelope sender is left to your MTA.
>  
> +--sendmail-cmd=<command>::
> +	Specify a command to run to send the email. The command should
> +	be compatible with `sendmail` (specifically, it should support
> +	the `-i` option).  The command will be executed in the shell if
> +	necessary.  Default is the value of `sendemail.sendmailcmd`.  If
> +	unspecified, and if --smtp-server is also unspecified,
> +	git-send-email will search for `sendmail` in `/usr/sbin`,
> +	`/usr/lib` and $PATH.

OK.

>  --smtp-encryption=<encryption>::
>  	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
>  	value reverts to plain SMTP.  Default is the value of
> @@ -211,13 +220,16 @@ a password is obtained using 'git-credential'.
>  
>  --smtp-server=<host>::
>  	If set, specifies the outgoing SMTP server to use (e.g.
> -	`smtp.example.com` or a raw IP address).  Alternatively it can
> -	specify a full pathname of a sendmail-like program instead;
> -	the program must support the `-i` option.  Default value can
> -	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is to search for `sendmail` in
> -	`/usr/sbin`, `/usr/lib` and $PATH if such program is
> -	available, falling back to `localhost` otherwise.
> +	`smtp.example.com` or a raw IP address).  If unspecified, and if
> +	`--sendmail-cmd` is also unspecified, the default is to search
> +	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
> +	program is available, falling back to `localhost` otherwise.
> +
> +	For backward compatibility, this option can also specify a full
> +	pathname of a sendmail-like program instead; the program must
> +	support the `-i` option.  This method does not support passing
> +	arguments or using plain command names.  For those use cases,
> +	consider using `--sendmail-cmd` instead.

Two comments here:

 - The paragraph would probably not render well, unless you replace
   the blank "paragraph break" line before it with a line that
   consists of a sole '+', and dedent the paragraph body.

 - The way the "-i" option is mentioned is different from the one we saw
   earlier for `--sendmail-cmd` and might risk puzzling the users if
   the requirement is subtly different.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 175da07d94..cbd9f89060 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> ...
> @@ -1492,11 +1499,15 @@ sub send_message {
>  
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif (file_name_is_absolute($smtp_server)) {
> +	} elsif (defined $sendmail_cmd || file_name_is_absolute($smtp_server)) {
>  		my $pid = open my $sm, '|-';
>  		defined $pid or die $!;
>  		if (!$pid) {
> -			exec($smtp_server, @sendmail_parameters) or die $!;
> +			if (defined $sendmail_cmd) {
> +				exec "$sendmail_cmd @sendmail_parameters" or die $!;

This looks problematic, as @sendmail_parameters is computed like
this:

	my @sendmail_parameters = ('-i', @recipients);
	...
	$raw_from = extract_valid_address($raw_from);
	unshift (@sendmail_parameters,
			'-f', $raw_from) if(defined $envelope_sender);
	...
       	unshift (@sendmail_parameters, @smtp_server_options);

Notice that nothing quotes its elements for the shell, and it is
natural if we think about the original use of this array---it is to
be fed to the array form of exec($cmd, @args).

@recipients, and $raw_from come from extract_valid_address(), which
gives 'add@ress' for "Human readable name <add@ress>", and it may be
rare (but possible) to have a problematic characer in them.  But the
elements of @smtp_server_options can be anything, and because the
values the end users already have in their configuration files are
designed to be used in the original "exec ($smtp_server,
@sendmail_parameters)" codepath, they would not be quoted for the
shell, and they should not be treated differently in the new codepath.

In short, it is far from sufficient to just "$concatenate @variables"
to form a single string.  $sendmail_cmd should be left as-is (after
all, we do want the shell to split it at $IFS whitespace into tokens),
but each element of @sendmail_parameters should be protected from
the shell (both word splitting and $interpolation rules).  Perhaps
something along the lines of this instead?

    exec ("sh", "-c", "$sendmail_cmd \"\$\@\"", "-", @sendmail_parameters);

> +			} else {
> +				exec ($smtp_server, @sendmail_parameters) or die $!;
> +			}

Other than that, looking good.

Thanks.
