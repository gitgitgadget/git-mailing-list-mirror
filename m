From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Merging changes from branches where file paths have changed
Date: Sat, 14 Apr 2012 21:49:46 +0200
Message-ID: <4F89D4DA.8010407@kdbg.org>
References: <CA+39Oz7m1hGrTEdpSAjBP3EDFSVyKdc6T9CORcwQkjuEbvD4Ug@mail.gmail.com> <4F89CE36.4000607@kdbg.org> <CA+39Oz5Jc8Tj6WX+836h_fA6qHDYp6guaoniF6LX027MFHhP0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8yo-0002h8-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab2DNTtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:49:49 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:36033 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab2DNTts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:49:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F210F2C4002;
	Sat, 14 Apr 2012 21:50:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F276119F69F;
	Sat, 14 Apr 2012 21:49:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <CA+39Oz5Jc8Tj6WX+836h_fA6qHDYp6guaoniF6LX027MFHhP0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195512>

Am 14.04.2012 21:36, schrieb Thomas Adam:
> Hello,
> 
> On 14 April 2012 20:21, Johannes Sixt <j6t@kdbg.org> wrote:
>> You have these histories
>>
>>
>>  A--o--B--C--o--o--D--o--E   <- RepoA
>>
>>  A'----B'-C'                 <- RepoB
>>
>> and you want to cherry-pick D and E to RepoB. Right?
> 
> Yes, that's about right.
> 
>> I suggest that you install a graft in RepoB, then cherry-pick D and E:
>>
>>  echo $(git rev-parse C' C) >> .git/info/grafts
> 
> Can you elaborate on this a little more please?  Or point me towards
> some documentation.  Note that due to the way git-filter-branch works,
> although the history between RepoA and RepoB are common, the commit
> IDs between the two are completely different; presumably
> git-filter-branch uses patch-id at some level to reform commits.
> Nevertheless, if I'm understanding superficially what this graft is
> supposed to do, I do not see how getting a list of commits from C' to
> C is going to help in repoB when neither RepoA or RepoB have any
> ancestry in common?

There is no "list of commits from C' to C". Look carefully: it's
rev-parse, not rev-list. The command above only states that the (only)
parent of C' is C, i.e., it fakes this history:

  A--o--B--C--o--o--D--o--E   <- RepoA
            \
             C'               <- RepoB

and then the two repositories have history in common.

And BTW:

1. C' must be the top-most commit that was derived from RepoA.

2. If D or E add new paths, they will not be moved to the root by the
cherry-pick. Be sure to check the result.

3. If you have additional commits in RepoB that were not derived from
RepoA, it may not work out as smoothly, if the changes are so large that
rename detection does not kick in anymore.

-- Hannes
