Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849CC54EBE
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 23:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjAFXsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 18:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFXsH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 18:48:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE783C710
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 15:48:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6891191pjt.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 15:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lv7ZLVMA/MiSoKqcWY21wRa5kb8FyOsqYSAqtl4GS0w=;
        b=SLmyelHbQY1UWDt9EtxsMWmNHWZyzHdgyVT1S73NlXyBmvRgMuyve+pf+4trD0pS6b
         WUNG1o0Af4Z3QNZkyqRmAIQx/pKsvgRoXF3+2omQJJbtOlpBJut3P2RA8RIZhwyCcYA8
         L8UHTw8ue6894c5a/qU2lO1+O4AM+8mMFAkpDwj5vv1aoSAnjXSyNhoYmXg2ocK3s3yl
         Zx51JzxX7Gslt8RcARq1gy1vPVly3ImW4S/iElEJckpftygH1175/qejw8owZhJiNvZW
         RW/c/Pth+Vpxdk6Oh4ScVxVlTt8G6C0maMx7nTC9Ok7RpZynPcw6IRFrHxBH+mtDvhDl
         fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lv7ZLVMA/MiSoKqcWY21wRa5kb8FyOsqYSAqtl4GS0w=;
        b=EdcSai5EHK2zUGJGGte46IXJtK4BHG7UR5B59l1llAxhLObXvsFUQkKmMSGcWyar7R
         ZQSMt4u8baiS/NQw22SlBKDohrqw196OECsM7tZy59q5Wz/rCdSlCu0ndf44PK6hXQtP
         psypwEhuU1AP07DduATCMsLR+hmzNQxD7EhfHwugVbTmARYxmuRzxWrvQDUxGdHLXv1w
         xzeXX9wdh8SijSmos8vjZrJz62ElJrmKJHe1/PFykN3isKOnhrKTLypAVT9+gNTqreIx
         reVJ9PqvOWRhv6t5v5m1DK5cagIeiP6m+vEqRVhfxWQtJ6yyNkEfSyNuVGm3mco3RfPA
         vTTw==
X-Gm-Message-State: AFqh2ko6FmJtr/pRDONxiz20BlcbeJ3dgR5IRbLtnAdvMK5WuSR2tYhk
        d4S38sTldqtv41LLM8x8oMOSuyt3cJywpA==
X-Google-Smtp-Source: AMrXdXu8wUbiQYiyts1HCLNWOF4GxXEmtEoPbXuAKsblL2o25gq5tffF8Mkg4ZQVcTUfyd+A4Crr3A==
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id u5-20020a170902bf4500b00189fa12c98amr50928667pls.66.1673048884368;
        Fri, 06 Jan 2023 15:48:04 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00192e1590349sm1415046pln.216.2023.01.06.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 15:48:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 1/1] Expose header information to git-send-email's
 sendemail-validate hook
References: <20230106215012.1079319-1-michael.strawbridge@amd.com>
        <20230106215012.1079319-2-michael.strawbridge@amd.com>
Date:   Sat, 07 Jan 2023 08:48:03 +0900
In-Reply-To: <20230106215012.1079319-2-michael.strawbridge@amd.com> (Michael
        Strawbridge's message of "Fri, 6 Jan 2023 21:51:09 +0000")
Message-ID: <xmqqcz7rp6mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:

> Subject: Re: [PATCH v4 1/1] Expose header information to git-send-email's sendemail-validate hook

Subject: [PATCH v5 1/1] send-email: expose blah blah ...

I.e. follow "<area>: describe the change with a single sentence"
convention to allow this change blend in better in "git shortlog"
output in the future release, once we accept the change.

> To allow further flexibility in the git hook, the smtp header

I recall that in the cover letter for a previous round you mentioned
that s/smtp/SMTP/ was done?

> information of the email that git-send-email intends to send, is now
> passed as a 2nd argument to the sendemail-validate hook.

OK.  Existing hooks will not see the second argument, ignore it and
continue to work as before in the best case.  In the worst case, it
notices that there is an unexpected argument on its command line and
barf.

> A new t9001
> test was added to test this 2nd arg and docs are also updated.

It is not wrong per-se but it is perfectly expected to add tests to
protect a new feature from future breakage and docs to describe it,
so strictly speaking this sentence is not necessary.

> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.

Good.

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..346e536cbe 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,10 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].  It takes two parameters,
> +the name of a file that holds the patch and the name of a file that holds the
> +SMTP headers.  Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.

