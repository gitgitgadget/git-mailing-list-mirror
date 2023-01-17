Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3DDC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 13:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjAQNaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjAQNaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 08:30:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576A38EAD
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:30:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id az20so56256135ejc.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7V40grbu4OvUryPeg4ppGwYx2NEk+sXsDxVy/Mt07M=;
        b=RMFS7phjrhABEF4a1grrBejh39fBNltF4TDsXrsDuN4XFDjealMWfDyyfTPfHS+O7T
         D2kASBjNPpy9m71yPU7TEPYtQGmt6OeCWaqiJDKTiX9G+3xCaQ0btj38jJMobJMODt7p
         k+3r9AOEym2EhvjN/RCoEMs3Zj0/h8GoCY71xjPFr0UDvbNTcceE8nbJe7l9u/IZeLV/
         HD57n45KUZZPqNnQTP3gp4WTPYJvocI3WTieOLhf9dwrPZtVeWLuv/AI9oC6zC6xNddu
         Jk9kmLaSkg7m1ZLLens8KKBrnXim7qJ10H3WVDv4u8C7jYojuvPlWPC4v6Kg0P3F9FI+
         u+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7V40grbu4OvUryPeg4ppGwYx2NEk+sXsDxVy/Mt07M=;
        b=inaXzlf8IOkRjyCMPeDOd2P7FOjVNYJ+QROlez8T/Afkp0rHVdjJ3QNZkJOmvM+KzA
         5yAi4wpvgd5NBkBQCnyJOxQaHJElE8N6R+CY4hJ2ucpsTCRQ6GLjkja5ZBhmgcGPmeXR
         2S9FVA9NbvItjFQ0r1mWLaQ2mrHRCG8+njQ2iaxFnrP3llUGu0WkMDT9zaN4lhM1U54R
         WYzxCpEM/6rgW4rN/EA4ko0SHwxpdlrp/lfCoWhjqm3Yb3+Kzk5f6MiTOm4Mu9oQNI8O
         u8Sw2eNRourR6nQzne56xzPxE+SNRIusj7qnvSDAG/Km/BnzbMDhWzlPKPlikw+i/0mM
         KgFg==
X-Gm-Message-State: AFqh2komhLmje77jIT2b506pvpTdEkVQ+QrL4IwRKGxKZhND/u3luEiL
        z0Y0xXv5ryTlWoWhifZQZlw5+jRHocs=
X-Google-Smtp-Source: AMrXdXseR5ZNLQ928Jzaf5YK7KjBJwP5EWhd4XtVzeWqgaOFb7TMSQdqjK9LbEH8m7agoz2yBpeTQw==
X-Received: by 2002:a17:907:a07b:b0:7c1:3f04:efa2 with SMTP id ia27-20020a170907a07b00b007c13f04efa2mr16682271ejc.29.1673962212500;
        Tue, 17 Jan 2023 05:30:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fy5-20020a170906b7c500b0084d3bf4498csm11803842ejb.140.2023.01.17.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:30:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHm2V-002ebj-1o;
        Tue, 17 Jan 2023 14:30:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Date:   Tue, 17 Jan 2023 14:23:50 +0100
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
 <20230110211452.2568535-3-michael.strawbridge@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230110211452.2568535-3-michael.strawbridge@amd.com>
Message-ID: <230117.86sfg9xp98.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 10 2023, Strawbridge, Michael wrote:

> To allow further flexibility in the git hook, the SMTP header
> information of the email that git-send-email intends to send, is now
> passed as a 2nd argument to the sendemail-validate hook.
>
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.

Okey, but...

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..2b5c6640cc 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,19 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].
> +
> +It takes these command line arguments:
> +1. the name of the file that holds the e-mail to be sent.
> +2. the name of the file that holds the SMTP headers to be used.
> +
> +The hook doesn't need to support multiple header names (for example only Cc
> +is passed). However, it does need to understand that lines beginning with
> +whitespace belong to the previous header.  The header information follows
> +the same format as the confirmation given at the end of send-email.
> +
> +Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.
>  
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 810dd1f1ce..b2adca515e 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,14 +787,6 @@ sub is_format_patch_arg {
>  
>  @files = handle_backup_files(@files);
>  
> -if ($validate) {
> -	foreach my $f (@files) {
> -		unless (-p $f) {
> -			validate_patch($f, $target_xfer_encoding);
> -		}
> -	}
> -}
> -
>  if (@files) {
>  	unless ($quiet) {
>  		print $_,"\n" for (@files);
> @@ -1738,6 +1730,16 @@ sub send_message {
>  	return 1;
>  }
>  
> +if ($validate) {
> +	foreach my $f (@files) {
> +		unless (-p $f) {
> +		        pre_process_file($f, 1);
> +
> +			validate_patch($f, $target_xfer_encoding);
> +		}
> +	}
> +}

...here we have the seemingly unrelated change of first doing the
validation before this, and if we pass it we'll print the names of the
files we're sending unless --quiet.

Now we'll do it the other way around, maybe that's good, or maybe not,
but your updated docs don't say.

Also (and I didn't look at this all that carefully), why are you moving
the control logic to between the later function declarations?

Perl isn't a language where you need to arrange your source in that way
(unless a bareword is involved, or if this happens at BEGIN time or
whatever). The current structure is:

	<use & imports>
	<basic setup (getopts etc)>
	<main logic>
	<helper function>

Here you're moving part of the main logic to in-between two helper
function, why?

>  $in_reply_to = $initial_in_reply_to;
>  $references = $initial_in_reply_to || '';
>  $message_num = 0;
> @@ -2101,11 +2103,20 @@ sub validate_patch {
>  			chdir($repo->wc_path() or $repo->repo_path())
>  				or die("chdir: $!");
>  			local $ENV{"GIT_DIR"} = $repo->repo_path();
> +
> +			my ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header) = gen_header();
> +
> +			require File::Temp;
> +			my ($header_filehandle, $header_filename) = File::Temp::tempfile(
> +                            ".gitsendemail.header.XXXXXX", DIR => $repo->repo_path());
> +			print $header_filehandle $header;
> +
>  			my @cmd = ("git", "hook", "run", "--ignore-missing",
>  				    $hook_name, "--");
> -			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_msg = (@cmd, "<patch>", "<header>");
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");

I know "git hook run" doesn't support input on stdin yet, but isn't this
just working around it not supporting that? That seems like a much
better & natural interface than what we're doing here.

I have out-of-tree patches for that (or rather, a re-roll of Emily's
patches to do that), if that landed in-tree could this use that
interface, do you think?

I'd rather that we didn't forever codify a strange interface here due to
a temporary limitation in "git hook" and the hook API...
