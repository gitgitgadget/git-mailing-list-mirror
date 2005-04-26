From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 17:48:31 -0700
Message-ID: <426D8FDF.5050608@zytor.com>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org> <426D3B01.8060408@zytor.com> <Pine.LNX.4.58.0504251729080.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 02:44:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQEBK-00031X-Dl
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 02:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDZAtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDZAtI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:49:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:39380 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261196AbVDZAtA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 20:49:00 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3Q0mbZa017477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Apr 2005 17:48:37 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251729080.18901@ppc970.osdl.org>
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
>>No, mktime() always uses the local time zone.  It's the inverse of 
>>localtime().
> 
> Note that this still doesn't make any sense.
> 
> A true inverse of "localtime()" should still take the GMT offset from
> "struct tm", and it would work fine, assuming that localtime() set that
> offset correctly.
> 
> So _I_ think it's incredibly stupid that mktime() looks at the local 
> timezone. 
> 
> Oh, well.  Not a big issue except for the date conversion, and since there 
> hopefully aren't any old repo's left, we can leave it behind us.
> 

It *is* incredibly stupid, but dates back to the fact that a the GMT 
offset field in struct tm is a reasonably recent invention, and a lot of 
old code depended on just stuffing fields in struct tm and calling 
mktime(); they would leave the offset field uninitialized, as opposed to 
setting it to some well-defined "I don't know" value.

What totally blows is that if mktime() can't be fixed, that we haven't 
added mktime_have_offset() or something like that.

Oh well.  If you have the offset, the algorithm is fully arithmetric and 
doesn't rely on the zoneinfo system, so it can be trivially implemented. 
   And again, curl_gettime() does handle the whole string to time_t 
conversion of the common formats.

	-hpa

