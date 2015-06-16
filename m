From: Eric Raible <raible@nextest.com>
Subject: Re: Visualizing merge conflicts after the fact (using kdiff3)
Date: Tue, 16 Jun 2015 13:17:18 -0700
Message-ID: <5580844E.7070805@nextest.com>
References: <557F791D.3080003@nextest.com> <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 22:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4xKc-0001y4-66
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 22:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316AbbFPUTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 16:19:23 -0400
Received: from mail.nextest.com ([12.96.234.114]:43600 "EHLO
	Hermes.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757136AbbFPURV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2015 16:17:21 -0400
Received: from [131.101.150.237] (131.101.150.237) by
 HERMES.DOMAIN1.nextest.com (131.101.21.61) with Microsoft SMTP Server id
 8.3.327.1; Tue, 16 Jun 2015 13:17:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <87b840d8c73fd7e4e7597e2fd835c703@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271794>


On 6/16/2015 2:43 AM, Johannes Schindelin wrote:
> Hi Eric,
> 
> On 2015-06-16 03:17, Eric Raible wrote:
>> I'm running 1.9.5.msysgit.1, but this is a general git question...
>>
>> Upon returning from a vacation, I was looking at what people had been
>> up to, and discovered on merge in which a colleague had resolved a merge
>> incorrectly.  It turns out that he has pushed *many* merges over the past
>> year which had conflicts in my code, and now I don't trust any of them.
>>
>> So naturally I want to check each of them for correctness.
>>
>> I know about "git log -p -cc SHA -- path", but it really doesn't
>> show just the conflicts so there's just too much noise in that output.
>>
>> I use kdiff3 to resolve conflicts, so I'm looking for a way to
>> visualize these already-resolved conflicts with that tool.
>> As I said, there are many merges, so the prospect of checking
>> out each sha, doing the merge, and then comparing the results
>> is completely untenable.
>>
>> Can anyone help?  Surely other people have wanted to review how
>> conflicts were resolved w/out looking at the noise of unconflicted
>> changes, right?
> 
> If I was walking in your shoes, I would essentially recreate the merge conflicts and then use "git diff <merge-commit>" with the resolved merge in your current history.
> 
> Something like this:
> 
> ```bash
> mergecommit=$1
> 
> # probably should verify that the working directory is clean, yadda yadda
> 
> # recreate merge conflicts on an unnamed branch (Git speak: detached HEAD)
> git checkout $mergecommit^
> git merge $mergecommit^2 ||
> die "This merge did not have any problem!"
> 
> # compare to the actual resolution as per the merge commit
> git diff $mergecommit
> ```
> 
> To list all the merge commits in the current branch, I would use the command-line:
> 
> ```bash
> git rev-list --author="My Colleague" --parents HEAD |
> sed -n 's/ .* .*//p'
> ```
> 
> (i.e. listing all the commits with their parents, then filtering just the ones having more than one parent, which would include octopus merges if your history has them.)
> 
> Hopefully this gives you good ideas how to proceed.
> 
> Ciao,
> Johannes
> .

Thanks for the reply, Johannes.

That basically the procedure that I did on just the one I stumbled across.
But what I really want is just a way to review how each conflicts was resolved
w/out having to re-resolve each one myself.

gitk (obviously) makes it trivial to view changes in normal commits, but given that
git provides such a straightforward conflict resolution model I'm surprised that there
isn't a corresponding straightforward way of viewing those resolved conflicts in context.

Thanks - Eric
