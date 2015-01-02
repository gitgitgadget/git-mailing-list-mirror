From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: xfuncname problems with C++
Date: Fri, 2 Jan 2015 15:27:56 -0600
Message-ID: <CAHd499DpyO6Csji8gp1E6HsrvtBa7QMKBah2xOewrWAfNgQUHg@mail.gmail.com>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com>
	<CAHd499C_Z_npG3ibv_gJSU7kqrT6=DRCV8TU9_sjz9zzQ7vC-Q@mail.gmail.com>
	<54A7000A.3050605@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 22:28:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y79lL-0001OF-JF
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 22:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbbABV16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 16:27:58 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:61748 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbbABV16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 16:27:58 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so16290190lab.12
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 13:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=j3ckiSMa0SOANlVZTzgoJ3G2+MVUZ7VWMMw9Bu4RJ5A=;
        b=GRCg3BYbYbhvbhiyAJbViwEpFgW2IsTQ8MUpY7hBsEKAdof5/DHOS0X9D77DhOi39L
         cswTxrVrwlgqwIuXNEIZldAlY0m4w1+eG479WRQ0kzg89tA+wVXxGCK8DVMK5LrWbdQp
         RAUXyK6DDP6j9wS8E9LRah5IzxthEtHt3l+Fhjlt6mmPwuTGk/KiIVxx2R9JRln2S8iX
         1BrEhO3rF6jTpp9ibixHeM/H8+w2+59b9sqzvffBHu53y+EHlanrfCTh8Sh4DZbxzhEa
         A2YS0CSoZHzA0b+cM9XezH57ZO/kxCQA05Z4Z8rwHZ4diddwLO1k1E/esQFy6oNEnOhV
         z9ng==
X-Received: by 10.112.131.1 with SMTP id oi1mr76804470lbb.2.1420234076432;
 Fri, 02 Jan 2015 13:27:56 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.114.185.67 with HTTP; Fri, 2 Jan 2015 13:27:56 -0800 (PST)
In-Reply-To: <54A7000A.3050605@kdbg.org>
X-Google-Sender-Auth: 23ONmf8IraK1mhJ83sknfqrP3N8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261987>

On Fri, Jan 2, 2015 at 2:31 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 02.01.2015 um 18:03 schrieb Robert Dailey:
>> On Fri, Jan 2, 2015 at 10:49 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>> I have a function like so:
>>>
>>> void MyClass::SomeFunction(int someParameter)
>>> {
>>>     // Stuff changed in here
>>> }
>>>
>>> When I do `git diff` on the file containing this function, I get a
>>> chunk showing some changed code in this function somewhere in the
>>> middle of the body. However, the chunk header shows my root namespace
>>> name in the file instead of the function header:
>>>
>>> @@ -144,15 +149,22 @@ namespace Utils
>>>
>>> What I expect to see:
>>>
>>> @@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)
>>>
>>> I've tried various regular expressions that work in regex testers I
>>> use against this function signature, however they do not work when I
>>> apply them to my config:
>>>
>>> [diff "cpp"]
>>>     xfuncname =
>>> "^\\s*[\\w_][\\w\\d_]*\\s*.*\\s*[\\w_][\\w\\d_]*\\s*\\(.*\\)\\s*$"
>>>
>>> File name is "foo.cpp", I even added it to my git attributes file:
>>>
>>> *.cpp diff=cpp
>>>
>>> Using the regex above, my chunk headers come back blank. Why is it
>>> showing namespace? How do I make this match the nearest function
>>> header?
>>
>> Oopsie, I didn't realize the regex must be POSIX compatible. I've
>> updated the regex to this:
>> https://www.regex101.com/r/kP3dM6
>>
>> The test seems to work; however git gives me an error with the regex
>> when I do a diff:
>>
>> $ git diff Core
>> fatal: Invalid regexp to look for hunk header:
>> ^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\(.*\)[[:space:]]*$
>>
>> Here is how it is stored in my .gitconfig:
>>
>> [diff "cpp"]
>>     xfuncname =
>> "^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\\(.*\\)[[:space:]]*$"
>>
>
> Perhaps there is a pair of parentheses missing that capture text for the
> hunk header? I you intended that to be the part inside \(...\), then
> that is wrong. Use unescapted parentheses.
>
> There are two catch-all .* in your pattern. That is very suspicious,
> particularly since the first one is outside the meant-to-be capturing
> parentheses.

My regex actually is intended to not have any capture groups. Is that
required? The documentation I read didn't mention any requirements, so
I am not sure.

The 'void' does not start on the leftmost column, due to tabbing there
can be any number of whitespace (the regex should account for this).
