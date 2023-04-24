Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E8C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 21:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjDXVrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjDXVqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 17:46:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF4AD25
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:46:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a66888cb89so40728915ad.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682372774; x=1684964774;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd1WLt+y44fxRVEjUqcFpjtzYj2axaqVqc2l+uV1Y9g=;
        b=qlpYmq32sej01O3qlP8vpw2gRsWny9y2P2MBGDSjT6n/CH8eZN9uNSQjoiPnSpYREQ
         qJ9V4bPpE90vN4ZxJvTb6m6q+dEfyUPaBk5oQzdJyu1xt0MhuuS1ATsF8+sa55l5Lmqm
         neb46fjxs5D75ctWpUTEwJBLwncqDw6TUlVLKuI/uIjQCsWbFBz83pln4vbF13MezIFs
         RK+9kOURm7A2m+R8eIhf2ubPgP/PgX/WdGPrnGA5uc7uz1ZYJBIvctxbDpmGT1ys4fWJ
         jKYzjnEiiE53zlw3IqP7UF4bjfuly41swfrcSq7uJSa9+u7DDI8HTaQ0/PqRjFFVvzMm
         3sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372774; x=1684964774;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sd1WLt+y44fxRVEjUqcFpjtzYj2axaqVqc2l+uV1Y9g=;
        b=Q+shPnmYjJw8ubtoZzMzWrBDm+jg/RSI8ed+MYLnckNKOT2KslreocR6Fxs1FDREvE
         60JOhlLMzNwPXu4TUUng0si680w6FhpsOkTZTD8TWHEn2EVeD6bLkVoL6rgYRdFGclve
         tYogkiIqxR2BEzxRKjkaxqCtHR8oodp54xJgyjNw1yC330yqOeXtei7CvDTSSjyZ5UeI
         kZKzM0APksGB4BlmdoNkvlcjkeQ9r2d0pI8BJBeXitn7vYgarqpwW9lVLVwhDvLMM2/F
         6NIX163sOqJvWSBskTJ9Sg1kzCNiplS78b/JnAJ9zZ/5o/Nym5y9828h/RwlJkFxd9Nu
         3lzg==
X-Gm-Message-State: AAQBX9d9kFLx/2o95l8qRBTDBrDJfZaurxupyhfb0HaVAStzYBJ36N3U
        bq4QI0WH+A2HmlxJqhr9aa4=
X-Google-Smtp-Source: AKy350ZltLTi4hHWvayAe2nIsrVWG44V7zGzU2/9YuBFxB2E79nhZMUWaalhDD0tadjx+R+0jNThpg==
X-Received: by 2002:a17:902:eb89:b0:1a2:3108:5cc9 with SMTP id q9-20020a170902eb8900b001a231085cc9mr16655209plg.40.1682372773596;
        Mon, 24 Apr 2023 14:46:13 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902b18700b001a814fcbd7dsm6981364plr.185.2023.04.24.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 14:46:13 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] send-email: extract execute_cmd from recipients_cmd
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-2-maxim.cournoyer@gmail.com>
Date:   Mon, 24 Apr 2023 14:46:13 -0700
In-Reply-To: <20230423122744.4865-2-maxim.cournoyer@gmail.com> (Maxim
        Cournoyer's message of "Sun, 23 Apr 2023 08:27:43 -0400")
Message-ID: <xmqqedo99cnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:

> This refactor is to pave the way for the addition of the new
> '--header-cmd' option to the send-email command.
> ---
>  git-send-email.perl | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

Missing sign-off?

> diff --git a/git-send-email.perl b/git-send-email.perl
> index fd8cd0d46f..d2febbda1f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -2,6 +2,7 @@
>  #
>  # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
>  # Copyright 2005 Ryan Anderson <ryan@michonline.com>
> +# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
>  #
>  # GPL v2 (See COPYING)
>  #
> @@ -2006,15 +2007,30 @@ sub process_file {
>  	}
>  }
>  
> +# Execute a command (e.g., $x_cmd) and return its output lines as an
> +# array.
> +sub execute_cmd {
> +	my ($prefix, $cmd, $file) = @_;
> +	my @lines = ();
> +	open my $fh, "-|", "$cmd \Q$file\E"
> +		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
> +	while (my $line = <$fh>) {
> +		last if $line =~ /^$/;
> +		push @lines, $line;
> +	}
> +	close $fh
> +	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
> +	return @lines;
> +}
> +
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
>  # and return a results array
>  sub recipients_cmd {
>  	my ($prefix, $what, $cmd, $file) = @_;
> -
> +	my @lines = ();
>  	my @addresses = ();
> -	open my $fh, "-|", "$cmd \Q$file\E"
> -	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
> -	while (my $address = <$fh>) {
> +	@lines = execute_cmd($prefix, $cmd, $file);
> +	for my $address (@lines) {
>  		$address =~ s/^\s*//g;
>  		$address =~ s/\s*$//g;
>  		$address = sanitize_address($address);
> @@ -2023,8 +2039,6 @@ sub recipients_cmd {
>  		printf(__("(%s) Adding %s: %s from: '%s'\n"),
>  		       $prefix, $what, $address, $cmd) unless $quiet;
>  		}
> -	close $fh
> -	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
>  	return @addresses;
>  }
