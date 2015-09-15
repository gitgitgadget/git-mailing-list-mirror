From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 20:15:26 +0100
Message-ID: <55F86E4E.3030002@ramsayjones.plus.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <55F8643D.6040800@ramsayjones.plus.com>
 <20150915184211.GA31939@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbvhU-0002Ks-KU
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 21:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbIOTP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 15:15:28 -0400
Received: from avasout08.plus.net ([212.159.14.20]:37453 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbIOTP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 15:15:28 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id HXFP1r0082FXpih01XFQSK; Tue, 15 Sep 2015 20:15:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=RjNhV3nleeL-PidxTMAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150915184211.GA31939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277982>



On 15/09/15 19:42, Jeff King wrote:
> On Tue, Sep 15, 2015 at 07:32:29PM +0100, Ramsay Jones wrote:
>
>>> diff --git a/archive-tar.c b/archive-tar.c
>>> index b6b30bb..d543f93 100644
>>> --- a/archive-tar.c
>>> +++ b/archive-tar.c
>>> @@ -301,7 +301,7 @@ static int write_global_extended_header(struct archiver_args *args)
>>>  	memset(&header, 0, sizeof(header));
>>>  	*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
>>>  	mode = 0100666;
>>> -	strcpy(header.name, "pax_global_header");
>>> +	xsnprintf(header.name, sizeof(header.name), "pax_global_header");
>> How about using strlcpy() instead? Thus:
>>
>> -	strcpy(header.name, "pax_global_header");
>> +	strlcpy(header.name, "pax_global_header", sizeof(header.name));
>>
>> Ditto for other similar (strcpy->xsnprintf) hunks below.
> That misses the "assert" behavior of xsnprintf. We are preventing
> overflow here, but also truncation. What should happen if
> "pax_global_header" does not fit in header.name? I think complaining
> loudly and immediately is the most helpful thing, because it is surely a
> programming error.
>
> We could make xstrlcpy(), of course, but I don't see much point when
> xsnprintf does the same thing (and more).

Heh, I just sent an email about patch 22/67 which says similar things. I don't feel
too strongly, either way, but I have a slight preference for the use of [x]strlcpy()
in these cases.

I have to stop at patch #22 for now.

ATB,
Ramsay Jones
