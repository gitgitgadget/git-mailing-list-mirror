From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if  specified
Date: Sat, 7 Apr 2007 18:53:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704071846340.25121@qynat.qvtvafvgr.pbz>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com><al
 pine.LFD.0.98.0704052103410.28181@xanadu.home><56b7f5510704051919v7daac590m
 6ac52c4fcabd5321@mail.gmail.com><alpine.LFD.0.98.0704052257200.28181@xanadu
 .home><Pine.LNX.4.64.0704060845120.6730@woody.linux-foundation.org><56b7f55
 10704061109n2878a221p391b7c3edba89c63@mail.gmail.com><Pine.LNX.4.64.0704061
 214230.6730@woody.linux-foundation.org> <7v1wixjfpo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 04:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaN4V-0000FV-6M
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 04:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966039AbXDHCX6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 22:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966043AbXDHCX6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 22:23:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:49231 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S966039AbXDHCX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 22:23:57 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 7 Apr 2007 19:23:56 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 07 Apr 2007 19:23:26 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v1wixjfpo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43994>

On Fri, 6 Apr 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Fri, 6 Apr 2007, Dana How wrote:
>
> And I agree with Nico that rollback after a failed write beyond
> the boundary may not work correctly, so if we really want to do
> this safely and sanely while satisfying Dana's desire to have a
> hard limit, I think something like this is needed:
>
> - use "starting offset" to decide when to split;
>
> - introduce a "hard limit", perhaps optionally, to make sure
>   that the result of writing out a packfile does not overstep
>   that limit (i.e. the last object written below the "starting
>   offset limit" might make the pack go over 700MB).
>
> which means you would specify 600 as starting offset limit and
> 680 (or something like that) as the hard tail offset limit
>
>> Again, *in*practice*, for any sane situation, if you want to fit things on
>> a CD-ROM, just give a limit of 600MB, and I can pretty much guarantee that
>> you'll see a slop of just a percent or two for any realistic setup. And if
>> it goes up to 660MB, you'll still fit on any CD.
>
> if you really care the result fits on a CD.

there are going to be cases whereeyou have a fixed size, but would really like 
to stream things rather then write a temp file and then send that (one example 
of wanting to stream things, but without the size cap is the network pull where 
we atart sending things before we've finished figuring out the details of what 
we are going to send). with the appropriately sized buffer you could stream to a 
CD burner for example, and while this may not make a huge difference in the time 
taken to make the CD, it will save you a significant amount of disk I/O and 
buffer space that is now still populated by info that's more useful to the user.

David Lang
