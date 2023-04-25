Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC00C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjDYQWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjDYQWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:22:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D91D2684
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:22:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef38864360so60765941cf.2
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682439729; x=1685031729;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DsDKIbvyyTvWpQ6c9AZw7GmdA1s9ZtGHp7nXF0yqD3c=;
        b=bN5TwCeb2LcKEOcQ6UoDMqjcw3P6i52/hBTnW0HT8KE+54CDuTWWH01q2wKqBBz5Uq
         3kzD/No6cG9sx8B+x1r7JPRZOmvRM/WruY9tYPe5cgMymnqLMSBhCT9nzxecCN0fJObW
         u38lK/x59LxXpl1I2yXOYbHWoaY0xo0IOEkAUNTMkSRJMULT1QV/MJny4M1eLcW8OoEo
         u4/3th08yGsD37PrfjcEAuLR20Odmpa83Y7yx6zvsL+rN3O80769mKgvQ1lZfvd2SL3a
         hTclWDZPvuyUxGL8mUIDyv1Vzannt5MnvqYia2YZM+M2Z5cbrFv790L5HIJ3n7EJc+6a
         bZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439729; x=1685031729;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsDKIbvyyTvWpQ6c9AZw7GmdA1s9ZtGHp7nXF0yqD3c=;
        b=k8VIHkwAIttiUEfK5UyD7S4pDt8gbZYguDBc2E2hSnol37K4JjMpBMVDv5o1Vg1zg5
         N1AkVKhbhJSzQku/IW6qV8z0VddBOmcGOv1an5cLlk8HcoeWLoZBUcIJaswFGf8LBq3b
         vy3bV7xXxgP4wa0ELfLslv0+UOhRKHrQGFSEu6/Lteb0xILeYTid0Q1Mn4aIzuS/phhz
         pKOz+mfYWhl8t5he8E2EGZJeHAv/p22VOLgcB5B+541tZKFgRx9GUHS/wbmU9AkNCqpI
         MkQXEOafilNM733X+72zY8keml3SJzvFtZT9YGC1n9w9j0UBJEj0BZLLKrZ7aCE6LLiO
         rEjw==
X-Gm-Message-State: AAQBX9ffoPTT6WRL7beCZ2TlKffN6yeT5YF5nwD99VZtbZBoCH3STeSh
        x9FugXPCV2RkXJmS8rgqBj7VAAcArns=
X-Google-Smtp-Source: AKy350bS7KUvgvt5HpGdKRHaWA3JQSniWl7cq/ftBsCxTxwEe4+UCB8PKQ2eKAofh/iVZ61GUSwfKA==
X-Received: by 2002:ac8:4e50:0:b0:3f0:af2a:696c with SMTP id e16-20020ac84e50000000b003f0af2a696cmr3932882qtw.49.1682439729234;
        Tue, 25 Apr 2023 09:22:09 -0700 (PDT)
Received: from hurd ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b0074fb065bde4sm1722483qkn.18.2023.04.25.09.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:22:08 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     Juniog C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-3-maxim.cournoyer@gmail.com>
        <xmqqh6t57x0y.fsf@gitster.g>
Date:   Tue, 25 Apr 2023 12:22:07 -0400
In-Reply-To: <xmqqh6t57x0y.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Apr 2023 15:09:17 -0700")
Message-ID: <87y1mgortc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano <gitster@pobox.com> writes:

> Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:
>
>> Sometimes, adding a header different than CC or TO is desirable; for
>> example, when using Debbugs, it is best to use 'X-Debbugs-Cc' headers
>> to keep people in CC; this is an example use case enabled by the new
>> '--header-cmd' option.
>> ---
>
> Missing sign-off?

Added.

>>  Documentation/config/sendemail.txt |  1 +
>>  Documentation/git-send-email.txt   |  5 +++++
>>  git-send-email.perl                | 12 +++++++++---
>>  t/t9001-send-email.sh              | 21 +++++++++++++++++++--
>>  4 files changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
>> index 51da7088a8..3d0f516520 100644
>> --- a/Documentation/config/sendemail.txt
>> +++ b/Documentation/config/sendemail.txt
>> @@ -58,6 +58,7 @@ sendemail.annotate::
>>  sendemail.bcc::
>>  sendemail.cc::
>>  sendemail.ccCmd::
>> +sendemail.headerCmd::
>>  sendemail.chainReplyTo::
>>  sendemail.envelopeSender::
>>  sendemail.from::
>
> Why here?
>
> Asking because existing other entries look sorted lexicographically.

Oops.  Fixed.


>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index b0f438ec99..354c0d06db 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -320,6 +320,11 @@ Automating
>>  	Output of this command must be single email address per line.
>>  	Default is the value of `sendemail.ccCmd` configuration value.
>>
>> +--header-cmd=<command>::
>> +	Specify a command to execute once per patch file which should
>> +	generate arbitrary, patch file specific header entries.
>
> "arbitrary, patch file specific" sounds like a problematic thing to
> say here.  If it is truly arbitrary, then it is up to the user to
> emit identical output for all patches and there is no reason to
> inisist it has to be ptach file specific.  I am sure you meant "you
> do not have to add the same set of headres with the same values for
> all messages", but that is very much obvious once you said "command
> to execute once per patch file".

