From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 12/27] replace.c: use the ref transaction functions for updates
Date: Tue, 29 Apr 2014 09:18:25 -0700
Message-ID: <CAL=YDWn9TJsygZdgY2gXVBScFjO3zbrbJ5XORc2ZLaY-M8PmSw@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-13-git-send-email-sahlberg@google.com>
	<CAPig+cSWMK_kyVvaD8QCfZmPu4JVT+nOJZJLteHhDao0umHLbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:18:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfAjt-0006Mu-7d
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 18:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044AbaD2QS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 12:18:27 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:38628 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757458AbaD2QS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 12:18:26 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so553133veb.38
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WkkW28cxtf6qKV48bmwYPq0NmX+TKXb9b+z9PTINAAI=;
        b=C1rXiziiT726ad9l+/XCwdMmpR6GmsEqxG7cnO1OuBFfzs9tZQDPsvgVTdbeEHBFqE
         zUnMmBQ6xV1VmCAMufvhL0EuB9h2CykH7qVqOUgdF1cdbuCTu3lFNJSVsVykuM9g3KbK
         wHmlzrzfrrMiCby+js6s4Gcpvfnr02YMOMBB/ja4aoO1QPXZ49kX5wFw9pYO0OBNlZTE
         /8/X/AbrCIWaLX/FIZhoJgH7xLFT+AtAR9F36LeUxVXIBrfPPXEJ8GQV3nwa9Gg9LCg+
         eHKdVmSOwfZ9GQOlOdu3f1caVbdXos9UDcvbmz37D0F46d1rp2W0NjIC+1yJ9zqQE43q
         iHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WkkW28cxtf6qKV48bmwYPq0NmX+TKXb9b+z9PTINAAI=;
        b=j5gIJ4BOG6Kd9LpwD9yNQb0VR0yEzoTp9NCZGhJbxbsLW+6N5ddVM5iJYcw/6x8vB7
         jHq1Yr/HjMw9CcHqgArn5S317pe6JV/eCdy4BXgofrwWnnYSMu2cR+4RghPA41bnyg7G
         Pmr8/tY4uEzcT/cPyzg6vBz6smHv9dGfVUTCmSoBGj1ABHBW9fXhorJTmhkmHl5QGsG/
         fDupnwM4RV25ylbkSdwT2JT4KkZfZQgyLDrA8D+RzkKeQ/Xrpn3UgRwmXA2Gf/EbKmp6
         ByBdYOLNctQ/sClct5iV9XCt18yr0A/ySNJrrOjwlGuweXlxogrLwiym+VBcqyfKcwGH
         V5DQ==
X-Gm-Message-State: ALoCoQm+h27+t8NONhPy3QEHdvf9GiheJf3Dl8WevZo2Qur1QwDdINy7uQrDxrBJBW/Jx8qXKHBS4jgLkMoodfFQYXy+8qtrE6LbCvEjV9o22elrktSo8fRElYzjKl8X7vHRauj4MEg4kgdUCUPn5LD8NjW+V7eXPvnjhjEdp+A77Cw+j87dLh3qNTo8eyAO3ONg/suzpGzz
X-Received: by 10.52.237.228 with SMTP id vf4mr663680vdc.47.1398788305747;
 Tue, 29 Apr 2014 09:18:25 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Tue, 29 Apr 2014 09:18:25 -0700 (PDT)
In-Reply-To: <CAPig+cSWMK_kyVvaD8QCfZmPu4JVT+nOJZJLteHhDao0umHLbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247588>

On Mon, Apr 28, 2014 at 5:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> Update replace.c to use ref transactions for updates.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/replace.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index b62420a..b037b29 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>         unsigned char object[20], prev[20], repl[20];
>>         enum object_type obj_type, repl_type;
>>         char ref[PATH_MAX];
>> -       struct ref_lock *lock;
>> +       struct ref_transaction *transaction;
>> +       struct strbuf err = STRBUF_INIT;
>>
>>         if (get_sha1(object_ref, object))
>>                 die("Failed to resolve '%s' as a valid ref.", object_ref);
>> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>         else if (!force)
>>                 die("replace ref '%s' already exists", ref);
>>
>> -       lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>> -       if (!lock)
>> -               die("%s: cannot lock the ref", ref);
>> -       if (write_ref_sha1(lock, repl, NULL) < 0)
>> -               die("%s: cannot update the ref", ref);
>> +       transaction = ref_transaction_begin();
>> +       if (!transaction ||
>> +           ref_transaction_update(transaction, ref, repl, prev,
>> +                                  0, !is_null_sha1(prev)) ||
>> +           ref_transaction_commit(transaction, NULL, &err))
>> +               die(_("%s: failed to replace ref: %s"), ref, err.buf);
>
> Even though 'err' will be empty after this conditional, would
> strbuf_release(&err) here be warranted to future-proof it? Today's
> implementation of strbuf will not have allocated any memory, but
> perhaps a future change might pre-allocate (unlikely though that is),
> which would leak here.


Thanks.


I have no strong feelings either way.
A previous patch got a comment to remove a strbuf_release() because we
knew in that
code path that the string would be empty and thus the call was superfluous.

So one for and one against so far.
I will leave as is until there is more consensus.



>
>>         return 0;
>>  }
>> --
>> 1.9.1.528.g98b8868.dirty
