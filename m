Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E18C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35BC613EB
	for <git@archiver.kernel.org>; Wed, 12 May 2021 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhELNEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 09:04:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54197 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhELNEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 09:04:48 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620824618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVfX0IUipLFY1Br4QHK5lJSR8lGIOZ2D6dlMmq6n3n8=;
        b=HJLFFVTsPmM2aDPJlsKdbZtO9Y4t3km6kGK/xnI9XPZ6jX/BdNgd5+PD3eqrt4CqNQqUD0
        dQG/sWXP1mWYrpSGCx3VhG08g2+S4wuo+yS8gw5xL8bCYTskTdsH2C87W4FRAkyzt+BbLS
        j6KUQxPzo43tcHTrjnpcrHR5Rv50OicWvrO5B4YonghsB2g3D3+T11nHWATIe6zKIlZh6W
        a7jMHJhcp5QarDJozIBkr5KBXP3e083BkvUzGxVecH27EqqsMoFvlUW/gSec5/OI3F62n4
        prNOBRN+Qw9lCbtTaioDMuP6zCZMPd85YfkEzt5ZeWPEFLr6Cx88D3wL+39Bug==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A340C4000C;
        Wed, 12 May 2021 13:03:37 +0000 (UTC)
Date:   Wed, 12 May 2021 07:03:35 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Message-ID: <YJvSJ3/2RWFJVmoq@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <xmqqh7j8h9cy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh7j8h9cy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 13:19 +0900, Junio C Hamano wrote:
>Is this a totally unwarranted rewrapping of an unrelated part of the
>same document, or was there some words or phrases in this
>description of the envelope-sender option that needed to be adjusted
>for the introduction of sendmail-cmd option?

Yes it's just a rewrapping that I did while adding my new paragraph. The 
other reviewers pointed this out as well. My mistake, I will remove this 
from the next patch revision.

>> +--sendmail-cmd=<command>::
>> +	Specify a command to run to send the email. The command should
>> +	be compatible with `sendmail` as the arguments are passed
>> +	directly.  The command will be executed in the shell if
>> +	necessary.  Default is the value of `sendemail.sendmailCommand`.
>> +	If unspecified, and if --smtp-server is also unspecified,
>> +	git-send-email will search for `sendmail` in `/usr/sbin`,
>> +	`/usr/lib` and $PATH if such a program is available.

>OK, but doesn't this also need to support '-i'?

'The command should be compatible with `sendmail`' was meant to imply
this, though I can make this more explicit.

>> @@ -211,13 +221,14 @@ a password is obtained using 'git-credential'.
>>
>>  --smtp-server=<host>::
>>  	If set, specifies the outgoing SMTP server to use (e.g.
>> -	`smtp.example.com` or a raw IP address).  Alternatively it can
>> -	specify a full pathname of a sendmail-like program instead;
>> -	the program must support the `-i` option.  Default value can
>> -	be specified by the `sendemail.smtpServer` configuration
>> -	option; the built-in default is to search for `sendmail` in
>> -	`/usr/sbin`, `/usr/lib` and $PATH if such program is
>> -	available, falling back to `localhost` otherwise.
>> +	`smtp.example.com` or a raw IP address).  If unspecified, and if
>> +	`--sendmail-cmd` is also unspecified, the default is to search
>> +	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
>> +	program is available, falling back to `localhost` otherwise.
>> +
>> +	For backward compatibility, this option can also specify a full
>> +	pathname of a sendmail-like program instead; the program must
>> +	support the `-i` option.  Prefer using `--sendmail-cmd` instead.

>Drop the last sentence, if we are not going to explain why.

I do think nudging users to use the "correct" option is valuable, so I 
will add some why text. Though I think adhering to the "--smtp-server 
should specify a host and --sendmail-cmd specifies a command" dichotomy 
is a good reason in and of itself.

>> @@ -1490,14 +1497,15 @@ sub send_message {
>>
>>  	unshift (@sendmail_parameters, @smtp_server_options);
>>
>> +	if (file_name_is_absolute($smtp_server)) {
>> +		# Preserved for backward compatibility
>> +		$sendmail_command ||= $smtp_server;
>> +	}
>
>Hmph, I wonder if this makes the intent more clear.
>
>	if (!defined $sendmail_command && file_name_is_absolute($smtp_server)) {
>		$sendmail_command = $smtp_server;
>	}
>
>That is, if the user gave us the command in newer form, we do not
>even have to bother checking if the server is given as an absolute
>pathname.

Yes I think you're right, I'll make this change.

>You seem to have replaced every smtp-server="$(pwd)/ mechanically
>with sendmai-cmd=\"$(pwd)/, but please make sure that we have at
>least one test left that passes an absolute path to --smtp-server to
>ensure that the old mechanism keeps working.  A bonus point for
>marking such a test that needs to be adjusted when the actual
>deprecation happens (i.e. we'd likely to detect the use of absolute
>path and throw a warning, so the test should notice the warning
>message).

Noted, I'll add a test for this case.

>Also you would want to tweak some of the --sendmail-cmd variants to
>use just the command name, with and without args, to ensure that (1)
>discovery on $PATH works, and (2) passing initial args works.

I did add two such tests:

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..82a3efb987 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2148,6 +2148,29 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
         test_cmp expected-list actual-list
  '

+test_expect_success $PREREQ 'test using relative path with sendmailCommand' '
+       clean_fake_sendmail &&
+       PATH="$(pwd):$PATH" \
+       git send-email \
+               --from="Example <nobody@example.com>" \
+               --to=nobody@example.com \
+               --sendmail-cmd="fake.sendmail" \
+               HEAD~2 &&
+       test_path_is_file commandline1 &&
+       test_path_is_file commandline2
+'
+
+test_expect_success $PREREQ 'test using shell with sendmailCommand' '
+       clean_fake_sendmail &&
+       git send-email \
+               --from="Example <nobody@example.com>" \
+               --to=nobody@example.com \
+               --sendmail-cmd="[ 1 -eq 1 ] && \"$(pwd)/fake.sendmail\"" \
+               HEAD~2 &&
+       test_path_is_file commandline1 &&
+       test_path_is_file commandline2
+'
+
  test_expect_success $PREREQ 'invoke hook' '
         mkdir -p .git/hooks &&


Granted, the second test tests for some generic shell expression, not 
passing arguments, but I think if the former works the latter ought to 
as well.

Thanks for your feedback.
