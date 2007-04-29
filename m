From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sun, 29 Apr 2007 13:40:19 -0700
Message-ID: <84F8DDF3-BCF5-4C2A-9C90-38AE139D7178@apple.com>
References: "Pine.LNX.4.64.0704281303371.28708@iabervon.org" <46339819.8030007@freedesktop.org> <Pine.LNX.4.64.0704291416370.28708@iabervon.org> <4635003F.7080408@freedesktop.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 22:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiGCJ-0007R2-60
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 22:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbXD2Ukj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 16:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbXD2Ukj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 16:40:39 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:54399 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbXD2Uki (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 16:40:38 -0400
Received: from relay7.apple.com (relay7.apple.com [17.128.113.37])
	by mail-out3.apple.com (8.13.8/8.13.8) with ESMTP id l3TKeZFE011346;
	Sun, 29 Apr 2007 13:40:35 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id 71B8B30012;
	Sun, 29 Apr 2007 13:40:35 -0700 (PDT)
X-AuditID: 11807125-a144fbb00000097b-46-463502c376be 
Received: from [17.219.212.71] (unknown [17.219.212.71])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay7.apple.com (Apple SCV relay) with ESMTP id 1609230006;
	Sun, 29 Apr 2007 13:40:35 -0700 (PDT)
In-Reply-To: <4635003F.7080408@freedesktop.org>
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45838>

On Apr 29, 2007, at 1:29 PM, Josh Triplett wrote:

> Daniel Barkalow wrote:
>> On Sat, 28 Apr 2007, Josh Triplett wrote:
>>> Daniel Barkalow wrote:
>>>> It was implemented in commit.c; move it with the other x memory  
>>>> functions.
>>> [...]
>>>> +static inline char *xstrndup(const char *str, int len)
>>>> +{
>>>> +	char *ret = xmalloc(len + 1);
>>>> +	memcpy(ret, str, len);
>>>> +	ret[len] = '\0';
>>>> +	return ret;
>>>> +}
>>>> +
>>> I don't know if it matters, but this definition of xstrndup, like  
>>> the version
>>> in commit.c, doesn't match the definition of strndup.  strndup  
>>> duplicates a
>>> string, copying up to n characters or the length of the string.   
>>> This xstrndup
>>> always copies n characters, reading past the end of the string if  
>>> it doesn't
>>> have at least n characters.
>>
>> Good catch. Replacing the memcpy with strncpy solves this, right?
>> (Potentially allocating a bit of extra memory if someone is  
>> actually using
>> it on too short a string for some reason, of course).
>
> That would work, but it seems bad to allocate excess memory.  How  
> about just
> using strlen and setting len to that if shorter, before doing the  
> xmalloc and
> memcpy?  Yes, that makes two passes over the string, but I don't  
> see any way
> around that.

    An easy way around that is to do the string copy yourself,  
walking the string until you either find '\0' or reach len copied  
characters.

-Adam
