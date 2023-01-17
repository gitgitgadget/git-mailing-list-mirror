Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A53CC63797
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 13:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjAQNXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjAQNXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 08:23:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC10227B2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:23:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v30so45029647edb.9
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NscxDkqtfHeHQK4lWqrOkkg60gJbzDLl7IkEbjApwtM=;
        b=IzUVhnRJucEZoiKGobRelLJfoF7ZFqkh0DeGB2dJcUrPSOL5ubEJRtvyCUfOmNj+1H
         pXhhI+TT0JenRCDCbC3yMVT3ptmYMdZrJv6GTIMY4jN5sc3VEhLWvn6T3uwGiK/3jcRK
         PUO6NCjl1sJZFD0qV7IS4Ou6mHuXSDus4CqyixYZx0YvK1iNk8q+9PZKH+oE3Qn3mb7a
         7McUQP0+fISfveGNIITJKGI6BbxTIAOP2pvaPjt27yjl+5KOB1o+zA+JP3VQ4YPdoBI8
         XDwNKUn0Pj79iWBp5KGQ6fGIbfkqG8Yf+VCKIN2PLw/3xbIbIiEVTMLlNmDEOdnqz0Wf
         oENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NscxDkqtfHeHQK4lWqrOkkg60gJbzDLl7IkEbjApwtM=;
        b=vtZZH9UTepFSHsbB3kh/VwTskWO6piRNwpKqTz7zGQGhYbKpkxUIRRJxyaFye1if54
         ytPH4DAkOvlczwkPwQ9CuBLyAyws6RnPP2T3I4ob4uMSaZLDeLQUsv09sMt/dNcVv9y4
         W2vEx++tVLATqodveJh6Coy4TH556xFIOSF76WSzK4wCxesLspjb2EE08z6utReZsAVv
         nL8ERO1auBPKIKEnFngWWVTM407iD/He+m9mzASMaotsI9lVBfxWfEboVyFoYU9jgC7G
         qNvS2d9uj5JqH1wrCu42zVN2cgNoZX1OpiL87uZ8RWK396Ff/QqBoHpkgru/gi4RAz8N
         xEig==
X-Gm-Message-State: AFqh2kpBdERllwhT+J5ycbdcAjHPFMvCwaOjBv9h7g0d6ADJjRFNNDEq
        MRboVfFfCSZHYv46Gwb4XLA/XJEQeD8=
X-Google-Smtp-Source: AMrXdXsVxkCZKdzw/Hm5q/xU27P/V+06pWo9afhKrKhH9X56dE5rhZu0hErNobiTjizsXbo9RBveLg==
X-Received: by 2002:a05:6402:5d4:b0:499:bdd8:f8 with SMTP id n20-20020a05640205d400b00499bdd800f8mr3590842edx.5.1673961788285;
        Tue, 17 Jan 2023 05:23:08 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7d445000000b00482b3d0e1absm12774782edr.87.2023.01.17.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:23:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHlvf-002eMO-1D;
        Tue, 17 Jan 2023 14:23:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] send-email: refactor header generation functions
Date:   Tue, 17 Jan 2023 14:20:58 +0100
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
 <20230110211452.2568535-2-michael.strawbridge@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230110211452.2568535-2-michael.strawbridge@amd.com>
Message-ID: <230117.86wn5lxpl0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 10 2023, Strawbridge, Michael wrote:

> Split process_file and send_message into easier to use functions.
> Making SMTP header information more widely available.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  git-send-email.perl | 49 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..810dd1f1ce 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1495,16 +1495,7 @@ sub file_name_is_absolute {
>  	return File::Spec::Functions::file_name_is_absolute($path);
>  }
>  
> -# Prepares the email, then asks the user what to do.
> -#
> -# If the user chooses to send the email, it's sent and 1 is returned.
> -# If the user chooses not to send the email, 0 is returned.
> -# If the user decides they want to make further edits, -1 is returned and the
> -# caller is expected to call send_message again after the edits are performed.
> -#
> -# If an error occurs sending the email, this just dies.
> -
> -sub send_message {
> +sub gen_header {
>  	my @recipients = unique_email_list(@to);
>  	@cc = (grep { my $cc = extract_valid_address_or_die($_);
>  		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
> @@ -1546,6 +1537,22 @@ sub send_message {
>  	if (@xh) {
>  		$header .= join("\n", @xh) . "\n";
>  	}
> +	my $recipients_ref = \@recipients;
> +	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
> +}
> +
> +# Prepares the email, then asks the user what to do.
> +#
> +# If the user chooses to send the email, it's sent and 1 is returned.
> +# If the user chooses not to send the email, 0 is returned.
> +# If the user decides they want to make further edits, -1 is returned and the
> +# caller is expected to call send_message again after the edits are performed.
> +#
> +# If an error occurs sending the email, this just dies.
> +
> +sub send_message {
> +	my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();

This makes the diff smaller, but if we're refactoring these functions to
return arguments it's probably better to return a hash reference rather
than remembering all the parameter names.

But in this case it's probably fine...

> +	my @recipients = @$recipients_ref;
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sender;
> @@ -1735,11 +1742,8 @@ sub send_message {
>  $references = $initial_in_reply_to || '';
>  $message_num = 0;
>  
> -# Prepares the email, prompts the user, sends it out
> -# Returns 0 if an edit was done and the function should be called again, or 1
> -# otherwise.
> -sub process_file {
> -	my ($t) = @_;
> +sub pre_process_file {
> +	my ($t, $quiet) = @_;

This, I think, is an anti-pattern in this file. We can just read the
"$quiet" and other things that we set up when we parse the parameters as
globals, we don't need to pass them as named parameters.

It doesn't help readability to shadow that variable with another lexical
here below:

> [...]
> +}
> +
> +# Prepares the email, prompts the user, sends it out
> +# Returns 0 if an edit was done and the function should be called again, or 1
> +# otherwise.
> +sub process_file {
> +	my ($t) = @_;
> +
> +        pre_process_file($t, $quiet);
>  
>  	my $message_was_sent = send_message();
>  	if ($message_was_sent == -1) {
> @@ -2002,7 +2015,7 @@ sub process_file {
>  # Execute a command (e.g. $to_cmd) to get a list of email addresses
>  # and return a results array
>  sub recipients_cmd {
> -	my ($prefix, $what, $cmd, $file) = @_;
> +	my ($prefix, $what, $cmd, $file, $quiet) = @_;
>  
>  	my @addresses = ();
>  	open my $fh, "-|", "$cmd \Q$file\E"

