From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 18:05:45 -0700
Message-ID: <426D93E9.10407@zytor.com>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org> <426D3B01.8060408@zytor.com> <Pine.LNX.4.58.0504251729080.18901@ppc970.osdl.org> <426D8FDF.5050608@zytor.com> <Pine.LNX.4.58.0504251756190.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 03:01:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQERl-0004ZU-0U
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 03:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDZBGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 21:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDZBGL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 21:06:11 -0400
Received: from terminus.zytor.com ([209.128.68.124]:54228 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261248AbVDZBGJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 21:06:09 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3Q15ojT017703
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 18:05:50 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251756190.18901@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, H. Peter Anvin wrote:
> 
>>Oh well.  If you have the offset, the algorithm is fully arithmetric and 
>>doesn't rely on the zoneinfo system, so it can be trivially implemented. 
> 
> You have a different definition of "trivial" than I do. I have not a 
> frigging clue how to handle leap seconds etc ;)
> 

Leap seconds don't exist in the POSIX time_t universe, so they always obey:

	... + 3600*hour + 60*min + sec

... which means that during a positive leap second, time_t remains 
unchanged for 2 seconds, and for a negative leap second time_t jumps. 
Thus, the difference between two time_t doesn't always match the exact 
number of seconds between those two points in time.

> 
>>   And again, curl_gettime() does handle the whole string to time_t 
>>conversion of the common formats.
> 
> I don't doubt you, I just would prefer to not rely on boutique libraries 
> too much. 
> 
> Yeah, we already use it for http-pull, so I guess it's moot, but at least 
> that felt less like a core command..
> 

If we're already using libcurl, we might as well.  Otherwise, I'd just 
rip out curl_gettime from the libcurl sources.

	-hpa
