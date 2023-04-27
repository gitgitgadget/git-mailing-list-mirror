Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB15C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 15:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjD0Pte (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbjD0Ptc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 11:49:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D998
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 08:49:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a682eee3baso64569255ad.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610571; x=1685202571;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ8RUfKpr+hfj0PnRKcw67EwEmtAVr4o7r36rHQwiJc=;
        b=GMrY4MDscVjg6l6J++zUfV+PFK1AD+bvmo0M9qEtzH32jHz1mqevw8Cu6X3MJDBkZ/
         Md2IVcBPRCod2s3XaHoKutrvx0T5PFkar0MUErmX2LnY1iV6Ul/i491fCxeOdWJIJHP1
         YbFiH8U3XSX3tMPJIx9F5zmP2BIfu/TYqQn+eZ/qCATkFEFw7FRMv2NgCdJudmyr6kfq
         nqsGAe1WGXn+fEORiZIP2JZe5JLNkDvnqgRm0qRl6wSnpdN2NMKWItY7Ibdkv3HewPJc
         oVuR5/tYEuS0v3QYNJH0Qo+meVcWjzuyf0hL2CjmVDnjGKwMOOsdAboCt4qsxeoN1pqG
         kIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610571; x=1685202571;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aQ8RUfKpr+hfj0PnRKcw67EwEmtAVr4o7r36rHQwiJc=;
        b=NNBgflvd9e1C+iP0UNAA2dIi8cgIsnGbPUq5wmK4BFDRxDV6SuEBNmr6kM3kIWy9cf
         JRqOauJC2zeF21p9IsZxiyeD+YlPQIh02PmvyqJXJg0B8e4Q/Bz5eg0A9EOlDV6kYeA9
         K/WejY8jkfLMFvFuPmjZSAmVfZsTT45cpStLmCjyndnVDULM+lM/+I+UJrWA8xk4w+aD
         0I5PmC7tJIUNahkfXTDc+EsdElrxdxAtrzFtxOJLZXl8p5tiyfbSQXdVha7pWUJJ+Tzm
         efu5vzn+0lYyFPuz0dzRliYPeOydJgiq18BwpWbjuLD2m+XnY3/B/OvT0BTlxC81T30E
         hBTg==
X-Gm-Message-State: AC+VfDzsTlagFqgmSbD4HBKwb0f+2T5SevcML9th3CDXzMJypXWgQOqX
        oNivUp+yt/Mjq9KLmjDmuqQ=
X-Google-Smtp-Source: ACHHUZ6KScChB+wJCc0IRznBogYVz/4RwqwzdOjriMn61HgdT1so3wDAvU5tGq3NZ/YSPiHkChr/Tg==
X-Received: by 2002:a17:902:db0f:b0:1a6:7a19:331b with SMTP id m15-20020a170902db0f00b001a67a19331bmr2494174plx.5.1682610571086;
        Thu, 27 Apr 2023 08:49:31 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm11386032pjq.43.2023.04.27.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:49:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] send-email: prompt-dependent exit codes
References: <20230426061606.1495646-1-oswald.buddenhagen@gmx.de>
Date:   Thu, 27 Apr 2023 08:49:30 -0700
In-Reply-To: <20230426061606.1495646-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 26 Apr 2023 08:16:06 +0200")
Message-ID: <xmqqttx1l3zp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> From the perspective of the caller, failure to send (some) mails is an
> error even if it was interactively requested, so it should be indicated
> by the exit code.
>
> To make it somewhat specific, the exit code is 10 when only some mails
> were skipped, and 11 if the user quit on the first prompt.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> ---
> v2:
> - fix do_quit() not resetting $sent_all
> ---
>  git-send-email.perl | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)

Administrivia:

 * Marking the patch as "v2" is very good to signal that this is an
   improved version of a previous effort.  It also is very good that
   the difference from "v1" is summarized below the three-dash line.

 * When sending such a new iteration, it helps readers and reviewers
   to make it a reply to the previous round.  You seem to be using
   "git send-email" and giving the option

   --in-reply-to=20230323162234.995435-1-oswald.buddenhagen@gmx.de

   would have made this message a reply to the previous one.  Not
   everybody will remember your previous attempt.

 * It gives the new iteration a better chance to be reviewed if you
   CC'ed the right people, including the ones who gave reviews on
   the previous round.

