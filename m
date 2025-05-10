Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14732563
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880853; cv=none; b=nRcJsaOXOt2iZlK96CzNJ2EXvUjt774Uykkgh5+vNIIHPmQJrZVpaujcx6yJf4EAcLtcoVBf5VnbDKcSz/7L9iXELQ6kQQ3zeaD7S02mmMe5ESruNtuAWGBN/OmYrv1vQmtovbOjeRZgb2hnX2drK6QchxsZ7UlADk6LuAfi3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880853; c=relaxed/simple;
	bh=V4E+98QT2opE7Pe6S+hNBiRZjoHf25VcUngloEafjW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRR9PpGxS+Eyf1Rk1dO6NUZDCVJNTRKPu1vmM6scB/EhwXeGiVukpklhfrntKuwwPHEklVqo1IJtqm02Nxzg67oMDn1aTiung1J8CX7MrINtgf16M5/KpoznuGrPNjE/SNg9Ce2zSHbETddoNzSAh+ez4Hf87To7U7upLNwtBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4ZvlpJ28WSzRlWC;
	Sat, 10 May 2025 14:40:40 +0200 (CEST)
Message-ID: <ada6ff3b-1311-4d47-a098-7abc0ea9c46b@kdbg.org>
Date: Sat, 10 May 2025 14:40:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1][GSOC] userdiff: extend Bash pattern to cover more
 shell function forms
Content-Language: en-US
To: MOUMITA DHAR <dhar61595@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Atharva Raykar <raykar.ath@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
References: <20250328200525.4437-1-dhar61595@gmail.com>
 <20250330134018.9662-1-dhar61595@gmail.com>
 <20250330134018.9662-2-dhar61595@gmail.com>
 <9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org>
 <CAF=ncLbaxYPRx79wYVgpMFuV7UGSObMD+A3zTssWvtVJmXHXVg@mail.gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAF=ncLbaxYPRx79wYVgpMFuV7UGSObMD+A3zTssWvtVJmXHXVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The way how you cited the message makes it very difficult to see what is
citation, code, or your message text. Please insert sufficient blank
lines in your replies. Also, indentation may help to declare what is the
code that you talk about.

Am 10.05.25 um 13:37 schrieb MOUMITA DHAR:
> On Tue, 6 May 2025 at 22:00, Johannes Sixt <j6t@kdbg.org> wrote:
>>> diff --git a/userdiff.c b/userdiff.c
>>> index 340c4eb4f7..4c77c7e0f6 100644
>>> --- a/userdiff.c
>>> +++ b/userdiff.c
>>> @@ -64,15 +64,27 @@ PATTERNS("bash",
>>>            /* Bashism identifier with optional parentheses */
>>>            "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
>>>        ")"
>>> -      /* Optional whitespace */
>>> -      "[ \t]*"
>>> -      /* Compound command starting with `{`, `(`, `((` or `[[` */
>>> -      "(\\{|\\(\\(?|\\[\\[)"
>>> +      /* Everything after the function header is captured  */
>>> +      ".*$"
>>
>> I remember suggesting to capture everything after the function header.
>> However, If I am not mistaken, this does not do what I intended (and as
>> written it means that a pointless matching operation happens). The hunk
>> header shows everything that is in the outermost parentheses (group).
>> This catch-all, however, is even outside the outermost group and not
>> captured. It should be above the closing parenthesis that we see in the
>> context.
> > I am sorry I want to understand a thing  , we want everything from
> the function name to the end of the line to be the hunk header
> right ? So in the pattern

> "^[ \t]*"> /* Start of captured text */
> "("
> "("
>      /* POSIX identifier with mandatory parentheses */
>      "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> "|"
>      /* Bashism identifier with optional parentheses */
>      "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> ")"
> /* Optional whitespace */
> "[ \t]*"
> /* Compound command starting with `{`, `(`, `((` or `[[` */
> "(\\{|\\(\\(?|\\[\\[)"
> /* End of captured text */
> ")"

> if I replace

> "[ \t]*"
> "(\\{|\\(\\(?|\\[\\[)"

> part with .*$ then will it not capture the
> entire line ? I mean the outermost group ends here-
> 
>  /* End of captured text */
> ")"
> right ? What am I getting wrong ?

It is my error, sorry. I see now that your intended change was correct.

However, in my tests, a comment after the function name is not captured.
The reason is that the parentheses are not balanced. My editor tells me
that the parenthesis in "(function" is matched with the lone ")" in the
next line, but the latter is intended to match up with the "(" above the
'/* POSIX' comment. There is something fishy going on and needs a fix.

To test, apply this:

diff --git a/t/t4018/bash-posix-style-function b/t/t4018/bash-posix-style-function
index a4d144856e..673c51b89e 100644
--- a/t/t4018/bash-posix-style-function
+++ b/t/t4018/bash-posix-style-function
@@ -1,4 +1,4 @@
-RIGHT() {
+afunc () { # RIGHT
 
     ChangeMe
 }

-- Hannes

