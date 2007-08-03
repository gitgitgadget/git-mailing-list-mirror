From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 3 Aug 2007 08:48:13 +0200
Message-ID: <2FEBD7A5-9932-4636-955D-F7E258F8E56E@zib.de>
References: <46AFCF3E.5010805@alum.mit.edu>  <8b65902a0708010438s24d16109k601b52c04cf9c066@mail.gmail.com>  <46B1F96B.7050107@alum.mit.edu> <46a038f90708021608o21480074ybcfada767afc7b04@mail.gmail.com> <Pine.LNX.4.64.0708030454200.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	git@vger.kernel.org, users@cvs2svn.tigris.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqz8-0004gx-Gx
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbXHCGty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756518AbXHCGty
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:49:54 -0400
Received: from mailer.zib.de ([130.73.108.11]:56403 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321AbXHCGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 02:49:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l736lMQA014666;
	Fri, 3 Aug 2007 08:49:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l736lKRu008640
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 3 Aug 2007 08:47:21 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708030454200.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54677>


On Aug 3, 2007, at 6:03 AM, Johannes Schindelin wrote:

> On Fri, 3 Aug 2007, Martin Langhoff wrote:
>
>> On 8/3/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> cvsps is not a conversion tool at all, though it is used by other
>>> conversion tools to generate the changesets.  It appears (I hope  
>>> I am
>>> not misinterpreting things) to emphasize speed and incremental
>>> operation, for example attempting to make changesets consistent  
>>> from one
>>> run to the next, even if the CVS repository has been changed  
>>> prudently
>>> between runs.  cvsps does not appear to attempt to create atomic  
>>> branch
>>> and tag creation commits or handle CVS's special vendorbranch  
>>> behavior.
>>>  cvsps operates via the CVS protocol; you don't need filesystem  
>>> access
>>> to the CVS repository.
>>
>> 100% in agreement. And though I can't claim to be happy with  
>> cvsps, in
>> many scenarios it is mighty useful, in spite of its significant  
>> warts.
>>  The "does incrementals" is hugely important these days, as lots of
>> people use git to run "vendor branches" of upstream projects that use
>> CVS.
>
> Me too: 100% agreement.  A couple of people seem to be content to  
> proclaim
> that their incomplete solutions are better, but in the end of the day,
> they are as bad as the programs they purport to replace: incomplete.
>
> For the moment, I help myself with tracking the different branches
> individually, but there, really, git-cvsimport is as good as the other
> "solutions", with the further advantage that they are actually  
> hackable,
> and not closed to everybody outside a very small community.

I just want to add a warning. You should be suspicious of branched  
imported
using git-cvsimport (which is based on cvsps). If the time the branch is
created differs from the time of the first commit to the branch git- 
cvsimport
may get the branching point wrong. This introduces a race condition.  
Someone
may have committed changes to a file that is later changed on the  
branch. At
that point the history of the imported branch is broken and git reports
_wrong_ changesets.

I ran into this issue and abandoned the use of git-cvsimport. It's  
too dangerous
for me. The testcase in [1] illustrates the problem. I still strongly  
believe
the warning should be stated in *BOLD* in the documentation.

I'm not saying git-cvsimport is useless. But you should be suspicious  
about
the result of the import, especially if you plan to rely on  
changesets derived
from the imported repo, for example if you plan to do cherry-picking  
or merging
in git; or if you plan to blame people for their stupid changes based  
on what
you see in gitk (almost happend to me ;).

	Steffen

[1] http://marc.info/?l=git&m=118260312708709&w=2
