From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 9 Jul 2014 14:46:35 +0900
Message-ID: <CAFT+Tg8HZTsbWK2WHHg_q04LY5Vm7cjfNkfHGBEdbKjf1==rKw@mail.gmail.com>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
	<20140709051040.GB2318@sigill.intra.peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4kiF-0002Sf-R5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaGIFqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:46:36 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34396 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaGIFqf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:46:35 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so1498095igd.8
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 22:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VyU/Exe/W1xF3SrtqERh8GiDCJTRaOrBHUJY8ovRqoY=;
        b=okOYzf7Y7JKuGFO0Ag52jOOOCSADVWzj8n0xTplkvXkFwyHcQJC6d+bn2jt5UgbY2L
         ChEcMi3FWPIZ2ql2aRms6UE1YvG1sUEbwQ0YiazT0IwUfHfYYxsz1KUBFBWQ8E5YZDu2
         mEh6JayM9aZAFMXXctlmpd1EyGONAA588el435ltOFakJcAK5k/IQCE9r1h/I+gSG/wG
         y7KduvEiKcVsc2dgc1Qvhim7vwODRaqreXkgxKc0oYZCVL/YwgQJLQMo1NKR+/7DaYvM
         P0UajOYl9aK4Es9qlLSZG60H49UBcNpS9IPSI55FgxkrQLeZ3MwZzQjm8+pgTa2aIkQD
         hwzA==
X-Received: by 10.50.107.42 with SMTP id gz10mr9338459igb.15.1404884795081;
 Tue, 08 Jul 2014 22:46:35 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Tue, 8 Jul 2014 22:46:35 -0700 (PDT)
In-Reply-To: <20140709051040.GB2318@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253067>

2014-07-09 14:10 GMT+09:00 Jeff King <peff@peff.net>:
> On Wed, Jul 09, 2014 at 12:54:06AM +0900, Yi EungJun wrote:
>
>> From: Yi EungJun <eungjun.yi@navercorp.com>
>>
>> Add an Accept-Language header which indicates the user's preferred
>> languages defined by 'LANGUAGE' environment variable if the variable is
>> not empty.
>>
>> Example:
>>   LANGUAGE= -> ""
>>   LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
>>   LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"
>>
>> This gives git servers a chance to display remote error messages in
>> the user's preferred language.
>
> Should this also take into account other language-related variables? I'd
> think $LC_ALL, $LC_MESSAGES, and $LANG would affect it, too.  Are
> colon-separated values a standard in $LANGUAGE? I have never seen them,
> but I admit I am not very knowledgeable about localization issues.
>
> Also, we do we need to do more parsing? My $LANG is set to en_US.UTF-8.
> The encoding part is presumably uninteresting to the remote server.  I
> also wonder if there are support functions in libc or as part of gettext
> that can help us get these values.
>
> -Peff

I agree with you. In fact, I tried to get user's preferred language in
the same way as gettext. It has guess_category_value() to do that and
the function is good enough because it considers $LANGUAGE, $LC_ALL,
$LANG, and also system-dependent preferences. But the function does
not seem a public API and I don't know how can I use the function in
Git. So I chose to use $LANGUAGE only.
