From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 15:22:50 +0100
Message-ID: <CABPQNSabAcHEO0+ht7te9ScVigGOoCLdtiD10ye8AqqeLMagLw@mail.gmail.com>
References: <52FB2268.7080906@viscovery.net> <87mwhwa3s1.fsf@fencepost.gnu.org>
 <52FB7196.7060209@viscovery.net> <87ioska2iu.fsf@fencepost.gnu.org> <CACsJy8CW0shw5JYtXScQHMYJ+D18-UJ6HanP-5OCuv87kHbnBg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Kastrup <dak@gnu.org>, Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 15:23:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDaiu-0004tB-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 15:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaBLOXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 09:23:32 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35296 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaBLOXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 09:23:31 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so10989626oah.17
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YlcXv7JIHLkAXkAlOu6JIBdeBs3PDFdrsTiEWdotqJQ=;
        b=xcQg//wT3vgc8XL9/7a/5RCms+5995fAW/H1S4QYHGhy2LHG/R1OyU+1jnyPv+LPPQ
         MM35tRy9SyAyzLdyl+S5238uS2lb/HvnI0G/G9pUzAQYzJ1HMEPllra+7m2UNXaJTk+z
         GkJKac4wqPXlQxDa1Qpr8fwD02iO7LjUS55tU4p6TFdj6f/ia5+zD4FvOAGJUXMNDP07
         CQXhLbneX+CCqsrZ6c4FPOrbr3m+/ZTCvE7SitPibYFdwALgzUrWndFoWF1Leqfa7ZzC
         e0OyQ08lFZZEXsMVNlVJL2w1G8ZUEOWrAuTlTeCp1r7hLr4XpZePx6ZyCkoQz5Liv2fT
         ViTg==
X-Received: by 10.182.19.132 with SMTP id f4mr37013324obe.14.1392215011376;
 Wed, 12 Feb 2014 06:23:31 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 06:22:50 -0800 (PST)
In-Reply-To: <CACsJy8CW0shw5JYtXScQHMYJ+D18-UJ6HanP-5OCuv87kHbnBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241992>

On Wed, Feb 12, 2014 at 3:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 12, 2014 at 8:23 PM, David Kastrup <dak@gnu.org> wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Am 2/12/2014 13:55, schrieb David Kastrup:
>>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>>
>>>>> Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
>>>>> the following symptoms. I haven't followed the topic. Have there been
>>>>> patches floating that addressed the problem in one way or another?
>>>>>
>>>>> (gdb) run
>>>>> Starting program: D:\Src\mingw-git\t\trash
>>>>> directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap
>>>>> HEAD
>>>>> [New thread 3528.0x8d4]
>>>>> Bitmap v1 test (20 entries loaded)
>>>>> Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits
>>>>> / 15873b36 checksum
>>>>
>>>> Does reverting a201c20b41a2f0725977bcb89a2a66135d776ba2 help?
>>>
>>> YES! t5310 passes after reverting this commit.
>>
>> Oh.  I just looked through the backtrace until finding a routine
>> reasonably related with the regtest and checked for the last commit
>> changing it, then posted my question.
>>
>> Then I looked through the diff of the patch and considered it
>> unconspicuous.  So I commenced reading through earlier commits.
>>
>> I actually don't have a good idea what might be wrong here.  The code is
>> somewhat distasteful as it basically uses eword_t and uint64_t
>> interchangeably, but then this does match its current definition.
>
> Perhaps __BYTE_ORDER or __BIG_ENDIAN is misdefined and the ntohll() is skipped?

That is indeed the case.
