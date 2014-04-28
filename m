From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Mon, 28 Apr 2014 12:16:24 -0700
Message-ID: <CAL=YDWkJKOM7eo7cknMH4MAAYJ=Ds9PVjUvufHzrBu=neucf4g@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-17-git-send-email-sahlberg@google.com>
	<535AECC5.3090100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:19:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer4j-0007p4-SQ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbaD1TQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:16:28 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:60804 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaD1TQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:16:26 -0400
Received: by mail-vc0-f172.google.com with SMTP id id10so929965vcb.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=adED8MTr6AD2vffFCC6c56GFx538g8BooUf9M48UVeA=;
        b=EaPWgmgSKOe3LoxQn/iZU8mFBghfwETpBEbVsUGqLSiIWpmVyKvkHfeJO6flxJjdmG
         /5nQywLaSzQkiW08eLZLg+//I3ttY0BVdk+HeG+0vrpBvjvxCD92nVg0XqduB+doXHyg
         LJ9OmRj3wXdyHWI5DZrxEYyNAFf01dffHBqxRYYT6fIS+TrpuBBp6HV4/nc0r8LekS9m
         /UAIqEfBV6aFJFyPRdqz1orkb3/AGL+FZNqkG0IDsKCb7Ox1sEDYZOTis5kLLWoapHbP
         P9S/+tP9upIgtlRKvYqwk4J+FKpsyJ1CmkiMmnFc48lXLFmnPOck25S3i6+r2eb2fMRh
         ZKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=adED8MTr6AD2vffFCC6c56GFx538g8BooUf9M48UVeA=;
        b=akQtuRapt7CYKinU6pb6J1s/RXeYPNSMEpYc/vKDpk4h1Va7rV3WpV3e4kJaF9ezf4
         R+co36J2FqFD+Rp2Zlbp5P2ZMbozn3T9dmbTA5AZm5zrHNLCJR4580zKM51hbIMvC4Wc
         1EM0m3DJk2wcxXM+EtdS8DJSFBk8pwXxhc24DYda43pUEQWV4jH6UpHsecvC3JI8t29z
         CvnGdXUrDU/3CTlTc3/prr7jxZC2KHhjf300X2dZFa64kuLYqsy5HEG0G+0VsZytDIll
         Td1RbaqD/NXN6JpcuBKTXUYsyBvVERj6Tm88nIEXVZb4pUN5ibu0kXCw1O7dmQbolWcR
         jong==
X-Gm-Message-State: ALoCoQk5F95OHSDmTStJoeqdv13cBN+Fk+nP7F9UIg4BsBeCqV/91RGOZLEC+iDEXebjEBRL66/NGWrNavEaCT+G1Tv65pXff5enguXjvb/pHSfeowkV1fnkqoy6x6BepP5D4S3eocWd2cnhIz+M3q5YgZyn8JDdsDBh+FThgUomA0ZualVBuBDFMx+6xKnhF2Rh12Trdq2E
X-Received: by 10.58.49.10 with SMTP id q10mr24584926ven.5.1398712584981; Mon,
 28 Apr 2014 12:16:24 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 12:16:24 -0700 (PDT)
In-Reply-To: <535AECC5.3090100@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247397>

On Fri, Apr 25, 2014 at 4:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>> Change create_branch to use a ref transaction when creating the new branch.
>> ref_transaction_create will check that the ref does not already exist and fail
>> otherwise meaning that we no longer need to keep a lock on the ref during the
>> setup_tracking. This simplifies the code since we can now do the transaction
>> in one single step.
>>
>> If the forcing flag is false then use ref_transaction_create since this will
>> fail if the ref already exist. Otherwise use ref_transaction_update.
>>
>> This also fixes a race condition in the old code where two concurrent
>> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
>> did not protect against the ref already existsing. I.e. one thread could end up
>> overwriting a branch even if the forcing flag is false.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  branch.c | 39 +++++++++++++++++++++++++--------------
>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 660097b..23cde1e 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>>                  int force, int reflog, int clobber_head,
>>                  int quiet, enum branch_track track)
>>  {
>> -     struct ref_lock *lock = NULL;
>>       struct commit *commit;
>>       unsigned char sha1[20];
>>       char *real_ref, msg[PATH_MAX + 20];
>> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>>               die(_("Not a valid branch point: '%s'."), start_name);
>>       hashcpy(sha1, commit->object.sha1);
>>
>> -     if (!dont_change_ref) {
>> -             lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
>> -             if (!lock)
>> -                     die_errno(_("Failed to lock ref for update"));
>> -     }
>> -
>> -     if (reflog)
>> -             log_all_ref_updates = 1;
>> -
>>       if (forcing)
>>               snprintf(msg, sizeof msg, "branch: Reset to %s",
>>                        start_name);
>> @@ -301,13 +291,34 @@ void create_branch(const char *head,
>>               snprintf(msg, sizeof msg, "branch: Created from %s",
>>                        start_name);
>>
>> +     if (reflog)
>> +             log_all_ref_updates = 1;
>> +
>> +     if (!dont_change_ref) {
>> +             struct ref_transaction *transaction;
>> +             char *err = NULL;
>> +
>> +             transaction = ref_transaction_begin();
>> +             if (forcing) {
>> +                     if (!transaction ||
>> +                         ref_transaction_update(transaction, ref.buf, sha1,
>> +                                                NULL, 0, 0) ||
>> +                         ref_transaction_commit(transaction, msg, &err))
>> +                       die_errno(_("%s: failed to write ref: %s"),
>> +                                 ref.buf, err);
>> +             } else {
>> +                     if (!transaction ||
>> +                         ref_transaction_create(transaction, ref.buf, sha1,
>> +                                                0) ||
>> +                         ref_transaction_commit(transaction, msg, &err))
>> +                       die_errno(_("%s: failed to write ref: %s"),
>> +                                 ref.buf, err);
>> +             }
>
> You've got some indentation problems above.
>
> But actually, there seems like a lot of duplicated code here.  Couldn't
> you instead do a single block with have_old set based on forcing:
>
>     ref_transaction_update(transaction, ref.buf, sha1,
>                            null_sha1, 0, !forcing)
>
> ?

Done, thanks.


I am not sure how I feel about using _update to create new refs
since we already have ref_transaction_create for that purpose.

ref_transaction_update can either be used to update an existing ref
or it can be used to create new refs, either by passing have_old==0
or by passing old_sha1==null_sha1 and have_old==1

Maybe the api would be cleaner if we would change it so that update
and create does
not overlap and thus change _update so that it can only modify refs
that must already exist ?



>
>> +     }
>> +
>>       if (real_ref && track)
>>               setup_tracking(ref.buf + 11, real_ref, track, quiet);
>>
>> -     if (!dont_change_ref)
>> -             if (write_ref_sha1(lock, sha1, msg) < 0)
>> -                     die_errno(_("Failed to write ref"));
>> -
>>       strbuf_release(&ref);
>>       free(real_ref);
>>  }
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
