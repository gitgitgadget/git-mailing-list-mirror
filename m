From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 08/42] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Mon, 5 May 2014 16:09:59 -0700
Message-ID: <CAL=YDW=YYHGMsVSUsUKZeWwQ=ScPx66U72tcj8GNApnSopi6Uw@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-9-git-send-email-sahlberg@google.com>
	<53678D41.8010100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 19:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiD6-0007Xo-FY
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbaEEXKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 19:10:01 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:52063 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaEEXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 19:10:00 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so4936164veb.15
        for <git@vger.kernel.org>; Mon, 05 May 2014 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+s1zWqoFO6db/qg5Nlx0QwRAd9v1je93MmtrZnR46Yk=;
        b=SXLOurCrCmjAMYjRzuvUilzSENNlZSlVXw+CrjTw8TTq4lKhvAQFD6m9uZ8B3DBpy7
         SxpjfBFoR5YgxC6yR1V9/QeDfUEh1ASNID7+uMHcgsPzWmwW1PN0UPu3l6icBr+/iTM4
         caJ3KVVzN6WST/qVr7iQyO/8J67FKljZDTRN4MjYEuj7597bKYdxUy4qFQXnlmo9DieD
         0DW0I6i1rsoCviLTP9CikDaq0IZSrB+cONJX8wFQFGuQ0aKzxzUXsAH7SFQrw7wa2TT1
         UeVLygpOBy5CbsP2vJAP5MmXYV22rPfjbYDGjatKn8xW7MG2vwO0fvCl8nI7KQ3uKuZt
         7DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+s1zWqoFO6db/qg5Nlx0QwRAd9v1je93MmtrZnR46Yk=;
        b=k/96nSJGjxBE8B0MOdPq7LxMKsf5oRu+B2gjA+l8DdivJurTVun1Huf83/hRZNYIJH
         A40SHlFlhduJuzZTNAck7AADjGXwLNshwvwregqFrj1AlaRxo8AfCo2DGBvsq6DcWLUj
         r4OWDL25DqhzsaGcCsPwUDktWLA5Esd+dTdTE6hUg33w8LRWOrmQvOTYE7aze9kyBwkq
         cB1piJUqrx2qEfukACFWFkOE5Z0xA/QC4KVY9QDuzu0hHxBkHt1lr1LOW2e3cj3ARA88
         0U6P9WOS0CPkVXBw94bFXGC6A/81KaDUb9JD54pSD+Y/lvRgppq5CzVKI8v7HHPRKiDO
         Z/Hg==
X-Gm-Message-State: ALoCoQkEPx9Gfnioo2u8QGJb87823NSolv5ZSYbZdoAGyjV+ki0v6U0f5Zm+fp+G/B+eGCTAoTdc
X-Received: by 10.220.191.134 with SMTP id dm6mr30486087vcb.16.1399331399607;
 Mon, 05 May 2014 16:09:59 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Mon, 5 May 2014 16:09:59 -0700 (PDT)
In-Reply-To: <53678D41.8010100@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248180>

Thanks!

On Mon, May 5, 2014 at 6:08 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/01/2014 10:37 PM, Ronnie Sahlberg wrote:
>> Update ref_transaction_update() do some basic error checking and return
>> true on error. Update all callers to check ref_transaction_update() for error.
>> There are currently no conditions in _update that will return error but there
>> will be in the future.
>
> I would change s/true/non-zero/, because error return values are not
> just boolean values; the error values sometimes encode the type of error
> that occurred.

Done.

>
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/update-ref.c | 10 ++++++----
>>  refs.c               |  9 +++++++--
>>  refs.h               | 10 +++++-----
>>  3 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 2bef2a0..59c4d6b 100644
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
>>
>>       update_flags = 0;
>>       free(refname);
>> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>>       if (*next != line_termination)
>>               die("verify %s: extra input: %s", refname, next);
>>
>> -     ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> -                            update_flags, have_old);
>> +     if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> +                                update_flags, have_old))
>> +             die("failed transaction update for %s", refname);
>>
>>       update_flags = 0;
>>       free(refname);
>> diff --git a/refs.c b/refs.c
>> index 308e13e..1a903fb 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>>       return update;
>>  }
>>
>> -void ref_transaction_update(struct ref_transaction *transaction,
>> +int ref_transaction_update(struct ref_transaction *transaction,
>>                           const char *refname,
>>                           const unsigned char *new_sha1,
>>                           const unsigned char *old_sha1,
>>                           int flags, int have_old)
>>  {
>> -     struct ref_update *update = add_update(transaction, refname);
>> +     struct ref_update *update;
>> +
>> +     if (have_old && !old_sha1)
>> +             die("have_old is true but old_sha1 is NULL");
>
> This new check is orthogonal to the rest of the patch, isn't it?

Yes.

I have updated the commit message to mention that we also check and
die(BUG:...) for this condition.


>
>>
>> +     update = add_update(transaction, refname);
>>       hashcpy(update->new_sha1, new_sha1);
>>       update->flags = flags;
>>       update->have_old = have_old;
>>       if (have_old)
>>               hashcpy(update->old_sha1, old_sha1);
>> +     return 0;
>>  }
>>
>>  void ref_transaction_create(struct ref_transaction *transaction,
>> diff --git a/refs.h b/refs.h
>> index bc7715e..0364a3e 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>>   * that the reference should have had before the update, or zeros if
>>   * it must not have existed beforehand.
>>   */
>
> Please update the docstring above to explain the return value.

Done.

>
>> -void ref_transaction_update(struct ref_transaction *transaction,
>> -                         const char *refname,
>> -                         const unsigned char *new_sha1,
>> -                         const unsigned char *old_sha1,
>> -                         int flags, int have_old);
>> +int ref_transaction_update(struct ref_transaction *transaction,
>> +                        const char *refname,
>> +                        const unsigned char *new_sha1,
>> +                        const unsigned char *old_sha1,
>> +                        int flags, int have_old);
>>
>>  /*
>>   * Add a reference creation to transaction.  new_sha1 is the value
>>
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
