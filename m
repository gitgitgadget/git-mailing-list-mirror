From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 06/29] Fix the do_get_patch function.
Date: Wed, 14 May 2014 10:46:31 +0200
Message-ID: <CAP=KgsTDXkVEpKDVwqhbjY7hGLe97htDjBmiTb-zB7g6WvvKpA@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-7-git-send-email-cederp@opera.com>
	<20140513211326.GE4791@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 14 10:46:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkUpi-0007qh-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 10:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbaENIqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 04:46:35 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56030 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbaENIqc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 04:46:32 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so1511329ieb.41
        for <git@vger.kernel.org>; Wed, 14 May 2014 01:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=c7Abw6qmwUNDQa6f3Sfy/t1G0irKKMxKBCDTPbMPAfc=;
        b=hlaHYoEvaZOy2Bb4sIT1bDg3uK1BCvu1z/kWbx5gSS0qvCi4YTSwNAGuLnjUHnxAsf
         1V3LXEeFifYdT6wNLi0jAEQhtXbVi7OS5EGcIzQHwPXsy4AmhMq0oToXyXW8Ay9d2ZTP
         mvFqSymNgqi05hW08lBloj2n4viuSxnBIbluPUMT6EWKU2QwUgPzy/fCdzV4Xe2x1DwT
         ltWWpX6ODLmCWlT0LWRSgfIAzZJCaiReM2+Ze6jjQyNbw3Ihw5de6HuSHPigiksE53UG
         rw/5RuFq8g3AVLou2eWnOAOSMBIFHhi70oZO6umUTEFW0NywDXTzwp+Y0oRqmxXUOZbZ
         Sacg==
X-Gm-Message-State: ALoCoQmZVxHAZuDUUgmn2Tuolc/nc1oqi42SmpqO/6R7vebHIbN7UEA/ivZqwauODKN9X8Vc5iVA
X-Received: by 10.42.30.71 with SMTP id u7mr2098793icc.20.1400057191576; Wed,
 14 May 2014 01:46:31 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 14 May 2014 01:46:31 -0700 (PDT)
In-Reply-To: <20140513211326.GE4791@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248897>

On Tue, May 13, 2014 at 11:13 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:

> On Tue, May 13, 2014 at 10:30:42PM +0200, Per Cederqvist wrote:
>> A patch file consists of:
>>
>> (1) the description
>> (2) optional diffstat
>> (3) the patches
>>
>> When extracting the patch, we only want part 3.  The do_get_patch used
>> to give us part 2 and part 3.  That made for instance this series of
>> operations fail if guilt.diffstat is true:
>>
>>     guilt push empty-1
>>     guilt push empty-2
>>     guilt pop
>>     guilt fold empty-2
>>     guilt pop
>>     guilt push
>
> I would probably include the actual error here.  I got the following (using
> patch names a & b):
>
> $ guilt pop
> Now at a.
> $ guilt fold b
> error: No changes
> $ guilt pop
> All patches popped.
> $ guilt pu
> Applying patch..a
> error: No changes
> To force apply this patch, use 'guilt push -f'

A bit strange.  I see that I made an error in the commands. It should be
"guilt new empty-1" and "guilt new empty-2".  The updated example in the
commit message looks like this:

    $ guilt new empty-1
    $ guilt new empty-2
    $ guilt pop
    Now at empty-1
    $ guilt fold empty-2
    $ guilt pop
    All patches popped.
    $ guilt push
    Applying patch..empty-1
    fatal: unrecognized input
    To force apply this patch, use 'guilt push -f'

> The diff itself is good.
>
> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

Unless you object I'll add this signed-off line even though I'm
improving the commit message in preparation for version 3
of the patch series.

    /ceder

>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/guilt b/guilt
>> index 8701481..3fc524e 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -334,7 +334,7 @@ do_get_patch()
>>  {
>>       awk '
>>  BEGIN{}
>> -/^(diff |---$|--- )/ {patch = 1}
>> +/^(diff |--- )/ {patch = 1}
>>  patch == 1 {print $0}
>>  END{}
>>  ' < "$1"
>> --
>> 1.8.3.1
>>
>
> --
> I already backed up the [server] once, I can do it again.
>                 - a sysadmin threatening to do more frequent backups