Are you changing the format and contents of what you feed as the
first command line argument?  I am wondering why you did "the name
of the file that holds the e-mail to be sent" (which is very clear
that it would contain both the proposed log message and the patch
proper) to "the name of the file that holds the patch" (which now is
very unclear if we lost the proposed log message before the patch
proper).

If we expect that the "SMTP headers" is the last update for this
feature, then the above is OK, but most likely we will want to add
the third one in a few years.  Doing

    It takes these command line arguments:

    1. the name of the file that holds the e-mail to be sent.
    2. the name of the file that holds the SMTP headers to be used.

would be more future-proof.

The added description does not make (at least) one thing clear for
me to write an experimental hook to make use of this new feature.

The message I am responding to has these headers, for example:

    From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
    Subject: [PATCH v4 1/1] Expose header information to git-send-email's
     sendemail-validate hook
    To:     "git@vger.kernel.org" <git@vger.kernel.org>
    CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
            "Tuikov, Luben" <Luben.Tuikov@amd.com>,
            "brian m . carlson" <sandals@crustytoothpaste.net>

Now, does my hook need to know about RFC 5322 rules govering the 
e-mail headers, like "Cc:" and "CC:" are equivalent, and a line that
begins with a whitespace adds to the value of the previous line
(i.e. header folding)?

Another thing.  This is not a new issue, but the above paragraph
does not mention the fact that the hook silently chdir's to the root
of the working tree (or the repository) while running the hook.  We
should fix that but not as a part of this patch.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5861e99a6e..5a626a4238 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -787,14 +787,6 @@ sub is_format_patch_arg {

The patch looks very messy and unreviewable.  Each step of a patch
should do a single logical change well and cover the change in the
behaviour in documentation and tests if necessary.

But this seems to do too many things in a single step, I suspect.
It probably should be split into a handful of steps, earlier ones
just reorganizing the code structure (like splitting the early part
of "send-message" into a separate "gen-header" helper function, or
not calling validate_patch() early) without changing any externally
observable behaviour, and then final ones (possibly just the single
last step) changing how the hook is invoked (hence the documentation
and test changes would only appear in later steps).

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
> @@ -1495,16 +1487,7 @@ sub file_name_is_absolute {
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
> @@ -1546,6 +1529,22 @@ sub send_message {
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
> +	my @recipients = @$recipients_ref;
>  
>  	my @sendmail_parameters = ('-i', @recipients);
>  	my $raw_from = $sender;
> @@ -1955,6 +1954,15 @@ sub process_file {
>  		}
>  	}
>  
> +
> +	if ($validate) {
> +		foreach my $f (@files) {
> +			unless (-p $f) {
> +				validate_patch($f, $target_xfer_encoding);
> +			}
> +		}
> +	}
> +

Is this now done inside "process_file"?  Is your "process_file"
still called once per e-mail message?  If both are true, then this
part of the patch smells very wrong.  The original checks _all_
files with validate_patch() before sending even a single message,
because it does not send just a few, find a problem in the third
patch and stop.  Moving the loop to check all messages into a
function that is called once for each message simply does not make
sense---the desired "all or none" semantics may be retained because
the invocation of process_file for the first message will make all
messages to be inspected and a failure on any of them would cause
the process to stop, but that is by accident and not by a sound
design.  When sending a 5-patch series, in the normal case where the
patches we have are all good, we will inspect these patches over and
over again, no?

> @@ -2088,11 +2096,20 @@ sub validate_patch {
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
>  			my @cmd_msg = (@cmd, "<patch>");
> -			my @cmd_run = (@cmd, $target);
> +			my @cmd_run = (@cmd, $target, $header_filename);
>  			$hook_error = system_or_msg(\@cmd_run, undef, "@cmd_msg");
> +			unlink($header_filehandle);
>  			chdir($cwd_save) or die("chdir: $!");
>  		}

Outside this topic, we probably would want to get rid of these "chdir()"
and possibly "local $ENV{}" assignments.  The former should be
doable simply by starting @cmd with ("git", "-C", $dir).
