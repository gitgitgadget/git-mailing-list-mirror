From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 10/44] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Thu, 15 May 2014 15:09:14 -0700
Message-ID: <CAL=YDWmk6vR0J0fs6jDPgEaAXLVk5xGbR-wPToyccxuSe-MKuw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-11-git-send-email-sahlberg@google.com>
	<20140515193446.GH26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl3q3-0001KB-TD
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaEOWJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:09:16 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:49216 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaEOWJP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:09:15 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so5202715vcb.15
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6JQIh/+dkh7ALnfBo9LOm5Cvl5ANawG3h5ZqkCwAYG0=;
        b=fFjz+nvAwuCTl5bc94kSs8aDctSESQ5Ra6BLyyGvBpc7BN3xtxI9qgttTYq/F4WVQK
         0UKcXshwJ6t1V3yICZmNOKs/kRETN9k691eU7LWTjRyJC49eRsGcn2wiw4jsvkx3G7b0
         Zd6T1VFE5/ywAYxoADazQXjwwXc6pTRslFfImvpd8vVwUVZigdhSSnNrAQggw7KMhy3a
         WUZ6ObODmagXepOqPwvQnnLtwBSxDkdzVcK8YL2jk1cRvNhCJswu/FQljI2qPIyOAmau
         tt90Ox5V8xEEpLiZck8YMxVx1/p3U4JycNOxGDANdSxNBpH8OrBwQA/Euc/1XSZFWY4i
         Rphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6JQIh/+dkh7ALnfBo9LOm5Cvl5ANawG3h5ZqkCwAYG0=;
        b=iirPU+2QIQUbVBYwUMCPVCqpVL2USHNdZczNiqAjzMN5ZLfu0lFwX8IxCqaCTdgT9x
         fJePQHtBpT3oy2OCtGRADLYBUHbSzDYT6K1j1D8ssJYX0lL1UGfcjFYx+qpuaglBj8tz
         CFJBsbw90gUJfaQPYUDYmLa/yFO41dNH6nFK5DlzVFGngsZzBqkt7zpXDuvtkQgr7iuX
         l9f+jmC8/Ic0f+5AP+u5OoWzDwmjx5+MDkQwotkXlfCbzeDwdL0pUUS9zydiFmHH1IO0
         hFZ0APf5O887qtFGToLl29pmq90Gbt3jp1Lp9U3fV6yUTYlczyV7p3PFfO1ZjAr0xhaX
         7iKw==
X-Gm-Message-State: ALoCoQl8AeoueV+9jdHTNXafODWywI+A2PqJcan41sAZ2wkPW6hA5RFOr2p2iAvMusLRHX9QffUU
X-Received: by 10.220.159.4 with SMTP id h4mr10664679vcx.1.1400191754567; Thu,
 15 May 2014 15:09:14 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:09:14 -0700 (PDT)
In-Reply-To: <20140515193446.GH26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249209>

On Thu, May 15, 2014 at 12:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Update ref_transaction_update() do some basic error checking and return
>> non-zero on error. Update all callers to check ref_transaction_update() for
>> error. There are currently no conditions in _update that will return error but
>> there will be in the future.
>
> Probably worth passing a 'struct strbuf *err' argument.  Then callers
> can do
>
>                 die("%s", err.buf);
>

Done.

> and the error message can say which ref and whether we were trying to
> create a ref, or delete one, or whatever.
>
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>>       if (*next != line_termination)
>>               die("update %s: extra input: %s", refname, next);
>>
>> -     ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> -                            update_flags, have_old);
>> +     if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> +                                update_flags, have_old))
>> +             die("update %s: failed", refname);
>
> This could say
>
>                 die("update %s: %s", refname, err.buf);

Done.

>
> to give context about which command it was trying to execute.
>
> [...]
>> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>>       if (*next != line_termination)
>>               die("verify %s: extra input: %s", refname, next);
>>
>> -     ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> -                            update_flags, have_old);
>> +     if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> +                                update_flags, have_old))
>> +             die("failed transaction update for %s", refname);
>
> And this could say
>
>                 die("verify %s: %s", refname, err.buf);

Done.

>
> [...]
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -242,12 +242,15 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>>   * be deleted.  If have_old is true, then old_sha1 holds the value
>>   * that the reference should have had before the update, or zeros if
>>   * it must not have existed beforehand.
>> + * Function returns 0 on success and non-zero on failure. A failure to update
>> + * means that the transaction as a whole has failed and will need to be
>> + * rolled back.
>> + */
>
> Thanks for this documentation.
