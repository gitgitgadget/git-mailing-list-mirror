From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/8] send-pack.c: add an --atomic-push command line argument
Date: Thu, 30 Oct 2014 14:21:48 -0700
Message-ID: <CAL=YDWkUzC9bJo_iN6sPqS6JkAe7XWxtn99tLQYvfv1qwpBovw@mail.gmail.com>
References: <1413924400-15418-1-git-send-email-sahlberg@google.com>
	<1413924400-15418-3-git-send-email-sahlberg@google.com>
	<xmqqioj1uxx1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjxAH-0002H2-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 22:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934850AbaJ3VVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 17:21:50 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59640 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386AbaJ3VVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 17:21:49 -0400
Received: by mail-qc0-f181.google.com with SMTP id w7so4854948qcr.26
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3E/QRxAJozYm6724NeJzGbH7Nrj0EqRPL5dkpDMDkuU=;
        b=n1aMUTf0upjT7G/IdRido7YJgqVifiywk+PY/qPi7EE2q10OCK5wXl5wKun22Rd1Ni
         VVNhb/NMMXxmT4rndsQJfuaZGyDG1c55VeGsEk0XE9bmAtDky8ebuFBuow1/gEdvazid
         HdViNQ6CwLmkZNt+BPbcn5+CJZlUEZb/XTbhahE+aVargb9zYGFcaO0s7hHHG4arxVxB
         BJ1cDUM6Qab1TBqcF7soyWz05NT3V6Utxqlp/D2uw+WxkZc35kOYYhVl4Tfu/LC4/W1I
         7zU6NTDlXWGuPiP2VlhYYNCRg4mPQnSRgn2MgiGDzbUJ1V/S3C1E7qyWP2TyfN3hzdDM
         98RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3E/QRxAJozYm6724NeJzGbH7Nrj0EqRPL5dkpDMDkuU=;
        b=jH5FVQSGM5XEU9SdSGxzYZGbfIApnvjfU/G1c/HPUwX3MMuIIjXEJXzAVBHZWWauJY
         JJy+UmvHuNaRTkp841ydcYR20zaBXCLcW8g3jFXSqN2XghuEwIoj94p+4KJkr87p3Zgj
         8fbyygJjNXvdK9HW6fFb1AA1LCcaYZ1f+rULEOy5Q2Fdojolni76SGiF/ZYAwU69oEq0
         XJzoojghjHw2qd2jam9ypiZzaqJNduSCUUDcHwdpqml5VVJ2W4socx5YCHC1wcmUIKu9
         N/PbMtRfKCyrJAdb7sbuIapJcv3PK7sErugpu0HzocyqCLbsYx9jHI+zrI0hQZ5b1fjj
         pLEw==
X-Gm-Message-State: ALoCoQljcUkFst5rqitNMSNfNm1d9wBPHXKtHVFQCwlqB6IFXtedCAv6e+5lyjlOCDVUiDn/txxl
X-Received: by 10.224.2.135 with SMTP id 7mr31239344qaj.64.1414704108885; Thu,
 30 Oct 2014 14:21:48 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Thu, 30 Oct 2014 14:21:48 -0700 (PDT)
In-Reply-To: <xmqqioj1uxx1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 30, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
>> index 2a0de42..8f64feb 100644
>> --- a/Documentation/git-send-pack.txt
>> +++ b/Documentation/git-send-pack.txt
>> @@ -9,7 +9,7 @@ git-send-pack - Push objects over Git protocol to another repository
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
>> +'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic-push] [<host>:]<directory> [<ref>...]
>>
>>  DESCRIPTION
>>  -----------
>> @@ -62,6 +62,11 @@ be in a separate packet, and the list must end with a flush packet.
>>       Send a "thin" pack, which records objects in deltified form based
>>       on objects not included in the pack to reduce network traffic.
>>
>> +--atomic-push::
>> +     With atomic-push all refs are updated in one single atomic transaction.
>> +     This means that if any of the refs fails then the entire push will
>> +     fail without changing any refs.
>
> Whenever you say "This means that", please read it twice to see if
> everything before and including that phrase can be removed.  It is a
> sign that you found what you wrote before it is not understandable
> and what follows is the version that would be understood by the
> readers.

I reworded it for the next re-roll.

>
>> @@ -203,6 +203,13 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
>>       case REF_STATUS_REJECT_NEEDS_FORCE:
>>       case REF_STATUS_REJECT_STALE:
>>       case REF_STATUS_REJECT_NODELETE:
>> +             if (atomic_push_failed && args->use_atomic_push) {
>
> Hmph.  Can we even get atomis_push_failed when args->use_atomic_push
> is not set?

It can, but it looks wrong to have one variable passed in via an
argument and the other variable being a global.

I changed it to be
    if (atomic_push_failed) {
instead and only pass in a non-NULL atomic_push_failed by the caller
iff args->use_atomic_push is true.

>
>> +                     fprintf(stderr, "Atomic push is not possible "
>> +                             "for ref %s. Status:%d\n", ref->name,
>> +                             ref->status);
>> +                     *atomic_push_failed = 1;
>> +             }
>> +             /* fallthrough */
>
> Is this "is not possible" (hence we do not let the user use it), or
> "failed" (i.e. we tried and we failed)?
>

I reworded it to say failed instead.

Will be part of next re-roll.

Thanks
Ronnie Sahlberg
