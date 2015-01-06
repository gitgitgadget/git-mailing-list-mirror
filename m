From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] gettext.h: add parentheses around N_ expansion
Date: Tue, 6 Jan 2015 06:38:58 -0800
Message-ID: <694DC462-40E3-4081-8616-64483FCD0D77@gmail.com>
References: <ecb18f9d6ac56da0a61c3b98f8f2236@74d39fa044aa309eaea14b9f57fe79c> <f67db70c63f8dcbfc58d7ffda86ff10@74d39fa044aa309eaea14b9f57fe79c> <54ABE205.70801@ramsay1.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 06 15:42:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8VHo-0000c9-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 15:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbbAFOjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 09:39:03 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51332 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbbAFOjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 09:39:02 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so30332879pdb.5
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=No+3GRjsz8mhnrAYtsMiwKZy+UwB5TixfPMDdpFwgsA=;
        b=XHIHenqn91z8s9QXwIjReypJsQDT5tKu30xHvRIRwvB/ZXG+fIlMO16QKVZ3TYFp0O
         qyHZ40mkeScDJr48rMKRI1YaAI754k07jQqjgWB7wmgfWEzo+AMCQyLtvMUnljACqxtu
         FDjga9sFEercOIY02OjmFxavsGJ2VssolvfqiHEBffAA12nMnaXOaGLujU2RGnNhG8Ar
         4dF/WqTbheqoXfiWP1/InLaUsy5szAdupSDXY7j7LtzTnCZRqJQAdxpykMqLE1CO9pQZ
         wt6VDdibWaEV3ftjXjd1vgNb4SaIPiWaALajLuW0LpzyjX5caNGHA+wP6XUJQHWqQER7
         O33w==
X-Received: by 10.66.65.75 with SMTP id v11mr153412309pas.81.1420555141365;
        Tue, 06 Jan 2015 06:39:01 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id kb16sm57172033pbb.34.2015.01.06.06.38.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 06:39:00 -0800 (PST)
In-Reply-To: <54ABE205.70801@ramsay1.demon.co.uk>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262067>

On Jan 6, 2015, at 05:24, Ramsay Jones wrote:

> On 06/01/15 10:34, Kyle J. McKay wrote:
>> Avoid this by adding parentheses around the expansion of the
>> N_ macro so that instead of ending up with two adjacent strings
>> that are then combined by the preprocessor, two adjacent strings
>> surrounded by parentheses result instead which causes a compile
>> error so the mistake can be quickly found and corrected.
>>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> ---
>> This patch is optional, but prevents the problem fixed by 1/2
>> from recurring.
>>
>> gettext.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gettext.h b/gettext.h
>> index 7671d09d..d11a4139 100644
>> --- a/gettext.h
>> +++ b/gettext.h
>> @@ -63,6 +63,6 @@ const char *Q_(const char *msgid, const char  
>> *plu, unsigned long n)
>> }
>>
>> /* Mark msgid for translation but do not translate it. */
>> -#define N_(msgid) msgid
>> +#define N_(msgid) (msgid)
>>
>> #endif
>>
>
> Hmm, see commit 642f85faa ("i18n: avoid parenthesized string as
> array initializer", 07-04-2011), for a counter-point. :-P

Oh interesting.  So the bug bug fixed by 1/2 must have crept in after  
that change then.

Even clang -ansi -pedantic doesn't seem to complain about this.  And  
("a") is just as much a constant expression as "a".  Are you sure it's  
not just a tcc bug?

In any case, 642f85faa is talking about this:

   static const char ignore_error[] = ("something");

which is assigning a const char * to a const char [].

But builtin/log.c uses this:

   static const char * const builtin_log_usage[] = {("something",  
"else"};

Which is assigning a const char * to a const char * const.

Anyhow, if it breaks some existing compiler that works now, it  
shouldn't be picked up.  But it would sure be nice to have something  
to prevent a recurrence of the bug 1/2 fixes.  Perhaps the (msgid)  
version should be enabled when __GNUC__ is defined -- that should be  
compatible and enough folks use that it would catch such a problem  
early.

-Kyle
