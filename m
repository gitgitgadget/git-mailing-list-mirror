From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 16:42:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504191629410.26365@qynat.qvtvafvgr.pbz>
References: <200504191250.10286.mason@suse.com><Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com><Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org><Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz><Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org><Pine.LNX.4.62.0504191557410.26365@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.58.0504191608230.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 01:40:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO2Ju-0004wg-86
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVDSXoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDSXoB
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:44:01 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:21185 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261189AbVDSXn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:43:56 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Tue, 19 Apr 2005 16:38:49 -0700
Received: by ATHEXC01 with Internet Mail Service (5.5.2657.72)
	id <JC0B7RY6>; Tue, 19 Apr 2005 19:42:24 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JDHHA7S1; Tue, 19 Apr 2005 16:42:33 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0504191608230.2274@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Linus Torvalds wrote:

> On Tue, 19 Apr 2005, David Lang wrote:
>>
>> if you are useing quilt for locally developed patches I fully agree with
>> you, but I was thinking of the case where Andrew is receiving independant
>> patches from lots of people and storing them in quilt for testing, and
>> then sending them on to you. In this case the patches really are
>> independant and it may be useful to continue to treat them this way
>> instead of collapsing them into one 'update from Andrew' feed.
>
> If so, he should set up one repository per quilt patch.

a tool to do this automaticaly is what I was trying to suggest (and asking 
if it would be useful)

> That would be crazy, but yes, it would allow me to cherry-pick which
> one(s) I want to merge with.
>
> But the fact is, that cherry-picking should happen at quilt-time not at
> git time.

Ok, I could see arguments for both methods. if the forest of disposeable 
repositories is fast enough and flexible enough there is some value of 
getting patches into git as quickly as possible, and not having to fan 
them out to quilt as an intermediate step, but it may not be enough value 
to be worth the added complexity.

not being at all familar with quilt (in fact haveing never seen it, just 
seen it discussed here and LKML), how painful would it be to try and 
implement it useing git as a back-end? you would end up with a bunch of 
extra objects that you will ignore (they are parts of branches that you 
throw away), but I don't know if that space cost (plus the cost of the 
extra trees in git) is going to be too high.

this brings up a thought, is there a way to point at a bunch of 
repositories (trees) and a collection of objects and tell git to purge any 
objects that don't have anything linking to them? in the short-medium term 
this isn't a problem, but in the long term you will have extra objects 
being created and then orphaned when a branch gets thrown away that will 
eventually amount to a noticable amount of space.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
