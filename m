From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 16:17:59 -0700
Message-ID: <4831E838-1373-42F6-B490-2D2943E319C9@gmail.com>
References: <20140522094251.GA14994@sigill.intra.peff.net> <20140522094424.GB15255@sigill.intra.peff.net> <CAP8UFD0PkA_VokFpRkdaKE2UW1AtL6mCY2bOSxOCqX_C9wB=OQ@mail.gmail.com> <20140522134253.GA16408@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 23 01:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncFU-000176-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbaEVXSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:18:04 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:64665 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbaEVXSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:18:03 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so3209477pbc.0
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=uHH0JIIRwueuJ+TMs8iQHkCKoGd4iNFa5bVM2qXX8ww=;
        b=ld765XxkbK2Bl6/jQDBdjSQiiXJU88YTMypZEaLQLPUxJYONj5mkC9jSpYJnwvanYP
         kOajMUgSgNvdflmueMLiABSIgsZuTjiaREEGqVwn3YL8gr7vtwLvHCLWCB23Bl4pfcUs
         0aAmqnWP+lA61MI0cr2KrNCTyiVz0Co6Q3wxSY1JWNApJGALhPG4e5U1069kJ4RxXeV5
         eMuCv0evv2cOVatqkJBRtRkiv2LyKsJI66IgRIXQhaQYjBqMOVDqI4e9agqVfSJfJ89b
         rgx6VDTK09wGacottPR29D78k/WiDysIIyDw55RfrnhKlivoH5/Q19fKunyZf0hTEa+x
         ZaIA==
X-Received: by 10.68.231.229 with SMTP id tj5mr891906pbc.101.1400800682483;
        Thu, 22 May 2014 16:18:02 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id vx10sm5127458pac.17.2014.05.22.16.18.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:18:01 -0700 (PDT)
In-Reply-To: <20140522134253.GA16408@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249961>

On May 22, 2014, at 06:42, Jeff King wrote:

> [re-adding list cc]
>
> On Thu, May 22, 2014 at 03:16:45PM +0200, Christian Couder wrote:
>
>>> +void strbuf_tolower(struct strbuf *sb)
>>> +{
>>> +       char *p;
>>> +       for (p = sb->buf; *p; p++)
>>> +               *p = tolower(*p);
>>> +}
>>
>> Last time I tried a change like the above, I was told that strbufs  
>> are
>> buffers that can contain NUL bytes. So maybe it should be:
>>
>>       for (p = sb->buf; p < sb->buf + sb->len; p++)
>>              *p = tolower(*p);
>
> Hah. I wrote it like that originally, and in review was asked to  
> switch
> it. I agree that it might be worth keeping strbuf functions 8bit- 
> clean.
> The original intent of the strbuf code was to make C strings easier to
> use, but I think we sometimes use them as general buffers, too.


I didn't see this patch before I sent the other email, but this is the  
relevant part:

On May 22, 2014, at 15:52, Kyle J. McKay wrote:
> The only reason I brought up the code difference in the first place  
> was that the comment was "This makes config's lowercase() function  
> public" which made me expect to see basically the equivalent of  
> replacing a "static" with an "extern", but actually the function  
> being made public was a different implementation than config's  
> lowercase() function.  So it looks like the original PATCH 2/9  
> version of the code is best, but perhaps the comment can be tweaked  
> a bit to not convey the same impression I got.  Maybe something like  
> "Replace config's lowercase() function with a public one".


Or even just delete the "This makes config's lowercase() function  
public" line after switching the implementation back.

--Kyle
