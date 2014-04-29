From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 15/27] fast-import.c: change update_branch to use ref transactions
Date: Tue, 29 Apr 2014 09:57:16 -0700
Message-ID: <CAL=YDWkD+0=Cy5wjAUtVn8QNtVr3NSaUkRoEnC+QcdRhYG59vA@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-16-git-send-email-sahlberg@google.com>
	<CAPig+cTE9+XHYfnynMykbYf=0kMivj5wFu0Lovnr8XbxyEpsyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBLN-0005wY-W6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 18:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbaD2Q5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 12:57:17 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:57270 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbaD2Q5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 12:57:17 -0400
Received: by mail-vc0-f171.google.com with SMTP id ld13so648188vcb.2
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B9pf44klq6dizLUeAN0nxcG5ebwgc7HJCKnYzJewqJE=;
        b=GGclmx6XT6n7DU6MwMPS40FL/vF57VJaYF4cxW8C+pbP5y2QMeV5dyJVjk9d2IFUXp
         0F+oIaFdwhJ8WFp3Tg29l2oKSAHiSn2JHeIqWKHKuc9fQGFVlSjPGHPvW3SgHtAsKqj1
         2Wi/T42aI/AqA++7ymSZNNbwRJQqpXgY8bt1dpS74O8VXaV/tT0v5sUmMGBLyyoPc5II
         FuHMCvHiqk984AW3t3cE0EwlqcySTclDlPe8eLa/sbVa08zyqMutIMnBiW/mnbs7kuNr
         80lNU59gQAbdHCoeM32FWnDPyYYdB2f1S3cAiYgF63A5IRt8H7DBZP5pL35K3wkhPgid
         fB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B9pf44klq6dizLUeAN0nxcG5ebwgc7HJCKnYzJewqJE=;
        b=VAdGHYNft82j+CPd8TkH0ZJ3jqJpmwbLF2qwKHDL9QVRFxbcDyoOI+A9VFjzNZcrKM
         Fc2Ygd6jMYmGHnMCml85zFMbaunMa0xALe5aIegpQvZDL9HxIXVb3oEWM1QZ5HV/3Jwa
         2OimxLWcH/RK8AtFDZirUcZXrq+I2ccoc92u7XEPmrjwxtgie2pyPf1aA0GyChD54IdU
         L3C4xep7jEsjf6uGP2Y6YZxSHvxyg6irAM5MomUzccHJaxV738X9ktL5g0f1wnC9OYJD
         4RZqbr1JqWn4DqaogwqC9kxDDrYF0W5W2KBzuOR9wZ1L9z2WZa6ER8cvyLugDxKaa8CO
         boOw==
X-Gm-Message-State: ALoCoQka0gXXQuYR2t//V5MlZlSofqrR6dw9ReB0z8YjKE112MCMdNYxE/36Cl+X6XMGmjE/FL5w6ZcZVLXQQ2Gb7F52meM8Hc3tfjEj2IMZ83O/utU4zSH7noiSQvo1AaILYt2Ccg+5BaqCDh1vJYq3NmLG7iF+8BkH48UHwtNAhY/oiXDI2K7IowdBoppJ5izQbr/pr/ax
X-Received: by 10.58.112.98 with SMTP id ip2mr199618veb.35.1398790636439; Tue,
 29 Apr 2014 09:57:16 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 09:57:16 -0700 (PDT)
In-Reply-To: <CAPig+cTE9+XHYfnynMykbYf=0kMivj5wFu0Lovnr8XbxyEpsyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247590>

On Mon, Apr 28, 2014 at 7:18 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> Change update_branch() to use ref transactions for updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  fast-import.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/fast-import.c b/fast-import.c
>> index fb4738d..300c8dc 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1678,36 +1678,40 @@ found_entry:
>>  static int update_branch(struct branch *b)
>>  {
>>         static const char *msg = "fast-import";
>> -       struct ref_lock *lock;
>> +       struct ref_transaction *transaction;
>>         unsigned char old_sha1[20];
>> +       struct strbuf err = STRBUF_INIT;
>>
>>         if (is_null_sha1(b->sha1))
>>                 return 0;
>>         if (read_ref(b->name, old_sha1))
>>                 hashclr(old_sha1);
>> -       lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
>> -       if (!lock)
>> -               return error("Unable to lock %s", b->name);
>>         if (!force_update && !is_null_sha1(old_sha1)) {
>>                 struct commit *old_cmit, *new_cmit;
>>
>>                 old_cmit = lookup_commit_reference_gently(old_sha1, 0);
>>                 new_cmit = lookup_commit_reference_gently(b->sha1, 0);
>>                 if (!old_cmit || !new_cmit) {
>> -                       unlock_ref(lock);
>>                         return error("Branch %s is missing commits.", b->name);
>>                 }
>>
>>                 if (!in_merge_bases(old_cmit, new_cmit)) {
>> -                       unlock_ref(lock);
>>                         warning("Not updating %s"
>>                                 " (new tip %s does not contain %s)",
>>                                 b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
>>                         return -1;
>>                 }
>>         }
>> -       if (write_ref_sha1(lock, b->sha1, msg) < 0)
>> -               return error("Unable to update %s", b->name);
>> +       transaction = ref_transaction_begin();
>> +       if ((!transaction ||
>> +           ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
>> +                                  0, 1)) ||
>> +           (ref_transaction_commit(transaction, msg, &err) &&
>> +            !(transaction = NULL))) {
>> +               ref_transaction_rollback(transaction);
>> +               return error("Unable to update branch %s: %s", b->name,
>> +                            strbuf_detach(&err, NULL));
>
> Iffy strbuf handling. The strbuf content is being leaked here whether
> detached or not.
>

Thanks!

I have updated this and all other patches to make sure we do a
strbuf_release() any time we have
added to the string.

I also did a quick audit of the strbuf_detach() use in builtin/*
(which I based my use on)
and there seems to be quite common that strbuf_detach() is used in a
way that will leak memory.


I will make a note and perhaps audit all the other strbuf_detach()
calls for a future patch series.




>> +       }
>>         return 0;
>>  }
>>
>> --
>> 1.9.1.528.g98b8868.dirty
