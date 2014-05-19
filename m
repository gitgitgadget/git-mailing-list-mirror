From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 14/44] replace.c: use the ref transaction functions
 for updates
Date: Mon, 19 May 2014 11:04:56 -0700
Message-ID: <CAL=YDWmfudx0qVh_pV_14FE2EyHsHF1HHemCQ9h5f=5V8rVY7A@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-15-git-send-email-sahlberg@google.com>
	<537760B4.4010904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 20:05:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRvq-00063F-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 20:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaESSE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 14:04:58 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:38807 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaESSE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 14:04:57 -0400
Received: by mail-vc0-f170.google.com with SMTP id lf12so10136447vcb.1
        for <git@vger.kernel.org>; Mon, 19 May 2014 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gfdqmU1ilAEkR/Kk+PMd5qVIaNa8cGqTeQDNx38nWec=;
        b=RHY6fPXbPMjkygpl/quKKIeumcu1SyzX1lqtACbOkU2eMQ4sCyT7FEqXM0QRFTGTV0
         eyNOzXX+0+CVSDXfMrNcD/0Wolw2mG2qXXSzekr5knBdo+QQUF4tTgXFoClFeS8QLr01
         4MbC6ZX8YZl70Og1Jvtnbjvz7fs+0O6w9XLXnRnAjc3/kpWYN5jSYDuvO5tMQ+4HjZDN
         M797xJO6tjw1jmTvvoPUxIG4fpV0dlJdGrdWnAyLh5dmFGy2r7nU6OazbrtVZ8rKkN2d
         +EsQN+gA0GgXs7RACTzhDkYe8iSpHFgNdID1dI1a8PS/s29Qa8Md10A4el3ZAvpbVPHt
         f/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gfdqmU1ilAEkR/Kk+PMd5qVIaNa8cGqTeQDNx38nWec=;
        b=HBeenPz7/Mg22cbk27XdXleGmrxXu5a9edUt/KPRlsi2HQmOki67L25R0W4izue+3D
         DQXpivlJzN+zpmiRIzsAFD6URxLD8UIaFLWddkx22h5wS1FpKtfp8wQVe7VozZH9iUse
         uKAR7hQDjKox2VB//iNHVbhsupECLfCFRlGBxPrCSUolSlV5qY8FXN4Tek24BuA3eTkK
         WG2zNuTRwX0Y6tsBic8lsFWthHxHXsWl9yh0H5NvDpqBapO7IWeVdccNUkqZT4kFBEb7
         sk/AA0Q2S/UzmVj9pfimDabyktEnvkf1z3+lpK7iNKoHtDQwcyOq/nsAQoc6Q9ZLVjnG
         +yYA==
X-Gm-Message-State: ALoCoQlr6oO0kylXHBPF2gY0SBMK1Ye6yC9Oobt67xmRwttAZE8rvDD/0p/VxaY70UCckvslOiIf
X-Received: by 10.58.48.201 with SMTP id o9mr32430029ven.5.1400522696311; Mon,
 19 May 2014 11:04:56 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 11:04:56 -0700 (PDT)
In-Reply-To: <537760B4.4010904@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249609>

I have moved the patch to add an err argument to this branch and
update all patches that adds
calls to ref_Transaction_begin to the new signature.

Please see
https://github.com/rsahlberg/git/tree/ref-transactions

Thanks!


On Sat, May 17, 2014 at 6:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> Update replace.c to use ref transactions for updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/replace.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index 3da1bae..e8932cd 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -133,7 +133,8 @@ static int replace_object_sha1(const char *object_ref,
>>       unsigned char prev[20];
>>       enum object_type obj_type, repl_type;
>>       char ref[PATH_MAX];
>> -     struct ref_lock *lock;
>> +     struct ref_transaction *transaction;
>> +     struct strbuf err = STRBUF_INIT;
>>
>>       if (snprintf(ref, sizeof(ref),
>>                    "refs/replace/%s",
>> @@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
>>       else if (!force)
>>               die("replace ref '%s' already exists", ref);
>>
>> -     lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>> -     if (!lock)
>> -             die("%s: cannot lock the ref", ref);
>> -     if (write_ref_sha1(lock, repl, NULL) < 0)
>> -             die("%s: cannot update the ref", ref);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref, repl, prev,
>> +                                0, !is_null_sha1(prev), &err) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die("%s", err.buf);
>
> Same here: err can be empty if ref_transaction_begin() fails.  Please
> check later patches for the same error.
>
>>
>>       return 0;
>>  }
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
