From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH alt-v3] Improve function dir.c:trim_trailing_spaces()
Date: Fri, 13 Jun 2014 19:45:41 -0700
Message-ID: <CAKpPgvcwV_Zbd1W0gAGcy_A-bE6XZagXD-u4aMwOqhXMktUgWQ@mail.gmail.com>
References: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
 <xmqqoaxw1ru4.fsf@gitster.dls.corp.google.com> <20140613232537.GB23078@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 04:46:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvdyr-0004Li-L0
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 04:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbaFNCqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 22:46:04 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:58162 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbaFNCqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 22:46:03 -0400
Received: by mail-oa0-f51.google.com with SMTP id j17so3710753oag.24
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XprYGiWidiBMWxFfjv5Fizzoj8smydAqAEZaz2gTc0g=;
        b=greqHNkDT2zfFEiK74eoSGmHJ9PV8tzAfsDOoImeKSgJ4Y4jm5FHf8X+TZT0vmfPC/
         JFaLP4dOKdrVLB3xW7fSF6VKVkaQKLKgPURUT+X8QDJFiIWQQXZR3ew6YIGYZAmqEGva
         fLIB//vTowNHATUHvyReLf+IPYHRSK4ERUlPP5Kx0deGYkVwS267u99aBT7h4SiP66BR
         erJ+RJBJ8VZqzxhCmbL5TWGa3Zi9H9pLq0fpVxN8+awzXvXZVRfabqU5woE1ciM+dmsC
         97i+DOYTT2z45QtzJNzbo96DQq3MaWyzNTSWuiaFWSMk8LX2G4oXMrK61um9kUtohVwY
         zt9A==
X-Received: by 10.60.74.67 with SMTP id r3mr6691938oev.9.1402713962479; Fri,
 13 Jun 2014 19:46:02 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Fri, 13 Jun 2014 19:45:41 -0700 (PDT)
In-Reply-To: <20140613232537.GB23078@sigill>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251654>

Thanks for the fix. I knew these backslashes could cause trouble. No
doubt the fixed version reads better than a hundred backslashes


On Fri, Jun 13, 2014 at 4:25 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 13, 2014 at 01:23:47PM -0700, Junio C Hamano wrote:
>
>> This passes with your shell set to dash but fails with bash.
>>
>> Let's fix it up like so.
>
> Thanks, I should have been more suspicious of the combination of backslashes
> and echo during review. :)
>
>> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
>> index 5ef5ad3..39e55a1 100755
>> --- a/t/t0008-ignores.sh
>> +++ b/t/t0008-ignores.sh
>> @@ -816,12 +816,14 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
>>       >"whitespace/trailing 5 \\ \\ " &&
>>       >"whitespace/trailing 6 \\a\\" &&
>>       >whitespace/untracked &&
>> -     echo "whitespace/trailing 1 \\    " >ignore  &&
>> -     echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
>> -     echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
>> -     echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
>> -     echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
>> -     echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
>> +     sed -e "s/Z$//" >ignore <<-\EOF &&
>> +     whitespace/trailing 1 \    Z
>> +     whitespace/trailing 2 \\\\Z
>> +     whitespace/trailing 3 \\\\ Z
>> +     whitespace/trailing 4   \\\    Z
>> +     whitespace/trailing 5 \\ \\\   Z
>> +     whitespace/trailing 6 \\a\\Z
>> +     EOF
>
> The end result is much more readable, too, IMHO.
>
> -Peff
