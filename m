From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 09:42:08 -0600
Organization: CAF
Message-ID: <201109260942.08299.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109251443.28243.mfick@codeaurora.org> <4E809AFE.6010901@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:42:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8DJx-0008Hw-Uz
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1IZPmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 11:42:11 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:1132 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab1IZPmK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 11:42:10 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6480"; a="121605923"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 08:42:10 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2CFCA10004BE;
	Mon, 26 Sep 2011 08:42:10 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4E809AFE.6010901@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182124>

On Monday, September 26, 2011 09:32:14 am Michael Haggerty 
wrote:
> On 09/25/2011 10:43 PM, Martin Fick wrote:
> > A coworker of mine pointed out to me that a simple
> > 
> >   git checkout
> > 
> > can also take rather long periods of time > 3 mins when
> > run on a repo with ~100K refs.
> > 
> > While this is not massive like the other problem I
> > reported, it still seems like it is more than one
> > would expect.  So, I tried an older version of git,
> > and to my surprise/delight, it was much faster (.2s). 
> > So, I bisected this issue also, and it seems that the
> > "offending" commit is
> 
> > 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07:
> I'm still working on changes to store references
> hierarchically in the cache and read them lazily.  I
> hope that it will help some scaling problems with large
> number of refs.
> 
> Unfortunately I keep getting tangled up in side issues,
> so it is taking a lot longer than expected.  But there's
> still hope.
> 
> Michael

Thanks Michael, I look forward to those changes.  In the 
meantime however, I will try to take advantage of the 
current inefficiencies of large ref counts to attempt to 
find places where there are obvious problems in the code 
paths.  I suspect that there are several commands in git 
which inadvertently scan all the refs when they probably 
shouldn't.  Since this is likely very slow now, it should be 
easy to find those, if it were faster, this might get 
overlooked.  I feel like git checkout is one of those cases, 
it does not seem like git checkout should be affected by the 
number of refs in a repo?

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
