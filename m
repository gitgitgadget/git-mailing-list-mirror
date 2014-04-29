From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 16/19] branch.c: use ref transaction for all ref updates
Date: Tue, 29 Apr 2014 08:11:02 -0700
Message-ID: <CAL=YDWnav-26kBmmJ+XJq-hQEkdv3UUdz6wQ5Jn-cq+H8Ozb+g@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-17-git-send-email-sahlberg@google.com>
	<535AECC5.3090100@alum.mit.edu>
	<CAL=YDWkJKOM7eo7cknMH4MAAYJ=Ds9PVjUvufHzrBu=neucf4g@mail.gmail.com>
	<535F725B.5000102@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 29 17:11:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf9gc-0000Ws-F3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 17:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbaD2PLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 11:11:05 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35431 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaD2PLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 11:11:03 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so451159vcb.19
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8dDzbLRDaLWcLpwKPX6DGqS07ePe6q31j65vgqmA//M=;
        b=nvyNtrWIR5fAuAcXfndrqgJ7hd9Rb7bqjj83vGgVga1ezAv1y4wfMS2MMJkmajOmdb
         T+Cby4hXFfae8wwpeVX/7AWo0ge1hLea+GEp3IEAQ6gLJNQ0c4zUs846AhWylgRfKmRz
         2mOa+Dwo2G5bUb6I50+viXN53fVwGKpZ4UzZav/puO8YRNmNOVt+t/k5oyYnviQOlis/
         uA75Jds0Wk3nkyC/3lB4wxerUJh4p7pJhOmwfygYh4H6W8SzanLpPxraHkJhoWS3tHDB
         c5gNJvyW1LxXInqZQjf+wVINJCWABSjfEpsMl530ZnVipCB4ro5HzBYtjVIOZDF0loku
         QHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8dDzbLRDaLWcLpwKPX6DGqS07ePe6q31j65vgqmA//M=;
        b=T9v7DsksA+q21YBcEsAnT9yxudrMpvLfVLp6z0TcsIhA4GBQSSslC7GCzqIhVoiceD
         zkuVnIyX/xtnLxgJ0CXuc3NNiQIq9xB9rhnBOseEQa5m3J7NY6/Klz+0rMKly6flqkpm
         5pdKkCQoVfWkKAJtBpPULbPizGw/n28C3XVP569vG25CYaM8exsxSQm06KmXaYa2wqd0
         tgskWsHP4KK/YxeA8k2Pe62H0xIaG9HHezNE0bTiy71eU5rFxI68TYqY2YIGeFWCHMEi
         6cLY3WDAYFCBovXaM1Zxeobrjv95JJxK+6fhIdBGmTfkWltxdjdith0E+xQy2l1Ws9kA
         AQyA==
X-Gm-Message-State: ALoCoQnEAZRYOGxOJekzdXP3m3FS8fA6PIdxGXKhpV/M4fPq1ZTuL2qN0Q43oVbdBIX1BYcTeiENEWpADMt+IZzcyJYfgrZpG2chhwDuiDnPGOi5l9ElywNqjbWKVn/vjgZhEWdUzbvA6Zp5r8R7NyVsHOEH0VLE9PTwdrt1Z6ZvFa8vh2fxO7fKO3cZSrgXHmnPNqUXfll+
X-Received: by 10.52.119.178 with SMTP id kv18mr1155422vdb.39.1398784262096;
 Tue, 29 Apr 2014 08:11:02 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 08:11:02 -0700 (PDT)
In-Reply-To: <535F725B.5000102@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247586>

