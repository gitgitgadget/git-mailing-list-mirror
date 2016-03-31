From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v11 2/4] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Fri, 1 Apr 2016 01:04:03 +0530
Message-ID: <CAFZEwPO4CJ-Q=52Es14CdD0mjG-qgy4=X2kU71npi=8x7FsSQw@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
	<xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:34:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aliM7-0007ik-0P
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756801AbcCaTeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:34:06 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34443 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbcCaTeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:34:04 -0400
Received: by mail-yw0-f195.google.com with SMTP id f6so13026246ywa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=s6/ruDEunGgpRNpa02RxjJHmGomLMSCXNAPOZJUr8ZM=;
        b=JAZTzneicbaBS6pwkiYoqkUR/QAerVwNqIJhAYxIFFRSULrM7CUci0Q0dJihQFF3Xm
         8iEw7LudnLngbjtwAlR77phbMptKRH63aAjumgGcE1x72a31It9BuS6qg4D2tj0VcNxW
         /yNiHfj5aEPTB0yWMP7FXS/p7L32C7XN+J1swvQEJhgYSaTw1bGso83DhRSadehG4MXL
         /IQ2ZKzsKKJNv5do+0S+EXAtA2BKesUTK8o9Uy8hpGo7u7K+qJKwL6+TPCXi08ziSoeX
         tG/EDnBmjqe6k5oAjMfU/WCPl68j6/uVALsI5pRBz87GPcHZFzNCmzONc0rXdxUhI0BV
         wPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=s6/ruDEunGgpRNpa02RxjJHmGomLMSCXNAPOZJUr8ZM=;
        b=iko1BBbjnhmWIINjlDZndiTZaA9iwyfvsZ8Z6X1NSj0ORVzWzYWIWIuXEXAQZm090a
         kPFq2psJ/2/az3897XbtQqsMQfQONxRMJLSFYJOXxjyVaCUUAM5V3//l87Qeug5tJW/V
         c/k1eTh4hOWznPKeERALvANpbwiXC4W1in70Wh9DLi2LPLeq4VwZRyyGCESXE/OJ2u7K
         J/zNpnQM8JWiVayjBRr6oztZTHY1XJ12XcpbAWBmznR7VdskgWf4+2o4qva1FKzeFHDk
         DeIBbnjiqbI8mwQpEMdOAlhUln8fcwrHW7GMUb1BoCX7novKPV0JnO1vQoFZ4vHYGYFp
         8KtA==
X-Gm-Message-State: AD7BkJLsIas7aHPU9+M849cSooD6UNOaIaeSyLy7AsY69kkTrD94J9bU5KUQvLVPfL4hZOm5fQSxIJ+Ib9q1FQ==
X-Received: by 10.13.252.67 with SMTP id m64mr9481118ywf.67.1459452843924;
 Thu, 31 Mar 2016 12:34:03 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 31 Mar 2016 12:34:03 -0700 (PDT)
In-Reply-To: <xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290457>

On Fri, Apr 1, 2016 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> This change will not affect existing users of COUNTUP at all, as long as
>> they use the initial value of 0 (or more).
>>
>> Force uses the "unspecified" value in conjunction with OPT__FORCE in
>> builtin/clean.c in a different way to handle its config which
>> munges the "-1" into 0 before we get to parse_options.
>
> These two paragraphs leave the readers wondering what the conclusion
> is.  "it is OK as long as..." makes us wonder "so are there users
> that do not satisfy that condition?"  "in a different way" makes us
> wonder "Does this change break builtin/clean.c because COUNTUP is
> used in a different way?".
>
>         This change does not affect existing users of COUNTUP,
>         because they all use the initial value of 0 (or more).
>
>         Note that builtin/clean.c initializes the variable used with
>         OPT__FORCE (which uses OPT_COUNTUP()) to a negative value,
>         but it is set to either 0 or 1 by reading the configuration
>         before the code calls parse_options(), i.e. as far as
>         parse_options() is concerned, the initial value of the
>         variable is not negative.
>
> perhaps?

Thanks again for the help with the comit message. I sometimes fail to
see how first time readers will infer from the message.

>>  `OPT_COUNTUP(short, long, &int_var, description)`::
>>       Introduce a count-up option.
>> -     `int_var` is incremented on each use of `--option`, and
>> -     reset to zero with `--no-option`.
>> +     Each use of `--option` increments `int_var`, starting from zero
>> +     (even if initially negative), and `--no-option` resets it to
>> +     zero. To determine if `--option` or `--no-option` was set at
>> +     all, set `int_var` to a negative value, and if it is still
>> +     negative after parse_options(), then neither `--option` nor
>> +     `--no-option` was seen.
>>
>>  `OPT_BIT(short, long, &int_var, description, mask)`::
>>       Introduce a boolean option.
>> diff --git a/parse-options.c b/parse-options.c
>> index 47a9192..86d30bd 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
>>               return 0;
>>
>>       case OPTION_COUNTUP:
>> -             *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>> +             if (unset)
>> +                     *(int *)opt->value = 0;
>> +             else {
>> +                     if (*(int *)opt->value < 0)
>> +                             *(int *)opt->value = 0;
>> +                     *(int *)opt->value += 1;
>> +             }
>>               return 0;
>>
>>       case OPTION_SET_INT:
>
> The new behaviour given by the patch looks very sensible, but I
> wonder if this is easier to reason about:
>
>         case OPTION_COUNTUP:
> +               if (*(int *)opt->value < 0)
> +                       *(int *)opt->value = 0;
>                 *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>
> That is, upon hitting this case arm, we know that an explicit option
> was given from the command line, so the "unspecified" initial value,
> if it is still there, gets reset to 0, and after doing that, we just
> do the usual thing.

This does look cleaner. Nice thinking that there is no need to
actually specify when it gets 0. It gets 0 no matter what as long as
OPTION_COUNTUP is speficied in any format (with or without --no) and
variable is "unspecified".
