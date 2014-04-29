From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 08/27] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Tue, 29 Apr 2014 09:05:08 -0700
Message-ID: <CAL=YDW=R5LpG-w9zAo9eeop7QqnspcVb8OQmdTOg35sJi9fMyA@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-9-git-send-email-sahlberg@google.com>
	<CAPig+cQM-5_N5caoJVRY0+VcPXO0qhnv7hetdanOoqRQJkm3jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfAXb-000150-At
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 18:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbaD2QFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 12:05:14 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:61667 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618AbaD2QFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 12:05:09 -0400
Received: by mail-vc0-f170.google.com with SMTP id hr9so558889vcb.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zqtNwAlZ/BsPohmYt10A3BDF42RKpK4ad3Hrw5Hy8dg=;
        b=X45Xme2yaf+M5OPuQI1/wdkYtdJqtstA686PqtLiL0+i+AVLnxBB5FjSU7iZqJSnBz
         t4z/Lk/Lo/EW8h0wnLnheGW8Y/XOUztTvH5J2ib51vtSKMeFT86Lx+DtTa3tU+0qqbzK
         6rYdJUSdw4p/2HixzZ23iZUjP3UUpkjLt/s+R9xek5LyrSIQpoCoNyYFn0O2xRPB2iFB
         dR8zuSCraJ445v8YNRV0HlTpDiRTvkogOMD/kfxqeTV1RCjEx81RBm1aGykJZ/gUw4jQ
         BoLdJG5GAhG9Jczs54N9hDCAKg8YIHYN1gpvc+4IWsnj8YJItbXui7kJWjWfTU1wOsK5
         FvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zqtNwAlZ/BsPohmYt10A3BDF42RKpK4ad3Hrw5Hy8dg=;
        b=hHwripIXW88ARjDufx+vFntw9bRylvdfpfbv3Y/jfmRIv5Xt8trMY50tO7t/l/g9Fg
         w9FrZQwTAPiB12P9uJZampeuddUvABELfNNPuLXXBEfDrVF8CTnMuBsaQXEHMDSV0EIQ
         fknqnjgZXyfLm9NtD0HRZiywYnSCAis0VhOuxY2rOXeF7UmB1h6fQaSa/uOG5zVATQTg
         Ur59w3SF5+vX09F4TNfbIYcDw17URZt4M+XFyrlh/aG0PUnJoz1y339ALjAYHL/fjd4y
         LZMGg6NHVUG1isajxwUr+Rnhw94Vf0s9UVdqRt3nVb88yGnUVQPyteqOtnvvtCPYJX5l
         DSmQ==
X-Gm-Message-State: ALoCoQkRBl4moyeFjfS/9z+5Fcvxs4+iubmfvMDz3mE9SmKGakRB10Lzy8XVGbmkDjLd3sjyTTQNKYVOWXCWsTM20q0c/s1tv/nPAcUdMiHjmBsytXJE0LnmrDBsWYslpj0knSgbiMgeo8zTZCKik9CQ2JljzGBrBcHgdo6H3wtm+cE6Q9Q47GtTC8LVHFJBTMLwIPk5R2cN
X-Received: by 10.58.171.229 with SMTP id ax5mr159421vec.24.1398787508508;
 Tue, 29 Apr 2014 09:05:08 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 09:05:08 -0700 (PDT)
In-Reply-To: <CAPig+cQM-5_N5caoJVRY0+VcPXO0qhnv7hetdanOoqRQJkm3jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247587>

On Mon, Apr 28, 2014 at 5:51 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> Update ref_transaction_update() do some basic error checking and return
>> true on error. Update all callers to check ref_transaction_update() for error.
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
>>         if (*next != line_termination)
>>                 die("update %s: extra input: %s", refname, next);
>>
>> -       ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> -                              update_flags, have_old);
>> +       if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> +                                  update_flags, have_old))
>> +               die("update %s: failed", refname);
>>
>>         update_flags = 0;
>>         free(refname);
>> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>>         if (*next != line_termination)
>>                 die("verify %s: extra input: %s", refname, next);
>>
>> -       ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> -                              update_flags, have_old);
>> +       if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
>> +                                  update_flags, have_old))
>> +               die("failed transaction update for %s", refname);
>>
>>         update_flags = 0;
>>         free(refname);
>> diff --git a/refs.c b/refs.c
>> index 308e13e..1a903fb 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>>         return update;
>>  }
>>
>> -void ref_transaction_update(struct ref_transaction *transaction,
>> +int ref_transaction_update(struct ref_transaction *transaction,
>>                             const char *refname,
>>                             const unsigned char *new_sha1,
>>                             const unsigned char *old_sha1,
>>                             int flags, int have_old)
>>  {
>> -       struct ref_update *update = add_update(transaction, refname);
>> +       struct ref_update *update;
>> +
>> +       if (have_old && !old_sha1)
>> +               die("have_old is true but old_sha1 is NULL");
>>
>> +       update = add_update(transaction, refname);
>>         hashcpy(update->new_sha1, new_sha1);
>>         update->flags = flags;
>>         update->have_old = have_old;
>>         if (have_old)
>>                 hashcpy(update->old_sha1, old_sha1);
>> +       return 0;
>
> Am I misreading? The commit message talks about returning true on
> error, but this code seems to only ever die() or return 0 (false).
>

I have updated the commit message to be more precise.
The function returns true on error but there are currently no checks
that actually
do return failure in this function. Such checks will be added in the future.
Also having it return an int instead of void allows us to use the pattern

if(!transaction ||
  ref_transaction_update(transaction, ...) |||
  ref_transaction_commit(transaction, ...)) {

eventhough we do not yet have any conditions where _update will fail.




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
>> -void ref_transaction_update(struct ref_transaction *transaction,
>> -                           const char *refname,
>> -                           const unsigned char *new_sha1,
>> -                           const unsigned char *old_sha1,
>> -                           int flags, int have_old);
>> +int ref_transaction_update(struct ref_transaction *transaction,
>> +                          const char *refname,
>> +                          const unsigned char *new_sha1,
>> +                          const unsigned char *old_sha1,
>> +                          int flags, int have_old);
>>
>>  /*
>>   * Add a reference creation to transaction.  new_sha1 is the value
>> --
>> 1.9.1.528.g98b8868.dirty
