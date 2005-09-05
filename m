From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Moved files and merges
Date: Mon, 05 Sep 2005 08:16:55 -0700
Message-ID: <431C6167.4070703@zytor.com>
References: <4318E754.9000703@zytor.com>	<7vek87djat.fsf@assigned-by-dhcp.cox.net>	<7vek867e29.fsf@assigned-by-dhcp.cox.net>	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>	<20050903190500.GB8379@mars.ravnborg.org>	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>	<20050903220355.GA1895@mars.ravnborg.org>	<7v64thl248.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0509041329340.23242@iabervon.org> <7vvf1gejjf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 17:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECIj4-0000Qy-UJ
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 17:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVIEPRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 11:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVIEPRa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 11:17:30 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:40089 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932304AbVIEPR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 11:17:29 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j85FGuJv029484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2005 08:16:57 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf1gejjf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8094>

Junio C Hamano wrote:
> 
>>  1
>> / \
>>0-2-3-5-7
>>   \   /
>>    4-6
>>
>>It shouldn't matter to the merge at 7 if the 2-3 reorganization was done 
>>locally, by applying a patch, or by merging.
> 
> 
> There was another problem in my message that treated #3
> specially.  I did it that way primarily because I wanted to have
> an algorithm that needs to look only limited (namely, one)
> number of commits, more than what we currently look at.  The
> problem is that the trail #0..#1..#3 (in the example in second
> message, whose rename probably happened between #0 and #1) may
> change the contents of the renamed file so drastically that diff
> between #2 and #3 may not look like rename anymore, while we
> could still detect it if we followed the whole trail and looked
> for renames between each commit on it.
> 

One question, of course, is if one should simply keep additional 
metadata around to handle this sort of situations.  One could, for 
example, keep a UUID for each file, which would be carried over by the 
renaming commit.  If one runs into a tree which doesn't have the UUIDs, 
they should be generated at that time (this could be a bit tricky to do 
without invalidating all signatures in the tree, since the obvious way 
-- adding it to the tree object -- would invalidate all the commit and 
tag objects.)

In some ways this is similar to the Unix filesystem model of separating 
location (pathname) from identity (device:inode).

It would also hade the somewhat interesting possibility that one could 
"remove and recreate" a file and have it exist as a different entity. 
That probably needs to be a user option.

	-hpa