As to the motivation described in the proposed log message, I am not
convinced.  The end-user knows the best, they told the program to
stop, and the program stopped as it was told.  I tend to think that
it should not be treated as an error.  But if somebody is driving
"git send-email" from a wrapper that wants to know what happened, I
can understand that "did we send everything we were told to send" is
*one* of the things such a wrapper may want to know.  And my earlier
"I am not convinced" is definitely not "I am convinced that what
this patch wants to do is wrong".

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 07f2a0cbea..7587cd2d20 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -254,6 +254,19 @@ sub system_or_die {
>  	die $msg if $msg;
>  }
>  
> +my $sent_any = 0;
> +my $sent_all = 1;
> +
> +sub do_exit {
> +	exit($sent_any ? $sent_all ? 0 : 10 : 11);
> +}

Without knowing where "v1" was (see Administrivia above) and seeing
the use of above two variables, I found them a bit unnatural and was
going to suggest to have the total number of messages and the number
of messages that were actually sent, but it turns out that it was
the exact same reaction as Phillip had for "v1" iteration.

It would work either way until we start caring how many we actually
have sent, but keeping tallies may be more future-proof.

In any case, before sending anything, we initialize ourselves to the
"we haven't sent anything" and "we have sent everything we have been
asked to send so far" state.  The idea to flip the former flag to true
once we sent a single message while flipping the latter flag to false
once we failed to send a single message to maintain these two flags is
simple and effective.

> +sub do_quit {
> +	cleanup_compose_files();
> +	$sent_all = 0;
> +	do_exit();
> +}
> +
>  sub do_edit {
>  	if (!defined($editor)) {
>  		$editor = Git::command_oneline('var', 'GIT_EDITOR');
> @@ -1172,8 +1185,7 @@ sub validate_address {
>  		if (/^d/i) {
>  			return undef;
>  		} elsif (/^q/i) {
> -			cleanup_compose_files();
> -			exit(0);
> +			do_quit();
>  		}
>  		$address = ask("$to_whom ",
>  			default => "",
> @@ -1593,8 +1605,7 @@ sub send_message {
>  		} elsif (/^e/i) {
>  			return -1;
>  		} elsif (/^q/i) {
> -			cleanup_compose_files();
> -			exit(0);
> +			do_quit();
>  		} elsif (/^a/i) {
>  			$confirm = 'never';
>  		}

OK, the above two covers the case where the end-user interactively
tells the command to stop before sending the message in question,
and by definition in such a case, at least one message (i.e. the one
that triggered the interactive session) was not sent, so dropping
the "all" flag makes sense.

> @@ -1968,6 +1979,12 @@ sub process_file {
>  		return 0;
>  	}
>  
> +	if ($message_was_sent) {
> +		$sent_any = 1;
> +	} else {
> +		$sent_all = 0;
> +	}

And after processing a single file, we adjust the "any" and "all"
counter.

The only semi-tricky part of the whole set-up, I presume, is that
the "I've sent everything I was asked to send so far" flag needs to
be initialized to true, and the "I have sent anything yet" flag to
false.  When the number of messages we were given is 0, after
iterating over the loop 0 times and never calling process_file,
do_exit will see that we haven't sent any and we have sent all that
were asked to be sent.  Is that an error?  According to the
hard-to-read nested ternary in do_exit, it is:

	exit($sent_any ? $sent_all ? 0 : 10 : 11);

because $sent_any would be 0.  I wonder if it can be remedied by a
simple reordering to check $sent_all first?  I.e. something like (as
I do not think anybody can read nested ternary and keep their
sanity) this?

	if ($sent_all) {
		exit(0);
	} elsif ($sent_any) {
		exit(11);
	} else {
		exit(10);
	}

>  	# set up for the next message
>  	if ($thread) {
>  		if ($message_was_sent &&
> @@ -2187,3 +2204,5 @@ sub body_or_subject_has_nonascii {
>  	}
>  	return 0;
>  }
> +
> +do_exit();

Thanks.