On Tue, Apr 29, 2014 at 2:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/28/2014 09:16 PM, Ronnie Sahlberg wrote:
>> On Fri, Apr 25, 2014 at 4:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>>>> Change create_branch to use a ref transaction when creating the new branch.
>>>> ref_transaction_create will check that the ref does not already exist and fail
>>>> otherwise meaning that we no longer need to keep a lock on the ref during the
>>>> setup_tracking. This simplifies the code since we can now do the transaction
>>>> in one single step.
>>>>
>>>> If the forcing flag is false then use ref_transaction_create since this will
>>>> fail if the ref already exist. Otherwise use ref_transaction_update.
>>>>
>>>> This also fixes a race condition in the old code where two concurrent
>>>> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
>>>> did not protect against the ref already existsing. I.e. one thread could end up
>>>> overwriting a branch even if the forcing flag is false.
>>>>
>>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>>> ---
>>>>  branch.c | 39 +++++++++++++++++++++++++--------------
>>>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/branch.c b/branch.c
>>>> index 660097b..23cde1e 100644
>>>> --- a/branch.c
>>>> +++ b/branch.c
>>>> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>>>>                  int force, int reflog, int clobber_head,
>>>>                  int quiet, enum branch_track track)
>>>>  {
>>>> -     struct ref_lock *lock = NULL;
>>>>       struct commit *commit;
>>>>       unsigned char sha1[20];
>>>>       char *real_ref, msg[PATH_MAX + 20];
>>>> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>>>>               die(_("Not a valid branch point: '%s'."), start_name);
>>>>       hashcpy(sha1, commit->object.sha1);
>>>>
>>>> -     if (!dont_change_ref) {
>>>> -             lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
>>>> -             if (!lock)
>>>> -                     die_errno(_("Failed to lock ref for update"));
>>>> -     }
>>>> -
>>>> -     if (reflog)
>>>> -             log_all_ref_updates = 1;
>>>> -
>>>>       if (forcing)
>>>>               snprintf(msg, sizeof msg, "branch: Reset to %s",
>>>>                        start_name);
>>>> @@ -301,13 +291,34 @@ void create_branch(const char *head,
>>>>               snprintf(msg, sizeof msg, "branch: Created from %s",
>>>>                        start_name);
>>>>
>>>> +     if (reflog)
>>>> +             log_all_ref_updates = 1;
>>>> +
>>>> +     if (!dont_change_ref) {
>>>> +             struct ref_transaction *transaction;
>>>> +             char *err = NULL;
>>>> +
>>>> +             transaction = ref_transaction_begin();
>>>> +             if (forcing) {
>>>> +                     if (!transaction ||
>>>> +                         ref_transaction_update(transaction, ref.buf, sha1,
>>>> +                                                NULL, 0, 0) ||
>>>> +                         ref_transaction_commit(transaction, msg, &err))
>>>> +                       die_errno(_("%s: failed to write ref: %s"),
>>>> +                                 ref.buf, err);
>>>> +             } else {
>>>> +                     if (!transaction ||
>>>> +                         ref_transaction_create(transaction, ref.buf, sha1,
>>>> +                                                0) ||
>>>> +                         ref_transaction_commit(transaction, msg, &err))
>>>> +                       die_errno(_("%s: failed to write ref: %s"),
>>>> +                                 ref.buf, err);
>>>> +             }
>>>
>>> You've got some indentation problems above.
>>>
>>> But actually, there seems like a lot of duplicated code here.  Couldn't
>>> you instead do a single block with have_old set based on forcing:
>>>
>>>     ref_transaction_update(transaction, ref.buf, sha1,
>>>                            null_sha1, 0, !forcing)
>>>
>>> ?
>>
>> Done, thanks.
>>
>>
>> I am not sure how I feel about using _update to create new refs
>> since we already have ref_transaction_create for that purpose.
>>
>> ref_transaction_update can either be used to update an existing ref
>> or it can be used to create new refs, either by passing have_old==0
>> or by passing old_sha1==null_sha1 and have_old==1
>
> Hold onto your socks then, because I think in the future update() should
> get a have_new parameter too.  That way it can also be used to verify
> the current value of a reference by passing have_old=1, have_new=0
> without also re-setting the reference unnecessarily like now.  Though I
> admit, have_old=have_new=0 might *not* be so useful :-)
>
>> Maybe the api would be cleaner if we would change it so that update
>> and create does
>> not overlap and thus change _update so that it can only modify refs
>> that must already exist ?
>
> I have no compunctions about using update() to create or delete a
> reference.  My point of view is that update() is the general case, and
> create() and delete() are special-cases that exist only for the
> convenience of callers.  For example, our future pluggable backends
> might only have to implement update(), and the other two functions could
> delegate to it at the abstract layer.
>
> Plus, making this stricter would make it impossible to eliminate
> duplicate code like in the example above, which is itself evidence that
> update() is a useful abstraction.
>

Ok, Fair enough.
In that case, in the future we should change
ref_transaction_create/ref_transaction_delete to just
become wrappers that invoke ref_transaction_update.


> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
