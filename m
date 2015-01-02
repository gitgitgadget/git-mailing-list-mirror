From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: xfuncname problems with C++
Date: Fri, 02 Jan 2015 21:31:06 +0100
Message-ID: <54A7000A.3050605@kdbg.org>
References: <CAHd499Cn8C51i_+Dm4h_U4X_Jc-nhNMjoufiZRdn5LGxFqD_HA@mail.gmail.com> <CAHd499C_Z_npG3ibv_gJSU7kqrT6=DRCV8TU9_sjz9zzQ7vC-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y78sM-0006QX-87
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 21:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbABUbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 15:31:09 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:3874 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750783AbbABUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 15:31:08 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3kDdDC41jRz5tlC;
	Fri,  2 Jan 2015 21:31:07 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0271519F8BD;
	Fri,  2 Jan 2015 21:31:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CAHd499C_Z_npG3ibv_gJSU7kqrT6=DRCV8TU9_sjz9zzQ7vC-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261983>

Am 02.01.2015 um 18:03 schrieb Robert Dailey:
> On Fri, Jan 2, 2015 at 10:49 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> I have a function like so:
>>
>> void MyClass::SomeFunction(int someParameter)
>> {
>>     // Stuff changed in here
>> }
>>
>> When I do `git diff` on the file containing this function, I get a
>> chunk showing some changed code in this function somewhere in the
>> middle of the body. However, the chunk header shows my root namespace
>> name in the file instead of the function header:
>>
>> @@ -144,15 +149,22 @@ namespace Utils
>>
>> What I expect to see:
>>
>> @@ -144,15 +149,22 @@ void MyClass::SomeFunction(int someParameter)
>>
>> I've tried various regular expressions that work in regex testers I
>> use against this function signature, however they do not work when I
>> apply them to my config:
>>
>> [diff "cpp"]
>>     xfuncname =
>> "^\\s*[\\w_][\\w\\d_]*\\s*.*\\s*[\\w_][\\w\\d_]*\\s*\\(.*\\)\\s*$"
>>
>> File name is "foo.cpp", I even added it to my git attributes file:
>>
>> *.cpp diff=cpp
>>
>> Using the regex above, my chunk headers come back blank. Why is it
>> showing namespace? How do I make this match the nearest function
>> header?
> 
> Oopsie, I didn't realize the regex must be POSIX compatible. I've
> updated the regex to this:
> https://www.regex101.com/r/kP3dM6
> 
> The test seems to work; however git gives me an error with the regex
> when I do a diff:
> 
> $ git diff Core
> fatal: Invalid regexp to look for hunk header:
> ^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\(.*\)[[:space:]]*$
> 
> Here is how it is stored in my .gitconfig:
> 
> [diff "cpp"]
>     xfuncname =
> "^[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*.*[[:space:]]*[[:word:]_][[:word:][:digit:]_]*[[:space:]]*\\(.*\\)[[:space:]]*$"
> 

Perhaps there is a pair of parentheses missing that capture text for the
hunk header? I you intended that to be the part inside \(...\), then
that is wrong. Use unescapted parentheses.

There are two catch-all .* in your pattern. That is very suspicious,
particularly since the first one is outside the meant-to-be capturing
parentheses.

-- Hannes
