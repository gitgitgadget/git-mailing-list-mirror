From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 15:52:04 -0600
Organization: CAF
Message-ID: <201109261552.04946.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk> <201109261539.33437.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8J5w-0006Y1-7I
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab1IZVwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:52:07 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:45362 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab1IZVwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:52:06 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6481"; a="121589984"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 14:52:06 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 2D95310004BE;
	Mon, 26 Sep 2011 14:52:06 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201109261539.33437.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182172>

On Monday, September 26, 2011 03:39:33 pm Martin Fick wrote:
> On Monday, September 26, 2011 02:28:53 pm Julian Phillips
> wrote:
> > >> Random thought.  What happens to the with
> > >> compression case if you leave the commit in, but
> > >> add a sleep(15) to the end of sort_refs_list?
> > > 
> > > Why, what are you thinking?  Hmm, I am trying this on
> > > the non gced repo and it doesn't seem to be
> > > completing (no cpu usage)!  It appears that perhaps
> > > it is being called many times (the sleeping would
> > > explain no cpu usage)?!?  This could be a real
> > > problem, this should only get called once right?
> > 
> > I was just wondering if the time taken to get the refs
> > was changing the interaction with something else.  Not
> > very likely, but ...
> > 
> > I added a print statement, and it was called four times
> > when I had unpacked refs, and once with packed.  So,
> > maybe you are hitting some nasty case with unpacked
> > refs.  If you use a print statement instead of a sleep,
> > how many times does sort_refs_lists get called in your
> > unpacked case?  It may well also be worth calculating
> > the time taken to do the sort.
> 
> In my case it was called 18785 times!  Any other tests I
> should run?

Gerrit stores the changes in directories under refs/changes 
named after the last 2 digits of the change.  Then under 
each change it stores each patchset.  So it looks like this:   
refs/changes/dd/change_num/ps_num

I noticed that:

 ls refs/changes/* | wc -l 
 -> 18876

somewhat close, but not super close to 18785,  I am not sure 
if that is a clue.  It's almost like each change is causing 
a re-sort,

 
-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
