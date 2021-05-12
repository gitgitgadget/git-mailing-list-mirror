Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89580C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538AB611BE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 09:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELJ3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhELJ3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 05:29:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E75C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:28:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bf4so26239710edb.11
        for <git@vger.kernel.org>; Wed, 12 May 2021 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vBJfL0IfBQkY1AjmR2PdyZ1ea1gOnW2CJ5k/o98pchw=;
        b=byAQLJqdgHFpoE4Myem4iDmoA9y0nwsDb6kXK+6iQZjPAOk0+AYLpTipfBLQcUK08s
         GqbaWIgiqu1Wn2QVwnyfA9Nbr2eUcBlrbspP76CMb9FgipufqUzOTvHrWTXDLfb6Bl33
         2KNQzjKwm/GLeHJJG+++cFx/ofyY/mnpU5UsCUqHNvIYMy0Y4xzAbalordTCAyXetSys
         SWeC04vbnMYYRPz8FICeZuK6xKWyAizIPmxO34RVlJHr2ebNTON1i2rciJHh/femvCQ1
         suFNc7GO0pvqE7r05Q4fuQbGe+25qphGOwRULfceHQX91AZEjMIpB5rNXuDHqsMcguPE
         Hn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vBJfL0IfBQkY1AjmR2PdyZ1ea1gOnW2CJ5k/o98pchw=;
        b=KpDRyhAZh8hOzIEGEeJ7+YNlZprtUVoRQXv3D6/SHhkp4ppIhmDQUXbNF8scpsTjHp
         OQpMAcX4reQT5B4OezgFYScHIRHuFBl+pjlWS4GjGT+TvQXdhjJFoYMEaBt7nlgbOICO
         Y5Yo+5CPkFZFZNHzDMP+VOUbzsqRZZw3kzkxgHERhXvjJhIpUXPfGT2F7MP/KmeeFxpK
         S28gq6GTByowerSIw9f3aksWw2WofOs1qKW+fWC+xYPasQkkjcu/j41hVDeVLm4KJVNj
         /us2QH3JFZ2P2PVvi3HiucZc2PBSDaqF1uuFLlSxjf3RbNhGkHaUzndmARvydyQM81kc
         uk/A==
X-Gm-Message-State: AOAM531/POMg+tgZAvUt8ULCKqvwk1rSGzExIAOm6qweO8zlPWsY2Gu2
        m1+jOxh76zKWHnP1U34cZhnfP5ivPWehyA==
X-Google-Smtp-Source: ABdhPJyw1mK2BOPyVj/sfhMBeV6iKCoTtWIemtgY0Ujfmu4ACwmWlXM98hKHrEgPIjeQlckVRACAeA==
X-Received: by 2002:a05:6402:5111:: with SMTP id m17mr42443769edd.343.1620811711698;
        Wed, 12 May 2021 02:28:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id de49sm13648630ejc.16.2021.05.12.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 02:28:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Gregory Anders <greg@gpanders.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Date:   Wed, 12 May 2021 11:04:59 +0200
References: <20210512033039.4022-1-greg@gpanders.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210512033039.4022-1-greg@gpanders.com>
Message-ID: <87y2cks3lt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 11 2021, Gregory Anders wrote:

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 93708aefea..d9fe8cb7c0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -159,13 +159,23 @@ Sending
>  ~~~~~~~
>  
>  --envelope-sender=<address>::
> -	Specify the envelope sender used to send the emails.
> -	This is useful if your default address is not the address that is
> -	subscribed to a list. In order to use the 'From' address, set the
> -	value to "auto". If you use the sendmail binary, you must have
> -	suitable privileges for the -f parameter.  Default is the value of the
> -	`sendemail.envelopeSender` configuration variable; if that is
> -	unspecified, choosing the envelope sender is left to your MTA.
> +	Specify the envelope sender used to send the emails.  This is
> +	useful if your default address is not the address that is
> +	subscribed to a list. In order to use the 'From' address, set
> +	the value to "auto". If you use the sendmail binary, you must
> +	have suitable privileges for the -f parameter.  Default is the
> +	value of the `sendemail.envelopeSender` configuration variable;
> +	if that is unspecified, choosing the envelope sender is left to
> +	your MTA.

Please don't include word-wrapping for unrelated changes in the main
patch.

> -	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
> +
> +	if (!defined $sendmail_command) {
> +		$smtp_server = 'localhost'; # could be 127.0.0.1, too... *shrug*
> +	}
>  }

This "let's not accept a 0" change seems unrelated & should be split
into a prep cleanup / refactoring patch. On the one hand it's sensible,
on the other nobody cares about having a command named "0" in their path
(or a hostname), so I think it's fine to have the ||= Perl idiom leak
out here.

But also, this just seems like confusing logic. Per your docs "your
sendmailCommand has precedence over smtpServer.".

Why not make this "if not $sendmail_command" part of the top-level check
here (the if this one is nested under), which is only done if
$smtp_sever is not defined, if $sendmail_command is defined we don't
care about $smtp_server later on, no?

>  if ($compose && $compose > 0) {
> @@ -1490,14 +1497,15 @@ sub send_message {
>  
>  	unshift (@sendmail_parameters, @smtp_server_options);
>  
> +	if (file_name_is_absolute($smtp_server)) {
> +		# Preserved for backward compatibility
> +		$sendmail_command ||= $smtp_server;
> +	}
> +
>  	if ($dry_run) {
>  		# We don't want to send the email.
> -	} elsif (file_name_is_absolute($smtp_server)) {
> -		my $pid = open my $sm, '|-';
> -		defined $pid or die $!;
> -		if (!$pid) {
> -			exec($smtp_server, @sendmail_parameters) or die $!;
> -		}
> +	} elsif (defined $sendmail_command) {
> +		open my $sm, '|-', "$sendmail_command @sendmail_parameters";

Can we really not avoid moving from exec-as-list so Perl quotes
everything, to doing our own interpolation here? It looks like the tests
don't check arguments with whitespace (which should fail with this
change).

>  		print $sm "$header\n$message";
>  		close $sm or die $!;
>  	} else {

I've just skimmed the previous thread, so forgive me if this was brought
up.

I for one would be fine with just using --smtp-server and not adding an
--sendmail-command, and doing this by simply doing an exec() on whatever
the user specifies.

If it's an absolute path and an executable command, OK. If it's a
command name we find in $PATH, OK, or other valid shell whatever. You
can use $? to distinguish between a failed and nonexisting command.

If not exec() will return and we continue resolving it as a hostname/IP
address/whatever. We'll have a conflict if someone has a command in
their $PATH called gmail.com or whatever, but really. Who does that?

Maybe it's way too nasty. This design is also fine, just a suggestion.

> @@ -1592,14 +1600,14 @@ sub send_message {
>  		printf($dry_run ? __("Dry-Sent %s\n") : __("Sent %s\n"), $subject);
>  	} else {
>  		print($dry_run ? __("Dry-OK. Log says:\n") : __("OK. Log says:\n"));
> -		if (!file_name_is_absolute($smtp_server)) {
> +		if (defined $sendmail_command) {
> +			print "Sendmail: $sendmail_command ".join(' ',@sendmail_parameters)."\n";
> +		} else {
>  			print "Server: $smtp_server\n";
>  			print "MAIL FROM:<$raw_from>\n";
>  			foreach my $entry (@recipients) {
>  			    print "RCPT TO:<$entry>\n";
>  			}
> -		} else {
> -			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
>  		}
>  		print $header, "\n";
>  		if ($smtp) {

Minor nit: Let's just continue to use "if (!" here to keep the diff
minimal or split up such refactoring into another change...
