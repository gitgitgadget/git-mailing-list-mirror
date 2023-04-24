Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C0C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjDXWJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjDXWJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:09:48 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBBC93E6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:09:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a9253d4551so41167785ad.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374158; x=1684966158;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7K+YPEtNFvbVUjdWawuzHJJvf6LSp2dZLQQ7mGmLwU=;
        b=NArjIqxM1Rqc9mNg8yL3CQKWL7keOOhUCHaq6DrLyVi84se7+zqU5KhUdjIRfOnu5U
         HmgCrVE8QkqzuxayXCpH8gQd9/M80JPNFCENV3wInCidGIffud9pqBG4H3FER5e+LRqM
         +UIPSrBXTOyQzZZTlv2d7j38rJkhctQDmQgJUdAJ9SJYlBv0kxXVTNkEp4OTfMzI3EUs
         eT/surWMXMFxKAhBoZ8EOzKwYirUeQNJglIxmihYBAyHP/WvZJhSsH9CPDimb+FfMBOJ
         aL/jWzoCFbUcvB1c1MsBDjsba360iQOZQ6ZOQAe8/tCYUKmF69W5SrzJVf2i66aKAOt2
         ozRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374158; x=1684966158;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q7K+YPEtNFvbVUjdWawuzHJJvf6LSp2dZLQQ7mGmLwU=;
        b=AGYWOgxr7ha65sLBfNMz/f4Os7OISn/NSz//znYG9uSrbgq1Y5gSKkTP3uvtVPToWC
         0fal4w7gC/8PAGX/nX6ekgNAkk0e4gzGcJrZRHGaSzJ7f3c5Es2NQH9eBGR+D7SAxC9S
         6kkekZYrCKHySQje0XpYx0I4wXtnTKy1vpldiLZf36tJOz5gNXbNWS5iluHmrEA19qTO
         DcjTl4eeY9vkZrICzttfy2gwMn3wwfjuwA754FXVrlA+qnOSTMFgC1MN2kpxEbg394Bi
         lqo5R4HTx33zA8Ma5n792fqX199if9IJIlntDVfU8OM3/IKqRxc9zmIXS2pcA0iG3nUI
         vYdg==
X-Gm-Message-State: AAQBX9c+5rErSErXycSNt95gKfj8OD0f0Yekelto8nK8hG9tSo4JYQg7
        8Jwq/sgfPq5vtUlIiYmctpg=
X-Google-Smtp-Source: AKy350bicTGTl1N/Sm0lqD8SE5Efhp2ZIN2ny3h12O+YbjzLkSLlo0o1/1HmfXyJ6KEUVSSmYjcSpA==
X-Received: by 2002:a17:902:ce8f:b0:1a9:7262:fe55 with SMTP id f15-20020a170902ce8f00b001a97262fe55mr7821274plg.13.1682374157826;
        Mon, 24 Apr 2023 15:09:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r12-20020a170902be0c00b001a0567811fbsm6985820pls.127.2023.04.24.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:09:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-3-maxim.cournoyer@gmail.com>
