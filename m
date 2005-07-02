From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Fri, 01 Jul 2005 21:29:12 -0700
Message-ID: <42C61818.30109@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org> <42C5D553.80905@timesys.com> <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org> <42C61351.10306@zytor.com> <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 06:22:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoZWD-0004R2-3u
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 06:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVGBE34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 00:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVGBE34
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 00:29:56 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27059 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261789AbVGBE3y
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 00:29:54 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j624TCm8003945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Jul 2005 21:29:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 1 Jul 2005, H. Peter Anvin wrote:
> 
>>Any reason not to simply append objects to an existing packfile?
> 
> 
> What happens when somebody screws up in the middle?
> 
> The one thing I care about more than anything else is consistency. We are 
> careful about writing objects in the right order, and we can re-create the 
> state from the originator etc. But if we start appending stuff and 
> something goes wrong in the middle, I'm just not going to touch it. A 
> "truncate and hope for the best" algorithm? 
> 
> Besides, the result is not a valid git archive any more. 
> 

It's a log.  It's a standard technique to append entries to a log.  The 
requirements for this to always be consistent is that a) it's possible 
to know when the entry/entries at the end are inconsistent and b) it's 
always possible to roll back the log to a consistent state.

This is normally done with commit records (write data - fdatasync - 
write commit record - fdatasync), but in the case of git, the commit 
record isn't required because each git record is self-validating.  This 
is an incredibly powerful property.

If the log is written in topological sort order, then even a truncated 
log file is a valid (subset) git object store.

	-hpa
