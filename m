From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 11:24:20 -0800
Message-ID: <204011cb0701041124g40440fd4udf1088ab1341c031@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 20:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2YCc-0002yj-Ho
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 20:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXADTYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 14:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbXADTYW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 14:24:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:23314 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbXADTYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 14:24:21 -0500
Received: by wr-out-0506.google.com with SMTP id 68so928402wri
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 11:24:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gUVqmjxNyE+G9EFSZtWrofsZ6df5/eETLcGQufYSYDOsHA1n0ArBaiteEQDoAVvKHiogtl/IWnJHDK1anZHpRbfHZTK+DGbQEjvDP+584VaRpiLdMgCm6DSQuSG5ej73QThUTTVf1oHZiEmA7qFYvxfyBHflqzCNotby2fEI/8A=
Received: by 10.90.78.9 with SMTP id a9mr310023agb.1167938660988;
        Thu, 04 Jan 2007 11:24:20 -0800 (PST)
Received: by 10.90.83.17 with HTTP; Thu, 4 Jan 2007 11:24:20 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35948>

On 1/3/07, Linus Torvalds <torvalds@osdl.org> wrote:
> > Checking `top` and `ps` revealed that there were no git-svnimport
> > processes doing anything, but all of my 4G of RAM was still marked as
> > used by the kernel. I had to do sysctl -w vm.drop_caches=3 to get it
> > to free all the RAM that the svn import had used up.
>
> I think that was just all cached, and all ok. The reason you didn't see
> any git-svnimport was that it had died off already, and all your memory
> was just caches. You could just have left it alone, and the kernel would
> have started re-using the memory for other things even without any
> "drop_caches".
>
> But what you did there didn't make anything worse, it was just likely had
> no real impact.

Thought it was worth mentioning this:

When I checked top, the numbers it showed me were:
Mem:   4059332k total,  3216480k used,   842852k free,    40824k buffers
Swap:        0k total,        0k used,        0k free,    37364k cached

40MB in buffers, 37MB in cache, and 3GB used.

Seems like *something* was definitely lost there. The 'used' number
didn't go down at all when I started doing other things; it went up as
the new programs started, then they used up some RAM, and then when
they exited they'd free whatever resources they'd used. However, until
I did the drop_caches, that number stayed pretty damn big.

The system has been up since then, doing lots of things, and still
seems pretty stable, so I think it's okay, but I thought that it was
worth mentioning that something seemed to be leaky.