Date:   Mon, 24 Apr 2023 15:09:17 -0700
In-Reply-To: <20230423122744.4865-3-maxim.cournoyer@gmail.com> (Maxim
        Cournoyer's message of "Sun, 23 Apr 2023 08:27:44 -0400")
Message-ID: <xmqqh6t57x0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:

> Sometimes, adding a header different than CC or TO is desirable; for
> example, when using Debbugs, it is best to use 'X-Debbugs-Cc' headers
> to keep people in CC; this is an example use case enabled by the new
> '--header-cmd' option.
> ---

Missing sign-off?

>  Documentation/config/sendemail.txt |  1 +
>  Documentation/git-send-email.txt   |  5 +++++
>  git-send-email.perl                | 12 +++++++++---
>  t/t9001-send-email.sh              | 21 +++++++++++++++++++--
>  4 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
> index 51da7088a8..3d0f516520 100644
> --- a/Documentation/config/sendemail.txt
> +++ b/Documentation/config/sendemail.txt
> @@ -58,6 +58,7 @@ sendemail.annotate::
>  sendemail.bcc::
>  sendemail.cc::
>  sendemail.ccCmd::
> +sendemail.headerCmd::
>  sendemail.chainReplyTo::
>  sendemail.envelopeSender::
>  sendemail.from::

Why here?

Asking because existing other entries look sorted lexicographically.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index b0f438ec99..354c0d06db 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -320,6 +320,11 @@ Automating
>  	Output of this command must be single email address per line.
>  	Default is the value of `sendemail.ccCmd` configuration value.
>  
> +--header-cmd=<command>::
> +	Specify a command to execute once per patch file which should
> +	generate arbitrary, patch file specific header entries.

"arbitrary, patch file specific" sounds like a problematic thing to
say here.  If it is truly arbitrary, then it is up to the user to
emit identical output for all patches and there is no reason to
inisist it has to be ptach file specific.  I am sure you meant "you
do not have to add the same set of headres with the same values for
all messages", but that is very much obvious once you said "command
to execute once per patch file".

By the way, does it apply also to the cover-letter, which is not a
patch file?  I presume it does, in which case we shouldn't be saying
"once per patch file", but something like "once per outgoing message"
or something.

Also, its output is not really arbitrary.  It has to emit RFC-2822
style header lines.  Emitting a block of lines, with an empty line
in it, would be a disaster, isn't it?  The expected output format
for the <command> this option specifies needs to be described a bit
better.

	Specify a command that is executed once per outgoing message
	and output RFC-2822 style header lines to be inserted into
	them.

or something like that?

> +	Default is the value of `sendemail.headerCmd` configuration value.

Make it clear what you mean by the Default here.  If you configure
the variable, will the command be always used without any way to
turn it off?  Or does it specify the default value to be used when
"git send-email ---header-cmd" option is used without any value?

If it is the former, there should be a way to turn it off from the
command line, probably.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index d2febbda1f..676dd83d89 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -88,8 +88,9 @@ sub usage {
>  
>    Automating:
>      --identity              <str>  * Use the sendemail.<id> options.
> -    --to-cmd                <str>  * Email To: via `<str> \$patch_path`
> -    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
> +    --to-cmd                <str>  * Email To: via `<str> \$patch_path`.
> +    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`.
> +    --header-cmd            <str>  * Add headers via `<str> \$patch_path`.
>      --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
>      --[no-]cc-cover                * Email Cc: addresses in the cover letter.
>      --[no-]to-cover                * Email To: addresses in the cover letter.
> @@ -270,7 +271,7 @@ sub do_edit {
>  # Variables with corresponding config settings
>  my ($suppress_from, $signed_off_by_cc);
>  my ($cover_cc, $cover_to);
> -my ($to_cmd, $cc_cmd);
> +my ($to_cmd, $cc_cmd, $header_cmd);
>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>  my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
>  my ($batch_size, $relogin_delay);
> @@ -319,6 +320,7 @@ sub do_edit {
>      "tocmd" => \$to_cmd,
>      "cc" => \@config_cc,
>      "cccmd" => \$cc_cmd,
> +    "headercmd" => \$header_cmd,
>      "aliasfiletype" => \$aliasfiletype,
>      "bcc" => \@config_bcc,
>      "suppresscc" => \@suppress_cc,
> @@ -520,6 +522,7 @@ sub config_regexp {
>  		    "compose" => \$compose,
>  		    "quiet" => \$quiet,
>  		    "cc-cmd=s" => \$cc_cmd,
> +		    "header-cmd=s" => \$header_cmd,
>  		    "suppress-from!" => \$suppress_from,
>  		    "no-suppress-from" => sub {$suppress_from = 0},
>  		    "suppress-cc=s" => \@suppress_cc,
> @@ -1777,6 +1780,9 @@ sub process_file {
>  			push(@header, $_);
>  		}
>  	}
> +	# Add computed headers, if applicable.
> +	push @header, execute_cmd("header-cmd", $header_cmd, $t)
> +		if defined $header_cmd;

While execute_cmd() may be a good enough interface to be used
without much post-processing to read cc-cmd and to-cmd output (but
notice that even there it needs post-processing), I do not think it
is a good interface to directly use to read header lines without any
postprocessing like patch [2/2] does.  Its use in recipients_cmd()
is OK primarily because it is about just reading bunch of values
placed on Cc: or To: lines.  If you are going to use it in arbitrary
sets of header lines, it is very likely that you would need to
handle header folding (see what the loop before "# Now parse the
header" is doing to preprocess <$fh>, which is not done for lines
you read into @header in [2/2]).


Thanks.
