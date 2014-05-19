From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 07/31] refs.c: add a flag to allow reflog updates to
 truncate the log
Date: Mon, 19 May 2014 16:27:05 -0700
Message-ID: <CAL=YDWn=t_+0Tt7--k1wAfUFXwTpsaEUDgYwdKbDPjmca5xdVA@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-8-git-send-email-sahlberg@google.com>
	<xmqqy4y18lol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 01:27:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWxd-0004sO-E6
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbaESX1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:27:08 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:44571 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaESX1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:27:06 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so10278666vcb.7
        for <git@vger.kernel.org>; Mon, 19 May 2014 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e4FzjFNIANWODw7TVJLmlnCrCykXni7kl2FaMEU1dDQ=;
        b=hKzs7/9uI9OuE69XcnaRwbavZhV7VR7H0nycx2YJQX3dOGHGvtgf0icTIMzsYnEvyf
         HUiot4fUcfSNNZaSGUJ4EoAtzTN+o4MMnWiQ5jDvdD9PBulZAfmtauqGsn9NvZAH8VLt
         B5g+i+XWCEszNtl4+hzRv8auySXKZAVeY293zH0OjAttvvYFANh5UO0bekewg4cSuYL6
         0E3OzKKcG4Va+F9uekpXtHgFAsA5SK441/kpXRuaOsUR7mpFvkCZnTD9lfAYAKjMHV+w
         ce6melAsrEavixfS85Qj48hGAWhxKwfD04WYJwFpIUra1XeA+qA7yLDj1YL8KG/SwhEf
         HHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=e4FzjFNIANWODw7TVJLmlnCrCykXni7kl2FaMEU1dDQ=;
        b=ihJO0reIfA8eDxmJtBq99Lh8+HJ7GXnezzxrOnggwgvCGCuEoh+fEr9ctQrwOc7DNe
         dlEQapf8T8Fd6kltdvNct1XHlLtNejQ2fp6iPl6+nyqJiwNQwCQdYeZI5nqMjn4ZGG6f
         j8Vjm/p9Qpt84sJs7lr+/buOX3LuMlptB9bKO/veZq1pj354gIGT+UZZc5XIX70UmKxY
         B0DxRVq+W/RahWxkFSEFDiIRNNZkKHfV5jSKf3RQNapEkTwW9h2+xP4BTHWEHQ0buTEE
         5Tk9CGFu6ruIcDVI8PCRfZCiXEk2uyfhQLvvIvE2wd8WbuIW94ue5BZ97ahm2EP+C0lA
         8Gww==
X-Gm-Message-State: ALoCoQm67CnslUhikuRDDng9I2BX1ci8ydTO+6jAXFnO62C7EqvG2mYzJhGeZ9tapcSqHbY5NUHg
X-Received: by 10.52.248.41 with SMTP id yj9mr634136vdc.22.1400542025720; Mon,
 19 May 2014 16:27:05 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 16:27:05 -0700 (PDT)
In-Reply-To: <xmqqy4y18lol.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249638>

On Fri, May 16, 2014 at 2:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Add a flag that allows us to truncate the reflog before we write the update.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>
> Until we read the callers it is hard to see how such a feature is
> useful, though.

Shortly later in the series comes the update to builtin/reflog.c which
uses this feature.
Even later in the series I also use this in builtin/reflog.c to both
do the ref update as well as the corresponding reflog updates all in
one single transaction.


>
> (style) The two multi-line comments are formatted differently.

Fixed. Thanks.

>
>>  refs.c | 12 ++++++++++--
>>  refs.h |  4 +++-
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index d8a1568..a8b583a 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3608,7 +3608,11 @@ int transaction_commit(struct ref_transaction *transaction,
>>               }
>>       }
>>
>> -     /* Update all reflog files */
>> +     /* Update all reflog files
>> +        We have already done all ref updates and deletes.
>> +        There is not much we can do here if there are any reflog
>> +        update errors, other than complain.
>> +     */
>>       for (i = 0; i < n; i++) {
>>               struct ref_update *update = updates[i];
>>
>> @@ -3616,7 +3620,11 @@ int transaction_commit(struct ref_transaction *transaction,
>>                       continue;
>>               if (update->reflog_fd == -1)
>>                       continue;
>> -
>> +             if (update->flags & REFLOG_TRUNCATE)
>> +                     if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
>> +                         ftruncate(update->reflog_fd, 0)) {
>> +                             error("Could not truncate reflog");
>> +                     }
>
> The {} looks somewhat curious here.  If you seeked to the beginning,
> and failed to truncate, do you still want to go on without "return"
> in front of the error()?  Would that overwrite existing entries?

I have changed it to do this :
+               if (update->flags & REFLOG_TRUNCATE)
+                       if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+                               ftruncate(update->reflog_fd, 0)) {
+                               error("Could not truncate reflog: %s",
+                                     update->refname);
+                               rollback_lock_file(&update->reflog_lock);
+                               update->reflog_fd = -1;
+                       }


At this point we have already committed all the changes to refs and
also performed all unlinks for refs we are deleting. So if things
start to go wrong here during the reflog updates it is too late to do
much more than complain.


>
>>               if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
>>                                    update->new_sha1,
>>                                    update->committer, update->msg)) {
>> diff --git a/refs.h b/refs.h
>> index 2e22a26..b1b97e7 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -269,8 +269,10 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
>>                           const unsigned char *old_sha1,
>>                           int flags, int have_old, const char *msg);
>>
>> +#define REFLOG_TRUNCATE 0x01
>>  /*
>> - * Append a reflog entry for refname.
>> + * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>> + * this update will first truncate the reflog before writing the entry.
>>   */
>>  int transaction_update_reflog(struct ref_transaction *transaction,
>>                             const char *refname,
