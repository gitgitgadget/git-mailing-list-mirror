From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2][GSoC] diff-no-index: rename read_directory()
Date: Wed, 19 Mar 2014 15:15:31 -0400
Message-ID: <CAPig+cSew=zjhC54w4LGipaXCD7+M=7pXShh6hoYBo_krRTkbg@mail.gmail.com>
References: <1395244702-659-1-git-send-email-ba.bourn@gmail.com>
	<xmqqd2hi3ury.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Bourn <ba.bourn@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:16:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLyE-0006NW-AG
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 20:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaCSTQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 15:16:04 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35686 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbaCSTPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 15:15:32 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so24358720ykp.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1h5bUcYXoWI5aPPAYnv5XC/WGMsfd9+YwGJNPOgxKw0=;
        b=KS/w2O5T8Eouyz55vCxdeKalT0HxHf6IN5QLJ9t4IwFwMFFz4tB51/mt1FZ/Jm33eZ
         Jr24T1u0lVFb6RCzB635WSuKg/iZUHuQC5nGrc9+sXB1fK4V/wWyM9tDRszx6KcPvYdN
         Q6XUbB6taSI71xKYEoTXaVqY1P/4RF/tf0/k/ryPIz4xIJSBb905X9U3gIBg9aWCd6GH
         K4mSi/RXKPj6NgwuWeXykOE+GndK833bx3hXs05M/Yl2DalDEGEUMgnFHz069mum6MJa
         H5d+7Ir3YqQq9xEN/wPu8sKX0Zu5dZTZnRS7v1dUjRRLIDIOJd3djNehXfSWzV9B3VYv
         PM/g==
X-Received: by 10.236.50.194 with SMTP id z42mr4560870yhb.145.1395256531279;
 Wed, 19 Mar 2014 12:15:31 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 19 Mar 2014 12:15:31 -0700 (PDT)
In-Reply-To: <xmqqd2hi3ury.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: woBKZsrKOkOzJLblwdqyq_919jQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244481>

On Wed, Mar 19, 2014 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Bourn <ba.bourn@gmail.com> writes:
>
>> It would be desirable to replace manual checking of "." or ".."
>> in diff-no-index.c with is_dot_or_dotdot(), which is defined
>> in dir.h, however, dir.h declares a read_directory() which conflicts
>> with a (different) static read_directory() defined
>> in diff-no-index.c. As a preparatory step, rename the local
>> read_directory() to avoid the collision.
>>
>> Signed-off-by: Brian Bourn <ba.bourn@gmail.com>
>> ---
>> Part 1 of my submission for GSoC
>>  diff-no-index.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Looks good to me.  Doesn't Eric deserve a "Helped-by:" above?

Both patches look good to me too.

One final comment for future submissions (no need to resend this one):
As a courtesy to reviewers, below the "---" line after your sign-off,
provide a link to the previous attempt (like this [1]) and explain
what changed since the since the last version.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244412

>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 8e10bff..ec51106 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -16,7 +16,7 @@
>>  #include "builtin.h"
>>  #include "string-list.h"
>>
>> -static int read_directory(const char *path, struct string_list *list)
>> +static int read_directory_contents(const char *path, struct string_list *list)
>>  {
>>       DIR *dir;
>>       struct dirent *e;
>> @@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
>>               int i1, i2, ret = 0;
>>               size_t len1 = 0, len2 = 0;
>>
>> -             if (name1 && read_directory(name1, &p1))
>> +             if (name1 && read_directory_contents(name1, &p1))
>>                       return -1;
>> -             if (name2 && read_directory(name2, &p2)) {
>> +             if (name2 && read_directory_contents(name2, &p2)) {
>>                       string_list_clear(&p1, 0);
>>                       return -1;
>>               }
