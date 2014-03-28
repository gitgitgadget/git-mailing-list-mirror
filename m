From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/10] t4213: test --function-name option
Date: Fri, 28 Mar 2014 04:21:02 -0400
Message-ID: <CAPig+cSp0iJZjUAUSKyjVvYe=xR5h4c7OHQdSK0Op8vUD_mnhQ@mail.gmail.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
	<4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu>
	<533523F9.2000108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 09:21:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTS2M-0006F0-G8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 09:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaC1IVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 04:21:09 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:63575 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaC1IVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 04:21:04 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so3399696ykr.9
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 01:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iUz7xqs9Fy3eCOPXuahWcj3UNey8eE7w9F7eGUyL0bo=;
        b=TAOjV/DT1OeFuJr2JDiWFn4FQ6TLky7SfRXKRVJbS4YOmgnXnsas+iAJ9PkOY7Gp25
         dQvtLzb7ish1+277c18tZIsI8/ithj4EXcoTyQh11I/mMoO835AyfL+11Un+ijdjJU1z
         o/ONqR4Pb4rq7CKqfi5gbqoCfFgmy5pmxM3qlsddJD4bmuyxILccUzi+DdeE2OUSxxbg
         N/hoCgPCLi6MJUeZ7SjsU+VJL/6u4cCZgGXmK8UjOAnGHA75ZWK9+McTI5+6Y4sKeOCl
         2zrnmzmAZV/Q4FgDEcyL4+QZtjdiVrozejQOqohkouSEC5wGvOl+6Kw6cVTXcvc9+lKU
         zuLg==
X-Received: by 10.236.61.45 with SMTP id v33mr9660332yhc.20.1395994863101;
 Fri, 28 Mar 2014 01:21:03 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 28 Mar 2014 01:21:02 -0700 (PDT)
In-Reply-To: <533523F9.2000108@viscovery.net>
X-Google-Sender-Auth: ZT4jbPxjSWpP571WSnXOULxfIF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245369>

On Fri, Mar 28, 2014 at 3:25 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 3/27/2014 19:50, schrieb David A. Dalrymple (and Bhushan G. Lodha):
>> From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>
>>
>> This test builds a sample C file, adding and removing functions, and
>> checks that the right commits are filtered by --function-name matching.
>
> This is probably the most important patch in your series as it documents
> the expected behavior. Unfortunately, I find its clarity very lacking. :(
>
> This new feature uses the userdiff driver, IIUC. Does it do so in all
> respects? In particular, does it also evaluate the negative patterns? For
> example, when there is a label in the code, is it not mistaken as the
> beginning of a function? A test for this case would be very instructive.
>
> Furthermore, consider a patch for a change at the very beginning of a
> function. Then the function name would appear in the pre-context of the
> hunk, but the hunk header would show the function before the one with the
> change. Would such a change confuse your implementation? I guess not.
> Again, a test case would remove any doubts.
>
> Is it possible to search for a change that is before any functions? It
> would be useful to enumerate commits that change #include lines.
>
>>
>> Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
>> ---
>>  t/t4213-log-function-name.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100755 t/t4213-log-function-name.sh
>>
>> diff --git a/t/t4213-log-function-name.sh b/t/t4213-log-function-name.sh
>> new file mode 100755
>> index 0000000..1243ce5
>> --- /dev/null
>> +++ b/t/t4213-log-function-name.sh
>> @@ -0,0 +1,73 @@
>> +#!/bin/sh
>> +
>> +test_description='log --function-name'
>> +. ./test-lib.sh
>> +
>> +test_expect_success setup '
>> +     echo "* diff=cpp" > .gitattributes

Broken &&-chain here, as well.

>> +
>> +     >file &&
>> +     git add file &&
>> +     test_tick &&
>> +     git commit -m initial &&
>> +
>> +     printf "int main(){\n\treturn 0;\n}\n" >> file &&
>> +     test_tick &&
>> +     git commit -am second
>
> Broken && chain here and later as well. Please be careful.
>
>> +
>> +     printf "void newfunc(){\n\treturn;\n}\n" >> file &&
>> +     test_tick &&
>> +     git commit -am third
>
>         git commit -am "append a function" &&
>
>> +
>> +     printf "void newfunc2(){\n\treturn;\n}\n" | cat - file > temp &&
>> +     mv temp file &&
>> +     test_tick &&
>> +     git commit -am fourth
>
>         git commit -am "prepend a function" &&
>
> etc. You get the picture.
>
>> +
>> +     printf "void newfunc3(){\n\treturn;\n}\n" | cat - file > temp &&
>> +     mv temp file &&
>> +     test_tick &&
>> +     git commit -am fifth
>> +
>> +     sed -i -e "s/void newfunc2/void newfunc4/" file &&
>> +     test_tick &&
>> +     git commit -am sixth
>> +'
>> +
>> +test_expect_success 'log --function-name=main' '
>
> test_expect_success 'log --function-name finds a function with a change' '
>
>> +     git log --function-name=main >actual &&
>> +     git log --grep=second >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log --function-name "newfunc\W"' '
>
> test_expect_success 'log --function-name with extended regexp' '
>
> etc. You get the picture.
>
>> +     git log --function-name "newfunc\W" >actual &&
>> +     git log --grep=third >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log --function-name "newfunc2"' '
>> +     git log --function-name newfunc2 >actual &&
>> +     git log -E --grep "sixth|fourth" >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log --function-name "newfunc3"' '
>> +     git log --function-name newfunc3 >actual &&
>> +     git log --grep=fifth >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log --function-name "newfunc4"' '
>> +     git log --function-name newfunc4 >actual &&
>> +     git log --grep=sixth >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'log --function-name "newfunc"' '
>> +     git log --function-name newfunc >actual &&
>> +     git log -E --grep "third|fourth|fifth|sixth" >expect &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_done
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
