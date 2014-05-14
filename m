From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 25/29] "guilt push" now fails when there are no more
 patches to push.
Date: Wed, 14 May 2014 11:27:19 +0200
Message-ID: <CAP=KgsRrtkRZB24CebZsunE=Mc55+NNjoGKLxCPa=KY-GDJ-+w@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-26-git-send-email-cederp@opera.com>
	<20140513214114.GI4791@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 14 11:27:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkVTC-0002lo-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 11:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbaENJ1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 05:27:23 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:39903 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbaENJ1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 05:27:20 -0400
Received: by mail-ig0-f177.google.com with SMTP id l13so1533763iga.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 02:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=kxobg5A3MdYRhOKYqwGq+LbrBvDMCnXh1rfRyHYwqx0=;
        b=AG1FYKLlAca7fgkdjv5Vj0W5skmIKu2nNpsxY9mm1ySnOqSUqAYoH5ch9etguV7Mgg
         EKQd7n3GgxuWok/+nciHF0jX+H5MW1p+sP3SApT5ql9LItvm7rTvmg7IJxlGSephNo8g
         zlTecuWExY9RMcSCOLd3CaNczk44ed5sYsqKSlDz8zUagS9SNcWDrz2H+cRUBAJWumvn
         l/Lx7j7Ixvvqu1S4ovXcEUKJYQNi2m2/7W5kVJDNie95mGeOSnxBQGR4Pav3k1XPvMme
         ZvFSdbrnrHK1atSlZYwVpl1RbmBOkZZAwF3e7u537yhqysMhfiXWO3YWjo2L6RXqNwOc
         4g9w==
X-Gm-Message-State: ALoCoQnb1CfrWfKa1k2R8oOxLP2op+rqhDTY4utwNZvabFbHPbxPCZSpEXfOPJLGJRGvh1NnkH/9
X-Received: by 10.50.143.107 with SMTP id sd11mr63572247igb.39.1400059639555;
 Wed, 14 May 2014 02:27:19 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Wed, 14 May 2014 02:27:19 -0700 (PDT)
In-Reply-To: <20140513214114.GI4791@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248902>

On Tue, May 13, 2014 at 11:41 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 10:31:01PM +0200, Per Cederqvist wrote:
>> This makes it easier to script operations on the entire queue, for
>> example run the test suite on each patch in the queue:
>>
>>     guilt pop -a;while guilt push; do make test||break; done
>>
>> This brings "guilt push" in line with the push operation in Mercurial
>> Queues (hg qpush), which fails when there are no patches to apply.
>>
>> Updated the test suite.
>>
>> "guilt push -a" still does not fail.  (It successfully manages to
>> ensure that all patches are pushed, even if it did not have to do
>> anything to make it so.)
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt-push           | 19 ++++++-----
>>  regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-020.sh  | 13 +++++++-
>>  3 files changed, 113 insertions(+), 8 deletions(-)
> ...
>> diff --git a/regression/t-020.sh b/regression/t-020.sh
>> index 906aec6..0f9f85d 100755
>> --- a/regression/t-020.sh
>> +++ b/regression/t-020.sh
>> @@ -26,6 +26,17 @@ guilt series | while read n ; do
>>  done
>>
>>  #
>> +# pushing when there is nothing to push
>> +#
>> +
>> +shouldfail guilt push
>> +cmd guilt push -a
>> +
>> +cmd list_files
>> +
>> +cmd git log -p
>
> I don't particularly care for the git-log.  Otherwise it looks good.
>
> Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

In my defense, I was just continuing the pattern already
established in that file. Anyhow, I'll add a new commit to
the patch series that removes all "git log -p" from all tests.
(They are present in both t-020.sh and t-021.sh.)

    /ceder

>> +
>> +#
>>  # pop all
>>  #
>>  cmd guilt pop --all
>> @@ -61,7 +72,7 @@ cmd guilt pop --all
>>
>>  npatches=`guilt series | wc -l`
>>  for n in `_seq -2 $npatches`; do
>> -     if [ $n -ge 0 ]; then
>> +     if [ $n -gt 0 ]; then
>>               cmd guilt push -n $n
>>       else
>>               shouldfail guilt push -n $n
>> --
>> 1.8.3.1
>>
>
> --
> Evolution, n.:
>   A hypothetical process whereby infinitely improbable events occur with
>   alarming frequency, order arises from chaos, and no one is given credit.
