From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] refs.c: enable large transactions
Date: Wed, 22 Apr 2015 12:09:43 -0700
Message-ID: <CAGZ79kbb=UUVq8np-ndiMS_id5GaBHpDafDe9ZB3TvsK3xYe_g@mail.gmail.com>
References: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>
	<1429643171-27530-1-git-send-email-sbeller@google.com>
	<5537AC00.5060208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl01x-0004Ym-9G
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966047AbbDVTJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:09:47 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36278 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966025AbbDVTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:09:44 -0400
Received: by iebrs15 with SMTP id rs15so45047614ieb.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JNdWoFYlqWbFa3iSUC3yeCs8JEeBktrGkJg5lyVVjz4=;
        b=Aq3DqGZ7nbZuzvoNIBz0nvTwO/gNjLBnVuI2rv/2aiS5qTqD73qeuuH1kdmgs17Crm
         bR10OZ5aok9PeO2PHDFVNEPhA8cfKduUmSibrOLaB40Gyys+rJDQkVyfLH2Kg3vVRxe/
         nirnmwOS33cjt6xlL7LnE8iEHOwtEuLwoCm6DOmtfsUN9QQMSH82upAO7TgyzHabnRah
         WHApVZqRDsi0lzlV7MyFXXdFA9wHQPUoX2Tl8g9i7Bjo/4NE4GROhNNs8RYKm3ViSdt/
         l63yEF0LqU/zart5HTQO5ZnUuJoVRq2QLniwihg7tiRk0rGZ5uVLVkl/PW9HwCLcsyPF
         rcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JNdWoFYlqWbFa3iSUC3yeCs8JEeBktrGkJg5lyVVjz4=;
        b=CcLV6ibR7+KXjitF1RMUsfbAw6tdLDsxU0Zc4g8CXoKfLwmyQsHO28U1Z12j4QrRTK
         2x5CYz6VpIwDa4Sxy76pA9ZOU05XYEZAjncDp4ln61f+DJHD1TgQFAjkBQM7dUKYeo+z
         lJ7RcNG8+XcBDJb7q9tLsWCZ/6P2m0snFdGlPbJEOIZAjoFHFm0gLdaSTJjTXroarF+5
         OzMan79F3mzjKFYWGDYCgQfccSrIIkwvx2JY3Ea8Lj3jSplSAFyIxRjWzQaULtKifqsz
         Fz7PQB1rjJFw9jrYxnsZUfvbdv0Pz5vI240mOIuGXr3+QrUsGrBBeP8yUZ0dSqkppLEh
         DJQA==
X-Gm-Message-State: ALoCoQmq8eJ/I7VGvGfjfuPAygZKJagqBMvnGPrHhGN+ePrUZkQIiwhDCDMLyELDaSRRVeXXKDRg
X-Received: by 10.42.30.141 with SMTP id v13mr11814605icc.76.1429729783694;
 Wed, 22 Apr 2015 12:09:43 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 22 Apr 2015 12:09:43 -0700 (PDT)
In-Reply-To: <5537AC00.5060208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267611>

On Wed, Apr 22, 2015 at 7:11 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> +     if (lock->lk->fd == -1)
>> +             reopen_lock_file(lock->lk);
>
> You should check that reopen_lock_file() was successful.

ok


>> @@ -3762,6 +3779,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                   update->refname);
>>                       goto cleanup;
>>               }
>> +             if (remaining_fds > 0)
>> +                     remaining_fds--;
>> +             else
>> +                     close_lock_file(update->lock->lk);
>
> I consider this code a stopgap, and simplicity is more important than
> optimization.

Can you explain a bit why you think this is a stopgap?

Looking at the patch this looks simple to me, as there are no
huge pain points involved. (Compared to [1] as we'd change a lot in
that series)

Also this is pretty good on performance.
The small cases do not have an additional unneeded close and reopen,
but only the
larger cases do.

[1] http://git.661346.n2.nabble.com/PATCHv1-0-6-Fix-bug-in-large-transactions-tt7624363.html#a7624368




> But just for the sake of discussion, if we planned to keep
> this code around, it could be improved by not wasting open file
> descriptors for references that are only being verified or deleted, like so:

I'll pick that up for the resend.
