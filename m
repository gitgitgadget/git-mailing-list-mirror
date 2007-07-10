From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: how to combine two clones in a collection
Date: Tue, 10 Jul 2007 14:27:39 -0400
Message-ID: <72218C10-EE5E-4CD9-B5DE-DFEC40EBEF27@silverinsanity.com>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org> <20070710062104.GA22603@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0707100950520.3412@woody.linux-foundation.org> <20070710174543.GA16054@piper.oerlikon.madduck.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 20:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8KR8-0004uj-R8
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 20:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759131AbXGJS1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbXGJS1m
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 14:27:42 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:42760 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbXGJS1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 14:27:41 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 954A21FFC01F;
	Tue, 10 Jul 2007 18:27:40 +0000 (UTC)
In-Reply-To: <20070710174543.GA16054@piper.oerlikon.madduck.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52104>


On Jul 10, 2007, at 1:45 PM, martin f krafft wrote:
> I wonder how to create a project with two completely independent
> branches which have no common ancestry. I don't think it's possible.
> One needs a throwaway branch to create the first commit, then branch
> each of the two branches off that, then delete the throwaya branch
> (or keep it around).
>
> But this is getting academic now...

But interesting.

What you describe won't create two independent branches.  They'll  
share the root commit.  I think what you have do is create the first  
branch as normal, then clear out the working copy (be sure not to  
delete .git) and do the commit manually.  I believe it goes something  
like this:

   git init
   # Create files for master
   git add .
   git commit
   rm -rf * .git/index
   # Create files for second branch
   git add .
   tree=$(git write-tree)
   # Edit commit message into some file (commit-msg here)
   commit=$(git commit-tree $tree < commit-msg)
   git update-ref refs/branches/independent $commit

The important bits are to be sure to remove the index so you don't  
commit the wrong files and the last four lines that do the heavy  
lifting.  You could also create the branch in a second repository and  
pull it from there into the first (probably simpler), or perhaps  
trick git-commit into thinking there isn't any commits yet (remove  
the index and HEAD perhaps?).

~~ Brian
