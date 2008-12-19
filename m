From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Odd merge behaviour involving reverts
Date: Fri, 19 Dec 2008 12:44:52 +0900
Message-ID: <20081219124452.6117@nanako3.lavabit.com>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
 <1229642734.5770.25.camel@rotwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alan <alan@clueserver.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 04:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWKC-0000Aq-Dr
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYLSDpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbYLSDpc
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:45:32 -0500
Received: from karen.lavabit.com ([72.249.41.33]:52380 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbYLSDpb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:45:31 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C12B0C8441;
	Thu, 18 Dec 2008 21:45:30 -0600 (CST)
Received: from 9623.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 0Q2YQYB4B6DW; Thu, 18 Dec 2008 21:45:30 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=bBhkhR+mOqAeJeoCPR0ovHvRXYAdarXeT/4D7/SOet/uJFFxcRG6cSnKEsdOFIH+FpeCcqAULEl+lNXcXpntHluB7UCskc2HYDSmk+aDmWx/YS89HBkzfCwLjFh1C23TlQ9mz5EZ8KDjqjc5L1RzZpRDfhrRdE1T1NrtvkzFkv0=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103538>

Quoting Linus Torvalds <torvalds@linux-foundation.org>:

> On Thu, 18 Dec 2008, Alan wrote:
>> 
>> What am i doing wrong here?
>
> Reverting a merge is your problem.
>
> You can do it, but you seem to have done it without understanding what it 
> causes.
>
> A revert of a merge becomes a regular commit that just undoes everything 
> that the merge did in your branch. When you then do the next merge, you'll 
> do that merge with that in mind, so now git will essentially consider the 
> previous merge to be the base line, but your revert undid everything that 
> that one brought in, so the new merge will really only contain the new 
> stuff from the branch you are merging. 
>
> So if a merge causes problems, you generally should either undo it 
> _entirely_ (ie do a 'git reset --hard ORIG_HEAD'), not revert it. 
>
> Of course, if you had already made the merged state public, or done 
> development on top of it, you can't really do that. In which case a revert 
> works, but if you want it back, you should revert the revert, not merge 
> the branch again - because what you merged last time you threw away, and 
> won't be applied again.

If I understand Alan's case correctly, I think he does not want to "undo" the revert but wants to merge an updated version of the branch, as if no mistaken merge nor its revert happened in the past.

If you revert the revert on the branch before merging, doesn't it mean that you will be merging what the older version of the branch did (that is in the revert of the revert as a single huge patch) and what the updated version of the branch wants to do?  Wouldn't that lead to a mess with huge conflicts?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
