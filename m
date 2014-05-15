From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 08/42] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Thu, 15 May 2014 09:06:50 -0700
Message-ID: <CAL=YDW=e1FdVn5cHvRHPQrA8ywPne-uZk_iYNO4EmxJEA=fHSw@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-9-git-send-email-sahlberg@google.com>
	<20140514234015.GE9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyBN-0004Tw-N5
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbaEOQGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:06:53 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:63710 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbaEOQGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:06:52 -0400
Received: by mail-ve0-f176.google.com with SMTP id jz11so1554560veb.21
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LG//m9a8OMtq2x+LuuvoaZslkp9JJauWlk3n3OHtmHQ=;
        b=K7Lfh6URtRjgQ7lo7ODXm2l6QsH54ezOI4xtOjj2pABS/4eFK+0JTGBEc9KFC8iSv/
         uYE5lykYC76w7azRbubbDVSCRaqOdmn0qXAUA7Kzui3wVk/+YRnyRtDjsHDqFJovqte2
         H8iY8H2g/7HTRLvScBHEMcUe4WlA4kdUij0DT/DgAjchZx7XzadGp3CUfDg9QAigxnPL
         vp73gf8LteBQtHssr8E1KPf6ppEhwkVLHlfRYK2gcwqbNkNa4MO1arW5LeosORbHPDc6
         OdiORGxFUHEyI7GioIZ8YN5tp9kXM0gl4K95ULZ0qVvBCDvoHnVkYmNO/jmqkN1cYTf5
         0dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LG//m9a8OMtq2x+LuuvoaZslkp9JJauWlk3n3OHtmHQ=;
        b=cEoHkm/hKDNLQq5Bn6vw9Elw2WMaY+GVbjwrHh242J9goICfnEGQ6yw/U9kSzczrkN
         xCoCvOd0A19Z2rfWBNs65vDF7sXGZTy5AM9YYC3L0nPAgl9nkLw3kgCvryizWcp891xp
         L5E5HyYqv72F6YFrWVK77hSswTTpTI1HcIAchVRnfFafqjVXJl3LcfUzYaR3rfkF8Iz8
         H0r27n3jOVmQxEezykOl8eh8lOzBzRC8m4gsbCQVX2VqErpvmo7ezaEl3xTMpO5TAfFG
         utXbD2Wqb+XP5GFXfuOT1+RnzuiPUiCrdoIHBmow1/AEjXDhKFrjFJfLis4LJJQmNHF/
         zBqA==
X-Gm-Message-State: ALoCoQn7kpw9ylwPMX/iTxJ3FyVAQZ+gzxwsGTiKr6BEDYyfUfpcY75mB2J7q2AOMC0aDq3NebTK
X-Received: by 10.220.47.201 with SMTP id o9mr910024vcf.65.1400170010954; Thu,
 15 May 2014 09:06:50 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:06:50 -0700 (PDT)
In-Reply-To: <20140514234015.GE9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249105>

On Wed, May 14, 2014 at 4:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Update ref_transaction_update() do some basic error checking and return
>> true on error. Update all callers to check ref_transaction_update() for error.
>> There are currently no conditions in _update that will return error but there
>> will be in the future.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/update-ref.c | 10 ++++++----
>>  refs.c               |  9 +++++++--
>>  refs.h               | 10 +++++-----
>>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> Revisiting comments from [1]:
>
>  * When I call ref_transaction_update, what does it mean that I get
>    a nonzero return value?  Does it mean the _update failed and had
>    no effect?  What will I want to do next: should I try again or
>    print an error and exit?

It means the transaction will no longer work and must be rolled back.
See below for the updated text I added to refs.h

>
>    Ideally I should be able to answer these questions by reading
>    the signature of ref_transaction_update and the comment documenting
>    it.  The comment doesn't say anything about what errors
>    mean here.

I have updated the description to include :
 * Function returns 0 on success and non-zero on failure. A failure to update
 * means that the transaction as a whole has failed and will need to be
 * rolled back.


>
>  * the error message change for the have_old && !old_sha1 case (to add
>    "BUG:" so users know the impossible has happened and translators
>    know not to bother with it) seems to have snuck ahead into patch 28
>    (refs.c: add transaction.status and track OPEN/CLOSED/ERROR).

Done.

>
>  * It would be easier to make sense of the error path (does the error
>    message have enough information?  Will the user be bewildered?)
>    if there were an example of how ref_transaction_update can fail.
>
>    There still doesn't seem to be one by the end of the series.

This patch series got a lot longer than I initially thought so I did
not get to the point where we it would make sense
to start returning !0. :-(

The next patchseries I sent out for review does add things to _update
that will cause it to return failures.
For example, locking the ref there happens in _update instead of
_commit and then it starts make sense to
return failures back to the caller for things such as "Multiple
updates for ref '%s' not allowed."

Unfortunate but since this patch series reached >40 patches I did not
want to continue expanding on it.
This means that actually starting to use "let _update return error"
did not actually start becomming used until the second
patch series, which now is well over 30 patches in size :-(

I just felt I had to stop growing this series or it would never be finished.



>
> The general idea still seems sensible.
>
> Thanks,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/246437/focus=247115
