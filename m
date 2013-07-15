From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4203: fix checks for email address remapping
Date: Mon, 15 Jul 2013 03:00:58 -0400
Message-ID: <CAPig+cT6zY9F1AEyJx3bw8RYgxPWBuGqyUQm=t8G6ORs4mSs6Q@mail.gmail.com>
References: <1373675709-40486-1-git-send-email-sunshine@sunshineco.com>
	<51E0F3CC.3040304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 09:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycmi-0007Jb-2W
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 09:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab3GOHBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 03:01:03 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:38106 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOHBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 03:01:02 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so9250923lab.33
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=EYEch/R60NtLVxsz+uXKcd7BMlUny72OHf7YsLXderc=;
        b=wYWl3I+ltrN3nQ831ENAXdRQWfPoIvlkpFTjEu1Kg2bTXHjTGL3O1LUtEqc4EN3FjG
         /cPu5eyDWHQy0yy8kJy1FdHwnjkS/jM5o5+LZRdSoVxuFvecbxcoBhEtUfYcw3gEhDFH
         hQyRELgvkOMe341iIJbua+7M18vAqTLbwxuXq9wbgbyAWYbPe/qz/hlp7Gyghp3/Xu+i
         ZMbnja0tcT5mFmkGHtp2APycqk7YrDaL1+mO0Qt3lUZ3vYzoffz3ceQRW8pjW8WYyQ0l
         yuMuAZDEywzvWk7h73G6ezNpoegLcHyM+1bwl5tqF3qxVaxIN3dR/aFeuuqNi0OBCwAJ
         fQMA==
X-Received: by 10.112.12.225 with SMTP id b1mr23871321lbc.3.1373871658785;
 Mon, 15 Jul 2013 00:00:58 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Mon, 15 Jul 2013 00:00:58 -0700 (PDT)
In-Reply-To: <51E0F3CC.3040304@googlemail.com>
X-Google-Sender-Auth: vzjJReYqBWMkOcRlf6isl6yvSjo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230435>

On Sat, Jul 13, 2013 at 2:29 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> On 07/13/2013 02:35 AM, Eric Sunshine wrote:
>> Two tests in t4203-mailmap.sh set up the mapping <bugs@company.xx> =>
>> <bugs@company.xy> in an apparent attempt to check that email address
>> remapping works as expected (in addition to name remapping which is also
>> tested).  To test the remapping, git-shortlog is invoked but the
>> invocation lacks the -e option instructing it to show email addresses,
>> hence the tests do not actually prove that address remapping succeeded.
>> Fix this by instructing git-shortlog to output email addresses as well.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>
>> The very last git-shortlog "complex" test in the script does use -e and
>> checks that email address remapping actually works, so it's not clear
>> that this patch is needed. The <bugs@company.xx> => <bugs@company.xy>
>> remapping done by the two tests touched by this patch, however, is
>> misleading to the reader since it seems to imply that these two tests
>> want to check address remapping as well. Perhaps a better change would
>> be to remove the address remapping from these two tests.
>>
>>  cat >expect <<\EOF
>> -Internal Guy (1):
>> +Internal Guy <bugs@company.xy> (1):
>>        second
>>
>> -Repo Guy (1):
>> +Repo Guy <author@example.com> (1):
>>        initial
>>
>>  EOF
>> @@ -131,7 +131,7 @@ test_expect_success 'name entry after email entry, case-insensitive' '
>>       mkdir -p internal_mailmap &&
>>       echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
>>       echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&+
>
> So here it is capitalized email address (BUGS@), but at the expect file
> it's still lower cased. I think this is a bug.
> Junio was trying to fix it in 543f99173c2d2f648d8f846e24875150f7de03d3
> (origin/jc/mailmap-case-insensitivity)

With the re-roll of Junio's series which I just sent out [1], this
case-preserving problem is tested (and fixed), and email address
remapping is tested in general, so I think this submission should be
retired.

(It might still be worthwhile, as mentioned in the patch commentary,
to drop the confusing lines altogether from those two tests, but
that's an issue for another day.)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/230425/

> So I think we need another yet test case there:
> commited:
>     Internal Guy <BUGS@Company.xx>
>     Internal Guy <bugs@company.xy>
>
> Having just one entry in the mailmap
>     Internal Guy <BUGS@Company.xx> <bugs@Company.xy>
>
> should still work with the "shortlog -e"
>
>> -     git shortlog HEAD >actual &&
>> +     git shortlog -e HEAD >actual &&
>>       test_cmp expect actual
>>  '
