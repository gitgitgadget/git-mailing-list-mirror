From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] git-compat-util: do not step on MAC_OS_X_VERSION_MIN_REQUIRED
Date: Fri, 6 Feb 2015 12:43:26 -0800
Message-ID: <1FC680E6-2258-4DBB-802C-6FB62D29C378@gmail.com>
References: <f2a35ed9fba20d48ef5736ee4564101@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cT0-ftZZyRORx-W2_Nit6XdgrpiyGS=pRjGtHoz1jW+Kg@mail.gmail.com> <28F603A7-610B-4711-9D2F-CD9866C96A74@gmail.com> <xmqq7fvuhkl3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJpkU-0004np-G2
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 21:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbBFUna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 15:43:30 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39408 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbBFUn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 15:43:29 -0500
Received: by mail-pa0-f48.google.com with SMTP id ey11so19537112pad.7
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 12:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=GnjOXOvUyUsDy9156/++TCk6XnFlCsq0vf0wS8XE+xY=;
        b=IkXCJo+9WsrmVL/WkhM6p6okHyWCEOrpQFdtraWhdDEEb+B9LqkGnxnAiYt1ijMZlV
         acykjqcGA7y4AqbiHmYEHh7XfqEb8XF5uPGd53guAIfcUu+r23SX90huxAZ4eAQbYfOJ
         tI/vnVtkUZ0iDZ9Kgu3QW4lc+4nUOvWUxECl+2jo+I8Hx3to2MTFF4B0ja76Q71n1IQl
         P/wC90mNb9EHW/vYLa5Qz4pyxIvPmR9A/Y1AlCVXWz/QgeqnuyZ8UNFRo3EXVJLHwgKS
         kj6hdhAchaoP4UkrsfrPBfLveVt+VCDDOYWNNHBN3XzmQj8rfQC+5l3YnU02WL92KNjA
         OD0Q==
X-Received: by 10.66.141.42 with SMTP id rl10mr8679897pab.124.1423255408991;
        Fri, 06 Feb 2015 12:43:28 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id q2sm8941762pde.27.2015.02.06.12.43.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 06 Feb 2015 12:43:28 -0800 (PST)
In-Reply-To: <xmqq7fvuhkl3.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263427>

On Feb 6, 2015, at 12:05, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> Actually I just tested it.  If we #undef it we could end up producing
>> these:
>>
>>   error: syntax error before DEPRECATED_ATTRIBUTE
>>
>> So I think it needs to stay #define'd to nothing to be safe in case
>> anything later on ends up including stuff that uses it.
>
> Doesn't the fact that your test failed indicates that it is not jsut
> "to be safe in case" but is required for correctness?
>
> The first hit for "MAC_OS_X_VERSION_MIN_REQUIRED" was this:
>
>  https://opensource.apple.com/source/CarbonHeaders/CarbonHeaders-18.1/AvailabilityMacros.h
>
> which marks quite a many macros to that value.  I do not know what
> changes they make to openssl/*.h (which is included just after the
> above header is included, but I would imagine that is where the
> AVAILABLE_MAC_OS_X_VERSION_XXX_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_VERSION_YYY
> macros are checked and annoying warnings that are being squelched by
> the previous change are given?

Yes.

Although Eric didn't specify exactly where when he suggested adding  
this:

On Feb 6, 2015, at 02:00, Eric Sunshine wrote:
>    #ifdef __APPLE__
>    #undef DEPRECATED_ATTRIBUTE
>    #endif


I took the suggestion to be after the openssl/*.h headers are included  
which would avoid the error of having DEPRECATED_ATTRIBUTE be #undef'd  
for them.  But, even math.h can end up including AvailabilityMacros.h,  
so I think #undef'ing DEPRECATED_ATTRIBUTE after the openssl/*.h  
headers are included would be unsafe in general.  While we might  
happen to get away with that today, if say compat/apple-common- 
crypto.h changes in the future (or for that matter any sequence of  
includes in other files or any headers in the Apple SDK) we could  
start seeing the error.

TLDR; yeah, DEPRECATED_ATTRIBUTE needs to remain defined to nothing.

-Kyle
