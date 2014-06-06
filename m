From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 2/2] mingw: avoid const warning
Date: Fri, 06 Jun 2014 23:15:04 +0200
Message-ID: <53922F58.80509@gmail.com>
References: <20140529104329.GA24021@camelia.ucw.cz>	<20140529104716.GC24021@camelia.ucw.cz> <5391D956.7050903@gmail.com> <xmqq1tv1rguh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Stepan Kasal <kasal@ucw.cz>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt1Ti-0003mw-Ly
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 23:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbaFFVPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 17:15:03 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38696 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbaFFVPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 17:15:02 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so1646667wib.5
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 14:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jnV7QqR9HAdZ9Q+xm44Iou7OcRTmq4Mv3MlMPbpd8JQ=;
        b=hbhYHNLV0uteeZe94SaQ2ZooyTKkvigiX4+EctWXPGbsjVBKBek4wSoPH9tqKr1gjl
         7KxF8V5S6hZ+wpTE8dIKvpTfu+BTigM4R4GNGkM9wmU0/Lp2EB+PNlGlUtPL3Z3/e6S1
         o/i7uB7/TrqBKYff4Z5x0AsqFwQ1/pDwpw5OntaCGoHtsiz7LaIGOBaGQj+ouG/ENpOc
         aeqc2OEoNLwkYEMuPRC9CWU+x6ATDMKT9qqc7gceOaTtTKFf/MeOARvAVm9CPB1vjMMo
         qxWuJTOr//5vjlmJ8TXJtoLdq1dJM9b5yfUC+Qk1uq7FN0yYTkk3FU7H1iNwgAQhy340
         7LoA==
X-Received: by 10.15.53.1 with SMTP id q1mr1561881eew.7.1402089300966;
        Fri, 06 Jun 2014 14:15:00 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y8sm3752066eef.5.2014.06.06.14.14.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 14:15:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqq1tv1rguh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250969>

Am 06.06.2014 21:13, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Am 29.05.2014 12:47, schrieb Stepan Kasal:
>>> Fix const warnings in http-fetch.c and remote-curl.c main() where is
>>> argv declared as const.
>>>
>>> The fix should work for all future declarations of main, no matter
>>> whether the second parameter's type is "char**", "const char**", or
>>> "char *[]".
>>
>> I'm 100% in favor of a solution that doesn't restrict main to non-const char**! Thanks.
>>
>>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>>> ---
>>>  compat/mingw.h | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/compat/mingw.h b/compat/mingw.h
>>> index 15f0c9d..8745d19 100644
>>> --- a/compat/mingw.h
>>> +++ b/compat/mingw.h
>>> @@ -369,10 +369,11 @@ extern CRITICAL_SECTION pinfo_cs;
>>>  void mingw_startup();
>>>  #define main(c,v) dummy_decl_mingw_main(); \
>>>  static int mingw_main(c,v); \
>>> -int main(int argc, char **argv) \
>>> +int main(c, char **main_argv_not_used) \
>>>  { \
>>> +	typedef v, **argv_type; \
>>>  	mingw_startup(); \
>>> -	return mingw_main(__argc, __argv); \
>>> +	return mingw_main(__argc, (argv_type)__argv); \
>>>  } \
>>>  static int mingw_main(c,v)
>>>  
>>
>> I have to admit I had trouble understanding what 'typedef v,
>> **arv_type;' does (looks invalid at first glance), and why you
>> would need main_argv_not_used instead of just main(c,v).
>>
>> So, I'd like to award +10 points for cleverness, but -10 for
>> obscurity ;-) Probably deserves a comment or an explanation in the
>> commit message.
> 
> Agreed.  The "typedef" one is a cute hack.
> 
> I am wondering why the solution is not a more obvious "drop const
> that is not ANSI C", though.  I only have a ready-access to N1570
> draft but in it I find:
> 

Actually, that was the original solution ($gmane/247535). I just complained because it was slightly different from what we had in msysgit for quite some time [1], causing merge conflicts.

I guess compilers probably won't complain if you declare argv const, even if the standard is more strict. After all, you aren't supposed to modify argv.

> 
>> A simpler solution that works with all definitions of main() is to
>> cast to void* (tell the compiler all responsibility is on
>> us).
> 
> Can you cast away the constness that way, though?
> 

Not 'away'. This passes a non-const value to a const parameter, which is typically not a problem. Its just 'char**' to 'const char**' that produces the warning, because 'const char' hides behind a non-const pointer, see [2]. 'void*' to 'const char**' works, though.

[1] https://github.com/msysgit/git/commit/6949537a
[2] http://c-faq.com/ansi/constmismatch.html
