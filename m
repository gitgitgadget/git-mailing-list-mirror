From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 25/48] replace.c: use the ref transaction functions
 for updates
Date: Mon, 14 Jul 2014 14:19:59 -0700
Message-ID: <CAL=YDWng3eBnbUAGVBoESio6d75Lz47oY3ntLFa1ktY2513bXg@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-26-git-send-email-sahlberg@google.com>
	<53BBE578.9030703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:20:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nfJ-0002i2-VI
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 23:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbaGNVUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 17:20:01 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:56299 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbaGNVUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 17:20:00 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so8308755vcb.24
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=glkUfp5bIMrmvfoLdcQ1i/fedehVSVeuJCwI9fKfIWA=;
        b=STgG6Kf/zldv7sDF8Wjr6podTCGV80Y4CztVdE96CkDyYD2wc2ZRxQgPK5FNgypQvM
         ZSZXwCNPmKRDx8vxJdvRgv0/gS/lF4egpGuqPduILbd7ZWskp8cvIn4JsiFlNKbSiVJw
         isdsafus9vein6kTxWzx/I5aPjF4bLNUqGcDdNgj8A6vTUs8fPaopoxNof/adtpcFhw5
         ps8Zga+E2JQxGOguxsn82Y2kes9rfR1mOqTNRanDtcpkfyxFnubZNaWVOr/YvU/GLohF
         Ar/waR7/KTuqR405epCWT7TLizVQ0/zp/QJRZASjQhuRXkFMYIxhwjk3mq5xaRmSGUf5
         bFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=glkUfp5bIMrmvfoLdcQ1i/fedehVSVeuJCwI9fKfIWA=;
        b=HapOvaT9zH/t7DcI5Fz5w9F9biAJtpPlEzTjI3eIGgndgKETG5DBg4eISQ5b/t8xcr
         3aCSortE+E7wTb/FQNgXWjINAyFe8MLVE0BhYo/W3pI8qA7/n7glmWPT1MQBWj4PKUS3
         xSxDdTqq4ZenclAqgIAFr0QT3ntzk7f/RmjxWrk4jUQlk9oYgZC7hND3hyYxxjf7tYQD
         EYkp/LxiLaHt+LrVlRI7zIiqlUGa0Ck+8229gUtvh1DAX4ercTdb12IByYoPvwoAfZmO
         JGIJaruo4EDjQsLVwJW7qYf8RcSC1R5/bomOho7d/c8yayeuHfg552ikGV26y27BAmON
         H80w==
X-Gm-Message-State: ALoCoQliLO4y0TWkXc5TtDHkEPw6XUDhlpO5AKcMbCdpSV2Y380tBxN04u3HmHt6TZZC+iyef2Rk
X-Received: by 10.58.212.2 with SMTP id ng2mr2729096vec.33.1405372799451; Mon,
 14 Jul 2014 14:19:59 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 14:19:59 -0700 (PDT)
In-Reply-To: <53BBE578.9030703@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253538>

On Tue, Jul 8, 2014 at 5:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Update replace.c to use ref transactions for updates.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/replace.c | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index 1bb491d..7528f3d 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
>>       unsigned char prev[20];
>>       enum object_type obj_type, repl_type;
>>       char ref[PATH_MAX];
>> -     struct ref_lock *lock;
>> +     struct ref_transaction *transaction;
>> +     struct strbuf err = STRBUF_INIT;
>>
>>       obj_type = sha1_object_info(object, NULL);
>>       repl_type = sha1_object_info(repl, NULL);
>> @@ -166,12 +167,14 @@ static int replace_object_sha1(const char *object_ref,
>>
>>       check_ref_valid(object, prev, ref, sizeof(ref), force);
>>
>> -     lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>> -     if (!lock)
>> -             die("%s: cannot lock the ref", ref);
>> -     if (write_ref_sha1(lock, repl, NULL) < 0)
>> -             die("%s: cannot update the ref", ref);
>> +     transaction = ref_transaction_begin(&err);
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref, repl, prev,
>> +                                0, !is_null_sha1(prev), &err) ||
>
> Same problem here.  You need
>
>     s/!is_null_sha1(prev)/1/
>

I think we need it.
prev can be null_sha1 here if check_ref_valid fails to resolve the ref.


>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die("%s", err.buf);
>>
>> +     ref_transaction_free(transaction);
>>       return 0;
>>  }
>>
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