That is indeed what I meant.

> By the way, does it apply also to the cover-letter, which is not a
> patch file?  I presume it does, in which case we shouldn't be saying
> "once per patch file", but something like "once per outgoing message"
> or something.

I think it happens for every message (the logic is in the
'process_files' procedure), so it'd also apply to the cover letter
(which is produced with the extension .patch by format-patch, although
it isn't a patch as you noted :-)).

> Also, its output is not really arbitrary.  It has to emit RFC-2822
> style header lines.  Emitting a block of lines, with an empty line
> in it, would be a disaster, isn't it?  The expected output format
> for the <command> this option specifies needs to be described a bit
> better.

I'm not too familiar with the email format; but I presume an empty line
would signal the end of a message?  That'd be bad yes, but I think it
cannot currently happen given the 'last if $line =~ /^$/;' guard at in
execute_cmd around line 2023; it'd means headers following an empty line
would be discarded though.  The expected use case is indeed for a user's
script to produce RFC 2822 style headers to messages.

> 	Specify a command that is executed once per outgoing message
> 	and output RFC-2822 style header lines to be inserted into
> 	them.
>
> or something like that?

That's much clearer, thanks.  I've reworded the text following your
suggestion.

>> +	Default is the value of `sendemail.headerCmd` configuration value.
>
> Make it clear what you mean by the Default here.  If you configure
> the variable, will the command be always used without any way to
> turn it off?  Or does it specify the default value to be used when
> "git send-email ---header-cmd" option is used without any value?
>
> If it is the former, there should be a way to turn it off from the
> command line, probably.

The former (a true default with no way to turn it off other than
redefining it), which I believe is the same behavior as for --cc-cmd or
--to-cmd.  There are no '--no-cc-cmd' or '--no-to-cmd' options, although
their result can be filtered via the '--no-cc' and '--no-to' options.
Looking in the source, options supporting '--no-' always appear to be
boolean toggles (on/off) though, so I'm not sure how a '--no-header-cmd'
that take a value can currently be implemented.  Perhaps it could be
added later if there is a need?

>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index d2febbda1f..676dd83d89 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -88,8 +88,9 @@ sub usage {
>>
>>    Automating:
>>      --identity              <str>  * Use the sendemail.<id> options.
>> -    --to-cmd                <str>  * Email To: via `<str> \$patch_path`
>> -    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
>> +    --to-cmd                <str>  * Email To: via `<str> \$patch_path`.
>> +    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`.
>> +    --header-cmd            <str>  * Add headers via `<str> \$patch_path`.
>>      --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
>>      --[no-]cc-cover                * Email Cc: addresses in the cover letter.
>>      --[no-]to-cover                * Email To: addresses in the cover letter.
>> @@ -270,7 +271,7 @@ sub do_edit {
>>  # Variables with corresponding config settings
>>  my ($suppress_from, $signed_off_by_cc);
>>  my ($cover_cc, $cover_to);
>> -my ($to_cmd, $cc_cmd);
>> +my ($to_cmd, $cc_cmd, $header_cmd);
>>  my ($smtp_server, $smtp_server_port, @smtp_server_options);
>>  my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
>>  my ($batch_size, $relogin_delay);
>> @@ -319,6 +320,7 @@ sub do_edit {
>>      "tocmd" => \$to_cmd,
>>      "cc" => \@config_cc,
>>      "cccmd" => \$cc_cmd,
>> +    "headercmd" => \$header_cmd,
>>      "aliasfiletype" => \$aliasfiletype,
>>      "bcc" => \@config_bcc,
>>      "suppresscc" => \@suppress_cc,
>> @@ -520,6 +522,7 @@ sub config_regexp {
>>  		    "compose" => \$compose,
>>  		    "quiet" => \$quiet,
>>  		    "cc-cmd=s" => \$cc_cmd,
>> +		    "header-cmd=s" => \$header_cmd,
>>  		    "suppress-from!" => \$suppress_from,
>>  		    "no-suppress-from" => sub {$suppress_from = 0},
>>  		    "suppress-cc=s" => \@suppress_cc,
>> @@ -1777,6 +1780,9 @@ sub process_file {
>>  			push(@header, $_);
>>  		}
>>  	}
>> +	# Add computed headers, if applicable.
>> +	push @header, execute_cmd("header-cmd", $header_cmd, $t)
>> +		if defined $header_cmd;
>
> While execute_cmd() may be a good enough interface to be used
> without much post-processing to read cc-cmd and to-cmd output (but
> notice that even there it needs post-processing), I do not think it
> is a good interface to directly use to read header lines without any
> postprocessing like patch [2/2] does.
>
> Its use in recipients_cmd() is OK primarily because it is about just
> reading bunch of values placed on Cc: or To: lines.  If you are going
> to use it in arbitrary sets of header lines, it is very likely that
> you would need to handle header folding (see what the loop before "#
> Now parse the header" is doing to preprocess <$fh>, which is not done
> for lines you read into @header in [2/2]).

I've extracted such postprocessing into fold_headers and applied
execute_cmd to it in new invoke_header_cmd subroutine.

v2 will follow shortly.

Thanks for the review!

--
Maxim
