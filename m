From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 17:10:03 -0400
Message-ID: <426FFFAB.1030005@tmr.com>
References: <20050426135606.7b21a2e2.akpm@osdl.org><20050426135606.7b21a2e2.akpm@osdl.org> <20050427063439.GA22014@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
	mason@suse.com, torvalds@osdl.org, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:07:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtis-0002f6-OO
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 23:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVD0VKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 17:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVD0VKs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 17:10:48 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48270 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262017AbVD0VKh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 17:10:37 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j3RLA4V13010;
	Wed, 27 Apr 2005 17:10:08 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050427063439.GA22014@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>Magnus Damm <magnus.damm@gmail.com> wrote:
>>
>>>My primitive guess is that it was because
>>> the ext3 journal became full.
>>
>>The default ext3 journal size is inappropriately small, btw.  Normally 
>>you should manually make it 128M or so, rather than 32M.  Unless you 
>>have a small amount of memory and/or a large number of filesystems, in 
>>which case there might be problems with pinned memory.
>>
>>Mounting as ext2 is a useful technique for determining whether the fs 
>>is getting in the way.
> 
> 
> on ext3, when juggling patches and trees, the biggest performance boost 
> for me comes from adding noatime,nodiratime to the mount options in 
> /etc/fstab:
> 
>  LABEL=/ / ext3 noatime,nodiratime,defaults 1 1

I said much the same in another post, but noatime is not always what I 
really want. How about a "nojournalatime" option, so the atime would be 
updated at open and close, but not journaled at any other time. This 
would reduce journal traffic but still allow an admin to tell if anyone 
ever uses a file. The info would be lost in a crash, but otherwise 
preserved just as it is for ext2. Might even be useful for ext2, not to 
write the atime, just track it in core.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
