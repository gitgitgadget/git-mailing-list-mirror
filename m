From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Tue, 23 Oct 2007 07:38:23 +0200
Message-ID: <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <471C9B13.9080603@op5.se> <Pine.LNX.4.64.0710221445170.25221@racer.site> <471CB443.9070606@op5.se> <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCSN-0005NO-N6
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXJWFhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbXJWFhE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:37:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:64969 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbXJWFhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:37:01 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9N5atU1021422;
	Tue, 23 Oct 2007 07:36:55 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b654.pool.einsundeins.de [77.177.182.84])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9N5aswX009470
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 23 Oct 2007 07:36:55 +0200 (MEST)
In-Reply-To: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62094>


On Oct 23, 2007, at 1:35 AM, Jakub Narebski wrote:

> On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
>> Johannes Schindelin wrote:
>>> On Mon, 22 Oct 2007, Andreas Ericsson wrote:
>>>
>>>> If I were to suggest any improvements, it'd be to change the  
>>>> semantics of
>>>> git-pull to always update the local branches set up to be merged  
>>>> with the
>>>> remote tracking branches when they, prior to fetching, pointed  
>>>> to the same
>>>> commit, such that when
>>>>
>>>> $ git show-ref master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
>>>> d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master
>>>>
>>>> refs/heads/master gets set to refs/remotes/origin/master post- 
>>>> fetch.
>>>
>>> In general, this should fail.  Because you are expected to have  
>>> local
>>> changes in the local branches.
>>
>>
>> BS argument. Git knows when I haven't got any changes on my local
>> branches, and it can be fairly safely assumed that when I feel like
>> making any, I'd like to make them off as fresh a tip as possible  
>> unless
>> I explicitly tell git otherwise.
> [cut]
>
> It would be I think possible to make git behave as you want,  
> although I'd rather
> (at least at first) have behaviour described above turned on by  
> some option
> or config variable. I guess that it would be not that hard to make  
> script to do
> what you ant (and probably it would be best if you tried your idea  
> that way).
>
> There are the following caveats.
> 1. For each local branch that is to be updated on pull, this branch
> must be marked as tracking some branch of some repository. This has to
> be explicitely done; for example by creating those branches using
> --track option.

True, and only the branches matching the remote currently pulled
should be considered. Tracking branches pointing to a different
remote need to be skipped.


> 2. Git can do a merge with conflicts _only_ if that branch is checked
> out.

Andreas' proposal contains an important requirement that
avoids this problem. His proposal states "when they, prior
to fetching, pointed to the same commit [the head in remotes
pointed to]". That is only fast-forwards are needed, which
never have merge conflicts.


> So for all local branches which you want to get updated using
> "git pull --update-all <repo>" (or something like that), the merge
> with remote branch should be either fast-forward, trivial merge, or
> merge without conflicts. "git pull --update-all <repo>" would return
> then list of updated branches and list of branches which cannot be
> updated.

Maybe Andreas' proposal could be extended as you describe.
But I don't think any merging should automatically be done. I'd
only support fast forwards. Merging always includes a risk
of unexpected changes to the code; even if there are no merge
conflicts detected by git. I think it is reasonable to leave
all such cases to the user for manual resolution. Supporting
fast-forward should be sufficient.

	Steffen
